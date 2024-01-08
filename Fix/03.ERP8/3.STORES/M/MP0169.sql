IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0169]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0169]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Customize Angel: Đổ dữ liệu lưới detail ở MH kế thừa KHSX tổng hợp công đoạn
---- Created by Bảo Anh, Date: 25/02/2016
---- Modified by Tiểu Mai on 30/11/2016: Sửa lại truy lưu vết từ OT2202_AG
---- Modified by Bảo Anh on 26/04/2017: Sửa danh mục dùng chung (bỏ kết theo DivisionID)
---- Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.
---- MP0169 'CTY','ES/09/2013/0003','','%'

CREATE PROCEDURE [dbo].[MP0169] 
    @DivisionID NVARCHAR(50), 
    @VoucherIDList AS NVARCHAR(max),
	@VoucherID AS NVARCHAR(50) = '',
	@I06ID AS NVARCHAR(50)
	
AS
Declare @SQL1 varchar(max),
		@SQL2 varchar(max),
		@SQL3 varchar(max)

SELECT @SQL1 = '', @SQL2 = '', @SQL3 = ''
--SET @VoucherIDList = REPLACE(@VoucherIDList,',',''',''')

--- Lọc ra các KHSX tổng hợp công đoạn chưa kế thừa hoặc kế thừa chưa hết
SET @SQL1 = '
SELECT EstimateID, TransactionID, (MaterialQuantity - Isnull(ProductQuantity,0)) as EndQuantity
INTO #TAM
FROM	(
	Select OT03.EstimateID, TransactionID, Isnull(MaterialQuantity,0) as MaterialQuantity, Isnull(ProductQuantity,0) as ProductQuantity
	From OT2203 OT03
	Left join	(Select DivisionID, InheritVoucherID, InheritTransactionID, sum(Quantity) as ProductQuantity From OT2202_AG
				Where DivisionID = ''' + @DivisionID + '''
				And Isnull(InheritTransactionID,'''') <> ''''
				Group by DivisionID, InheritVoucherID, InheritTransactionID
				) OT02 
	On OT03.DivisionID = OT02.DivisionID And OT03.EstimateID = OT02.InheritVoucherID and OT03.TransactionID = OT02.InheritTransactionID
	Inner join OT2201 OT01 On OT03.DivisionID = OT01.DivisionID And OT03.EstimateID = OT01.EstimateID
	LEFT JOIN AT1302 T02 ON OT03.MaterialID = T02.InventoryID AND T02.DivisionID IN (OT03.DivisionID,''@@@'')
	Where OT03.DivisionID = ''' + @DivisionID + ''' And ExpenseID = ''COST001'' and OT03.EstimateID in (''' + @VoucherIDList + ''')
	and T02.I06ID = ''' + @I06ID + ''' 
) A
WHERE MaterialQuantity - Isnull(ProductQuantity,0) > 0'

IF isnull(@VoucherID,'')<> ''	--- khi load edit
BEGIN
	SET @SQL2 = '
	SELECT	cast(1 as tinyint) as IsChecked, OT02.InheritVoucherID as VoucherID,OT03.TransactionID, OT01.VoucherNo, OT03.Orders,
			OT03.ProductID, T01.InventoryName as ProductName,
			(Select ProductQuantity From OT2202 Where DivisionID = ''' + @DivisionID + ''' And EDetailID = OT03.EDetailID) as ProductQuantity, 
			OT03.MaterialID, T02.InventoryName as MaterialName,
			OT03.UnitID as MaterialUnitID, T04.UnitName as MaterialUnitName, OT03.MaterialQuantity
	FROM OT2202 OT02
	INNER JOIN OT2201 OT01 ON OT02.DivisionID = OT01.DivisionID And OT02.InheritVoucherID = OT01.EstimateID
	INNER JOIN OT2203 OT03 ON OT02.DivisionID = OT03.DivisionID And OT02.InheritVoucherID = OT03.EstimateID and OT02.InheritTransactionID = OT03.TransactionID and OT03.ExpenseID = ''COST001''
	LEFT JOIN AT1302 T01 ON OT03.ProductID = T01.InventoryID AND T01.DivisionID IN (OT03.DivisionID,''@@@'')
	LEFT JOIN AT1302 T02 ON OT03.MaterialID = T02.InventoryID AND T02.DivisionID IN (OT03.DivisionID,''@@@'')
	LEFT JOIN AT1304 T04 ON OT03.UnitID = T04.UnitID and OT03.ExpenseID = ''COST001''
	WHERE OT02.DivisionID = ''' + @DivisionID + ''' AND OT02.EstimateID = ''' + @VoucherID + ''' AND Isnull(OT02.InheritTableID,'''') = ''OT2203'' AND Isnull(OT02.InheritTransactionID,'''') <> ''''
	'

	SET @SQL3 = '
	UNION
	SELECT	cast(0 as tinyint) as IsChecked, OT03.EstimateID as VoucherID, OT03.TransactionID, OT01.VoucherNo, OT03.Orders,
			OT03.ProductID, T01.InventoryName as ProductName,
			(Select ProductQuantity From OT2202 Where DivisionID = ''' + @DivisionID + ''' And EDetailID = OT03.EDetailID) as ProductQuantity,
			OT03.MaterialID, T02.InventoryName as MaterialName,
			OT03.UnitID as MaterialUnitID, T04.UnitName as MaterialUnitName, #TAM.EndQuantity as MaterialQuantity
	FROM OT2203 OT03
	INNER JOIN OT2201 OT01 ON OT03.DivisionID = OT01.DivisionID And OT03.EstimateID = OT01.EstimateID
	INNER JOIN #TAM ON OT03.TransactionID = #TAM.TransactionID
	LEFT JOIN AT1302 T01 ON OT03.ProductID = T01.InventoryID AND T01.DivisionID IN (OT03.DivisionID,''@@@'')
	LEFT JOIN AT1302 T02 ON OT03.MaterialID = T02.InventoryID AND T02.DivisionID IN (OT03.DivisionID,''@@@'')
	LEFT JOIN AT1304 T04 ON OT03.UnitID = T04.UnitID and OT03.ExpenseID = ''COST001''
	WHERE OT03.DivisionID = ''' + @DivisionID + ''' AND ExpenseID = ''COST001'' AND T02.I06ID = ''' + +@I06ID + '''
	
	ORDER BY OT01.VoucherNo, OT03.ProductID, OT03.Orders'
END
ELSE --- addnew
	SET @SQL2 = '
	SELECT	cast(0 as tinyint) as IsChecked, OT03.EstimateID as VoucherID, OT03.TransactionID, OT01.VoucherNo, OT03.Orders,
			OT03.ProductID, T01.InventoryName as ProductName, 
			(Select ProductQuantity From OT2202 Where DivisionID = ''' + @DivisionID + ''' And EDetailID = OT03.EDetailID) as ProductQuantity,
			OT03.MaterialID, T02.InventoryName as MaterialName,
			OT03.UnitID as MaterialUnitID, T04.UnitName as MaterialUnitName, #TAM.EndQuantity as MaterialQuantity
	FROM OT2203 OT03
	INNER JOIN OT2201 OT01 ON OT03.DivisionID = OT01.DivisionID And OT03.EstimateID = OT01.EstimateID
	INNER JOIN #TAM ON OT03.TransactionID = #TAM.TransactionID
	LEFT JOIN AT1302 T01 ON OT03.ProductID = T01.InventoryID AND T01.DivisionID IN (OT03.DivisionID,''@@@'')
	LEFT JOIN AT1302 T02 ON OT03.MaterialID = T02.InventoryID AND T02.DivisionID IN (OT03.DivisionID,''@@@'')
	LEFT JOIN AT1304 T04 ON OT03.UnitID = T04.UnitID and OT03.ExpenseID = ''COST001''
	WHERE OT03.DivisionID = ''' + @DivisionID + ''' AND ExpenseID = ''COST001'' AND T02.I06ID = ''' + @I06ID + '''
	ORDER BY OT01.VoucherNo, OT03.ProductID, OT03.Orders'

--print @SQL1
--print @SQL2
EXEC(@SQL1 + @SQL2 + @SQL3)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
