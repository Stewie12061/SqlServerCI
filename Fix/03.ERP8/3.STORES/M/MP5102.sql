IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP5102]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[MP5102]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----- 	Created BY Nguyen Van Nhan AND Hoang Thi Lan; Date: 5/11/2003
---- 	Purpose: Phan bo chi phi NVL theo PP he so
----- 	Edit BY Quoc Hoai
----- 	Last updated Date 24/05/04, Van Nhan
/********************************************
'* Edited BY: [GS] [Thành Nguyên] [03/08/2010]
'********************************************/
----- Modify on 02/12/2015 by Phương Thảo: Bổ sung điều kiện where theo PeriodID vì store MP5000 bảng MT2222 đã bỏ điều kiện này
----- Modify on 25/02/2016 by Bảo Anh: Chỉ where theo PeriodID cho MT2222 nếu là Meiko
----- Modify on 25/04/2016 by Phương Thảo: Customize KH Meiko - Trừ bớt số lượng đầu kỳ trước
----- Modified by Bảo Thy on 24/05/2016: Bổ sung WITH (NOLOCK)
----- Modify on 21/06/2016 by Phương Thảo: Cải tiến tốc độ Meiko
----- Modify on 30/06/2017 by Bảo Anh: Bổ sung stote customize GodRej
---- Modified by Kim Thư on 13/12/2018 - Bổ sung lưu dữ liệu đã phân bổ vô table MT0400 => Không load MF0011 cải thiện tốc độ

CREATE Procedure [dbo].[MP5102] 	
				@DivisionID AS nvarchar(50), 
				@UserID AS VARCHAR(50),
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
	@InProcessID Varchar(50)
	

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName) 

IF(@CustomerName = 74)
BEGIN
	EXEC MP5102_GOD @DivisionID, @UserID, @PeriodID, @TranMonth, @TranYear, @MaterialTypeID, @CoefficientID
END

ELSE
BEGIN
SET @ConvertDecimal = (SELECT ConvertDecimal FROM MT0000 WITH (NOLOCK) where DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID)))

IF(@CustomerName = 50)
begin
	IF NOT EXISTS ( SELECT TOP 1 1 FROM MT1613 WITH (NOLOCK)
					WHERE TranMonth = @TranMonth and TranYear = @TranYear and DivisionID = @DivisionID AND Type ='B'  
							AND  PeriodID = @PeriodID)
	BEGIN 
		SELECT @InProcessID = (SELECT InprocessID FROM MT1601 WITH (NOLOCK) WHERE PeriodID = @PeriodID AND DivisionID = @DivisionID)

		DELETE MT1613 WHERE PeriodID = @PeriodID AND DivisionID = @DivisionID AND Type ='B'   
		EXEC MP8001 @DivisionID, @PeriodID, @TranMonth, @TranYear, @InProcessID
	END
end

---Print ' Van Nhan '
SET @sSQL='
Select 	MT1605.DivisionID, (Case  when MT1605.InventoryID is NULL then MT2222.ProductID ELSE MT1605.InventoryID END) AS ProductID ,
	MT2222.UnitID,		
	ISNULL(CoValue,0) AS  CoValue,
	'+ CASE WHEN @CustomerName = 50 THEN 'ISNULL(MT2222.ProductQuantity,0) - ISNULL(MT13.ProductQuantity,0) AS ProductQuantity,'  ELSE 'ISNULL(ProductQuantity,0) AS ProductQuantity,' END+'
	'+ CASE WHEN @CustomerName = 50 THEN 'CoValue* (ISNULL(MT2222.ProductQuantity,0) - ISNULL(MT13.ProductQuantity,0)) AS ProductCoValues ' ELSE  'CoValue* ProductQuantity AS ProductCoValues' END +'
FROM MT1605 WITH (NOLOCK)  Full JOIN MT2222 WITH (NOLOCK) ON MT2222.DivisionID = MT1605.DivisionID AND MT2222.ProductID = MT1605.InventoryID'

IF(@CustomerName = 50)
begin
set @sSQLwhere = ' LEFT JOIN (	SELECT DivisionID, PeriodID, ProductID , ISNULL(MAX(ProductQuantity),0) AS ProductQuantity
								FROM MT1613  WITH (NOLOCK)
								WHERE PeriodID = '''+@PeriodID+''' AND DivisionID = '''+@DivisionID+''' and ExpenseID = ''COST001'' AND Type = ''B''
								GROUP BY DivisionID, PeriodID, ProductID) MT13 
					ON  MT13.DivisionID = MT1605.DivisionID AND MT2222.PeriodID = MT13.PeriodID AND (Case  when MT1605.InventoryID is NULL then MT2222.ProductID ELSE MT1605.InventoryID END) = MT13.ProductID
					
	WHERE MT2222.PeriodID = N''' + @PeriodID + ''' AND CoefficientID = N'''+@CoefficientID+'''
    AND MT1605.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(N'''+@DivisionID+'''))		'
end
ELSE
begin
	
set @sSQLwhere = '
WHERE CoefficientID = N'''+@CoefficientID+'''
    AND MT1605.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(N'''+@DivisionID+'''))
'
end

IF NOT EXISTS (Select TOP 1 1 FROM SysObjects WITH (NOLOCK) WHERE name = 'MV5102' AND Xtype ='V')
	EXEC ('CREATE VIEW MV5102 AS '+@sSQL + @sSQLwhere)
ELSE
	EXEC ('ALTER VIEW MV5102 AS '+@sSQL+ @sSQLwhere)
	print @sSQL
	print @sSQLwhere
---- tao ra VIEW So 1
SET @sSQL='
Select DivisionID, InventoryID AS MaterialID , SUM( Case D_C  when  ''D'' then ISNULL(Quantity,0) ELSE - ISNULL(Quantity,0) END) AS MaterialQuantity,
	 SUM( Case D_C  when  ''D'' then   ISNULL(ConvertedAmount,0) ELSE - ISNULL(ConvertedAmount,0) END)  AS ConvertedAmount
FROM MV9000   --- INNER JOIN MT0700 ON MV9000.DebitAccountID=MT0700.AccountID
WHERE PeriodID = N'''+@PeriodID+''' 
    AND ExpenseID =''COST001'' 
    AND MaterialTypeID =N'''+@MaterialTypeID+''' 
    AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(N'''+@DivisionID+'''))
GROUP BY DivisionID,InventoryID '

IF NOT EXISTS (Select TOP 1 1 FROM SysObjects WITH (NOLOCK) WHERE name = 'MV6102' AND Xtype ='V')
	EXEC ('CREATE VIEW MV6102 AS '+@sSQL)
ELSE
	EXEC ('ALTER VIEW MV6102 AS '+@sSQL)
		
--select v5.*, AT1302.InventoryName from MV5102 v5 inner join AT1302 WITH (NOLOCK) on v5.ProductID = AT1302.InventoryID
--select * from MV6102 

------ Buoc 3  --- Xac dinh tong he so chung

SET @SumProductCovalues = (Select SUM(ISNULL(ProductCovalues,0)) FROM MV5102)
--select @SumProductCovalues
SET @ListProduct_cur = Cursor Scroll KeySet FOR 
	Select 	ProductID, ProductQuantity, ProductCoValues , UnitID
	FROM MV5102		
	WHERE ProductQuantity <> 0
	 
OPEN	@ListProduct_cur
FETCH NEXT FROM @ListProduct_cur INTO  @ProductID, @ProductQuantity, @ProductCoValues, @UnitID			
WHILE @@Fetch_Status = 0
	Begin	
		SET @ListMaterial_cur  = Cursor Scroll KeySet FOR 
		Select MaterialID , MaterialQuantity, ConvertedAmount FROM MV6102
		
		OPEN @ListMaterial_cur 
		FETCH NEXT FROM @ListMaterial_cur INTO  @MaterialID , @MaterialQuantity , @ConvertedAmount
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
				
				INSERT MT0621 (DivisionID, MaterialID, ProductID,  UnitID,     ExpenseID,  Quantity,  QuantityUnit,   MaterialTypeID,
					    	ConvertedAmount,  ConvertedUnit,    ProductQuantity, Rate  )
				VALUES (@DivisionID, @MaterialID, @ProductID,  @UnitID,   'COST001', @Quantity  ,  
					@QuantityUnit,   @MaterialTypeID,@ConvertedAmount1 ,  @ConvertedUnit,    @ProductQuantity, NULL)
				
				FETCH NEXT FROM @ListMaterial_cur INTO  @MaterialID , @MaterialQuantity , @ConvertedAmount
			END
		CLOSE @ListMaterial_cur
	 FETCH NEXT FROM @ListProduct_cur INTO  @ProductID, @ProductQuantity, @ProductCoValues, @UnitID
	END

CLOSE @ListProduct_cur

---- Xu ly lam tron
DECLARE @Detal_ConvertedAmount AS DECIMAL(28, 8),
	@Detal_MaterialQuantity  AS DECIMAL(28, 8),
	@ID AS DECIMAL(28,0)

SET @ListMaterial_cur  = Cursor Scroll KeySet FOR 
Select ISNULL(MaterialID,'')  , SUM(Quantity) AS Quantity, SUM(ConvertedAmount) AS ConvertedAmount 
FROM MT0621 WITH (NOLOCK) WHERE MaterialTypeID =@MaterialTypeID  AND ExpenseID ='COST001'
    AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
GROUP BY ISNULL(MaterialID,'')

OPEN @ListMaterial_cur 
FETCH NEXT FROM @ListMaterial_cur INTO  @MaterialID , @MaterialQuantity , @ConvertedAmount
WHILE @@Fetch_Status = 0
	Begin
		Select @Detal_ConvertedAmount =0, @Detal_MaterialQuantity = 0 
		Select  @Detal_ConvertedAmount =round( ISNULL((Select  SUM( Case D_C  when  'D' then   ISNULL(ConvertedAmount,0) ELSE - ISNULL(ConvertedAmount,0) END) 
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
				SET @ID = (Select TOP 1 ID  FROM MT0621  WITH (NOLOCK)
				           WHERE MaterialTypeID =@MaterialTypeID AND ExpenseID = 'COST001' AND ISNULL(MaterialID,'') = @MaterialID 
				                AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
				           Order BY  ConvertedAmount Desc )
				IF @ID is NOT NULL
				Update MT0621  SET ConvertedAmount = ConvertedAmount + @Detal_ConvertedAmount	 
					WHERE ID =@ID
    					AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
			END
	
		IF @Detal_MaterialQuantity <>0
			Begin
				SET @ID = NULL
				SET @ID = (Select TOP 1 ID  FROM MT0621  WITH (NOLOCK)
				           WHERE MaterialTypeID =@MaterialTypeID AND ExpenseID = 'COST001' AND ISNULL(MaterialID,'') = @MaterialID 
				                AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
				           Order BY  Quantity Desc )
				IF @ID is NOT NULL
					Update MT0621  SET Quantity = Quantity + @Detal_MaterialQuantity
					WHERE ID =@ID
    					AND DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(@DivisionID))
			END
		FETCH NEXT FROM @ListMaterial_cur INTO  @MaterialID , @MaterialQuantity , @ConvertedAmount
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
					Description, DivisionID, VoucherNo, VoucherDate, MaterialTypeID, VoucherTypeID, EmployeeID)

SELECT NEWID(), @PeriodID, Quantity, ProductQuantity, ConvertedAmount, ConvertedUnit, QuantityUnit, ProductID, MaterialID, ExpenseID, @TranMonth, @TranYear,
				@DistributeDescription + @PeriodStr, @DivisionID, @VoucherNo, GETDATE(), @MaterialTypeID, @ExpenseVoucherTypeID, @UserID
FROM MT0621	
WHERE ExpenseID = 'COST001'  AND MaterialTypeID = @MaterialTypeID
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

