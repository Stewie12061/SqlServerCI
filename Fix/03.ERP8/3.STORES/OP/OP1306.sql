IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP1306]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[Op1306]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load danh sách các chương trình khuyến mãi theo số lượng - % chiết khấu
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by Tiểu Mai on 08/04/2016
--- Modify on 15/05/2017 by Bảo Anh: Sửa danh mục dùng chung (bỏ kết theo DivisionID)
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
-- <Example>
/*
	Exec OP1306 'KE', 'CF_4MUA', '%', '600*298K12-BBIII', '04/08/2016', 110
*/
CREATE PROCEDURE OP1306
(
	@DivisionID NVARCHAR(50),
	@ObjectID NVARCHAR(50),
	@InventoryTypeID NVARCHAR(50),
	@InventoryID NVARCHAR(50),
	@OrderDate DATETIME,
	@OrderQuantity DECIMAL(28,8)
)
AS
DECLARE @sSQL NVARCHAR(MAX)
SET @sSQL = '
	SELECT 			AT1338.PromotePercent
	FROM AT1328
	LEFT JOIN AT1202 ON (isnull(AT1202.O01ID,'''') = isnull(AT1328.O01ID,'''') or isnull(AT1328.O01ID,'''') = '''')
		  AND (isnull(AT1202.O02ID,'''') = isnull(AT1328.O02ID,'''') or isnull(AT1328.O02ID,'''') = '''')
		  AND (isnull(AT1202.O03ID,'''') = isnull(AT1328.O03ID,'''') or isnull(AT1328.O03ID,'''') = '''')
		  AND (isnull(AT1202.O04ID,'''') = isnull(AT1328.O04ID,'''') or isnull(AT1328.O04ID,'''') = '''')
		  AND (isnull(AT1202.O05ID,'''') = isnull(AT1328.O05ID,'''') or isnull(AT1328.O05ID,'''') = '''')
	LEFT JOIN AT1338 ON AT1338.VoucherID = AT1328.VoucherID
	LEFT JOIN AT1302 ON AT1302.DivisionID IN (''@@@'', AT1338.DivisionID) AND AT1302.InventoryID = AT1338.PromoteInventoryID     
	WHERE AT1328.DivisionID IN ('''+@DivisionID+''',''@@@'')
		AND AT1328.[Disabled] = 0
		AND AT1202.ObjectID = '''+@ObjectID+'''
		AND (AT1328.InventoryTypeID LIKE '''+@InventoryTypeID+''' OR (AT1328.InventoryTypeID LIKE ''%''))
		AND AT1328.InventoryID = '''+@InventoryID+'''
		AND ('''+Convert(Nvarchar(20),@OrderDate, 112)+''' BETWEEN Convert(Nvarchar(20),AT1328.FromDate,112) AND Convert(Nvarchar(20),AT1328.ToDate,112) 
			OR ('''+Convert(Nvarchar(20),@OrderDate,112)+''' >= Convert(Nvarchar(20),AT1328.FromDate,112) AND AT1328.ToDate IS NULL))
		AND ('+Convert(Nvarchar(20),@OrderQuantity)+' BETWEEN AT1328.FromQuantity AND AT1328.ToQuantity OR ('+Convert(Nvarchar(20),@OrderQuantity)+'>= AT1328.FromQuantity AND AT1328.ToQuantity IS NULL))
		AND  AT1328.PromoteTypeID = 2
	'	
--PRINT @sSQL
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
