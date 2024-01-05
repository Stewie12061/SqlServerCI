IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[FNP1000]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[FNP1000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load danh mục định mức chi phí (màn hình truy vấn)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- ASOFT - FN \ Danh mục \Danh mục định mức chi phí 
-- <History>
----Created by: Hồng Thảo  on 17/08/2018
----Modified by Hồng Thảo on 05/09/2018: Bổ sung 
-- <Example>
---- 
/*-- <Example>
EXEC FNP1000 @DivisionID='AS' , @DivisionList='', @UserID='',@PageNumber ='1',@PageSize =25,@NormID ='',@NormName ='',@Disabled ='',@IsCommon ='',@AreaID ='1',
@CityID ='',@CurrencyID='',@LanguageID = '',@SearchWhere=N' where IsNull(NormID,'''') = N''DM1'''


FNP1000 @DivisionID,@DivisionList,@UserID,@PageNumber,@PageSize,@NormID,@NormName,@Disabled,@IsCommon,@AreaID,@CityID,@CurrencyID,@LanguageID,@SearchWhere

----*/

CREATE PROCEDURE FNP1000
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @NormID VARCHAR(50),
	 @NormName VARCHAR(50),
	 @Disabled VARCHAR(1),
	 @IsCommon VARCHAR(1),
	 @AreaID VARCHAR(50),
	 @CityID VARCHAR(50),
	 @CurrencyID VARCHAR(50),
	 @LanguageID VARCHAR(50),
	 @SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @OrderBy NVARCHAR(500) = N'',
        @TotalRow NVARCHAR(50) = N''
        
SET @OrderBy = 'NormID'

SET @TotalRow = 'COUNT(*) OVER ()'
SET @sWhere = ' 1 = 1 '

    If Isnull(@SearchWhere, '') = '' --Lọc thường
	Begin
		IF ISNULL(@DivisionList, '') <> ''
		SET @sWhere = @sWhere + 'AND T1.DivisionID IN ('''+@DivisionList+''', ''@@@'') ' 
		ELSE
		SET @sWhere = @sWhere + 'AND T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') ' 

		IF ISNULL(@NormID,'') <> '' SET @sWhere = @sWhere + '
		AND T1.NormID LIKE N''%'+@NormID+'%'' '	
		IF ISNULL(@NormName,'') <> '' SET @sWhere = @sWhere + '
		AND T1.NormName LIKE N''%'+@NormName+'%'' '
		IF ISNULL(@Disabled,'') <> '' SET @sWhere = @sWhere + N'
		AND T1.Disabled = '+@Disabled+''
		IF ISNULL(@IsCommon,'') <> '' SET @sWhere = @sWhere + N'
		AND T1.IsCommon = '+@IsCommon+''
		IF ISNULL(@CityID,'') <> '' SET @sWhere = @sWhere + '
		AND T1.CityID LIKE N''%'+@CityID+'%'' '
		IF ISNULL(@AreaID,'') <> '' SET @sWhere = @sWhere + '
		AND T1.AreaID LIKE N''%'+@AreaID+'%'' '
		IF ISNULL(@CurrencyID,'') <> '' SET @sWhere = @sWhere + '
		AND T1.CurrencyID LIKE N''%'+@CurrencyID+'%'' '

		--nếu giá trị NULL thì set về rổng 
		SET @SearchWhere = Isnull(@SearchWhere, '')
	END

	

SET @sSQL = @sSQL + N'
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
T1.APK, T1.DivisionID, T1.NormID, T1.NormName, T1.AreaID,'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T2.Description' ELSE 'T2.DescriptionE' END+' AS AreaName,
T1.CityID,T3.AnaName AS CityName,T1.CurrencyID,T4.CurrencyName,T1.Description,T1.IsCommon, T1.Disabled
INTO #FNP1000
FROM FNT1000 T1 WITH (NOLOCK)
LEFT JOIN FNT0099 T2 WITH (NOLOCK) ON T1.AreaID = T2.ID AND T2.CodeMaster = ''Area'' 
LEFT JOIN AT1015 T3 WITH (NOLOCK) ON T3.DivisionID IN (T1.DivisionID, ''@@@'') AND T3.AnaID = T1.CityID AND T3.AnaTypeID = ''O01''
LEFT JOIN AT1004 T4 WITH (NOLOCK) ON T4.DivisionID IN (T1.DivisionID, ''@@@'') AND T4.CurrencyID = T1.CurrencyID
WHERE '+@sWhere +'


SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow
						,*
						FROM #FNP1000 AS Temp
						'+@SearchWhere +'

ORDER BY '+@OrderBy+' 
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

--PRINT(@sSQL)
EXEC (@sSQL)


  
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
