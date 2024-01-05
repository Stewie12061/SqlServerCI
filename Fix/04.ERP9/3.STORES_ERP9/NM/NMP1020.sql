IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP1020]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP1020]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
---- Load danh mục nhóm thực đơn ( màn hình truy vấn)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
-- <History>
----Created by: Trà Giang, Date: 25/08/2018
-- <Example>
---- 
/*-- <Example>
	NMP1020 @DivisionID = 'BE', @DivisionList = 'BE', @UserID = 'ASOFTADMIN', @PageNumber = 1, @PageSize = 25, @MenuTypeID = '', 
	@MenuTypeName = '',@GradeLevelID='', @Disabled = 0, @IsCommon=''

----*/

CREATE PROCEDURE NMP1020
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @MenuTypeID VARCHAR(50),
	 @MenuTypeName NVARCHAR(250),
	 @GradeLevelID VARCHAR(50) ,
	 @Disabled VARCHAR(1),
	 @IsCommon VARCHAR(1)

)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @OrderBy NVARCHAR(500) = N'',
        @TotalRow NVARCHAR(50) = N''
        
SET @OrderBy = 'M.MenuTypeID'

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF ISNULL(@DivisionList, '') <> ''
	SET @sWhere = @sWhere + ' M.DivisionID IN ('''+@DivisionList+''', ''@@@'') ' 
ELSE 
	SET @sWhere = @sWhere + ' M.DivisionID IN ('''+@DivisionID+''', ''@@@'') ' 

IF ISNULL(@MenuTypeID,'') <> '' SET @sWhere = @sWhere + '
AND M.MenuTypeID LIKE N''%'+@MenuTypeID+'%'' '	
IF ISNULL(@MenuTypeName,'') <> '' SET @sWhere = @sWhere + '
AND M.MenuTypeName LIKE N''%'+@MenuTypeName+'%'' '
IF ISNULL(@GradeLevelID,'') <> '' SET @sWhere = @sWhere + '
AND NMT1022.GradeLevelID LIKE N''%'+@GradeLevelID+'%'' '
IF @Disabled IS NOT NULL SET @sWhere = @sWhere + N'
AND M.Disabled = '+@Disabled+''
IF ISNULL(@IsCommon, '') != '' SET @sWhere = @sWhere + N'
	AND M.IsCommon = '+@IsCommon+''


SET @sSQL = @sSQL + N'
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, '+@TotalRow+' AS TotalRow,
 M.APK, M.DivisionID , M.MenuTypeID, M.MenuTypeName,M.IsCommon,M.Disabled
, M.Description 

	,stuff(isnull((Select  '', '' + D6.GradeLevelID
    From  NMT1022 D6 WITH (NOLOCK) Left join EDMT1000 D8 WITH (NOLOCK) On Cast(D8.GradeID as Varchar(50)) = D6.GradeLevelID
	where D6.APKMaster= Cast(M.APK as Varchar(50))
     Group By D6.GradeLevelID, D8.GradeID
    Order by D6.GradeLevelID
    FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 2, '''') as GradeID
				 
, stuff(isnull((Select  '', '' + D8.GradeName
    From  NMT1022 D6 WITH (NOLOCK) Left join EDMT1000 D8 WITH (NOLOCK) On Cast(D8.GradeID as Varchar(50)) = D6.GradeLevelID
	where D6.APKMaster= Cast(M.APK as Varchar(50))
     Group By D6.GradeLevelID, D8.GradeName
    Order by D6.GradeLevelID
    FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 2, '''') as GradeName
		FROM NMT1020 M With (NOLOCK)  
		LEFT JOIN NMT1022 WITH (NOLOCK) on M.APK=NMT1022.APKMaster
WHERE '+@sWhere +'
ORDER BY '+@OrderBy+' 
	
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
 

EXEC (@sSQL)
--PRINT(@sSQL)

   








GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
