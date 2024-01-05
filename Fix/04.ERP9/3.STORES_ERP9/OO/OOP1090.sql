IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP1090]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP1090]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid Form OOF1090: Danh mục Thiết bị
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Lê Hoàng, Date: 13/10/2020
----Modified by: Lê Hoàng, Date: 19/10/2020
-- <Example>
---- 
/*
	OOP1090 @DivisionID='CBD', @DivisionList = '', @UserID='ASOFTADMIN', @LanguageID = 'vi-VN', @PageNumber=1 ,@PageSize=25
*/

CREATE PROCEDURE [dbo].[OOP1090]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionIDList VARCHAR(MAX),
	 @DeviceID VARCHAR(50)=N'',
	 @DeviceName VARCHAR(50)=N'',
	 @DeviceNameE VARCHAR(50)=N'',
	 @TypeID VARCHAR(50)=N'',
	 @AreaID VARCHAR(50)=N'',
	 @Disabled VARCHAR(10)=N'',
	 @IsCommon VARCHAR(10)=N'',
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT
)
AS 
SET NOCOUNT ON

DECLARE @sSQL NVARCHAR (MAX)='',
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
                

SET @OrderBy = 'DeviceID'
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
SET @sWhere = ' 1 = 1 '


--IF ISNULL(@SearchWhere, '') = '' --Lọc thường 
BEGIN 
	IF ISNULL(@DivisionIDList, '') <> ''
		SET @sWhere = @sWhere + N'AND OOT1090.DivisionID IN ('''+@DivisionIDList+''',''@@@'')'
	ELSE 
		SET @sWhere = @sWhere + N'AND OOT1090.DivisionID IN ('''+@DivisionID+''',''@@@'')'

	IF ISNULL(@DeviceID,'') <> '' SET @sWhere = @sWhere + '
	AND OOT1090.DeviceID LIKE N''%'+@DeviceID+'%'' '	
	IF ISNULL(@DeviceName,'') <> '' SET @sWhere = @sWhere + '
	AND OOT1090.DeviceName LIKE N''%'+@DeviceName+'%'' '	
	IF ISNULL(@DeviceNameE,'') <> '' SET @sWhere = @sWhere + '
	AND OOT1090.DeviceNameE LIKE N''%'+@DeviceNameE+'%'' '	
	IF ISNULL(@TypeID,'') <> '' SET @sWhere = @sWhere + '
	AND OOT1090.TypeID LIKE N''%'+@TypeID+'%'' '	
	IF ISNULL(@AreaID,'') <> '' SET @sWhere = @sWhere + '
	AND OOT1090.AreaID LIKE N''%'+@AreaID+'%'' '	
	IF ISNULL(@Disabled, '') <> '' SET @sWhere = @sWhere + N'
	AND OOT1090.Disabled LIKE N''%'+@Disabled+'%'' '	
	IF ISNULL(@IsCommon, '') <> '' SET @sWhere = @sWhere + N'
	AND OOT1090.IsCommon LIKE N''%'+@IsCommon+'%'' '

	--nếu giá trị NULL thì set về rổng 
	--SET @SearchWhere = Isnull(@SearchWhere, '')
END

SET @sSQL = @sSQL + '
SELECT
	OOT1090.DivisionID, OOT1090.APK, OOT1090.DeviceID, 
	O98.Description AS TypeID,
	O99.Description AS AreaID,
	OOT1090.DeviceName,
	OOT1090.DeviceNameE,
	OOT1090.CreateUserID +'' - ''+ (SELECT TOP 1 FullName FROM AT1103 WITH (NOLOCK) WHERE EmployeeID = OOT1090.CreateUserID) CreateUserID, OOT1090.CreateDate, 
	OOT1090.LastModifyUserID +'' - ''+ (SELECT TOP 1 FullName FROM AT1103 WITH (NOLOCK) WHERE EmployeeID = OOT1090.LastModifyUserID) LastModifyUserID, OOT1090.LastModifyDate,
	OOT1090.Disabled, OOT1090.IsCommon
INTO #OOP1090 
FROM OOT1090 WITH (NOLOCK) 
LEFT JOIN (SELECT CodeMaster, ID, Description FROM OOT0099 WITH (NOLOCK) WHERE CodeMaster = ''OOF1091.Area'') O99 ON O99.ID = OOT1090.AreaID 
LEFT JOIN (SELECT CodeMaster, ID, Description FROM OOT0099 WITH (NOLOCK) WHERE CodeMaster = ''OOF1091.Type'') O98 ON O98.ID = OOT1090.TypeID
WHERE ' + @sWhere + '
ORDER BY ' + @OrderBy + '

SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * 
FROM #OOP1090 AS Temp
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
