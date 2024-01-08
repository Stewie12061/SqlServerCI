IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0172]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0172]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




---- Customize Angel: Load tình hình dự kiến sử dụng vật tư ở MH chi tiết các đợt sản xuất trước đó (ANGEL)
---- Created by Tiểu Mai on 27/07/2016
---- Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.

/*
exec MP0172 @DivisionID=N'ANG',@TranMonth=1,@TranYear=2016,@VoucherDate='2016-01-01 00:00:00',@PurchasePlanID=N'49d653e9-e056-4da4-a740-d0982543fca5', 
			@MaterialID=N'VLTEMSTB',@Quantity = 1532, @ApportionID = 'CR16001'
*/

CREATE PROCEDURE [dbo].[MP0172] 
    @DivisionID NVARCHAR(50),
	@TranMonth int,
	@TranYear int,
    @TransactionID AS NVARCHAR(50),
	@VoucherDate as datetime,	--- ngày lập dự tính sản xuất
	@PurchasePlanID as nvarchar(50), --- kế hoạch mua hàng
	@MaterialID NVARCHAR(50),
	@Quantity DECIMAL(28,8),
	@ApportionID NVARCHAR(50)
	
AS
Declare 
		@SQL varchar(max),
		@SQL1 varchar(max),
		@SQL2 varchar(max),
		@SQL3 varchar(max),
		@SQL4 varchar(max),
		@SQL5 varchar(max),
		@i tinyint

SET @SQL = ''
SET @SQL1 = ''
SET @SQL2 = ''
SET @SQL3 = ''
SET @SQL4 = ''
SET @SQL5 = ''
SET @i = 1

SELECT MT03.MaterialID, AT1302.InventoryName as MaterialName, MT03.MaterialUnitID, AT1304.UnitName as MaterialUnitName,
(Select Sum(SignQuantity) From AV7000 Where DivisionID = @DivisionID And (VoucherDate <= @VoucherDate OR D_C = 'BD') And InventoryID = MT03.MaterialID) as MaterialEndQuantity,
@Quantity * MT03.QuantityUnit * (case when Isnull(MT03.RateWastage,0) = 0 then 1 else MT03.RateWastage end) as MaterialQuantity, AT1302.I01ID as ProductTypeID, MT0171.BeginDate, MT0171.FinishDate, MT0171.Quantity as FinishQuantity,
OT0156.ReceiveDate, OT0156.ActualQuantity, 0 AS [Type]
INTO #TAM21
FROM MT1603 MT03 WITH (NOLOCK)
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (MT03.DivisionID,'@@@') And MT03.MaterialID = AT1302.InventoryID
LEFT JOIN AT1304 WITH (NOLOCK) ON MT03.DivisionID = AT1304.DivisionID And MT03.MaterialUnitID = AT1304.UnitID
LEFT JOIN MT0171 WITH (NOLOCK) ON MT03.DivisionID = MT0171.DivisionID And MT0171.TranMonth = @TranMonth and MT0171.TranYear = @TranYear And MT0171.InventoryID = MT03.MaterialID
LEFT JOIN OT0156 WITH (NOLOCK) ON MT03.DivisionID = OT0156.DivisionID And OT0156.VoucherID = @PurchasePlanID And MT03.MaterialID = OT0156.InventoryID
WHERE MT03.DivisionID = @DivisionID AND MT03.ApportionID = @ApportionID AND MT03.MaterialID = @MaterialID AND ExpenseID = 'COST001' AND Isnull(MT0171.TransactionID,'') <> Isnull(@TransactionID,'')

UNION 

SELECT MT03.MaterialID, AT1302.InventoryName as MaterialName, MT03.MaterialUnitID, AT1304.UnitName as MaterialUnitName,
(Select Sum(SignQuantity) From AV7000 Where DivisionID = @DivisionID And (VoucherDate <= @VoucherDate OR D_C = 'BD') And InventoryID = MT03.MaterialID) as MaterialEndQuantity,
MT0171.Quantity * MT03.QuantityUnit * (case when Isnull(MT03.RateWastage,0) = 0 then 1 else MT03.RateWastage end) as MaterialQuantity, 
AT1302.I01ID as ProductTypeID, 
MT0171.BeginDate, MT0171.FinishDate, MT0171.Quantity * MT03.QuantityUnit * (case when Isnull(MT03.RateWastage,0) = 0 then 1 else MT03.RateWastage end) as FinishQuantity,
NULL as ReceiveDate, 0 as ActualQuantity, 1 AS [Type]
FROM MT1603 MT03 WITH (NOLOCK)
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (MT03.DivisionID,'@@@') And MT03.MaterialID = AT1302.InventoryID
LEFT JOIN AT1304 WITH (NOLOCK) ON MT03.DivisionID = AT1304.DivisionID And MT03.MaterialUnitID = AT1304.UnitID
LEFT JOIN MT0171 WITH (NOLOCK) ON MT03.DivisionID = MT0171.DivisionID And MT0171.TranMonth = @TranMonth and MT0171.TranYear = @TranYear And MT0171.InventoryID = MT03.ProductID
LEFT JOIN OT0156 WITH (NOLOCK) ON MT03.DivisionID = OT0156.DivisionID And OT0156.VoucherID = @PurchasePlanID And MT03.MaterialID = OT0156.InventoryID
WHERE MT03.DivisionID = @DivisionID AND MT03.ApportionID = @ApportionID AND MT03.MaterialID = @MaterialID AND ExpenseID = 'COST001' AND Isnull(MT0171.TransactionID,'') <> Isnull(@TransactionID,'')

SET @SQL = '
SELECT MaterialID,MaterialName,MaterialUnitID,MaterialUnitName,MaterialEndQuantity,Isnull(MaterialQuantity,0) as MaterialQuantity,[Type],'

SET @SQL1 = '
SELECT MaterialID,MaterialName,MaterialUnitID,MaterialUnitName,MaterialEndQuantity,SUM(MaterialQuantity) AS MaterialQuantity,'

SET @SQL2 = '
SELECT MaterialID,MaterialName,MaterialUnitID,MaterialUnitName,MaterialEndQuantity,MAX(MaterialQuantity) as MaterialQuantity,'

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
INTO #TAM22
FROM #TAM21
GROUP BY MaterialID, MaterialName, MaterialUnitID, MaterialUnitName, MaterialEndQuantity, MaterialQuantity,[Type]'

SET @SQL1 = LEFT(@SQL1,len(@SQL1)-1)
SET @SQL3 = @SQL3 + '
INTO #TAM23
FROM #TAM22
WHERE [Type] = 1
GROUP BY MaterialID, MaterialName, MaterialUnitID, MaterialUnitName, MaterialEndQuantity'

SET @SQL4 = @SQL4 + '
FROM #TAM22
WHERE [Type] = 0
GROUP BY MaterialID, MaterialName, MaterialUnitID, MaterialUnitName, MaterialEndQuantity'

SET @SQL2 = LEFT(@SQL2,len(@SQL2)-1)
SET @SQL2 = @SQL2 + '
INTO #TAM24
FROM #TAM23
GROUP BY MaterialID, MaterialName, MaterialUnitID, MaterialUnitName, MaterialEndQuantity


INSERT INTO TEM	(TEM_MaterialID, TEM_MaterialUnitID, TEM_MaterialEndQuantity, TEM_MaterialQuantity, 
TEM_DebitQuantity01, TEM_CreditQuantity01, TEM_DebitQuantity02, TEM_CreditQuantity02, TEM_DebitQuantity03, TEM_CreditQuantity03, TEM_DebitQuantity04, TEM_CreditQuantity04, TEM_DebitQuantity05, TEM_CreditQuantity05, TEM_DebitQuantity06, TEM_CreditQuantity06, TEM_DebitQuantity07, TEM_CreditQuantity07, TEM_DebitQuantity08, TEM_CreditQuantity08, TEM_DebitQuantity09, TEM_CreditQuantity09, TEM_DebitQuantity10, TEM_CreditQuantity10,
TEM_DebitQuantity11, TEM_CreditQuantity11, TEM_DebitQuantity12, TEM_CreditQuantity12, TEM_DebitQuantity13, TEM_CreditQuantity13, TEM_DebitQuantity14, TEM_CreditQuantity14, TEM_DebitQuantity15, TEM_CreditQuantity15, TEM_DebitQuantity16, TEM_CreditQuantity16, TEM_DebitQuantity17, TEM_CreditQuantity17, TEM_DebitQuantity18, TEM_CreditQuantity18, TEM_DebitQuantity19, TEM_CreditQuantity19, TEM_DebitQuantity20, TEM_CreditQuantity20,
TEM_DebitQuantity21, TEM_CreditQuantity21, TEM_DebitQuantity22, TEM_CreditQuantity22, TEM_DebitQuantity23, TEM_CreditQuantity23, TEM_DebitQuantity24, TEM_CreditQuantity24, TEM_DebitQuantity25, TEM_CreditQuantity25, TEM_DebitQuantity26, TEM_CreditQuantity26, TEM_DebitQuantity27, TEM_CreditQuantity27, TEM_DebitQuantity28, TEM_CreditQuantity28, TEM_DebitQuantity29, TEM_CreditQuantity29, TEM_DebitQuantity30, TEM_CreditQuantity30, TEM_DebitQuantity31, TEM_CreditQuantity31)

SELECT MaterialID, MaterialUnitID, MaterialEndQuantity, MaterialQuantity, 
DebitQuantity01, CreditQuantity01, DebitQuantity02, CreditQuantity02, DebitQuantity03, CreditQuantity03, DebitQuantity04, CreditQuantity04, DebitQuantity05, CreditQuantity05, DebitQuantity06, CreditQuantity06, DebitQuantity07, CreditQuantity07, DebitQuantity08, CreditQuantity08, DebitQuantity09, CreditQuantity09, DebitQuantity10, CreditQuantity10,
DebitQuantity11, CreditQuantity11, DebitQuantity12, CreditQuantity12, DebitQuantity13, CreditQuantity13, DebitQuantity14, CreditQuantity14, DebitQuantity15, CreditQuantity15, DebitQuantity16, CreditQuantity16, DebitQuantity17, CreditQuantity17, DebitQuantity18, CreditQuantity18, DebitQuantity19, CreditQuantity19, DebitQuantity20, CreditQuantity20,
DebitQuantity21, CreditQuantity21, DebitQuantity22, CreditQuantity22, DebitQuantity23, CreditQuantity23, DebitQuantity24, CreditQuantity24, DebitQuantity25, CreditQuantity25, DebitQuantity26, CreditQuantity26, DebitQuantity27, CreditQuantity27, DebitQuantity28, CreditQuantity28, DebitQuantity29, CreditQuantity29, DebitQuantity30, CreditQuantity30, DebitQuantity31, CreditQuantity31

FROM #TAM24


'

EXEC(@SQL+@SQL5+@SQL1+ @SQL3+' 
UNION '
+ @SQL1 + @SQL4+@SQL2)

--PRINT @SQL
--PRINT @SQL5
--PRINT @SQL1
--PRINT @SQL3
--PRINT @SQL1
--PRINT @SQL4
--PRINT @SQL2






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
