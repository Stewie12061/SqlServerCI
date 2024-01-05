IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2151]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2151]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load thông tin bảo lưu học sinh 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Hồng Thảo on 12/10/2018
-- <Example>
---- 
/*-- <Example>
	EDMP2151 @DivisionID = 'BE', @UserID = '', @APK = '1E57D00D-9BC2-49B9-8237-00A445E1625F'
	
	EDMP2151 @DivisionID, @UserID, @APK
----*/
CREATE PROCEDURE EDMP2151
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50) 
)

AS 

DECLARE @sSQL NVARCHAR(MAX)

SET @sSQL = N'
SELECT T1.APK,T1.DivisionID,T1.ReserveID,T1.ReserveDate,T1.ProposerID,T2.FullName AS ProposerName,
T1.SchoolYearID, 
T1.GradeID,T4.GradeName, 
T1.ClassID,T5.ClassName,
T1.StudentID, T6.StudentName,
T1.FeeID,
T1.ReservePeriod,T1.FromDate,T1.ToDate,T1.Reason,T1.Description,T1.DeleteFlg,T1.CreateUserID,T7.FullName AS CreateUserName,
T1.CreateDate,T1.LastModifyUserID,T8.FullName AS LastModifyUserName,T1.LastModifyDate
FROM EDMT2150 T1 WITH (NOLOCK) 
LEFT JOIN AT1103 T2 WITH (NOLOCK) ON T2.DivisionID IN (T1.DivisionID,''@@@'') AND T1.ProposerID = T2.EmployeeID
LEFT JOIN EDMT1000 T4 WITH (NOLOCK) ON T4.DivisionID IN (T1.DivisionID,''@@@'') AND T4.GradeID = T1.GradeID
LEFT JOIN EDMT1020 T5 WITH (NOLOCK) ON T5.DivisionID IN (T1.DivisionID,''@@@'') AND T5.ClassID = T1.ClassID 
LEFT JOIN EDMT2010 T6 WITH (NOLOCK) ON T6.DivisionID = T1.DivisionID AND T6.StudentID = T1.StudentID AND T6.DeleteFlg = 0
LEFT JOIN AT1103 T7 WITH (NOLOCK) ON T7.DivisionID = T1.DivisionID AND T7.EmployeeID = T1.CreateUserID
LEFT JOIN AT1103 T8 WITH (NOLOCK) ON T8.DivisionID = T1.DivisionID AND T8.EmployeeID = T1.LastModifyUserID
LEFT JOIN EDMT1040 T9 WITH(NOLOCK) ON T1.SchoolYearID = T9.SchoolYearID
WHERE T1.APK = '''+@APK+''' 
'
 --PRINT @sSQL
 EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
