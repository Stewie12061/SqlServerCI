IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CP0059]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CP0059]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- In Tem danh sách mặt hàng
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Cao Thị Phượng: In tem mặt hàng theo điều kiện search or theo mặt hàng đã chọn trên màn hình
----Create date: 26/07/2017
---- Modified by 
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Nhật Thanh on 15/08/2023 : Bổ sung customize Thanh Liêm
/*
	exec CP0059 'MS', '0000000001'',''BDNGALGL6020'',''BITWTS0206'',''TIVPANTH40D400V'',''CHDETLEBG200'
*/
 CREATE PROCEDURE CP0059 
 (
	@DivisionID nvarchar(50),
	@InventoryIDList NVarchar(max), ---ID của những mặt hàng được chọn hoặc search trên màn hình danh mục
	@PriceTableID nvarchar(50)
 )
 AS
BEGIN
Declare @sSQL Nvarchar(max),
		@PriceListID Nvarchar(max),
		@Price Nvarchar(max),
		@sWhere Nvarchar(max),
		@CustomerName as int

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

---------INSERT dữ liệu từ file excel vào bảng tạm---------------------------------------
If @CustomerName = 79 --Customize MINH SANG
BEGIN

Set @PriceListID = (Select Top 1 ID From OT1301 where (GetDate() Between FromDate AND ToDate)) 

If isnull(@PriceListID,'') !='' 
		Set @Price ='D.UnitPrice'
	Else 
		Set @Price =' A.SalePrice01'

	SET @sSQL = N'
		SELECT A.DivisionID, B.DivisionName, A.InventoryID, A.InventoryName
		, '+@Price+ ' as SalePrice, '''+ CONVERT(VARCHAR(10),GetDate(),103) +''' as PrintDate 
		FROM AT1302 A WITH (NOLOCK)
		LEFT JOIN AT1101 B WITH (NOLOCK) ON A.DivisionID = B.DivisionID
		FULL JOIN OT1302 D WITH (NOLOCK) ON D.InventoryID = A.InventoryID AND D.ID = ''' + ISNULL(@PriceListID, '') + '''
		WHERE A.DivisionID IN (''@@@'','''+@DivisionID+''') and  A.InventoryID in ('''+@InventoryIDList+''')
		'

END 
If @CustomerName = 163 --Customize Thanh Liêm 
BEGIN
	SET @sSQL = N'
		SELECT A.DivisionID, B.DivisionName, A.InventoryID, A.InventoryName,A.I03ID,A3.AnaName as I03Name,A.I04ID, A4.AnaName as I04Name ,A.I02ID, A2.AnaName as I02Name
			,A.Specification,A.I05ID, A5.AnaName as I05Name,A.Notes01, A.Notes02 , '''+ CONVERT(VARCHAR(10),GetDate(),103) +''' as PrintDate 
			, D.UnitPrice as SalePrice
		FROM AT1302 A WITH (NOLOCK) 
		LEFT JOIN AT1101 B WITH (NOLOCK) ON A.DivisionID = B.DivisionID
		LEFT JOIN AT1015 A2 ON A.DivisionID = A2.DivisionID AND A.I02ID = A2.AnaID AND A2.AnaTypeID = ''I02''
		LEFT JOIN AT1015 A3 ON A.DivisionID = A3.DivisionID AND A.I03ID = A3.AnaID AND A3.AnaTypeID = ''I03''
		LEFT JOIN AT1015 A4 ON A.DivisionID = A4.DivisionID AND A.I04ID = A4.AnaID AND A4.AnaTypeID = ''I04''
		LEFT JOIN AT1015 A5 ON A.DivisionID = A5.DivisionID AND A.I05ID = A5.AnaID AND A5.AnaTypeID = ''I05''
		FULL JOIN OT1302 D WITH (NOLOCK) ON D.InventoryID = A.InventoryID AND D.ID = ''' + ISNULL(@PriceTableID, '') + '''
		WHERE A.DivisionID IN ('''+@DivisionID+''', ''@@@'') and  A.InventoryID in ('''+@InventoryIDList+''')
		
		'

END 

Exec (@sSQL)
--Print @sSQL
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
