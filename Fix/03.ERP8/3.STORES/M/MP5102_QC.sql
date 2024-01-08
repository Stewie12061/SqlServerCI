IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP5102_QC]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[MP5102_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Phân bổ chi phí NVL theo bộ hệ số (QL hàng hóa theo quy cách)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Bảo Anh on 05/12/2018
---- Modified by Kim Thư on 13/12/2018 - Bổ sung lưu dữ liệu đã phân bổ vô table MT0400 => Không load MF0011 cải thiện tốc độ

--- EXEC MP5102_QC 'VH', 'CD-EPTHO',10,2018,'M01','HS-Ver01'

CREATE Procedure [dbo].[MP5102_QC] 	
				@DivisionID AS nvarchar(50), 
				@UserID VARCHAR(50),
				@PeriodID AS nvarchar(50),
				@TranMonth AS INT,@TranYear AS INT,
				@MaterialTypeID AS nvarchar(50), 
				@CoefficientID AS nvarchar(50) 
AS 
DECLARE @sSQL AS nvarchar(4000), @sSQLwhere AS nvarchar(4000),
	@SumProductCovalues AS DECIMAL(28,8),
	@ListProduct_cur AS Cursor,
	@ProductID AS nvarchar(50),
	@ProductQuantity AS DECIMAL(28,8),
	@ProductCovalues AS DECIMAL(28,8),
	@ListMaterial_cur AS Cursor,
	@MaterialID AS nvarchar(50),
	@MaterialQuantity AS DECIMAL(28,8),
	@ConvertedAmount AS DECIMAL(28,8),
	@QuantityUnit AS DECIMAL(28,8),
	@ConvertedUnit	 AS DECIMAL(28,8),
	@UnitID AS nvarchar(50),
	@Quantity AS DECIMAL(28,8),
	@ConvertedAmount1 AS DECIMAL(28,8),
	@ConvertDecimal AS INT,
	@CustomerName INT,
	@InProcessID Varchar(50),
	@PS01ID Varchar(50), @PS02ID Varchar(50), @PS03ID Varchar(50), @PS04ID Varchar(50), @PS05ID Varchar(50),
	@PS06ID Varchar(50), @PS07ID Varchar(50), @PS08ID Varchar(50), @PS09ID Varchar(50), @PS10ID Varchar(50),
	@PS11ID Varchar(50), @PS12ID Varchar(50), @PS13ID Varchar(50), @PS14ID Varchar(50), @PS15ID Varchar(50),
	@PS16ID Varchar(50), @PS17ID Varchar(50), @PS18ID Varchar(50), @PS19ID Varchar(50), @PS20ID Varchar(50)

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName) 

SET @ConvertDecimal = (SELECT ConvertDecimal FROM MT0000 WITH (NOLOCK) where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)))

CREATE TABLE #MP5102_QC (DivisionID Varchar(50), ProductID Varchar(50), UnitID Varchar(50), CoValue decimal(28, 8), ProductQuantity decimal(28, 8), 
						ProductCoValues decimal(28, 8),
						PS01ID Varchar(50), PS02ID Varchar(50),	PS03ID Varchar(50),	PS04ID Varchar(50),	PS05ID Varchar(50),	
						PS06ID Varchar(50),	PS07ID Varchar(50),	PS08ID Varchar(50),	PS09ID Varchar(50),	PS10ID Varchar(50),
						PS11ID Varchar(50),	PS12ID Varchar(50),	PS13ID Varchar(50),	PS14ID Varchar(50),	PS15ID Varchar(50),
						PS16ID Varchar(50),	PS17ID Varchar(50),	PS18ID Varchar(50),	PS19ID Varchar(50),	PS20ID Varchar(50))
																										
INSERT INTO #MP5102_QC
SELECT 	MT1605.DivisionID, (Case  when MT1605.InventoryID is NULL then MT2222.ProductID ELSE MT1605.InventoryID END) AS ProductID ,
		MT2222.UnitID,		
		ISNULL(CoValue,0) AS  CoValue,
		ISNULL(ProductQuantity,0) AS ProductQuantity,
		CoValue * ISNULL(ProductQuantity,0) AS ProductCoValues,
		ISNULL(MT8899.S01ID, MT2222.PS01ID) AS PS01ID, ISNULL(MT8899.S02ID, MT2222.PS02ID) AS PS02ID, ISNULL(MT8899.S03ID, MT2222.PS03ID) AS PS03ID,
		ISNULL(MT8899.S04ID, MT2222.PS04ID) AS PS04ID, ISNULL(MT8899.S05ID, MT2222.PS05ID) AS PS05ID, ISNULL(MT8899.S06ID, MT2222.PS06ID) AS PS06ID,
		ISNULL(MT8899.S07ID, MT2222.PS07ID) AS PS07ID, ISNULL(MT8899.S08ID, MT2222.PS08ID) AS PS08ID, ISNULL(MT8899.S09ID, MT2222.PS09ID) AS PS09ID,
		ISNULL(MT8899.S10ID, MT2222.PS10ID) AS PS10ID, ISNULL(MT8899.S11ID, MT2222.PS11ID) AS PS11ID, ISNULL(MT8899.S12ID, MT2222.PS12ID) AS PS12ID,
		ISNULL(MT8899.S13ID, MT2222.PS13ID) AS PS13ID, ISNULL(MT8899.S14ID, MT2222.PS14ID) AS PS14ID, ISNULL(MT8899.S15ID, MT2222.PS15ID) AS PS15ID,
		ISNULL(MT8899.S16ID, MT2222.PS16ID) AS PS16ID, ISNULL(MT8899.S17ID, MT2222.PS17ID) AS PS17ID, ISNULL(MT8899.S18ID, MT2222.PS18ID) AS PS18ID,
		ISNULL(MT8899.S19ID, MT2222.PS19ID) AS PS19ID, ISNULL(MT8899.S20ID, MT2222.PS20ID) AS PS20ID
FROM MT1605 WITH (NOLOCK)
LEFT JOIN MT8899 WITH (NOLOCK) ON MT1605.DivisionID = MT8899.DivisionID AND MT8899.TableID = 'MT1605'
	AND MT1605.CoefficientID = MT8899.VoucherID AND MT1605.DeCoefficientID = MT8899.TransactionID
FULL JOIN MT2222 WITH (NOLOCK) ON MT2222.DivisionID = MT1605.DivisionID AND MT2222.ProductID = MT1605.InventoryID
	AND ISNULL(MT8899.S01ID,'') = ISNULL(MT2222.PS01ID,'') AND ISNULL(MT8899.S02ID,'') = ISNULL(MT2222.PS02ID,'') AND ISNULL(MT8899.S03ID,'') = ISNULL(MT2222.PS03ID,'') AND ISNULL(MT8899.S04ID,'') = ISNULL(MT2222.PS04ID,'') AND ISNULL(MT8899.S05ID,'') = ISNULL(MT2222.PS05ID,'') 
	AND ISNULL(MT8899.S06ID,'') = ISNULL(MT2222.PS06ID,'') AND ISNULL(MT8899.S07ID,'') = ISNULL(MT2222.PS07ID,'') AND ISNULL(MT8899.S08ID,'') = ISNULL(MT2222.PS08ID,'') AND ISNULL(MT8899.S09ID,'') = ISNULL(MT2222.PS09ID,'') AND ISNULL(MT8899.S10ID,'') = ISNULL(MT2222.PS10ID,'') 
	AND ISNULL(MT8899.S11ID,'') = ISNULL(MT2222.PS11ID,'') AND ISNULL(MT8899.S12ID,'') = ISNULL(MT2222.PS12ID,'') AND ISNULL(MT8899.S13ID,'') = ISNULL(MT2222.PS13ID,'') AND ISNULL(MT8899.S14ID,'') = ISNULL(MT2222.PS14ID,'') AND ISNULL(MT8899.S15ID,'') = ISNULL(MT2222.PS15ID,'') 
	AND ISNULL(MT8899.S16ID,'') = ISNULL(MT2222.PS16ID,'') AND ISNULL(MT8899.S17ID,'') = ISNULL(MT2222.PS17ID,'') AND ISNULL(MT8899.S18ID,'') = ISNULL(MT2222.PS18ID,'') AND ISNULL(MT8899.S19ID,'') = ISNULL(MT2222.PS19ID,'') AND ISNULL(MT8899.S20ID,'') = ISNULL(MT2222.PS20ID,'') 
WHERE MT1605.CoefficientID = @CoefficientID
AND MT1605.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)) 

SET @sSQL='
Select	DivisionID, InventoryID AS MaterialID,
		SUM( Case D_C  when  ''D'' then ISNULL(Quantity,0) ELSE - ISNULL(Quantity,0) END) AS MaterialQuantity,
		SUM( Case D_C  when  ''D'' then   ISNULL(ConvertedAmount,0) ELSE - ISNULL(ConvertedAmount,0) END)  AS ConvertedAmount
FROM MV9000   --- INNER JOIN MT0700 ON MV9000.DebitAccountID=MT0700.AccountID
WHERE PeriodID = N'''+@PeriodID+''' 
    AND ExpenseID =''COST001'' 
    AND MaterialTypeID =N'''+@MaterialTypeID+''' 
    AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(N'''+@DivisionID+'''))
GROUP BY DivisionID,InventoryID'

IF NOT EXISTS (Select TOP 1 1 FROM SysObjects WITH (NOLOCK) WHERE name = 'MV6102' AND Xtype ='V')
	EXEC ('CREATE VIEW MV6102 AS '+@sSQL)
ELSE
	EXEC ('ALTER VIEW MV6102 AS '+@sSQL)
		
----- Xac dinh tong he so chung
SET @SumProductCovalues = (Select SUM(ISNULL(ProductCovalues,0)) FROM #MP5102_QC)

SET @ListProduct_cur = Cursor Scroll KeySet FOR 
	Select 	ProductID, PS01ID, PS02ID, PS03ID, PS04ID, PS05ID, PS06ID, PS07ID, PS08ID, PS09ID, PS10ID,
			PS11ID, PS12ID, PS13ID, PS14ID, PS15ID, PS16ID, PS17ID, PS18ID, PS19ID, PS20ID, ProductQuantity, ProductCoValues, UnitID
	FROM #MP5102_QC		
	WHERE ProductQuantity <> 0
	 
OPEN	@ListProduct_cur
FETCH NEXT FROM @ListProduct_cur INTO @ProductID, @PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
				@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID, @ProductQuantity, @ProductCoValues, @UnitID			
WHILE @@Fetch_Status = 0
	Begin	
		SET @ListMaterial_cur  = Cursor Scroll KeySet FOR 
		Select	MaterialID, MaterialQuantity, ConvertedAmount
		FROM MV6102
		
		OPEN @ListMaterial_cur 
		FETCH NEXT FROM @ListMaterial_cur INTO @MaterialID, @MaterialQuantity, @ConvertedAmount
			
		WHILE @@Fetch_Status = 0
			Begin				
				---- Phan bo so luong NVL cho mot san pham
				IF ISNULL(@SumProductCovalues,0) <> 0 AND  ISNULL(@ProductQuantity,0)<>0		
					SET @QuantityUnit=(ISNULL(@MaterialQuantity,0)/@SumProductCovalues)*ISNULL(@ProductCoValues,0)/ @ProductQuantity 
				ELSE SET @QuantityUnit=0				
				
				---- Phan bo thanh tien chi phi mot nguyen vat lieu cho mot san pham
				IF ISNULL(@SumProductCovalues,0) <> 0 AND  ISNULL(@ProductQuantity,0)<> 0					
				   SET @ConvertedUnit = (@ConvertedAmount/@SumProductCovalues)*@ProductCoValues/@ProductQuantity					
				ELSE SET @ConvertedUnit = 0
				--INSERT vao bang MT0612
				IF ISNULL(@SumProductCovalues,0) <>0 
					Begin
						SET @Quantity =	(ISNULL(@MaterialQuantity,0)* ISNULL(@ProductCoValues,0)/@SumProductCovalues) 
						SET @ConvertedAmount1 = Round( (ISNULL(@ConvertedAmount,0)*ISNULL(@ProductCoValues,0)/@SumProductCovalues), @ConvertDecimal)
					END			
				ELSE 
					Begin
						SET @Quantity = 0
						SET @ConvertedAmount1 = 0
					END
				
				INSERT MT0621 (	DivisionID, MaterialID,
								ProductID, PS01ID, PS02ID, PS03ID, PS04ID, PS05ID, PS06ID, PS07ID, PS08ID, PS09ID, PS10ID,
								PS11ID, PS12ID, PS13ID, PS14ID, PS15ID, PS16ID, PS17ID, PS18ID, PS19ID, PS20ID,
								UnitID, ExpenseID, Quantity, QuantityUnit, MaterialTypeID, ConvertedAmount, ConvertedUnit, ProductQuantity, Rate)
				VALUES (@DivisionID, @MaterialID,
						@ProductID, @PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
						@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID,
						@UnitID, 'COST001', @Quantity, @QuantityUnit, @MaterialTypeID,@ConvertedAmount1, @ConvertedUnit, @ProductQuantity, NULL)
				
				FETCH NEXT FROM @ListMaterial_cur INTO @MaterialID, @MaterialQuantity, @ConvertedAmount
			END
		CLOSE @ListMaterial_cur
		
	 FETCH NEXT FROM @ListProduct_cur INTO @ProductID, @PS01ID, @PS02ID, @PS03ID, @PS04ID, @PS05ID, @PS06ID, @PS07ID, @PS08ID, @PS09ID, @PS10ID,
				@PS11ID, @PS12ID, @PS13ID, @PS14ID, @PS15ID, @PS16ID, @PS17ID, @PS18ID, @PS19ID, @PS20ID, @ProductQuantity, @ProductCoValues, @UnitID
	END

CLOSE @ListProduct_cur

---- Xu ly lam tron
DECLARE @Detal_ConvertedAmount AS DECIMAL(28, 8),
	@Detal_MaterialQuantity  AS DECIMAL(28, 8),
	@ID AS DECIMAL(28,0)

SET @ListMaterial_cur  = Cursor Scroll KeySet FOR 
Select	ISNULL(MaterialID,''),
		SUM(Quantity) AS Quantity, SUM(ConvertedAmount) AS ConvertedAmount 
FROM MT0621 WITH (NOLOCK) WHERE MaterialTypeID =@MaterialTypeID AND ExpenseID ='COST001'
    AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
GROUP BY ISNULL(MaterialID,'')

OPEN @ListMaterial_cur 
FETCH NEXT FROM @ListMaterial_cur INTO @MaterialID, @MaterialQuantity, @ConvertedAmount
WHILE @@Fetch_Status = 0
	Begin
		Select @Detal_ConvertedAmount =0, @Detal_MaterialQuantity = 0 
		Select @Detal_ConvertedAmount =round( ISNULL((Select  SUM( Case D_C  when  'D' then   ISNULL(ConvertedAmount,0) ELSE - ISNULL(ConvertedAmount,0) END) 
				                                       FROM MV9000 
				                                       WHERE PeriodID =@PeriodID 
				                                            AND MaterialTypeID = @MaterialTypeID 
				                                            AND ISNULL(InventoryID,'')  = @MaterialID															
				                                            AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))),0),@ConvertDecimal) - @ConvertedAmount,
				
				@Detal_MaterialQuantity =  ISNULL((Select  SUM( Case D_C  when  'D' then   ISNULL(Quantity,0) ELSE - ISNULL(Quantity,0) END)  
				                                   FROM MV9000 
				                                   WHERE PeriodID =@PeriodID 
				                                        AND MaterialTypeID =@MaterialTypeID 
				                                        AND ISNULL(InventoryID,'')  = @MaterialID
														AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))),0) - @MaterialQuantity
				                                        
		IF @Detal_ConvertedAmount <>0
			Begin
				SET @ID = NULL
				SET @ID = (Select TOP 1 ID FROM MT0621 WITH (NOLOCK)
				           WHERE MaterialTypeID =@MaterialTypeID AND ExpenseID = 'COST001' AND ISNULL(MaterialID,'') = @MaterialID								
				                AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
				           Order BY ConvertedAmount Desc)

				IF @ID is NOT NULL
					Update MT0621 SET ConvertedAmount = ConvertedAmount + @Detal_ConvertedAmount	 
					WHERE ID =@ID
    					AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
			END
	
		IF @Detal_MaterialQuantity <>0
			Begin
				SET @ID = NULL
				SET @ID = (Select TOP 1 ID  FROM MT0621 WITH (NOLOCK)
				           WHERE MaterialTypeID =@MaterialTypeID AND ExpenseID = 'COST001' AND ISNULL(MaterialID,'') = @MaterialID
								AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
				           Order BY Quantity Desc)

				IF @ID is NOT NULL
					Update MT0621 SET Quantity = Quantity + @Detal_MaterialQuantity
					WHERE ID =@ID
    					AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
			END
		FETCH NEXT FROM @ListMaterial_cur INTO @MaterialID, @MaterialQuantity, @ConvertedAmount
	END

CLOSE @ListMaterial_cur

-- SINH SỐ CHỨNG TỪ PHÂN BỔ TỰ ĐỘNG
DECLARE @Enabled1 TINYINT,
		@Enabled2 TINYINT,
		@Enabled3 TINYINT,
		@S1 NVARCHAR(50),
		@S2 NVARCHAR(50),
		@S3 NVARCHAR(50),
		@S1Type TINYINT,
		@S2Type TINYINT,
		@S3Type TINYINT,
		@VoucherNo NVARCHAR(50),
		@StringKey1 nvarchar(50),
		@StringKey2 nvarchar(50),
		@StringKey3 nvarchar(50), 
		@OutputLen int, 
		@OutputOrder int,
		@Separated int, 
		@Separator char(1),
		@ExpenseVoucherTypeID VARCHAR(50),
		@DistributeDescription NVARCHAR(1000),
		@PeriodStr VARCHAR(20)

SET @ExpenseVoucherTypeID = (SELECT ISNULL(ExpenseVoucherTypeID,'PBO') FROM MT0000 WHERE DivisionID = @DivisionID)
SET @DistributeDescription = (SELECT ISNULL(DistributeDescription + ' ',N'Phân bổ chi phí ') FROM MT0000 WITH (NOLOCK) WHERE DivisionID = @DivisionID)
SET @PeriodStr = CASE WHEN @TranMonth < 10 THEN '0' + ltrim(@TranMonth) + ltrim(@TranYear) ELSE ltrim(@TranMonth) + ltrim(@TranYear) END

--LẤY CHỈ SỐ TĂNG SỐ CHỨNG TỪ
Select	@Enabled1=Enabled1, @Enabled2=Enabled2, @Enabled3=Enabled3, @S1=S1, @S2=S2, @S3=S3, @S1Type=S1Type, @S2Type=S2Type, @S3Type=S3Type,
		@OutputLen=OutputLength, @OutputOrder=OutputOrder, @Separated=Separated, @Separator=Separator
From AT1007 WITH (NOLOCK) Where DivisionID = @DivisionID AND VoucherTypeID = @ExpenseVoucherTypeID

If @Enabled1 = 1
	SET @StringKey1 = 
	Case @S1Type 
	When 1 Then Case When @TranMonth <10 Then '0' + ltrim(@TranMonth) Else ltrim(@TranMonth) End
	When 2 Then ltrim(@TranYear)
	When 3 Then @ExpenseVoucherTypeID
	When 4 Then @DivisionID
	When 5 Then @S1
	Else '' End
Else
	SET @StringKey1 = ''

If @Enabled2 = 1
	SET @StringKey2 = 
	Case @S2Type 
	When 1 Then Case When @TranMonth <10 Then '0' + ltrim(@TranMonth) Else ltrim(@TranMonth) End
	When 2 Then ltrim(@TranYear)
	When 3 Then @ExpenseVoucherTypeID
	When 4 Then @DivisionID
	When 5 Then @S2
	Else '' End
Else
	SET @StringKey2 = ''

If @Enabled3 = 1
	SET @StringKey3 = 
	Case @S3Type 
	When 1 Then Case When @TranMonth <10 Then '0' + ltrim(@TranMonth) Else ltrim(@TranMonth) End
	When 2 Then ltrim(@TranYear)
	When 3 Then @ExpenseVoucherTypeID
	When 4 Then @DivisionID
	When 5 Then @S3
	Else '' End
Else
	SET @StringKey3 = ''


Recal:
--- SINH SỐ CHỨNG TỪ PHÂN BỔ
Exec AP0000  @DivisionID, @VoucherNo OUTPUT, 'MT0400', @StringKey1, @StringKey2, @StringKey3, @OutputLen, @OutputOrder, @Separated, @Separator

IF EXISTS (SELECT 1 FROM MT0400 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND VoucherNo = @VoucherNo)
	GOTO Recal

--INSERT VÀO BẢNG KẾT QUẢ PHÂN BỔ - MT0400
INSERT INTO MT0400 (ApportionCostID, PeriodID, MaterialQuantity, ProductQuantity, ConvertedAmount, ConvertedUnit, QuantityUnit, ProductID, MaterialID,ExpenseID, TranMonth, TranYear,
					Description, DivisionID, VoucherNo, VoucherDate, MaterialTypeID, VoucherTypeID, EmployeeID, PS01ID, PS02ID, PS03ID, PS04ID, PS05ID, PS06ID, PS07ID, PS08ID, PS09ID, PS10ID,
					PS11ID, PS12ID, PS13ID, PS14ID, PS15ID, PS16ID, PS17ID, PS18ID, PS19ID, PS20ID)

SELECT NEWID(), @PeriodID, Quantity, ProductQuantity, ConvertedAmount, ConvertedUnit, QuantityUnit, ProductID, MaterialID, ExpenseID, @TranMonth, @TranYear,
				@DistributeDescription + @PeriodStr, @DivisionID, @VoucherNo, GETDATE(), @MaterialTypeID, @ExpenseVoucherTypeID, @UserID, PS01ID, PS02ID, PS03ID, PS04ID, PS05ID, PS06ID, PS07ID, PS08ID, PS09ID, PS10ID,
					PS11ID, PS12ID, PS13ID, PS14ID, PS15ID, PS16ID, PS17ID, PS18ID, PS19ID, PS20ID
FROM MT0621	
WHERE ExpenseID = 'COST001'  AND MaterialTypeID = @MaterialTypeID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

