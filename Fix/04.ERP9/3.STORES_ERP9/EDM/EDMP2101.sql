IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2101]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2101]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Thời khóa biểu năm học
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Hồng Thảo on 12/09/2018
-- <Example>
---- 
/*-- <Example>
	EDMP2101 @DivisionID = 'BE', @UserID = '', @APK = '21808ED8-B313-46C0-8E31-B6C3634CB584'

	EDMP2101 @DivisionID, @UserID, @APK
----*/
CREATE PROCEDURE EDMP2101
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50)
)

AS 

DECLARE @sSQL NVARCHAR(MAX)

SET @sSQL = N'
SELECT T1.APK,T1.DivisionID,T1.DailyScheduleID,T1.DateSchedule, T1.Description,
T1.GradeID,T2.GradeName,
T1.ClassID, T8.ClassName,
T1.TermID,
T1.CreateUserID,T5.FullName AS CreateUserName,T1.CreateDate,T1.LastModifyUserID,T6.FullName AS LastModifyUserName,T1.LastModifyDate
FROM EDMT2100 T1  WITH (NOLOCK)
LEFT JOIN EDMT1000 T2 WITH (NOLOCK) ON T1.GradeID = T2.GradeID
LEFT JOIN AT1103 T5 WITH (NOLOCK) ON T5.DivisionID = T1.DivisionID AND T5.EmployeeID = T1.CreateUserID
LEFT JOIN AT1103 T6 WITH (NOLOCK) ON T6.DivisionID = T1.DivisionID AND T6.EmployeeID = T1.LastModifyUserID
LEFT JOIN EDMT1040 T7 WITH(NOLOCK) ON T1.TermID = T7.SchoolYearID
LEFT JOIN EDMT1020 T8 WITH(NOLOCK) ON T1.ClassID = T8.ClassID

WHERE T1.APK = '''+@APK+''''
 --PRINT @sSQL
 EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
