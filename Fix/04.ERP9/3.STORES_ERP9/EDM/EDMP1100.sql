IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1100]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1100]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load danh mục biểu phí (màn hình truy vấn)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- ASOFT - EDM \ Danh mục \ Danh mục khuyến mãi
-- <History>
----Created by: Lương Mỹ on 26/12/2019
-- <Example>
---- 
/*-- <Example>
---Lọc thường 

---Lọc nâng cao 
----*/

CREATE PROCEDURE EDMP1100
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @PromotionID VARCHAR(50),
	 @PromotionName VARCHAR(50),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @OrderBy NVARCHAR(500) = N'',
        @TotalRow NVARCHAR(50) = N''
        
SET @OrderBy = 'PromotionName'

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
SET @sWhere = '1 = 1 '

IF ISNULL(@SearchWhere, '') = '' --Lọc thường 
	BEGIN 
		IF ISNULL(@DivisionList, '') <> ''
			SET @sWhere = @sWhere + 'AND EDMT1100.DivisionID IN ('''+@DivisionList+''',''@@@'') ' 
		ELSE 
			SET @sWhere = @sWhere + 'AND EDMT1100.DivisionID IN ('''+@DivisionID+''',''@@@'') ' 

	IF ISNULL(@PromotionID,'') <> '' 
		SET @sWhere = @sWhere + ' AND EDMT1100.PromotionID LIKE N''%'+@PromotionID+'%'' '	

	IF ISNULL(@PromotionName,'') <> '' 
		SET @sWhere = @sWhere + ' AND EDMT1100.PromotionName LIKE N''%'+@PromotionID+'%'' '	

	IF ISNULL(@FromDate,'') <> '' 
		SET @sWhere = @sWhere + ' AND  CONVERT(VARCHAR(10), EDMT1100.ToDate,112) >= '+CONVERT(VARCHAR(10),@FromDate,112)+'   '

	IF ISNULL(@ToDate,'') <> '' 
		SET @sWhere = @sWhere + ' AND  CONVERT(VARCHAR(10), EDMT1100.ToDate,112) <= '+CONVERT(VARCHAR(10),@ToDate,112)+'   '

	--nếu giá trị NULL thì set về rổng 
	SET @SearchWhere = Isnull(@SearchWhere, '')
END 

	SET @sSQL = @sSQL + N'
	 SELECT 
		EDMT1100.APK,				EDMT1100.DivisionID,		EDMT1100.PromotionID,	EDMT1100.PromotionName,
		EDMT1100.FromDate,			EDMT1100.ToDate,
		EDMT1100.Value, EDMT1100.Quantity,
		-- EDMT1100.RemainQuantity,
		EDMT1100.Description,
		EDMT0099.Description as PromotionType,	EDMT1050.ReceiptTypeName as ReceiptTypeID


	 INTO #EDMP1100 
	 FROM EDMT1100 WITH (NOLOCK)
	 INNER JOIN EDMT1050 WITH(NOLOCK) ON EDMT1050.ReceiptTypeID = EDMT1100.ReceiptTypeID
	 INNER JOIN EDMT0099 WITH(NOLOCK) ON EDMT0099.CodeMaster = ''PromotionType'' AND EDMT0099.ID = EDMT1100.PromotionType

	 WHERE '+@sWhere +' 
	 ORDER BY '+@OrderBy+' 
	
	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * 
	FROM #EDMP1100 AS Temp
	'+@SearchWhere +'
	ORDER BY '+@OrderBy+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'



PRINT(@sSQL)
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
