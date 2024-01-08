IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2032]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2032]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Tab thông tin EDMF2032: phân công giáo viên
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Văn Tình, Date: 20/10/2018
-- <Example>
---- 
--	EDMP2032 @DivisionID='BE', @UserID='ASOFTADMIN', @LanguageID = 'vi-VN', @APK=N'099E50F2-30EF-4F31-99F0-E6BD08480FA0'

CREATE PROCEDURE [dbo].[EDMP2032]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @LanguageID VARCHAR(50),
	 @APK VARCHAR(50)
)
AS 
SET NOCOUNT ON

DECLARE @cLan VARCHAR(1)
DECLARE @sSQL NVARCHAR (MAX), @sWhere NVARCHAR(4000), @Param NVARCHAR(1000)
DECLARE @TeacherID VARCHAR(1000), @TeacherName NVARCHAR(4000), @NannyName NVARCHAR(4000), @NannyID VARCHAR(1000)
               
IF @LanguageID = 'vi-VN' SET @cLan = '' ELSE SET @cLan = 'E'

SELECT @TeacherName = COALESCE(@TeacherName + ',', '') + ' ' + T1.TeacherName --, @TeacherID =  COALESCE(@TeacherID + ',', '') + ' ' + T1.TeacherID
FROM (
	SELECT A.TeacherID, ISNULL(HV.FullName, '') AS TeacherName
		FROM EDMT2031 A WITH(NOLOCK) LEFT JOIN AT1103 HV WITH(NOLOCK) ON HV.EmployeeID = A.TeacherID
		WHERE A.APKMaster = @APK AND A.DeleteFlg = 0
) AS T1

SELECT @NannyName = COALESCE(@NannyName + ',', '') + ' ' + T1.NannyName --, @NannyID =  COALESCE(@NannyID + ',', '') + ' ' + T1.NannyID
FROM (
	SELECT A.NannyID, ISNULL(HV.FullName, '') AS NannyName
		FROM EDMT2032 A WITH(NOLOCK) LEFT JOIN AT1103 HV WITH(NOLOCK) ON HV.EmployeeID = A.NannyID
		WHERE A.APKMaster = @APK AND A.DeleteFlg = 0
) AS T1

SET @sSQL = N'
SELECT A.DivisionID, A.APK, A.VoucherNo, A.SchoolYearID,
	A.GradeID, C.GradeName, A.ClassID, D.ClassName, 
	A.[ApprovalID01], A.[ApprovalID02], A.[ApprovalID03],A.[ApprovalID04],A.[ApprovalID05],
	H1.FullName AS ApprovalName01, H2.FullName AS ApprovalName02,H3.FullName AS ApprovalName03,
	H4.FullName AS ApprovalName04,H5.FullName AS ApprovalName05,
	A.CreateUserID, A.CreateDate, A.LastModifyUserID, A.LastModifyDate,
	@TeacherName AS TeacherName, @NannyName AS NannyName
FROM EDMT2030 A WITH(NOLOCK) 
	LEFT JOIN (SELECT GradeID, GradeName FROM EDMT1000 WITH(NOLOCK) WHERE DivisionID IN (@DivisionID, ''@@@'') AND [Disabled] = 0) AS C ON A.GradeID = C.GradeID
	LEFT JOIN (SELECT ClassID, ClassName FROM EDMT1020 WITH(NOLOCK) WHERE DivisionID IN (@DivisionID, ''@@@'') AND [Disabled] = 0) AS D ON D.ClassID = A.ClassID
	LEFT JOIN HV1400 H1 WITH(NOLOCK) ON H1.EmployeeID = A.[ApprovalID01]
	LEFT JOIN HV1400 H2 WITH(NOLOCK) ON H2.EmployeeID = A.[ApprovalID02]
	LEFT JOIN HV1400 H3 WITH(NOLOCK) ON H3.EmployeeID = A.[ApprovalID03]
	LEFT JOIN HV1400 H4 WITH(NOLOCK) ON H4.EmployeeID = A.[ApprovalID04]
	LEFT JOIN HV1400 H5 WITH(NOLOCK) ON H5.EmployeeID = A.[ApprovalID05]
WHERE A.APK = @APK 
'

SET @Param = '@DivisionID VARCHAR(50), @APK VARCHAR(50), @TeacherName NVARCHAR(4000), @NannyName NVARCHAR(4000)'

EXEC sp_executesql @sSQL, @Param, @DivisionID, @APK, @TeacherName, @NannyName



--PRINT @sSQL
--EXEC (@sSQL)

GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

