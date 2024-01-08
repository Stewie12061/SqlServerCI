IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2014]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2014]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Load Grid Form SOF2000 Danh muc đơn hàng bán
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Tiểu Mai on 25/05/2016: Load danh sách mặt hàng lên màn hình SOF2014
---- Modified by Tiểu Mai on 11/07/2017: Bổ sung loại mặt hàng, kiểm tra null
---- Modified by Tiểu Mai on 09/08/2017: Bổ sung nếu là in báo cáo thì ko hạn chế loại mặt hàng
---- Modified by Tiểu Mai on 17/08/2017: Bổ sung nhóm hàng MPT mặt hàng 03, kiểm tra null
---- Modified by Thành Luân on 13/08/2020: Bổ sung thêm điều kiện dùng khi Where DivisionID.
---- Modified by Văn Tài	on 26/04/2022: Bổ sung điều kiện DivisionID @@@.
-- <Example>
----    exec SOP2014 @DivisionID=N'ANG',@TxtSearch=N'',@PageNumber=1,@PageSize=25,@FromInventoryTypeID=N'SP51',@ToInventoryTypeID=N'SP51',@IsReport = 1
----
CREATE PROCEDURE SOP2014 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
        @TxtSearch NVARCHAR(250),
		@PageNumber INT,
		@PageSize INT,
		@FromInventoryTypeID NVARCHAR(50) = '',
		@ToInventoryTypeID NVARCHAR(50) = '',
		@IsReport TINYINT = 0,
		@FromI03ID NVARCHAR(50) = '',
		@ToI03ID NVARCHAR(50) = ''
)
AS
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
        
SET @sWhere = ' 1 = 1 '
SET @TotalRow = ''
SET @OrderBy = 'AT1302.InventoryID, AT1302.UnitID'

IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'


SET @sSQL = '	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,  
AT1302.DivisionID, AT1302.InventoryID, AT1302.InventoryName, AT1302.UnitID, AT1304.UnitName, AT1302.InventoryTypeID, 1 as OrderQuantity     ,
SalePrice01 as SalePrice, SalePrice01 as OriginalAmount, VATGroupID, VATPercent, 
SalePrice01 * (VATPercent/100) as VATOriginalAmount, SalePrice01 as ConvertedAmount      , 
SalePrice01 * (VATPercent/100) as VATConvertedAmount,
AT1302.IsCommon, 0 as IsProInventoryID, AT1302.[Disabled]
From AT1302 inner join AT1304 on AT1304.DivisionID IN (''@@@'', AT1302.DivisionID) and AT1302.UnitID = AT1304.UnitID  
Where AT1302.DivisionID IN (''@@@'', '''+@DivisionID+''') and AT1302.Disabled = 0   
AND (AT1302.InventoryID LIKE N''%'+ @TxtSearch+'%'' OR AT1302.InventoryName LIKE N''%'+ @TxtSearch+'%'') 
AND AT1302.InventoryTypeID IN (SELECT InventoryTypeID FROM AT1301 WHERE AT1301.DivisionID IN (''@@@'', '''+@DivisionID+''')
'+ CASE WHEN ISNULL(@IsReport,0) = 0 THEN ' AND AT1301.IsUseWeb = 1' ELSE '' END + ')
'+ CASE WHEN ISNULL(@FromInventoryTypeID,'') <> '' THEN '
AND AT1302.InventoryTypeID BETWEEN '''+@FromInventoryTypeID+''' AND '''+@ToInventoryTypeID+''' ' ELSE '' END +'
'+ CASE WHEN ISNULL(@FromI03ID,'') <> '' THEN '
AND AT1302.I03ID BETWEEN '''+@FromI03ID+''' AND '''+@ToI03ID+''' ' ELSE '' END +'
ORDER BY '+@OrderBy+'
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
EXEC (@sSQL)
print (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
