IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[EDMP2170]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[EDMP2170]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid nghiệp vụ quản lý tin tức EDMF2170
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo, Date: 26/10/2018
--- Modify by ...: Bổ sung ...
-- <Example>

/*-- <Example>
--Lọc nâng cao 
	 EXEC EDMP2170 @DivisionID='BE', @DivisionList = '' , @NewsID = '',@TitleName='',@NewTypeID= '',@FromCreateDate = ' ',@ToCreateDate = '',@FromPublicDate = '',@ToPublicDate='',
	 @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @LanguageID = '',@SearchWhere=N' where IsNull(NewsID,'''') = N''1234'''

	
--Lọc thường
	 EXEC EDMP2170 @DivisionID='BE', @DivisionList = '' , @NewsID = '',@TitleName='',@NewTypeID = '',@FromCreateDate = ' ',@ToCreateDate = '',@FromPublicDate = '',@ToPublicDate='',
	 @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25,@SearchWhere=N'', @LanguageID = '' 

--*/


CREATE PROCEDURE EDMP2170
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @NewsID VARCHAR(50),
	 @TitleName VARCHAR(250),
	 @NewTypeID VARCHAR(50),
	 @FromCreateDate DATETIME,
	 @ToCreateDate DATETIME,
	 @FromPublicDate DATETIME,
	 @ToPublicDate DATETIME,
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @LanguageID VARCHAR (50),
	 @SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
)
AS 
Begin
	DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @OrderBy NVARCHAR(500) = N'',
        @TotalRow NVARCHAR(50) = N''



	SET @TotalRow = 'COUNT(*) OVER ()' 
	SET @OrderBy = 'CreateDate DESC'
	SET @sWhere = ' 1 = 1 '
		

	If Isnull(@SearchWhere, '') = '' --Lọc thường
	Begin

		IF ISNULL(@DivisionList, '') != '' 
			SET @sWhere = @sWhere + N' AND T1.DivisionID IN ('''+@DivisionList+''')'
		ELSE
			SET @sWhere = @sWhere + N' AND T1.DivisionID = '''+@DivisionID+''''

		IF ISNULL(@NewsID,'') !=  '' 
			SET @sWhere = @sWhere + 'AND T1.NewsID LIKE N''%'+@NewsID+'%'' '	
		IF ISNULL(@TitleName,'') != '' 
			SET @sWhere = @sWhere + 'AND T1.TitleName LIKE N''%'+@TitleName+'%'' '
		
		IF ISNULL(@NewTypeID,'') !=  '' 
			SET @sWhere = @sWhere + 'AND T1.NewTypeID LIKE N''%'+@NewTypeID+'%'' '

				
		IF (ISNULL(@FromCreateDate, '') <> '' AND ISNULL(@ToCreateDate, '') = '') SET @sWhere = @sWhere + '
		AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.CreateDate,120), 126) >= '''+CONVERT(VARCHAR(10),@FromCreateDate,126)+''' '
		IF (ISNULL(@FromCreateDate, '') = '' AND ISNULL(@ToCreateDate, '') <> '') SET @sWhere = @sWhere + '
		AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.CreateDate,120), 126) <= '''+CONVERT(VARCHAR(10),@ToCreateDate,126)+''' '
		IF (ISNULL(@FromCreateDate, '') <> '' AND ISNULL(@ToCreateDate, '') <> '') SET @sWhere = @sWhere + '
		AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.CreateDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromCreateDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToCreateDate,126)+''' '


		IF (ISNULL(@FromPublicDate, '') <> '' AND ISNULL(@ToPublicDate, '') = '') SET @sWhere = @sWhere + '
		AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.PublicDate,120), 126) >= '''+CONVERT(VARCHAR(10),@FromPublicDate,126)+''' '
		IF (ISNULL(@FromPublicDate, '') = '' AND ISNULL(@ToPublicDate, '') <> '') SET @sWhere = @sWhere + '
		AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.PublicDate,120), 126) <= '''+CONVERT(VARCHAR(10),@ToPublicDate,126)+''' '
		IF (ISNULL(@FromPublicDate, '') <> '' AND ISNULL(@ToPublicDate, '') <> '') SET @sWhere = @sWhere + '
		AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.PublicDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@FromPublicDate,126)+''' AND '''+CONVERT(VARCHAR(10),@ToPublicDate,126)+''' '

		--nếu giá trị NULL thì set về rổng 
		SET @SearchWhere = Isnull(@SearchWhere, '')
	END
	SET @sSQL = @sSQL + N'
		SELECT T1.APK,T1.DivisionID, T1.NewsID, T1.TitleName,T1.NewTypeID, 
		T1.PublicDate,T1.Summary,T1.DeleteFlg, '+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T3.Description' ELSE 'T3.DescriptionE' END+' AS NewTypeName,
		T1.GradeID,T4.GradeName, T1.ClassID,T5.ClassName,
	    T1.CreateDate,T1.CreateUserID,T1.LastModifyUserID, T1.LastModifyDate
		INTO #EDMP2170
		FROM EDMT2170 T1 WITH (NOLOCK)
		LEFT JOIN EDMT0099 T3 WITH (NOLOCK) ON T3.ID = T1.NewTypeID AND T3.CodeMaster = ''NewType''
		LEFT JOIN EDMT1000 T4 WITH (NOLOCK) ON T4.DivisionID IN (T1.DivisionID,''@@@'') AND T4.GradeID = T1.GradeID
		LEFT JOIN EDMT1020 T5 WITH (NOLOCK) ON T5.DivisionID IN (T1.DivisionID,''@@@'') AND T5.ClassID = T1.ClassID
		WHERE  '+@sWhere +'  AND T1.DeleteFlg = 0

		SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
		* FROM #EDMP2170 AS Temp
		'+@SearchWhere +'
		ORDER BY '+@OrderBy+' 
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

--PRINT(@sSQL)
	EXEC (@sSQL)
END




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO