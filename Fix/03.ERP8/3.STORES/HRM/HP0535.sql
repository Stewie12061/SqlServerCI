IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0535]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0535]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid: Danh mục định mức lương sản phẩm (VIETFIRST)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Khả Vi, Date: 27/02/2018
/*-- <Example>
	HP0535 @DivisionID = 'VF', @UserID = 'ASOFTADMIN', @NormID = 'DML/02', @FromDate = '2018-01-01', @ToDate = '2018-03-31'

	HP0535 @DivisionID, @UserID, @NormID, @FromDate, @ToDate
----*/

CREATE PROCEDURE HP0535
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@NormID VARCHAR(50), 
	@FromDate DATETIME, 
	@ToDate DATETIME 
)
AS 

DECLARE @sSQL NVARCHAR(MAX) = N'',
		@sWhere NVARCHAR(MAX) = N'', 
		@OrderBy NVARCHAR(MAX) = N''

SET @OrderBy = N' NormID'
SET @sWhere = @sWhere + 'DivisionID = '''+@DivisionID+''' '

IF ISNULL(@NormID, '') <> '' SET @sWhere = @sWhere + '
AND ISNULL(NormID,'''') LIKE ''%'+@NormID+'%'' '
IF ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '' SET @sWhere = @sWhere + '
AND CONVERT(VARCHAR(10), CONVERT(DATE, FromDate, 120), 126) >= '''+CONVERT(VARCHAR(10), @FromDate, 126)+''' '
IF ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '' SET @sWhere = @sWhere + '
AND CONVERT(VARCHAR(10), CONVERT(DATE, ToDate, 120), 126) <= '''+CONVERT(VARCHAR(10), @ToDate, 126)+''' '
IF ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '' SET @sWhere = @sWhere + '
AND CONVERT(VARCHAR(10), CONVERT(DATE, FromDate, 120), 126)  BETWEEN '''+CONVERT(VARCHAR(10), @FromDate, 126)+''' AND '''+CONVERT(VARCHAR(10), @ToDate, 126)+''' 
AND CONVERT(VARCHAR(10), CONVERT(DATE, ToDate, 120), 126)  BETWEEN '''+CONVERT(VARCHAR(10), @FromDate, 126) +''' AND '''+CONVERT(VARCHAR(10), @ToDate, 126) +''' '

SET @sSQL = @sSQL + N'
SELECT APK, DivisionID, NormID, Description, FromDate, ToDate, Disabled
FROM HT1123	WITH (NOLOCK)
WHERE '+@sWhere+' 
ORDER BY '+@OrderBy+''


--PRINT (@sSQL)
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
