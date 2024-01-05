IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2020]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2020]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Nghiệp vụ Xếp lớp (Màn hình truy vấn)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Minh Hòa , Date: 21/10/2018
-- <Example>
/*


--Lọc thường 
 EXEC EDMP2020 @DivisionID= 'BE', @DivisionList = 'BE', @UserID = '', @LanguageID = '', @PageNumber = 1, @PageSize = 25,
		@ArrangeClassID ='', @SchoolYearID  ='', 
		@GradeID  ='', @ClassID  ='', @ApproverID1  ='', @ApproverID2 ='',  @ApproverID3  ='', @ApproverID4  ='', @ApproverID5  ='', 
		@SearchWhere = '' 
--Lọc nâng cao 
 EXEC EDMP2020 @DivisionID= 'BE', @DivisionList = 'BE', @UserID = '', @LanguageID = '', @PageNumber = 1, @PageSize = 25,
		@ArrangeClassID ='', @SchoolYearID  ='', 
		@GradeID  ='', @ClassID  ='', @ApproverID1  ='', @ApproverID2 ='',  @ApproverID3  ='', @ApproverID4  ='', @ApproverID5  ='', 
		@SearchWhere =N'WHERE ISNULL(ArrangeClassID,'''') = N''XL/2019/02/0001''' 

*/

CREATE PROCEDURE EDMP2020 ( 
        @DivisionID VARCHAR(50), 
		@DivisionList VARCHAR(MAX), 
		@UserID VARCHAR(50),
	    @LanguageID VARCHAR(50),
		@PageNumber INT,
		@PageSize INT,
		@ArrangeClassID VARCHAR(50), 
		@SchoolYearID VARCHAR(50),
		@GradeID VARCHAR(50),
		@ClassID VARCHAR(50),
		@ApproverID1 VARCHAR(50),
		@ApproverID2 VARCHAR(50) ='',
		@ApproverID3 VARCHAR(50)='',
		@ApproverID4 VARCHAR(50)='',
		@ApproverID5 VARCHAR(50)='',

		@SearchWhere NVARCHAR(MAX) = NULL --#NULL: Lọc nâng cao; =NULL: Lọc thường
		
) 
AS 

DECLARE @sSQL NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(500) = N'', 
		@TotalRow NVARCHAR(50) = N''

	IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
	SET @OrderBy = 'ArrangeClassID'
	SET @sWhere = ' 1 = 1 '

	IF ISNULL(@SearchWhere, '') = '' --Lọc thường 
	BEGIN 
	IF ISNULL(@DivisionList, '') <> ''
		SET @sWhere = @sWhere + N'AND T1.DivisionID IN ('''+@DivisionList+''')'
	ELSE 
		SET @sWhere = @sWhere + N'AND T1.DivisionID = '''+@DivisionID+''''
	
	IF ISNULL(@ArrangeClassID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.ArrangeClassID  LIKE ''%'+@ArrangeClassID +'%'''
	IF ISNULL(@SchoolYearID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.SchoolYearID  LIKE ''%'+@SchoolYearID +'%'''
	
	IF ISNULL(@GradeID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.GradeID  LIKE ''%'+@GradeID +'%'''
	IF ISNULL(@ClassID, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.ClassID  LIKE ''%'+@ClassID +'%'''
	IF ISNULL(@ApproverID1, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.ApproverID1  LIKE ''%'+@ApproverID1 +'%'''
	IF ISNULL(@ApproverID2, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.ApproverID2  LIKE ''%'+@ApproverID2 +'%'''
	IF ISNULL(@ApproverID3, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.ApproverID3  LIKE ''%'+@ApproverID3 +'%'''
	IF ISNULL(@ApproverID4, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.ApproverID4  LIKE ''%'+@ApproverID4 +'%'''
	IF ISNULL(@ApproverID5, '') <> '' 
		SET @sWhere = @sWhere + N' AND T1.ApproverID5  LIKE ''%'+@ApproverID5 +'%'''					
	
	--nếu giá trị NULL thì set về rổng 
	SET @SearchWhere = Isnull(@SearchWhere, '')
	END 		

	
---- Danh sach Nguoi duyet
--SET @sSQL = '
--	DECLARE @RollLevel int
--	SELECT @RollLevel = Level FROM EDMT0002 WITH(NOLOCK) WHERE AbsentType=''XL'' AND DivisionID= ''@DivisionID''
--	SELECT @RollLevel = ISNULL(@RollLevel, 0)

--	SELECT HV.EmployeeID as ApproverID, HV.FullName as ApproverName INTO #approverTable
--                                            FROM HV1400 HV WITH (NOLOCK)
--                                            INNER JOIN EDMT0002 T1 WITH (NOLOCK) ON T1.DivisionID = HV.DivisionID  AND T1.AbsentType=''XL''
--                                            INNER JOIN EDMT0003 T2 WITH (NOLOCK) ON T2.DutyID = HV.DutyID AND T2.DivisionID = T1.DivisionID 
--                                                    AND T2.APKMaster = T1.APK AND T2.RollLevel= @RollLevel
--											RIGHT JOIN AT1405 WITH (NOLOCK) ON AT1405.DivisionID = HV.DivisionID AND AT1405.UserID = HV.EmployeeID
--                                            WHERE HV.DivisionID = ''@DivisionID'' AND HV.StatusID not in (3,9)
--'

SET @sSQL =  N'
SELECT 
T1.APK,T1.DivisionID,T1.ArrangeClassID, T1.SchoolYearID, 
T3.GradeName, T4.ClassName, 
A1.FullName as ApproverName1 , 
A2.FullName as ApproverName2 , 
A3.FullName as ApproverName3 , 
A4.FullName as ApproverName4 , 
A5.FullName as ApproverName5 
INTO #EDMP2020
FROM EDMT2020 T1  WITH (NOLOCK)
LEFT JOIN EDMT1000  T3 WITH (NOLOCK) ON T3.DivisionID IN (T1.DivisionID,''@@@'') AND T1.GradeID = T3.GradeID 
LEFT JOIN EDMT1020  T4 WITH (NOLOCK) ON T4.DivisionID IN (T1.DivisionID,''@@@'') AND  T1.ClassID = T4.ClassID

--LEFT JOIN #approverTable  A1 WITH (NOLOCK) ON T1.ApproverID1 = A1.ApproverID
--LEFT JOIN #approverTable  A2 WITH (NOLOCK) ON T1.ApproverID2 = A2.ApproverID
--LEFT JOIN #approverTable  A3 WITH (NOLOCK) ON T1.ApproverID3 = A3.ApproverID
--LEFT JOIN #approverTable  A4 WITH (NOLOCK) ON T1.ApproverID4 = A4.ApproverID
--LEFT JOIN #approverTable  A5 WITH (NOLOCK) ON T1.ApproverID5 = A5.ApproverID

LEFT JOIN HV1400  A1 WITH (NOLOCK) ON T1.ApproverID1 = A1.EmployeeID AND A1.DivisionID IN (T1.DivisionID,''@@@'') 
LEFT JOIN HV1400  A2 WITH (NOLOCK) ON T1.ApproverID2 = A2.EmployeeID AND A2.DivisionID IN (T1.DivisionID,''@@@'') 
LEFT JOIN HV1400  A3 WITH (NOLOCK) ON T1.ApproverID3 = A3.EmployeeID AND A3.DivisionID IN (T1.DivisionID,''@@@'') 
LEFT JOIN HV1400  A4 WITH (NOLOCK) ON T1.ApproverID4 = A4.EmployeeID AND A4.DivisionID IN (T1.DivisionID,''@@@'') 
LEFT JOIN HV1400  A5 WITH (NOLOCK) ON T1.ApproverID5 = A5.EmployeeID AND A5.DivisionID IN (T1.DivisionID,''@@@'') 
WHERE '+@sWhere+' AND DeleteFlg =0 
ORDER BY '+@OrderBy+'


SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * 
FROM #EDMP2020 AS Temp
'+@SearchWhere +'
ORDER BY '+@OrderBy+'
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

--DROP TABLE #approverTable
--PRINT @sSQL
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


