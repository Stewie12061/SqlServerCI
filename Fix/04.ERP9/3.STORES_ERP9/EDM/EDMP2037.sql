IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2037]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2037]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid Chọn Khuyến mãi(Màn hình chọn)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Lương Mỹ, Date: 07/01/2020
-- <Example>
/*


*/

CREATE PROCEDURE EDMP2037 ( 
        @DivisionID VARCHAR(50), 
		@UserID VARCHAR(50),
	    @LanguageID VARCHAR(50),
		@PageNumber INT,
		@PageSize INT,
		@DateSearch DATETIME,	
		@ReceiptTypeID VARCHAR(50)
) 
AS 

DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(500) = N'', 
		@TotalRow NVARCHAR(50) = N''

	IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	SET @OrderBy = 'T1.ReceiptTypeID,FromDate'

	SET @sWhere = @sWhere + ' 1 = 1 '

	IF ISNULL(@DateSearch, '') <> ''
		SET @sWhere = @sWhere + N' AND '''+CONVERT(VARCHAR(10),@DateSearch,112)+''' BETWEEN T1.FromDate AND T1.ToDate'
	
	IF ISNULL(@ReceiptTypeID, '') <> ''
		SET @sWhere = @sWhere + N' AND T1.ReceiptTypeID = '''+ @ReceiptTypeID +''''

SET @sSQL =  N'
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
T1.APK, T1.DivisionID,
T1.PromotionID, T1.PromotionName, 
T1.ReceiptTypeID, T2.ReceiptTypeName,
T1.FromDate, T1.ToDate,
T1.PromotionType as PromotionTypeID, T3.Description as PromotionTypeName,
T1.Value

FROM EDMT1100 T1  WITH (NOLOCK)
INNER JOIN EDMT1050 T2 WITH (NOLOCK) ON T2.ReceiptTypeID = T1.ReceiptTypeID
INNER JOIN EDMT0099 T3 WITH (NOLOCK) ON T3.ID = T1.PromotionType AND T3.CodeMaster= ''PromotionType''

WHERE '+@sWhere+' 

ORDER BY '+@OrderBy+'

OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
'
--PRINT @sSQL
EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
