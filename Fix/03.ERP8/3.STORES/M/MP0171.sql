IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0171]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0171]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Customize Angel: Load tình hình dự kiến sử dụng vật tư ở MH chi tiết các đợt sản xuất
---- Created by Bảo Anh, Date: 09/03/2016
---- Modified by Tiểu Mai on 27/07/2016: Fix bug load sai dữ liệu theo công thức của ANGEL
---- Modified by Tiểu Mai on 11/11/2016: Fix lấy dữ liệu theo yêu cầu ANGEL
---- Modified by Bảo Anh on 26/04/2017: Sửa danh mục dùng chung (bỏ kết theo DivisionID)
---- Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.
/*
exec MP0171 @DivisionID=N'ANG',@TranMonth=2,@TranYear=2016,@TransactionID=N'd4ef527b-37dc-4913-be81-b5fa755f4628',@VoucherDate='2016-02-28 00:00:00',@PurchasePlanID=N'a9470651-f727-4a5f-a28e-bc9545ea0ac3'
*/

CREATE PROCEDURE [dbo].[MP0171] 
    @DivisionID NVARCHAR(50),
	@TranMonth int,
	@TranYear int,
    @TransactionID AS NVARCHAR(50),
	@VoucherDate as datetime,	--- ngày lập dự tính sản xuất
	@PurchasePlanID as nvarchar(50)	 --- kế hoạch mua hàng
AS
Declare @InventoryID nvarchar(50),
		@ApportionID nvarchar(50),
		@Quantity decimal(28,8),
		@SQL varchar(max),
		@SQL1 varchar(max),
		@SQL2 varchar(max),
		@SQL3 varchar(max),
		@SQL4 varchar(max),
		@SQL5 varchar(max),
		@SQL6 varchar(max),
		@i TINYINT,
		@MaterialID NVARCHAR(50),
		@Cursor CURSOR

SET @SQL = ''
SET @SQL1 = ''
SET @SQL2 = ''
SET @SQL3 = ''
SET @SQL4 = ''
SET @SQL5 = ''
SET @SQL6 = ''
SET @i = 1

SELECT @InventoryID = InventoryID, @ApportionID = ApportionID, @Quantity = Quantity
FROM MT0170
WHERE DivisionID = @DivisionID AND TransactionID = @TransactionID


IF EXISTS (SELECT * FROM sysobjects WHERE NAME='TEM' AND xtype='U')
	DROP TABLE TEM

CREATE TABLE TEM 
(
TEM_MaterialID NVARCHAR(50),
TEM_MaterialUnitID NVARCHAR(50),
TEM_MaterialEndQuantity DECIMAL(28,8),
TEM_MaterialQuantity DECIMAL(28,8), 
TEM_DebitQuantity01 DECIMAL(28,8), TEM_CreditQuantity01 DECIMAL(28,8), TEM_DebitQuantity02 DECIMAL(28,8),  TEM_CreditQuantity02 DECIMAL(28,8), TEM_DebitQuantity03 DECIMAL(28,8),  TEM_CreditQuantity03 DECIMAL(28,8), TEM_DebitQuantity04 DECIMAL(28,8),  TEM_CreditQuantity04 DECIMAL(28,8), TEM_DebitQuantity05 DECIMAL(28,8), TEM_CreditQuantity05 DECIMAL(28,8), TEM_DebitQuantity06 DECIMAL(28,8), TEM_CreditQuantity06 DECIMAL(28,8), TEM_DebitQuantity07 DECIMAL(28,8), TEM_CreditQuantity07 DECIMAL(28,8), TEM_DebitQuantity08 DECIMAL(28,8), TEM_CreditQuantity08 DECIMAL(28,8), TEM_DebitQuantity09 DECIMAL(28,8), TEM_CreditQuantity09 DECIMAL(28,8), TEM_DebitQuantity10 DECIMAL(28,8), TEM_CreditQuantity10 DECIMAL(28,8),
TEM_DebitQuantity11 DECIMAL(28,8), TEM_CreditQuantity11 DECIMAL(28,8), TEM_DebitQuantity12 DECIMAL(28,8),  TEM_CreditQuantity12 DECIMAL(28,8), TEM_DebitQuantity13 DECIMAL(28,8),  TEM_CreditQuantity13 DECIMAL(28,8), TEM_DebitQuantity14 DECIMAL(28,8),  TEM_CreditQuantity14 DECIMAL(28,8), TEM_DebitQuantity15 DECIMAL(28,8), TEM_CreditQuantity15 DECIMAL(28,8), TEM_DebitQuantity16 DECIMAL(28,8), TEM_CreditQuantity16 DECIMAL(28,8), TEM_DebitQuantity17 DECIMAL(28,8), TEM_CreditQuantity17 DECIMAL(28,8), TEM_DebitQuantity18 DECIMAL(28,8), TEM_CreditQuantity18 DECIMAL(28,8), TEM_DebitQuantity19 DECIMAL(28,8), TEM_CreditQuantity19 DECIMAL(28,8), TEM_DebitQuantity20 DECIMAL(28,8), TEM_CreditQuantity20 DECIMAL(28,8),
TEM_DebitQuantity21 DECIMAL(28,8), TEM_CreditQuantity21 DECIMAL(28,8), TEM_DebitQuantity22 DECIMAL(28,8),  TEM_CreditQuantity22 DECIMAL(28,8), TEM_DebitQuantity23 DECIMAL(28,8),  TEM_CreditQuantity23 DECIMAL(28,8), TEM_DebitQuantity24 DECIMAL(28,8),  TEM_CreditQuantity24 DECIMAL(28,8), TEM_DebitQuantity25 DECIMAL(28,8), TEM_CreditQuantity25 DECIMAL(28,8), TEM_DebitQuantity26 DECIMAL(28,8), TEM_CreditQuantity26 DECIMAL(28,8), TEM_DebitQuantity27 DECIMAL(28,8), TEM_CreditQuantity27 DECIMAL(28,8), TEM_DebitQuantity28 DECIMAL(28,8), TEM_CreditQuantity28 DECIMAL(28,8), TEM_DebitQuantity29 DECIMAL(28,8), TEM_CreditQuantity29 DECIMAL(28,8), TEM_DebitQuantity30 DECIMAL(28,8), TEM_CreditQuantity30 DECIMAL(28,8),
TEM_DebitQuantity31 DECIMAL(28,8), TEM_CreditQuantity31 DECIMAL(28,8)
	
)

Set @Cursor  = Cursor Scroll KeySet FOR
SELECT MaterialID FROM MT1603 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND ApportionID = @ApportionID AND ProductID = @InventoryID
Open @Cursor 
FETCH NEXT FROM @Cursor INTO @MaterialID					
WHILE @@Fetch_Status = 0
	Begin	
		
		EXEC MP0172 @DivisionID, @TranMonth, @TranYear, @TransactionID, @VoucherDate,@PurchasePlanID, @MaterialID,@Quantity, @ApportionID

		FETCH NEXT FROM @Cursor INTO  @MaterialID

	End
Close @Cursor

--SELECT * FROM TEM WHERE TEM_MaterialID = 'VLTEMSTB'

SELECT MT03.MaterialID, AT1302.InventoryName as MaterialName, MT03.MaterialUnitID, AT1304.UnitName as MaterialUnitName,
(Select Sum(SignQuantity) From AV7000 Where DivisionID = @DivisionID And (VoucherDate <= @VoucherDate OR D_C = 'BD') And InventoryID = MT03.MaterialID) as MaterialEndQuantity,
@Quantity * MT03.QuantityUnit * (case when Isnull(MT03.RateWastage,0) = 0 then 1 else MT03.RateWastage end) as MaterialQuantity, AT1302.I01ID as ProductTypeID, MT0171.BeginDate, MT0171.FinishDate, MT0171.Quantity as FinishQuantity,
OT0156.ReceiveDate, OT0156.ActualQuantity, 0 AS [Type]
INTO #TAM
FROM MT1603 MT03 WITH (NOLOCK)
LEFT JOIN AT1302 WITH (NOLOCK) ON MT03.MaterialID = AT1302.InventoryID AND AT1302.DivisionID IN (MT03.DivisionID,'@@@')
LEFT JOIN AT1304 WITH (NOLOCK) ON MT03.MaterialUnitID = AT1304.UnitID
LEFT JOIN MT0171 WITH (NOLOCK) ON MT03.DivisionID = MT0171.DivisionID And MT0171.TranMonth = @TranMonth and MT0171.TranYear = @TranYear And MT0171.InventoryID = MT03.MaterialID
LEFT JOIN OT0156 WITH (NOLOCK) ON MT03.DivisionID = OT0156.DivisionID And OT0156.VoucherID = @PurchasePlanID And MT03.MaterialID = OT0156.InventoryID
WHERE MT03.DivisionID = @DivisionID AND MT03.ApportionID = @ApportionID AND MT03.ProductID = @InventoryID AND ExpenseID = 'COST001'

UNION 

SELECT MT03.MaterialID, AT1302.InventoryName as MaterialName, MT03.MaterialUnitID, AT1304.UnitName as MaterialUnitName,
(Select Sum(SignQuantity) From AV7000 Where DivisionID = @DivisionID And (VoucherDate <= @VoucherDate OR D_C = 'BD') And InventoryID = MT03.MaterialID) as MaterialEndQuantity,
MT0171.Quantity * MT03.QuantityUnit * (case when Isnull(MT03.RateWastage,0) = 0 then 1 else MT03.RateWastage end) as MaterialQuantity, 
AT1302.I01ID as ProductTypeID, 
MT0171.BeginDate, MT0171.FinishDate, MT0171.Quantity * MT03.QuantityUnit * (case when Isnull(MT03.RateWastage,0) = 0 then 1 else MT03.RateWastage end) as FinishQuantity,
NULL as ReceiveDate, 0 as ActualQuantity, 1 AS [Type]
FROM MT1603 MT03 WITH (NOLOCK)
LEFT JOIN AT1302 WITH (NOLOCK) ON MT03.MaterialID = AT1302.InventoryID AND AT1302.DivisionID IN (MT03.DivisionID,'@@@')
LEFT JOIN AT1304 WITH (NOLOCK) ON MT03.MaterialUnitID = AT1304.UnitID
LEFT JOIN MT0171 WITH (NOLOCK) ON MT03.DivisionID = MT0171.DivisionID And MT0171.TranMonth = @TranMonth and MT0171.TranYear = @TranYear And MT0171.InventoryID = MT03.ProductID
LEFT JOIN OT0156 WITH (NOLOCK) ON MT03.DivisionID = OT0156.DivisionID And OT0156.VoucherID = @PurchasePlanID And MT03.MaterialID = OT0156.InventoryID
WHERE MT03.DivisionID = @DivisionID AND MT03.ApportionID = @ApportionID AND MT03.ProductID = @InventoryID AND ExpenseID = 'COST001'

SET @SQL = '
SELECT MaterialID,MaterialName,MaterialUnitID,MaterialUnitName,MaterialEndQuantity,Isnull(MaterialQuantity,0) as MaterialQuantity,[Type],'

SET @SQL1 = '
SELECT MaterialID,MaterialName,MaterialUnitID,MaterialUnitName,MaterialEndQuantity,SUM(MaterialQuantity) AS MaterialQuantity,'

SET @SQL2 = '
SELECT MaterialID,MaterialName,MaterialUnitID,MaterialUnitName,Isnull(MaterialEndQuantity,0) as MaterialEndQuantity,MAX(MaterialQuantity) as MaterialQuantity,'

While @i <=31
Begin
	
	IF @i <= 10
		SET @SQL = @SQL + '
			sum(case when Isnull(day(FinishDate),0)=' + ltrim(@i) + ' and [Type]=0 then FinishQuantity else 0 end) 
			+ sum(case when Isnull(day(ReceiveDate),0)=' + ltrim(@i) + ' and [Type]=0 then ActualQuantity else 0 end) as DebitQuantity' + (case when @i < 10 then '0' else '' end) + ltrim(@i) + ',
			sum(case when Isnull(day(BeginDate),0)=' + ltrim(@i) + ' and [Type]=1 then FinishQuantity else 0 end) as CreditQuantity' + (case when @i < 10 then '0' else '' end) + ltrim(@i) + ','
	ELSE 
		SET @SQL5 = @SQL5 + '
			sum(case when Isnull(day(FinishDate),0)=' + ltrim(@i) + ' and [Type]=0 then FinishQuantity else 0 end) 
			+ sum(case when Isnull(day(ReceiveDate),0)=' + ltrim(@i) + ' and [Type]=0 then ActualQuantity else 0 end) as DebitQuantity' + (case when @i < 10 then '0' else '' end) + ltrim(@i) + ',
			sum(case when Isnull(day(BeginDate),0)=' + ltrim(@i) + ' and [Type]=1 then FinishQuantity else 0 end) as CreditQuantity' + (case when @i < 10 then '0' else '' end) + ltrim(@i) + ','
			
	SET @SQL1 = @SQL1 + '
		sum(DebitQuantity' + (case when @i < 10 then '0' else '' end) + ltrim(@i) + ') as DebitQuantity'+(case when @i < 10 then '0' else '' end) + ltrim(@i)+',
		sum(CreditQuantity' + (case when @i < 10 then '0' else '' end) + ltrim(@i) + ') as CreditQuantity'+(case when @i < 10 then '0' else '' end) + ltrim(@i)+','	
	
	SET @SQL2 =  @SQL2 + '
		sum(DebitQuantity' + (case when @i < 10 then '0' else '' end) + ltrim(@i) + ') as DebitQuantity'+(case when @i < 10 then '0' else '' end) + ltrim(@i)+',
		sum(CreditQuantity' + (case when @i < 10 then '0' else '' end) + ltrim(@i) + ') as CreditQuantity'+(case when @i < 10 then '0' else '' end) + ltrim(@i)+','	
		
		SET @i = @i+1
End

SET @SQL5 = LEFT(@SQL5,len(@SQL5)-1)

SET @SQL5 = @SQL5 + '
INTO #TAM1
FROM #TAM
GROUP BY MaterialID, MaterialName, MaterialUnitID, MaterialUnitName, MaterialEndQuantity, MaterialQuantity,[Type]'

SET @SQL1 = LEFT(@SQL1,len(@SQL1)-1)
SET @SQL3 = @SQL3 + '
INTO #TAM2
FROM #TAM1
WHERE [Type] = 1
GROUP BY MaterialID, MaterialName, MaterialUnitID, MaterialUnitName, MaterialEndQuantity'

SET @SQL4 = @SQL4 + '
FROM #TAM1
WHERE [Type] = 0
GROUP BY MaterialID, MaterialName, MaterialUnitID, MaterialUnitName, MaterialEndQuantity'

SET @SQL2 = LEFT(@SQL2,len(@SQL2)-1)
SET @SQL2 = @SQL2 + '
INTO #TAM3
FROM #TAM2
GROUP BY MaterialID, MaterialName, MaterialUnitID, MaterialUnitName, MaterialEndQuantity
'

SET @SQL6 = @SQL6 + '
SELECT t1.MaterialID, t1.MaterialName, t1.MaterialUnitID, t1.MaterialUnitName, t1.MaterialEndQuantity,t1.MaterialQuantity,
DebitQuantity01 + 0 AS DebitQuantity01, CreditQuantity01 + TEM_CreditQuantity01 AS CreditQuantity01, 
DebitQuantity02 + 0 AS DebitQuantity02, CreditQuantity02 + TEM_CreditQuantity02 AS CreditQuantity02, 
DebitQuantity03 + 0 AS DebitQuantity03, CreditQuantity03 + TEM_CreditQuantity03 AS CreditQuantity03, 
DebitQuantity04 + 0 AS DebitQuantity04, CreditQuantity04 + TEM_CreditQuantity04 AS CreditQuantity04, 
DebitQuantity05 + 0 AS DebitQuantity05, CreditQuantity05 + TEM_CreditQuantity05 AS CreditQuantity05, 
DebitQuantity06 + 0 AS DebitQuantity06, CreditQuantity06 + TEM_CreditQuantity06 AS CreditQuantity06, 
DebitQuantity07 + 0 AS DebitQuantity07, CreditQuantity07 + TEM_CreditQuantity07 AS CreditQuantity07, 
DebitQuantity08 + 0 AS DebitQuantity08, CreditQuantity08 + TEM_CreditQuantity08 AS CreditQuantity08, 
DebitQuantity09 + 0 AS DebitQuantity09, CreditQuantity09 + TEM_CreditQuantity09 AS CreditQuantity09, 
DebitQuantity10 + 0 AS DebitQuantity10, CreditQuantity10 + TEM_CreditQuantity10 AS CreditQuantity10, 
DebitQuantity11 + 0 AS DebitQuantity11, CreditQuantity11 + TEM_CreditQuantity11 AS CreditQuantity11, 
DebitQuantity12 + 0 AS DebitQuantity12, CreditQuantity12 + TEM_CreditQuantity12 AS CreditQuantity12, 
DebitQuantity13 + 0 AS DebitQuantity13, CreditQuantity13 + TEM_CreditQuantity13 AS CreditQuantity13, 
DebitQuantity14 + 0 AS DebitQuantity14, CreditQuantity14 + TEM_CreditQuantity14 AS CreditQuantity14, 
DebitQuantity15 + 0 AS DebitQuantity15, CreditQuantity15 + TEM_CreditQuantity15 AS CreditQuantity15, 
DebitQuantity16 + 0 AS DebitQuantity16, CreditQuantity16 + TEM_CreditQuantity16 AS CreditQuantity16, 
DebitQuantity17 + 0 AS DebitQuantity17, CreditQuantity17 + TEM_CreditQuantity17 AS CreditQuantity17, 
DebitQuantity18 + 0 AS DebitQuantity18, CreditQuantity18 + TEM_CreditQuantity18 AS CreditQuantity18, 
DebitQuantity19 + 0 AS DebitQuantity19, CreditQuantity19 + TEM_CreditQuantity19 AS CreditQuantity19, 
DebitQuantity20 + 0 AS DebitQuantity20, CreditQuantity20 + TEM_CreditQuantity20 AS CreditQuantity20,
DebitQuantity21 + 0 AS DebitQuantity21, CreditQuantity21 + TEM_CreditQuantity21 AS CreditQuantity21, 
DebitQuantity22 + 0 AS DebitQuantity22, CreditQuantity22 + TEM_CreditQuantity22 AS CreditQuantity22, 
DebitQuantity23 + 0 AS DebitQuantity23, CreditQuantity23 + TEM_CreditQuantity23 AS CreditQuantity23, 
DebitQuantity24 + 0 AS DebitQuantity24, CreditQuantity24 + TEM_CreditQuantity24 AS CreditQuantity24, 
DebitQuantity25 + 0 AS DebitQuantity25, CreditQuantity25 + TEM_CreditQuantity25 AS CreditQuantity25, 
DebitQuantity26 + 0 AS DebitQuantity26, CreditQuantity26 + TEM_CreditQuantity26 AS CreditQuantity26, 
DebitQuantity27 + 0 AS DebitQuantity27, CreditQuantity27 + TEM_CreditQuantity27 AS CreditQuantity27, 
DebitQuantity28 + 0 AS DebitQuantity28, CreditQuantity28 + TEM_CreditQuantity28 AS CreditQuantity28, 
DebitQuantity29 + 0 AS DebitQuantity29, CreditQuantity29 + TEM_CreditQuantity29 AS CreditQuantity29, 
DebitQuantity30 + 0 AS DebitQuantity30, CreditQuantity30 + TEM_CreditQuantity30 AS CreditQuantity30, 
DebitQuantity31 + 0 AS DebitQuantity31, CreditQuantity31 + TEM_CreditQuantity31 AS CreditQuantity31
FROM #TAM3 t1
LEFT JOIN TEM t2 ON t1.MaterialID = t2.TEM_MaterialID AND t1.MaterialUnitID = t2.TEM_MaterialUnitID
'

EXEC(@SQL+@SQL5+@SQL1+ @SQL3+' 
UNION '
+ @SQL1 + @SQL4+@SQL2+@SQL6)

--PRINT @SQL
--PRINT @SQL5
--PRINT @SQL1
--PRINT @SQL3
--PRINT @SQL1
--PRINT @SQL4
--PRINT @SQL2
--PRINT @SQL6






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
