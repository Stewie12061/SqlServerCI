IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2070]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2070]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form EDMF2070: điều chuyển giáo viên
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Văn Tình, Date: 15/11/2018
-- <Example>
/*
---Lọc thường 
EXEC EDMP2070 @DivisionID ='BE',@DivisionList ='BE',@UserID ='',@LanguageID='vi-VN',@PageNumber=1,@PageSize=25,@VoucherNo='',@DecisionDateFrom=NULL,@DecisionDateTo=NULL,@DivisionIDTo='',@TeacherID='',
@TeacherName='',@GradeIDTo='',@ClassIDTo='',@SearchWhere=''
---Lọc nâng cao 
EXEC EDMP2070 @DivisionID ='BE',@DivisionList ='BE',@UserID ='',@LanguageID='vi-VN',@PageNumber=1,@PageSize=25,@VoucherNo='',@DecisionDateFrom= NULL,@DecisionDateTo= NULL,@DivisionIDTo='',@TeacherID='',
@TeacherName='',@GradeIDTo='',@ClassIDTo='',@SearchWhere=N'WHERE ISNULL(VoucherNo,'''') = N''DCGV/2019/02/0007'''

*/


CREATE PROCEDURE [dbo].[EDMP2070]
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList VARCHAR(MAX),
	 @UserID VARCHAR(50),
	 @LanguageID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @VoucherNo VARCHAR(50),
	 @DecisionDateFrom DATETIME,
	 @DecisionDateTo DATETIME,
	 @DivisionIDTo VARCHAR(50),
	 @TeacherID VARCHAR(50),
	 @TeacherName NVARCHAR(256),
	 @GradeIDTo VARCHAR(50),
	 @ClassIDTo VARCHAR(50),
	 @SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
)
AS 
SET NOCOUNT ON

DECLARE @sSQL NVARCHAR (MAX)='', @sSQLDetailFilter NVARCHAR (4000),
        @sWhere NVARCHAR(4000),
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
                
 
SET @OrderBy = 'CreateDate DESC,VoucherNo'
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
SET @sWhere = 'AND 1 = 1 '
 
 
 
SET @sSQLDetailFilter = ''

IF ISNULL(@SearchWhere, '') = '' --Lọc thường 
BEGIN 
	IF ISNULL(@DivisionList, '') <> ''
		SET @sWhere = @sWhere + N'AND A.DivisionID IN ('''+@DivisionList+''')'
	ELSE 
		SET @sWhere = @sWhere + N'AND A.DivisionID = '''+@DivisionID+''''

SELECT TOP 0 APKMaster INTO #EDMT2071 FROM EDMT2071 WITH(NOLOCK) 
SELECT TOP 0 EmployeeID INTO #Teacher FROM AT1103 WITH(NOLOCK)

	IF @VoucherNo <> ''
		SET @sWhere = @sWhere + ' AND A.VoucherNo LIKE ''' + @VoucherNo+'%'' '
	IF @DivisionIDTo <> '' 
		SET @sWhere = @sWhere + ' AND A.DivisionIDTo LIKE ''' + @DivisionIDTo + '%'' '	
	IF @DecisionDateFrom IS NOT NULL
		SET @sWhere = @sWhere + ' AND A.DecisionDate >= ''' + CONVERT(VARCHAR(8), @DecisionDateFrom, 112) + ''' '
	IF @DecisionDateTo IS NOT NULL
		SET @sWhere = @sWhere + ' AND A.DecisionDate <= ''' + CONVERT(VARCHAR(8), @DecisionDateTo, 112) + ''' '

	-- Filter detail
	IF @TeacherID <> ''
	BEGIN
		SET @sSQLDetailFilter += 'INSERT INTO #Teacher(EmployeeID) 
		SELECT EmployeeID FROM AT1103 WITH(NOLOCK) WHERE EmployeeID LIKE ''%' + @TeacherID + '%'' 
		'
	END
	IF @TeacherName <> ''
	BEGIN
		SET @sSQLDetailFilter += 'INSERT INTO #Teacher(EmployeeID) 
		SELECT EmployeeID FROM AT1103 WITH(NOLOCK) WHERE FullName LIKE ''%' + @TeacherName + '%'' 
		'
	END
	--PRINT(@sSQLDetailFilter)
	IF @sSQLDetailFilter <> ''
		EXEC (@sSQLDetailFilter)
	
	IF (@TeacherID <> '' OR @TeacherName <> '') OR @GradeIDTo <> '' OR @ClassIDTo <> ''
	BEGIN
		SET @sSQLDetailFilter = '
		INSERT INTO #EDMT2071(APKMaster)
		SELECT B.APKMaster FROM EDMT2070 A WITH(NOLOCK) INNER JOIN EDMT2071 B WITH(NOLOCK) ON A.APK = B.APKMaster
		WHERE 1 = 1 '
		
		IF (@TeacherID <> '' OR @TeacherName <> '')
			SET @sSQLDetailFilter += ' AND EXISTS (SELECT TOP 1 1 FROM #Teacher T WHERE T.EmployeeID = B.TeacherID)'
		
		IF @GradeIDTo <> ''
			SET @sSQLDetailFilter += ' AND B.GradeIDTo LIKE ''' + @GradeIDTo + '%'' '
		IF @ClassIDTo <> ''
			SET @sSQLDetailFilter += ' AND B.ClassIDTo LIKE ''' + @ClassIDTo + '%'' '

		SET @sSQLDetailFilter += @sWhere + '
		GROUP BY B.APKMaster'

		--PRINT(@sSQLDetailFilter)
		EXEC (@sSQLDetailFilter)
	END
	--END Filter detail

	IF EXISTS (SELECT TOP 1 1 FROM #EDMT2071)
BEGIN
	SET @sWhere += ' AND EXISTS (SELECT TOP 1 1 FROM #EDMT2071 T WHERE T.APKMaster = A.APK)'
END

		--nếu giá trị NULL thì set về rổng 
	SET @SearchWhere = Isnull(@SearchWhere, '')
END



SET @sSQL = '
SELECT
	A.DivisionID, A.APK, A.VoucherNo, A.DecisionDate, A.PromoterID, H1.FullName AS PromoterName, A.DeciderID, H2.FullName AS DeciderName, A.Description,
	A.DivisionIDTo, C.DivisionName AS DivisionNameTo,
	A.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = A.CreateUserID) AS CreateUserID, A.CreateDate, 
	A.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = A.LastModifyUserID) AS LastModifyUserID, A.LastModifyDate
INTO #EDMP2070
FROM EDMT2070 A WITH(NOLOCK) 
	LEFT JOIN (SELECT DivisionID, DivisionName FROM AT1101 WITH(NOLOCK) WHERE Disabled = 0) C ON A.DivisionIDTo = C.DivisionID
	LEFT JOIN AT1103 H1 WITH(NOLOCK) ON H1.EmployeeID = A.PromoterID
	LEFT JOIN AT1103 H2 WITH(NOLOCK) ON H2.EmployeeID = A.DeciderID
WHERE A.DeleteFlg = 0 ' + @sWhere + '


SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * 
FROM #EDMP2070 AS Temp
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

