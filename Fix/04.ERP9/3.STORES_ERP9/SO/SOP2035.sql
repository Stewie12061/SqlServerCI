IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2035]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2035]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load grid danh sách hóa đơn lập từ app mobile 
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: by Tra Giang  on 07/01/2019
-- <Example>
/*
exec SOP2035 @DivisionID='AT',@UserID='ASOFTADMIN',@SaleEmployeeID='%',@ObjectID='%',@FromDate='2019-01-07 10:51:26.573',@ToDate='2019-01-07 10:51:26.573',@PageNumber=1,@PageSize=25

*/
CREATE PROCEDURE SOP2035
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@SaleEmployeeID VARCHAR(50),
	@ObjectID VARCHAR(50),
	@FromDate VARCHAR(50),
	@ToDate VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT
)
AS
Declare @sSQL as nvarchar(4000),
		@TotalRow NVARCHAR(50) = N'',
	 @OrderBy NVARCHAR(500) = N''
	 SET @OrderBy = 'order_no'
	IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	Set @sSQL =N' 
SELECT Distinct CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
 order_id OrderID,  order_no OrderNo, order_created_date OrderDate, customer_id ObjectID, A02.ObjectName,
	A01.[user_id] SaleEmployeeID, A03.AnaName SaleEmployeeName, A01.[priority] ImpactLevelID,
	CASE WHEN ISNULL(A01.[priority],0) = 0 THEN N''Bình thường''
		    WHEN ISNULL(A01.[priority],0) = 1 THEN N''Khẩn 1''
		    WHEN ISNULL(A01.[priority],0) = 2 THEN N''Khẩn 2''
		    WHEN ISNULL(A01.[priority],0) = 3 THEN N''Khẩn 3''
		    END AS ImpactLevelName,A01.note Notes, A01.discount_percent DiscountPercent,
		    A01.discount_money DiscountAmount
FROM APT0001 A01
LEFT JOIN AT1011 A03 ON A03.AnaID = A01.[user_id]
LEFT JOIN AT1202 A02 ON A02.ObjectID = A01.customer_id
LEFT JOIN OT2002 OT20 ON OT20.DivisionID = A01.DivisionID AND OT20.AppInheritOrderID = A01.order_id
WHERE A01.DivisionID = '''+@DivisionID+'''
AND OT20.AppInheritOrderID IS NULL

AND A01.[user_id] LIKE ISNULl('''+@SaleEmployeeID+''',''%'')
AND A01.customer_id LIKE ISNULl('''+@ObjectID+''',''%'')
AND CONVERT(VARCHAR, A01. order_created_date, 120) BETWEEN CONVERT(VARCHAR, '''+@FromDate+''', 120) AND CONVERT(VARCHAR,'''+ @ToDate+''', 120)

GROUP BY order_id, order_no, order_created_date, customer_id, A02.ObjectName, A01.[user_id], A03.AnaName, A01.[priority],
		 A01.note, A01.discount_percent,A01.discount_money
		  	ORDER BY '+@OrderBy+'
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
--Print (@sSQL)
EXEC  (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
