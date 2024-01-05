IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2010]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2010]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form EDMF2010: ho so hoc sinh
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Văn Tình, Date: 23/09/2018
-- <Example>
---- 
/*
---Lọc thường 
 EXEC EDMP2010 @DivisionID = 'BE',@DivisionList = '',@UserID = '',@LanguageID = 'vi-VN',@PageNumber = 1,@PageSize = 25,@StudentID = '',@StudentName = ''
 ,@StatusID = '', @GradeID = '',@ClassID = '',@RegistrationDate = null,@FatherName = '',@MotherName = '', @SearchWhere = ''

---Lọc nâng cao 
  EXEC EDMP2010 @DivisionID = 'BE',@DivisionList = 'BE',@UserID = '',@LanguageID = 'vi-VN',@PageNumber = 1,@PageSize = 25,@StudentID = '',@StudentName = ''
 ,@StatusID = '', @GradeID = '',@ClassID = '',@RegistrationDate = null,@FatherName = '',@MotherName = '', @SearchWhere =N'WHERE ISNULL(StudentID,'''') = N''BE-U002'''

*/

CREATE PROCEDURE [dbo].[EDMP2010]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @LanguageID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @StudentID VARCHAR(50),
	 @StudentName NVARCHAR(250),
	 @StatusID VARCHAR(50),
	 @GradeID VARCHAR(50),
	 @ClassID VARCHAR(50),
	 @RegistrationDate DATETIME,
	 @FatherName NVARCHAR(128),
	 @MotherName NVARCHAR(128),
	 @SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
)
AS 
SET NOCOUNT ON

DECLARE @cLan VARCHAR(1)
DECLARE @sSQL NVARCHAR (MAX)='',
        @sWhere NVARCHAR(4000),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
                
 
SET @OrderBy = 'CreateDate DESC'
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
SET @sWhere = ' 1 = 1 '


	IF ISNULL(@SearchWhere, '') = '' --Lọc thường 
	BEGIN 
	IF ISNULL(@DivisionList, '') != ''
		SET @sWhere = @sWhere + N' AND A.DivisionID IN ('''+@DivisionList+''')'
	ELSE 
		SET @sWhere = @sWhere + N' AND A.DivisionID = '''+@DivisionID+''''
	IF @StudentID <> ''
		SET @sWhere = @sWhere + ' AND A.StudentID LIKE ''' + @StudentID+'%'' '
	IF @StudentName <> ''
		SET @sWhere = @sWhere + ' AND A.StudentName LIKE N''%' + @StudentName + '%'' '
	IF @StatusID <> '' 
		SET @sWhere = @sWhere + ' AND A.StatusID = ''' + @StatusID + ''' '
	IF @GradeID <> ''
		SET @sWhere = @sWhere + ' AND A.GradeID = ''' + @GradeID + ''' '
	IF @ClassID <> ''
		SET @sWhere = @sWhere + ' AND A.ClassID = ''' + @ClassID + ''' '
	IF @FatherName <> ''
		SET @sWhere = @sWhere + '  AND   A.FatherID LIKE ''%'+@FatherName +'%'' OR O1.ObjectName LIKE N''%' + @FatherName + '%'' '
	IF @MotherName <> ''
		SET @sWhere = @sWhere + ' AND   A.MotherID LIKE ''%'+@MotherName +'%'' OR O2.ObjectName LIKE N''%' + @MotherName + '%'' '
	IF @RegistrationDate  <> ''
		SET @sWhere = @sWhere + ' AND A.RegistrationDate = ''' + CONVERT(VARCHAR(10), @RegistrationDate, 112) + '%'' '

		--nếu giá trị NULL thì set về rổng 
	SET @SearchWhere = Isnull(@SearchWhere, '')
	END 

SET @sSQL = @sSQL + N'
SELECT 
	A.DivisionID, A.APK, A.StudentID, A.StudentName, A.StatusID,
	'+ CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'E.Description' ELSE 'E.DescriptionE' END +' as StatusName,  
	A.DateOfBirth, A.PlaceOfBirth,
	'+ CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'F.Description' ELSE 'F.DescriptionE' END +' as SexName,  
	A.GradeID, C.GradeName, A.ClassID, D.ClassName, A.ComfirmID, '+ CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'G.Description' ELSE 'G.DescriptionE' END +' as ComfirmName,
	A.FatherID, O1.ObjectName AS FatherName, A.MotherID, O2.ObjectName AS MotherName, 
	A.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = A.CreateUserID) AS CreateUserID, A.CreateDate, 
	A.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = A.LastModifyUserID) AS LastModifyUserID, A.LastModifyDate,
	A.AdmissionDate, A.BeginTrialDate,A.EndTrialDate
INTO #EDMP2010
FROM EDMT2010 A WITH(NOLOCK) 
	LEFT JOIN EDMT1000 C WITH (NOLOCK) ON C.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND C.Disabled = 0 AND A.GradeID = C.GradeID
	LEFT JOIN EDMT1020 D WITH (NOLOCK) ON D.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND D.Disabled = 0 AND D.ClassID = A.ClassID
	LEFT JOIN EDMT0099 E WITH (NOLOCK) ON E.ID = A.StatusID AND E.CodeMaster = ''StudentStatus'' AND E.Disabled = 0 
	LEFT JOIN EDMT0099 F WITH (NOLOCK) ON F.ID = A.SexID AND F.CodeMaster = ''Sex'' AND F.Disabled = 0 
	LEFT JOIN AT1202 O1 WITH(NOLOCK) ON A.FatherID = O1.ObjectID
	LEFT JOIN AT1202 O2 WITH(NOLOCK) ON A.MotherID = O2.ObjectID
	LEFT JOIN EDMT0099 G WITH (NOLOCK) ON G.ID = A.ComfirmID AND G.CodeMaster = ''ComfirmStatus''
WHERE  '+ @sWhere +' AND A.DeleteFlg = 0
 

SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * 
FROM #EDMP2010 AS Temp
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

