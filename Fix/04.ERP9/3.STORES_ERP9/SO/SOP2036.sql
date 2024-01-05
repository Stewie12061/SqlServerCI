IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2036]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2036]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load grid chi tiết hóa đơn lập từ app mobile (SO- ERP9.0)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: by Tra Giang  on 07/01/2018

-- <Example>
/*
exec SOP2036 @DivisionID='AT',@UserID='ASOFTADMIN',@OrderIDList=N'',@PageNumber=1,@PageSize=25 
*/
CREATE PROCEDURE SOP2036
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@OrderIDList NVARCHAR(MAX),
	 @PageNumber INT,
	 @PageSize INT
)
AS
DECLARE @sSQL NVARCHAR(MAX),
		@TotalRow NVARCHAR(50) = N''
	   
--SET @OrderBy = 'A01.product_id '
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	
SET @sSQL = '
SELECT Distinct CONVERT(INT, ROW_NUMBER() OVER (ORDER BY A01.product_id )) AS RowNum, '+@TotalRow+' AS TotalRow,
 A01.APK, A01.order_id OrderID, A01.product_id InventoryID, A02.InventoryName,
	A01.unit UnitID, A04.UnitName, A01.quantity OrderQuantity, A01.user_id Ana01ID,
	A01.note Notes, A01.discount_percent DiscountPercent, (A01.discount_percent * A01.SalePrice * A01.quantity /100) as DiscountAmount,
	A01.PriceListID, A01.SalePrice, A01.VATPercent, A02.VATGroupID,
	A01.customer_id ObjectID, A03.ObjectName, A01.order_created_date OrderDate
FROM APT0001 A01 WITH (NOLOCK)
LEFT JOIN AT1304 A04 WITH (NOLOCK) ON A04.UnitID = A01.unit
LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.InventoryID = A01.product_id
LEFT JOIN AT1202 A03 WITH (NOLOCK) ON A03.ObjectID = A01.customer_id
WHERE A01.DivisionID = '''+@DivisionID+'''
AND A01.order_id IN ('''+@OrderIDList+''')
ORDER BY A01.order_id
  	
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

EXEC (@sSQL)
--print (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
