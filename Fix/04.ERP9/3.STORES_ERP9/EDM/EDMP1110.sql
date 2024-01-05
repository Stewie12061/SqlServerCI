IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1110]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1110]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




---- 
-- <Return>
---- 
-- <Reference>
---- ASOFT - EDM \ Danh mục biểu phí \ Cập nhật đưa đón \ Lưới
-- <History>
----Created by: Lương Mỹ, Date: 02/01/2019
---- Modified by on 
-- <Example>
---- 
/*-- <Example>

----*/

CREATE PROCEDURE EDMP1110
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @ShuttleID VARCHAR(50),
	 @PickupPlace NVARCHAR(250),
	 @ArrivedPlace NVARCHAR(250),
	 @ReceiptTypeID VARCHAR(50),
	 @PromotionID VARCHAR(50),
	 @SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @OrderBy NVARCHAR(500) = N'',
        @TotalRow NVARCHAR(50) = N''
        
SET @OrderBy = 'ShuttleID'

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
SET @sWhere = '1 = 1 '

IF ISNULL(@SearchWhere, '') = '' --Lọc thường 
	BEGIN 
		IF ISNULL(@DivisionList, '') <> ''
			SET @sWhere = @sWhere + 'AND T1.DivisionID IN ('''+@DivisionList+''',''@@@'') ' 
		ELSE 
			SET @sWhere = @sWhere + 'AND T1.DivisionID IN ('''+@DivisionID+''',''@@@'') ' 

	IF ISNULL(@ShuttleID,'') <> '' 
		SET @sWhere = @sWhere + ' AND T1.ShuttleID LIKE N''%'+@ShuttleID+'%'' '	

	IF ISNULL(@PickupPlace,'') <> '' 
		SET @sWhere = @sWhere + ' AND T1.PickupPlace LIKE N''%'+@PickupPlace+'%'' '	

	IF ISNULL(@ArrivedPlace,'') <> '' 
		SET @sWhere = @sWhere + ' AND T1.ArrivedPlace LIKE N''%'+@ArrivedPlace+'%'' '	

	IF ISNULL(@ReceiptTypeID,'') <> '' 
		SET @sWhere = @sWhere + ' AND T1.ReceiptTypeID LIKE ''%'+@ReceiptTypeID+'%'' '	

	IF ISNULL(@PromotionID,'') <> '' 
		SET @sWhere = @sWhere + ' AND T1.PromotionID LIKE ''%'+@PromotionID+'%'' '	

	--nếu giá trị NULL thì set về rổng 
	SET @SearchWhere = Isnull(@SearchWhere, '')
END 

	SET @sSQL = @sSQL + N'
	 SELECT 
		T1.APK,				T1.DivisionID,		T1.ShuttleID,	
		T1.PickupPlace,		T1.ArrivedPlace,
		T1.Description,
		T2.ReceiptTypeName as ReceiptTypeID,	T3.PromotionName as PromotionID

	 INTO #T1 
	 FROM EDMT1110 T1 WITH (NOLOCK)
	 LEFT JOIN EDMT1050 T2 WITH(NOLOCK) ON T1.ReceiptTypeID = T2.ReceiptTypeID
	 LEFT JOIN EDMT1100 T3 WITH(NOLOCK) ON T1.PromotionID = T3.PromotionID

	 WHERE '+@sWhere +' 
	 ORDER BY '+@OrderBy+' 
	
	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * 
	FROM #T1 AS Temp
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
