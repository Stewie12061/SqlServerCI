IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP5103_AG]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP5103_AG]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


----- Created BY  Nguyen Van Nhan AND Hoang Thi Lan
----- Created Date 07/11/2003.
----- Purpose: Phan bo chi phi Nguyen vat lieu theo PP dinh muc
----- Edit BY Vo Thanh  Huong, date : 06/05/2005
----- Purpose: Phan bo chi phí theo dinh muc chi theo so luong khong theo thanh tien, lam tron 
----- Edit BY: Dang Le Bao Quynh; Date 21/08/2007
----- Purpose: Xu ly truong hop ma nguyen lieu co do dang dau ky, ton tai trong bo dinh muc nhung khong co phat sinh trong ky nay
----- Edit BY Van Nhan
---- Purpose: Xu ly truong hop co NVL thay the
----- Modify on 24/04/2014 by Bảo Anh: Sửa lỗi phân bổ NVL thay thế chưa đúng
----- Modify on 27/07/2015 by Bảo Anh: Khi phân bổ NVL thay thế phải trừ số tiền đã phân bổ sản xuất trực tiếp
----- Modify on 25/08/2015 by Bảo Anh: Phân bổ NVL thay thế cùng với NVL chính (trước đây phân bổ NVL chính xong mới đến NVL thay thế)
----- Modified by Tiểu Mai on 31/12/2015: Sửa câu insert vào MT0621
----- Modified by Tiểu Mai on 26/10/2016: Fix bug làm tròn số lẻ chưa đúng, cập nhật lại cột ConvertedUnitID
----- Modified by Tiểu Mai on 15/11/2016: Bổ sung xử lý tính đúng số lượng NPL cho ANGEL (CustomizeIndex = 57)
----- Modified by Tiểu Mai on 28/02/2017: Chỉnh sửa hệ số phân bổ NPL thay thế  = Hệ số thay thế * số lượng định mức
----- Modified by Tiểu Mai on 15/03/2017: Chỉnh sửa làm tròn số khi nhân chưa đúng
----- Modified by Tiểu Mai on 30/03/2017: Fix chia cho 0 do số lượng NPL phân bổ = 0
----- Modified by TIểu Mai on 01/09/2017: Bổ sung loại tính giá trị NVL sản xuất dựa vào dở dang đầu kỳ + phát sinh - cuối kỳ (ANGEL)
----- Modified by Tiểu Mai on 10/11/2017: Bổ sung kiểm tra nếu tính dở dang đầu kỳ theo phương pháp cập nhật tay hoặc chuyển từ kỳ trước
----- Modified by Phương Thảo on 17/11/2017: Bổ sung các trường hợp đối với dữ liệu không phát sinh: đầu kỳ, trong kỳ, cuối kỳ
----- Modified by Bảo Anh on 25/01/2018: Sửa lỗi không phân bổ được khi NVL nhập trả cấn trừ hết với dở dang đầu kỳ
----- Modified by Bảo Anh on 19/04/2018: Bổ sung làm tròn sau khi áp giá bình quân cho chi phí dở dang cuối kỳ
----- Modified by Kim Thư on 08/04/2019: Tính số lượng và số lượng trên 1 ProductID (Nhân vs 1000 khi tính toán và chia lại 1000) do số quá nhỏ
/********************************************
'* Edited BY: [GS] [Thành Nguyên] [03/08/2010]
'********************************************/

CREATE PROCEDURE  [dbo].[MP5103_AG]     @DivisionID AS nvarchar(50), 
                     @PeriodID  AS nvarchar(50), 
                    @TranMonth AS INT, 
                    @TranYear AS INT, 
                    @MaterialTypeID  AS nvarchar(50), 
                    @ApportionID  AS nvarchar(50)

AS
DECLARE @sSQL AS nvarchar(4000), 
    @ListMaterial_cur AS cursor, 
    @MaterialID AS nvarchar(50), 
    @ConvertedAmount DECIMAL(28, 8), 
    @MaterialQuantity AS DECIMAL(28, 8), 
    @ProductConvertedUnit AS  DECIMAL(28, 8), 
    @MaterialQuantityUnit AS DECIMAL(28, 8), 
    @SumProductQuantity AS DECIMAL(28, 8), 
    @SumProductConverted AS DECIMAL(28, 8), 
    @MaterialConvertedUnit AS DECIMAL(28, 8), 
    @ListProduct_cur AS cursor, 
    @ProductID AS nvarchar(50), 
    @ProductQuantity AS DECIMAL(28, 8), 
    @ProductQuantityUnit AS DECIMAL(28, 8), 
    @UnitID AS nvarchar(50), 
    @QuantityUnit AS DECIMAL(28, 8), 
    @ConvertedUnit AS DECIMAL(28, 8), 
    @ConvertedDecimal INT, 
	@UnitCostDecimals Int,
    @Cur AS cursor, 
    @MaterialGroupID AS nvarchar(50),
    @ExtraMaterialID AS nvarchar(50),
    @ExtraQuantity as DECIMAL(28, 8),
    @QuantityDecimal INT,
    @CustomizeName INT,
    @BeginMethodID TINYINT,
    @FromPeriodID NVARCHAR(50)
    
SELECT @CustomizeName = ci.CustomerName FROM CustomerIndex ci
    
SET @ConvertedDecimal = (SELECT ConvertDecimal FROM MT0000 where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)))
SET @QuantityDecimal = (SELECT QuantityDecimal FROM MT0000 where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)))     
SELECT @UnitCostDecimals = UnitCostDecimals FROM AT0001 WITH (NOLOCK) WHERE DivisionID = @DivisionID
-- Print ' Phan bo NVL theo PP dinh muc'

SET @BeginMethodID = (SELECT BeginMethodID FROM MT1608 WITH (NOLOCK) 
                      LEFT JOIN MT1601 WITH (NOLOCK) ON MT1601.DivisionID = MT1608.DivisionID AND MT1601.InprocessID = MT1608.InprocessID
                      WHERE MT1601.PeriodID = @PeriodID And MT1608.DivisionID = @DivisionID)

SET @FromPeriodID = (SELECT  FromPeriodID FROM MT1601 WHERE PeriodID = @PeriodID And DivisionID = @DivisionID)

----- Update lại giá trị dở dang cuối kỳ theo đơn giá bình quân xuất kho trong kỳ
UPDATE MT1612
SET MT1612.ConvertedAmount = ROUND(WipQuantity*A.UnitPrice_CK,@ConvertedDecimal)
FROM MT1612 
INNER JOIN (
	SELECT MaterialID, (CASE WHEN ISNULL(SUM(Quantity),0) <> 0 THEN ROUND(SUM(ConvertedAmount)/SUM(Quantity),@UnitCostDecimals) ELSE 0 END) AS UnitPrice_CK 
		FROM (	
			---- Lấy dở dang đầu kỳ
			SELECT MT1612.DivisionID, MaterialID,
					ISNULL(PeriodID,'') AS PeriodID,
					ProductID,	
					SUM(ConvertedAmount) AS ConvertedAmount,
					SUM(WipQuantity) AS Quantity			
			FROM  MT1612 WITH (NOLOCK)	 
			WHERE MT1612.DivisionID = @DivisionID AND MT1612.ExpenseID = 'COST001' AND MaterialTypeID = @MaterialTypeID
				--AND TranMonth + TranYear * 100 = @TranMonth + @TranYear*100
				AND ISNULL(PeriodID,'') = @FromPeriodID
				AND [Type] = 'E'
			GROUP BY MT1612.DivisionID, MaterialID, ISNULL(PeriodID,''), ProductID

			UNION 
			---- Lấy chi phí NVL phát sinh trong kỳ
			---- Modified by Tiểu Mai on 07/11/2017: Bổ sung công thức trừ NVL nhập trả lại
			SELECT MV9000.DivisionID, MV9000.InventoryID AS MaterialID, ISNULL(MV9000.PeriodID,'') AS PeriodID, MV9000.ProductID,  
				SUM(CASE WHEN D_C = 'D' THEN MV9000.ConvertedAmount ELSE -MV9000.ConvertedAmount END) AS ConvertedAmount,
				SUM(CASE WHEN D_C = 'D' THEN MV9000.Quantity ELSE -MV9000.Quantity END) AS Quantity
			FROM  MV9000 	
			Where MV9000.TranMonth + MV9000.TranYear*100 = @TranMonth + @TranYear*100			
				AND MV9000.DivisionID = @DivisionID AND ISNULL(MV9000.PeriodID,'') LIKE @PeriodID
				AND (MV9000.ExpenseID='COST001' or (Isnull(MV9000.ExpenseID,'') = '' and
										(DebitAccountID in (Select AccountID 
													  From MT0700 WITH (NOLOCK)
													  Where MT0700.ExpenseID='COST001'	) or CreditAccountID in (Select AccountID 
													  From MT0700 WITH (NOLOCK)
													  Where MT0700.ExpenseID='COST001'	))))
			GROUP BY MV9000.DivisionID, MV9000.InventoryID, MV9000.UnitID, MV9000.ProductID, ISNULL(MV9000.PeriodID,'')
		) P
	GROUP BY MaterialID
) A ON ISNULL(A.MaterialID,'') = ISNULL(MT1612.MaterialID,'')
WHERE DivisionID = @DivisionID AND TranMonth = @TranMonth AND TranYear = @TranYear AND ISNULL(PeriodID,'') = @PeriodID AND [Type] = 'E' AND ExpenseID = 'COST001' AND MaterialTypeID = @MaterialTypeID
	
--- Làm tròn giá trị dở dang cuối kỳ
SELECT MaterialID, SUM(ConvertedAmount) AS ConvertedAmount, SUM(Quantity) AS Quantity
INTO #TAM1
FROM
(
SELECT	MaterialID,		
		SUM(ConvertedAmount) AS ConvertedAmount,
		SUM(WipQuantity) AS Quantity			
FROM  MT1612 WITH (NOLOCK)	 
WHERE MT1612.DivisionID = @DivisionID AND MT1612.ExpenseID = 'COST001' AND MaterialTypeID = @MaterialTypeID
	AND ISNULL(PeriodID,'') = @FromPeriodID
	AND [Type] = 'E'
GROUP BY MaterialID

UNION
SELECT InventoryID AS MaterialID,
	SUM(CASE WHEN D_C = 'D' THEN MV9000.ConvertedAmount ELSE -MV9000.ConvertedAmount END) AS ConvertedAmount,
	SUM(CASE WHEN D_C = 'D' THEN MV9000.Quantity ELSE -MV9000.Quantity END) AS Quantity
FROM  MV9000 	
Where TranMonth + TranYear*100 = @TranMonth + @TranYear*100			
	AND DivisionID = @DivisionID AND ISNULL(PeriodID,'') LIKE @PeriodID
	AND (ExpenseID='COST001' or (Isnull(ExpenseID,'') = '' and
							(DebitAccountID in (Select AccountID 
											From MT0700 WITH (NOLOCK)
											Where MT0700.ExpenseID='COST001'	) or CreditAccountID in (Select AccountID 
											From MT0700 WITH (NOLOCK)
											Where MT0700.ExpenseID='COST001'	))))
GROUP BY InventoryID
) A
GROUP BY MaterialID

SELECT MaterialID, ISNULL((SELECT ConvertedAmount FROM #TAM1 WHERE MaterialID = MT1612.MaterialID),0) - ISNULL(SUM(ConvertedAmount),0) AS DiffAmount
INTO #TAM2
FROM MT1612
WHERE DivisionID = @DivisionID AND TranMonth = @TranMonth AND TranYear = @TranYear AND ISNULL(PeriodID,'') = @PeriodID AND [Type] = 'E' AND ExpenseID = 'COST001' AND MaterialTypeID = @MaterialTypeID
GROUP BY MaterialID
HAVING ISNULL(SUM(WipQuantity),0) = ISNULL((SELECT Quantity FROM #TAM1 WHERE MaterialID = MT1612.MaterialID),0)
	AND ISNULL(SUM(ConvertedAmount),0) <> ISNULL((SELECT ConvertedAmount FROM #TAM1 WHERE MaterialID = MT1612.MaterialID),0)

UPDATE MT1612
SET ConvertedAmount = ConvertedAmount + AA.DiffAmount
FROM MT1612
INNER JOIN 
	(	SELECT WipVoucherID,ROW_NUMBER() OVER(PARTITION BY MT1612.MaterialID ORDER BY ConvertedAmount Desc) [ROW], #TAM2.DiffAmount
		FROM MT1612
		INNER JOIN #TAM2 ON MT1612.MaterialID = #TAM2.MaterialID
		WHERE MT1612.DivisionID = @DivisionID AND MT1612.TranMonth = @TranMonth AND MT1612.TranYear = @TranYear AND ISNULL(MT1612.PeriodID,'') = @PeriodID AND MT1612.[Type] = 'E' AND MT1612.ExpenseID = 'COST001' AND MT1612.MaterialTypeID = @MaterialTypeID			
	) AA ON MT1612.DivisionID = @DivisionID AND AA.WipVoucherID = MT1612.WipVoucherID AND AA.[ROW] = 1

--- Thực hiện phân bổ
CREATE TABLE #TMP_MV5103(DivisionID NVARCHAR(50), ProductID NVARCHAR(50), MaterialID NVARCHAR(50), QuantityUnit DECIMAL(28,8),
						 ConvertedUnit DECIMAL(28,8), ProductQuantity DECIMAL(28,8), UnitID NVARCHAR(50),IsExtraMaterial INT,
						  MaterialGroupID NVARCHAR(50), ProductQuantityUnit DECIMAL(28,8), ProductConvertedUnit DECIMAL(28,8))

CREATE TABLE #TMP_MV6103(DivisionID NVARCHAR(50),MaterialID NVARCHAR(100) , MaterialQuantity DECIMAL(28,8), ConvertedAmount DECIMAL(28,8))	
						
INSERT INTO #TMP_MV5103(DivisionID, ProductID,MaterialID,QuantityUnit,ConvertedUnit,ProductQuantity,UnitID,IsExtraMaterial,MaterialGroupID,ProductQuantityUnit,ProductConvertedUnit)
SELECT MT1603.DivisionID, MT1603.ProductID, MaterialID, QuantityUnit, ConvertedUnit, MT2222.ProductQuantity, 
	MT2222.UnitID, IsExtraMaterial, MaterialGroupID, 
	QuantityUnit*MT2222.ProductQuantity AS ProductQuantityUnit, 
	ConvertedUnit*MT2222.ProductQuantity AS ProductConvertedUnit
FROM MT1603 INNER JOIN MT2222 ON MT2222.DivisionID = MT1603.DivisionID AND MT2222.ProductID = MT1603.ProductID
WHERE     ApportionID = @ApportionID
	AND MT1603.DivisionID = @DivisionID
	AND ExpenseID ='COST001'

UNION	--- Bổ sung NVL thay thế
Select DivisionID, ProductID, MaterialID, QuantityUnit, ConvertedUnit, ProductQuantity, 
	UnitID, 1 as IsExtraMaterial, MaterialGroupID, 
	QuantityUnit*ProductQuantity AS ProductQuantityUnit, 
	ConvertedUnit*ProductQuantity AS ProductConvertedUnit
FROM
	(Select MT1603.DivisionID, MT1603.ProductID, MT0007.MaterialID,convert(decimal(10,8),MT0007.CoValues) * convert(decimal(28,8),MT1603.QuantityUnit) as QuantityUnit,
	MT1603.ConvertedUnit as ConvertedUnit, MT2222.ProductQuantity, MT2222.UnitID, MT1603.MaterialGroupID
	FROM MT1603 INNER JOIN MT2222 ON MT2222.DivisionID = MT1603.DivisionID AND MT2222.ProductID = MT1603.ProductID
	INNER JOIN MT0007 On MT1603.DivisionID = MT0007.DivisionID AND MT1603.IsExtraMaterial = 1 And MT1603.MaterialGroupID = MT0007.MaterialGroupID
	WHERE     ApportionID = @ApportionID
		AND MT1603.DivisionID = @DivisionID
		AND ExpenseID ='COST001'
	) MT1603
	
IF(@BeginMethodID = 2)
BEGIN
	--- Bang dk lam goc
	INSERT INTO #TMP_MV6103(DivisionID, MaterialID, MaterialQuantity, ConvertedAmount)
	SELECT B2.DivisionID, B2.MaterialID, ISNULL(B2.Quantity,0) + ISNULL(P.MaterialQuantity,0) - ISNULL(E.Quantity,0) AS  MaterialQuantity, 
			ISNULL(B2.ConvertedAmount,0) + ISNULL(P.ConvertedAmount,0) - ISNULL(E.ConvertedAmount,0) AS ConvertedAmount
		--((CASE WHEN @BeginMethodID = 2 THEN ISNULL(B2.ConvertedAmount,0) ELSE ISNULL(B.ConvertedAmount,0) END) + ISNULL(P.ConvertedAmount,0) - ISNULL(E.ConvertedAmount,0)) AS ConvertedAmount
	FROM 
	(
		SELECT MT1613.DivisionID, MaterialID,
				ISNULL(PeriodID,'') AS PeriodID,
				ProductID,	
				SUM(ConvertedAmount) AS ConvertedAmount,
				SUM(MaterialQuantity) AS Quantity			
		FROM  MT1613 WITH (NOLOCK)	 
		WHERE MT1613.DivisionID = @DivisionID AND MT1613.ExpenseID = 'COST001' AND MaterialTypeID = @MaterialTypeID
			AND ISNULL(PeriodID,'') = @FromPeriodID AND Type ='E'
		GROUP BY MT1613.DivisionID, MaterialID, ISNULL(PeriodID,''), ProductID	
	) B2 
	LEFT JOIN 
	(
		SELECT DivisionID, InventoryID AS MaterialID, 
			SUM( Case D_C  when  'D' then ISNULL(Quantity, 0) ELSE - ISNULL(Quantity, 0) END) AS MaterialQuantity, 
			SUM( Case D_C  when  'D' then   ISNULL(ConvertedAmount, 0) ELSE - ISNULL(ConvertedAmount, 0) END) AS ConvertedAmount    
		FROM MV9000  
		WHERE     PeriodID = @PeriodID
			AND ExpenseID ='COST001' 
			AND MaterialTypeID =@MaterialTypeID
			AND DivisionID = @DivisionID
		GROUP BY DivisionID, InventoryID 			
	) P ON B2.DivisionID = P.DivisionID AND B2.MaterialID = P.MaterialID
	LEFT JOIN
	(
		SELECT MT1612.DivisionID, MaterialID,
				ISNULL(PeriodID,'') AS PeriodID,
				ProductID,	
				SUM(ConvertedAmount) AS ConvertedAmount,
				SUM(WipQuantity) AS Quantity			
		FROM  MT1612 WITH (NOLOCK)	 
		WHERE MT1612.DivisionID = @DivisionID AND MT1612.ExpenseID = 'COST001' AND MaterialTypeID = @MaterialTypeID
			AND ISNULL(PeriodID,'') = @PeriodID
			AND [Type] = 'E'
		GROUP BY MT1612.DivisionID, MaterialID, ISNULL(PeriodID,''), ProductID	
	) E ON E.DivisionID = B2.DivisionID AND E.MaterialID = B2.MaterialID
	WHERE NOT EXISTS (SELECT TOP 1 1 FROM #TMP_MV6103 WHERE #TMP_MV6103.DivisionID = B2.DivisionID AND #TMP_MV6103.MaterialID =  B2.MaterialID)

	--- Bang ps lam goc
	INSERT INTO #TMP_MV6103(DivisionID, MaterialID, MaterialQuantity, ConvertedAmount)
	SELECT P.DivisionID, P.MaterialID, ISNULL(B2.Quantity,0) + ISNULL(P.MaterialQuantity,0) - ISNULL(E.Quantity,0) AS  MaterialQuantity, 
			ISNULL(B2.ConvertedAmount,0) + ISNULL(P.ConvertedAmount,0) - ISNULL(E.ConvertedAmount,0) AS ConvertedAmount
		--((CASE WHEN @BeginMethodID = 2 THEN ISNULL(B2.ConvertedAmount,0) ELSE ISNULL(B.ConvertedAmount,0) END) + ISNULL(P.ConvertedAmount,0) - ISNULL(E.ConvertedAmount,0)) AS ConvertedAmount
	FROM 
	(
		SELECT DivisionID, InventoryID AS MaterialID, 
			SUM( Case D_C  when  'D' then ISNULL(Quantity, 0) ELSE - ISNULL(Quantity, 0) END) AS MaterialQuantity, 
			SUM( Case D_C  when  'D' then   ISNULL(ConvertedAmount, 0) ELSE - ISNULL(ConvertedAmount, 0) END) AS ConvertedAmount    
		FROM MV9000  
		WHERE     PeriodID = @PeriodID
			AND ExpenseID ='COST001' 
			AND MaterialTypeID =@MaterialTypeID
			AND DivisionID = @DivisionID
		GROUP BY DivisionID, InventoryID 			
	) P	
	LEFT JOIN 
	(
		SELECT MT1613.DivisionID, MaterialID,
				ISNULL(PeriodID,'') AS PeriodID,
				ProductID,	
				SUM(ConvertedAmount) AS ConvertedAmount,
				SUM(MaterialQuantity) AS Quantity			
		FROM  MT1613 WITH (NOLOCK)	 
		WHERE MT1613.DivisionID = @DivisionID AND MT1613.ExpenseID = 'COST001' AND MaterialTypeID = @MaterialTypeID
			AND ISNULL(PeriodID,'') = @FromPeriodID AND Type ='E'
		GROUP BY MT1613.DivisionID, MaterialID, ISNULL(PeriodID,''), ProductID	
	) B2  ON B2.DivisionID = P.DivisionID AND B2.MaterialID = P.MaterialID
	LEFT JOIN
	(
		SELECT MT1612.DivisionID, MaterialID,
				ISNULL(PeriodID,'') AS PeriodID,
				ProductID,	
				SUM(ConvertedAmount) AS ConvertedAmount,
				SUM(WipQuantity) AS Quantity			
		FROM  MT1612 WITH (NOLOCK)	 
		WHERE MT1612.DivisionID = @DivisionID AND MT1612.ExpenseID = 'COST001' AND MaterialTypeID = @MaterialTypeID
			AND ISNULL(PeriodID,'') = @PeriodID
			AND [Type] = 'E'
		GROUP BY MT1612.DivisionID, MaterialID, ISNULL(PeriodID,''), ProductID	
	) E ON E.DivisionID = P.DivisionID AND E.MaterialID = P.MaterialID
	WHERE NOT EXISTS (SELECT TOP 1 1 FROM #TMP_MV6103 WHERE #TMP_MV6103.DivisionID = P.DivisionID AND #TMP_MV6103.MaterialID =  P.MaterialID)

	--- Bang ck lam goc
	INSERT INTO #TMP_MV6103(DivisionID, MaterialID, MaterialQuantity, ConvertedAmount)
	SELECT E.DivisionID, E.MaterialID, ISNULL(B2.Quantity,0) + ISNULL(P.MaterialQuantity,0) - ISNULL(E.Quantity,0) AS  MaterialQuantity, 
			ISNULL(B2.ConvertedAmount,0) + ISNULL(P.ConvertedAmount,0) - ISNULL(E.ConvertedAmount,0) AS ConvertedAmount
		--((CASE WHEN @BeginMethodID = 2 THEN ISNULL(B2.ConvertedAmount,0) ELSE ISNULL(B.ConvertedAmount,0) END) + ISNULL(P.ConvertedAmount,0) - ISNULL(E.ConvertedAmount,0)) AS ConvertedAmount
	FROM
	(
		SELECT MT1612.DivisionID, MaterialID,
				ISNULL(PeriodID,'') AS PeriodID,
				ProductID,	
				SUM(ConvertedAmount) AS ConvertedAmount,
				SUM(WipQuantity) AS Quantity			
		FROM  MT1612 WITH (NOLOCK)	 
		WHERE MT1612.DivisionID = @DivisionID AND MT1612.ExpenseID = 'COST001' AND MaterialTypeID = @MaterialTypeID
			AND ISNULL(PeriodID,'') = @PeriodID
			AND [Type] = 'E'
		GROUP BY MT1612.DivisionID, MaterialID, ISNULL(PeriodID,''), ProductID	
	) E 		
	LEFT JOIN
	(
		SELECT DivisionID, InventoryID AS MaterialID, 
			SUM( Case D_C  when  'D' then ISNULL(Quantity, 0) ELSE - ISNULL(Quantity, 0) END) AS MaterialQuantity, 
			SUM( Case D_C  when  'D' then   ISNULL(ConvertedAmount, 0) ELSE - ISNULL(ConvertedAmount, 0) END) AS ConvertedAmount    
		FROM MV9000  
		WHERE     PeriodID = @PeriodID
			AND ExpenseID ='COST001' 
			AND MaterialTypeID =@MaterialTypeID
			AND DivisionID = @DivisionID
		GROUP BY DivisionID, InventoryID 			
	) P ON E.DivisionID = P.DivisionID AND E.MaterialID = P.MaterialID
	LEFT JOIN 
	(
		SELECT MT1613.DivisionID, MaterialID,
				ISNULL(PeriodID,'') AS PeriodID,
				ProductID,	
				SUM(ConvertedAmount) AS ConvertedAmount,
				SUM(MaterialQuantity) AS Quantity			
		FROM  MT1613 WITH (NOLOCK)	 
		WHERE MT1613.DivisionID = @DivisionID AND MT1613.ExpenseID = 'COST001' AND MaterialTypeID = @MaterialTypeID
			AND ISNULL(PeriodID,'') = @FromPeriodID AND Type ='E'
		GROUP BY MT1613.DivisionID, MaterialID, ISNULL(PeriodID,''), ProductID	
	) B2  ON B2.DivisionID = E.DivisionID AND B2.MaterialID = E.MaterialID	
	WHERE NOT EXISTS (SELECT TOP 1 1 FROM #TMP_MV6103 WHERE #TMP_MV6103.DivisionID = E.DivisionID AND #TMP_MV6103.MaterialID =  E.MaterialID)
END
ElSE
BEGIN
	--- Bang dk lam goc
	INSERT INTO #TMP_MV6103(DivisionID, MaterialID, MaterialQuantity, ConvertedAmount)
	SELECT B.DivisionID, B.MaterialID, ISNULL(B.Quantity,0) + ISNULL(P.MaterialQuantity,0) - ISNULL(E.Quantity,0) AS  MaterialQuantity, 
			ISNULL(B.ConvertedAmount,0) + ISNULL(P.ConvertedAmount,0) - ISNULL(E.ConvertedAmount,0) AS ConvertedAmount
		--((CASE WHEN @BeginMethodID = 2 THEN ISNULL(B2.ConvertedAmount,0) ELSE ISNULL(B.ConvertedAmount,0) END) + ISNULL(P.ConvertedAmount,0) - ISNULL(E.ConvertedAmount,0)) AS ConvertedAmount
	FROM 
	(
		SELECT MT1612.DivisionID, MaterialID,
				ISNULL(PeriodID,'') AS PeriodID,
				ProductID,	
				SUM(ConvertedAmount) AS ConvertedAmount,
				SUM(WipQuantity) AS Quantity			
		FROM  MT1612 WITH (NOLOCK)	 
		WHERE MT1612.DivisionID = @DivisionID AND MT1612.ExpenseID = 'COST001' AND MaterialTypeID = @MaterialTypeID
			AND ISNULL(PeriodID,'') = @PeriodID
			AND [Type] = 'B'
		GROUP BY MT1612.DivisionID, MaterialID, ISNULL(PeriodID,''), ProductID	
	) B
	LEFT JOIN 
	(
		SELECT DivisionID, InventoryID AS MaterialID, 
			SUM( Case D_C  when  'D' then ISNULL(Quantity, 0) ELSE - ISNULL(Quantity, 0) END) AS MaterialQuantity, 
			SUM( Case D_C  when  'D' then   ISNULL(ConvertedAmount, 0) ELSE - ISNULL(ConvertedAmount, 0) END) AS ConvertedAmount    
		FROM MV9000  
		WHERE     PeriodID = @PeriodID
			AND ExpenseID ='COST001' 
			AND MaterialTypeID =@MaterialTypeID
			AND DivisionID = @DivisionID
		GROUP BY DivisionID, InventoryID 			
	) P ON B.DivisionID = P.DivisionID AND B.MaterialID = P.MaterialID
	LEFT JOIN
	(
		SELECT MT1612.DivisionID, MaterialID,
				ISNULL(PeriodID,'') AS PeriodID,
				ProductID,	
				SUM(ConvertedAmount) AS ConvertedAmount,
				SUM(WipQuantity) AS Quantity			
		FROM  MT1612 WITH (NOLOCK)	 
		WHERE MT1612.DivisionID = @DivisionID AND MT1612.ExpenseID = 'COST001' AND MaterialTypeID = @MaterialTypeID
			AND ISNULL(PeriodID,'') = @PeriodID
			AND [Type] = 'E'
		GROUP BY MT1612.DivisionID, MaterialID, ISNULL(PeriodID,''), ProductID	
	) E ON E.DivisionID = B.DivisionID AND E.MaterialID = B.MaterialID
	WHERE NOT EXISTS (SELECT TOP 1 1 FROM #TMP_MV6103 WHERE #TMP_MV6103.DivisionID = B.DivisionID AND #TMP_MV6103.MaterialID =  B.MaterialID)

	--- Bang ps lam goc
	INSERT INTO #TMP_MV6103(DivisionID, MaterialID, MaterialQuantity, ConvertedAmount)
	SELECT P.DivisionID, P.MaterialID, ISNULL(B.Quantity,0) + ISNULL(P.MaterialQuantity,0) - ISNULL(E.Quantity,0) AS  MaterialQuantity, 
			ISNULL(B.ConvertedAmount,0) + ISNULL(P.ConvertedAmount,0) - ISNULL(E.ConvertedAmount,0) AS ConvertedAmount
		--((CASE WHEN @BeginMethodID = 2 THEN ISNULL(B2.ConvertedAmount,0) ELSE ISNULL(B.ConvertedAmount,0) END) + ISNULL(P.ConvertedAmount,0) - ISNULL(E.ConvertedAmount,0)) AS ConvertedAmount
	FROM 
	(
		SELECT DivisionID, InventoryID AS MaterialID, 
			SUM( Case D_C  when  'D' then ISNULL(Quantity, 0) ELSE - ISNULL(Quantity, 0) END) AS MaterialQuantity, 
			SUM( Case D_C  when  'D' then   ISNULL(ConvertedAmount, 0) ELSE - ISNULL(ConvertedAmount, 0) END) AS ConvertedAmount    
		FROM MV9000  
		WHERE     PeriodID = @PeriodID
			AND ExpenseID ='COST001' 
			AND MaterialTypeID =@MaterialTypeID
			AND DivisionID = @DivisionID
		GROUP BY DivisionID, InventoryID 			
	) P	
	LEFT JOIN 
	(
		SELECT MT1612.DivisionID, MaterialID,
				ISNULL(PeriodID,'') AS PeriodID,
				ProductID,	
				SUM(ConvertedAmount) AS ConvertedAmount,
				SUM(WipQuantity) AS Quantity			
		FROM  MT1612 WITH (NOLOCK)	 
		WHERE MT1612.DivisionID = @DivisionID AND MT1612.ExpenseID = 'COST001' AND MaterialTypeID = @MaterialTypeID
			AND ISNULL(PeriodID,'') = @PeriodID
			AND [Type] = 'B'
		GROUP BY MT1612.DivisionID, MaterialID, ISNULL(PeriodID,''), ProductID	
	) B ON B.DivisionID = P.DivisionID AND B.MaterialID = P.MaterialID
	LEFT JOIN
	(
		SELECT MT1612.DivisionID, MaterialID,
				ISNULL(PeriodID,'') AS PeriodID,
				ProductID,	
				SUM(ConvertedAmount) AS ConvertedAmount,
				SUM(WipQuantity) AS Quantity			
		FROM  MT1612 WITH (NOLOCK)	 
		WHERE MT1612.DivisionID = @DivisionID AND MT1612.ExpenseID = 'COST001' AND MaterialTypeID = @MaterialTypeID
			AND ISNULL(PeriodID,'') = @PeriodID
			AND [Type] = 'E'
		GROUP BY MT1612.DivisionID, MaterialID, ISNULL(PeriodID,''), ProductID	
	) E ON E.DivisionID = P.DivisionID AND E.MaterialID = P.MaterialID
	WHERE NOT EXISTS (SELECT TOP 1 1 FROM #TMP_MV6103 WHERE #TMP_MV6103.DivisionID = P.DivisionID AND #TMP_MV6103.MaterialID =  P.MaterialID)

	--- Bang ck lam goc
	INSERT INTO #TMP_MV6103(DivisionID, MaterialID, MaterialQuantity, ConvertedAmount)
	SELECT E.DivisionID, E.MaterialID, ISNULL(B.Quantity,0) + ISNULL(P.MaterialQuantity,0) - ISNULL(E.Quantity,0) AS  MaterialQuantity, 
			ISNULL(B.ConvertedAmount,0) + ISNULL(P.ConvertedAmount,0) - ISNULL(E.ConvertedAmount,0) AS ConvertedAmount
		--((CASE WHEN @BeginMethodID = 2 THEN ISNULL(B2.ConvertedAmount,0) ELSE ISNULL(B.ConvertedAmount,0) END) + ISNULL(P.ConvertedAmount,0) - ISNULL(E.ConvertedAmount,0)) AS ConvertedAmount
	FROM 
	(
		SELECT MT1612.DivisionID, MaterialID,
				ISNULL(PeriodID,'') AS PeriodID,
				ProductID,	
				SUM(ConvertedAmount) AS ConvertedAmount,
				SUM(WipQuantity) AS Quantity			
		FROM  MT1612 WITH (NOLOCK)	 
		WHERE MT1612.DivisionID = @DivisionID AND MT1612.ExpenseID = 'COST001' AND MaterialTypeID = @MaterialTypeID
			AND ISNULL(PeriodID,'') = @PeriodID
			AND [Type] = 'E'
		GROUP BY MT1612.DivisionID, MaterialID, ISNULL(PeriodID,''), ProductID	
	) E	
	LEFT JOIN 
	(
		SELECT DivisionID, InventoryID AS MaterialID, 
			SUM( Case D_C  when  'D' then ISNULL(Quantity, 0) ELSE - ISNULL(Quantity, 0) END) AS MaterialQuantity, 
			SUM( Case D_C  when  'D' then   ISNULL(ConvertedAmount, 0) ELSE - ISNULL(ConvertedAmount, 0) END) AS ConvertedAmount    
		FROM MV9000  
		WHERE     PeriodID = @PeriodID
			AND ExpenseID ='COST001' 
			AND MaterialTypeID =@MaterialTypeID
			AND DivisionID = @DivisionID
		GROUP BY DivisionID, InventoryID 			
	) P	 ON E.DivisionID = P.DivisionID AND E.MaterialID = P.MaterialID
	LEFT JOIN
	(
		SELECT MT1612.DivisionID, MaterialID,
				ISNULL(PeriodID,'') AS PeriodID,
				ProductID,	
				SUM(ConvertedAmount) AS ConvertedAmount,
				SUM(WipQuantity) AS Quantity			
		FROM  MT1612 WITH (NOLOCK)	 
		WHERE MT1612.DivisionID = @DivisionID AND MT1612.ExpenseID = 'COST001' AND MaterialTypeID = @MaterialTypeID
			AND ISNULL(PeriodID,'') = @PeriodID
			AND [Type] = 'B'
		GROUP BY MT1612.DivisionID, MaterialID, ISNULL(PeriodID,''), ProductID	
	) B ON B.DivisionID = E.DivisionID AND B.MaterialID = E.MaterialID	
	WHERE NOT EXISTS (SELECT TOP 1 1 FROM #TMP_MV6103 WHERE #TMP_MV6103.DivisionID = E.DivisionID AND #TMP_MV6103.MaterialID =  E.MaterialID)

END

	
--- INSERT DU LIEU	
INSERT MT0621 (DivisionID, MaterialID, ProductID, UnitID, ExpenseID, Quantity, QuantityUnit,
				MaterialTypeID, ConvertedAmount, ConvertedUnit, ProductQuantity, Rate)    
	
SELECT	DivisionID, MaterialID, ProductID, UnitID, ExpenseID, 
		MaterialQuantityUnit AS Quantity,
		CASE WHEN ISNULL(ProductQuantity, 0) <> 0  THEN CAST(((MaterialQuantityUnit*1000)/ProductQuantity) AS DECIMAL(28,10))/1000 ELSE 0 END [QuantityUnit],
		--CASE WHEN ISNULL(ProductQuantity, 0) <> 0  THEN MaterialQuantityUnit/ProductQuantity ELSE 0 END [QuantityUnit],
		@MaterialTypeID,
		MaterialConvertedUnit AS ConvertedAmount,
		CASE WHEN ISNULL(ProductQuantity, 0) <> 0 THEN CAST(((MaterialConvertedUnit*1000)/ProductQuantity) AS DECIMAL(28,10))/1000 ELSE 0 END [ConvertedUnit],  
		--CASE WHEN ISNULL(ProductQuantity, 0) <> 0 THEN MaterialConvertedUnit/ProductQuantity ELSE 0 END [ConvertedUnit],  		
		ProductQuantity
		, NULL
FROM (SELECT  MV5103.DivisionID, MV5103.MaterialID, MV5103.ProductID,MV5103.UnitID,'COST001' [ExpenseID],
			CASE WHEN ISNULL(SumProductQuantity, 0) <> 0 
				THEN ROUND(CAST(((ISNULL(MV6103.MaterialQuantity, 0)*1000)*(ISNULL(MV5103.ProductQuantityUnit, 0)*1000)/ (SumProductQuantity*1000)) AS DECIMAL(28,10))/1000,@QuantityDecimal) 
				--THEN ROUND(ISNULL(MV6103.MaterialQuantity, 0)*ISNULL(MV5103.ProductQuantityUnit, 0)/ SumProductQuantity,@QuantityDecimal) 
				ELSE 0 END [MaterialQuantityUnit], 
			CASE WHEN ISNULL(SumProductQuantity, 0) <> 0 AND ISNULL(MV6103.MaterialQuantity,0) <> 0 
				--THEN round(ISNULL(MV6103.ConvertedAmount, 0)*ROUND(ISNULL(MV6103.MaterialQuantity, 0)*ISNULL(MV5103.ProductQuantityUnit, 0)/ SumProductQuantity, @QuantityDecimal)/ MV6103.MaterialQuantity, @ConvertedDecimal)  
				THEN round(ISNULL(MV6103.ConvertedAmount, 0)*ROUND(CAST(((ISNULL(MV6103.MaterialQuantity, 0)*1000)*(ISNULL(MV5103.ProductQuantityUnit, 0)*1000)/ (SumProductQuantity*1000)) AS DECIMAL(28,10))/1000, 8)/ MV6103.MaterialQuantity, 0)  				
				ELSE 0 END [MaterialConvertedUnit], 
			
			MV6103.ConvertedAmount, 
			MV6103.MaterialQuantity, MV5103.ProductQuantity,     
			MV5103.ProductQuantityUnit, MV5103.ProductConvertedUnit, 
			M03.SumProductQuantity ,
			M03.SumProductConverted 
	FROM #TMP_MV5103 MV5103				
	LEFT JOIN  #TMP_MV6103 MV6103 ON MV5103.DivisionID = MV6103.DivisionID AND MV5103.MaterialID = MV6103.MaterialID 
	LEFT JOIN	(	Select MaterialID,SUM (ISNULL(ProductQuantityUnit, 0)) SumProductQuantity,
							SUM (ISNULL(ProductConvertedUnit, 0)) SumProductConverted
					FROM #TMP_MV5103 M03
					GROUP BY M03.MaterialID
				) M03 ON M03.MaterialID = MV6103.MaterialID
    ) DATA
	
--- Làm Tròn Dữ liệu	
	UPDATE MT06
	SET MT06.ConvertedAmount = MT06.ConvertedAmount + AA.NewValue
	FROM MT0621 MT06
	INNER JOIN 
		(	SELECT MT06.ID,ROW_NUMBER() OVER( PARTITION BY MT06.MaterialID ORDER BY MT06.ConvertedAmount Desc)  [ROW]
		   ,ROUND(ISNULL(MV61.ConvertedAmount,0),@ConvertedDecimal) - MT061.ConvertedAmount [NewValue]
			FROM MT0621 MT06	
			INNER JOIN				
			( 		Select MaterialTypeID,ExpenseID,DivisionID, ISNULL(MaterialID,'')  [MaterialID],
							SUM(Quantity) AS Quantity,
							SUM(ConvertedAmount) AS ConvertedAmount 
					FROM MT0621 
					WHERE MaterialTypeID = @MaterialTypeID
						AND ExpenseID ='COST001'
						AND DivisionID =  @DivisionID
					GROUP BY MaterialTypeID,ExpenseID,DivisionID,ISNULL(MaterialID,'')			
			) MT061 
				ON MT06.MaterialTypeID = MT061.MaterialTypeID
				AND MT06.ExpenseID = MT061.ExpenseID
				AND MT06.DivisionID = MT061.DivisionID
				AND MT06.MaterialID = MT061.MaterialID
			LEFT JOIN #TMP_MV6103 MV61 
				ON ISNULL(MV61.MaterialID,0) = MT06.MaterialID			
			GROUP BY MT06.ID,MT06.MaterialID,MV61.ConvertedAmount,MT061.ConvertedAmount,MT06.ConvertedAmount
			HAVING (ROUND(ISNULL(MV61.ConvertedAmount,0),@ConvertedDecimal) - MT061.ConvertedAmount) <> 0
		) AA ON AA.ID = MT06.ID AND AA.[ROW] = 1

UPDATE MT0621 
SET ConvertedUnit = ConvertedAmount/ProductQuantity
WHERE ExpenseID = 'COST001'
AND DivisionID = @DivisionID
AND MaterialTypeID = @MaterialTypeID

--IF @CustomizeName = 57 ----------------- ANGEL làm tròn số lượng sau phân bổ
--BEGIN 
--	DECLARE @ID INT,
--			@Quantity DECIMAL(28,8)

--	SET @Cur  = Cursor Scroll KeySet FOR 
--		SELECT MT0621.MaterialID, A.MaterialQuantity - SUM(Isnull(MT0621.Quantity,0)) AS Quantity 
--		FROM MT0621 WITH (NOLOCK) 
--		LEFT JOIN #TMP_MV6103 A ON A.DivisionID = MT0621.DivisionID AND A.MaterialID = MT0621.MaterialID
--		WHERE MaterialTypeID = @MaterialTypeID
--			AND ExpenseID = 'COST001'
--		GROUP BY MT0621.MaterialID, A.MaterialQuantity 
--		HAVING A.MaterialQuantity - SUM(Isnull(MT0621.Quantity,0)) <> 0

--	OPEN @Cur
--	FETCH NEXT FROM @Cur INTO @MaterialID, @Quantity
--	WHILE @@Fetch_Status = 0
--		BEGIN
--    		SELECT TOP 1 @ID = ID FROM MT0621 WHERE MaterialID = @MaterialID AND DivisionID = @DivisionID AND ExpenseID = 'COST001' AND MaterialTypeID = @MaterialTypeID
    	
--    		UPDATE MT0621 
--    		SET Quantity = Quantity + @Quantity
--    		WHERE DivisionID = @DivisionID AND MaterialID = @MaterialID AND ExpenseID = 'COST001' AND ID = @ID
    		
--		FETCH NEXT FROM @Cur INTO  @MaterialID, @Quantity
    
--		END            
--	CLOSE @Cur
--END 

		



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

