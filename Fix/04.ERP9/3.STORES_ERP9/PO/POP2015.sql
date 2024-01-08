IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2015]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2015]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load dữ liệu màn hình xem/sửa Leadtime_MOQ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create by Tiểu Mai on 27/06/2018
 ----Modified by Tra Giang on  18/10/2018: Lấy thông tin người lập từ bảng AT1103 thay cho bang AT1405
-- <Example>
---- exec POP2015 'AT', 'ASOFTADMIN', 'IN',1,25

CREATE PROCEDURE POP2015
( 
		@DivisionID AS NVARCHAR(50),
		@UserID NVARCHAR(50),
		@LeadTimeID NVARCHAR(50),
		@PageNumber INT,
		@PageSize INT
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)='',
		@TotalRow NVARCHAR(50),
		@Orderby NVARCHAR(MAX)=''
SET @TotalRow = ''
 SET @Orderby='P13.LeadTimeID '
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

 SET @sSQL =N'
	    SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
 P13.*, A03.FullName AS EmployeeName, 
		P14.DetailID, P14.InventoryID, A12.InventoryName, A12.UnitID, 
		P14.ObjectID, A02.ObjectName,
		P14.Quantity, P14.UnitPrice, P14.ConvertedAmount, P14.DeliverDay
FROM POT2013 P13 WITH (NOLOCK)
LEFT JOIN POT2014 P14 WITH (NOLOCK) ON P13.LeadTimeID = P14.LeadTimeID AND P14.DivisionID = P13.DivisionID
LEFT JOIN AT1103 A03 WITH (NOLOCK) ON P13.DivisionID = A03.DivisionID AND P13.EmployeeID = A03.EmployeeID
LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.ObjectID = P14.ObjectID
LEFT JOIN AT1302 A12 WITH (NOLOCK) ON A12.InventoryID = P14.InventoryID
WHERE P13.DivisionID = '''+@DivisionID+''' AND P13.LeadTimeID = '''+@LeadTimeID+'''
ORDER BY '+@OrderBy+'
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

EXEC ( @sSQL)
--Print  ( @sSQL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO