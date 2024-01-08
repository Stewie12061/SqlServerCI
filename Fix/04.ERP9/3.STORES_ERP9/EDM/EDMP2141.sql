IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2141]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2141]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load thông tin điều chuyển học sinh  
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Hồng Thảo on 10/10/2018
-- <Example>
---- 
/*-- <Example>
	EDMP2141 @DivisionID = 'BS', @UserID = '', @APK = '1BC9D806-85E3-4029-9DF0-2C89309C2665'
	
	EDMP2141 @DivisionID, @UserID, @APK
----*/
CREATE PROCEDURE EDMP2141
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50) 
)

AS 

DECLARE @sSQL NVARCHAR(MAX)

SET @sSQL = N'
SELECT T01.APK,T01.DivisionID,T01.TranferStudentNo, T01.DateTranfer,T01.ProponentID,T02.FullName AS ProponentName, 
T01.Description,T01.StudentID, T03.StudentName, T03.DivisionID AS SchoolIDFrom,T04.DivisionName AS SchoolNameFrom, T05.GradeID, T06.GradeName,T05.ClassID, T07.ClassName,T01.ArrangeClassIDFrom,
T01.FromEffectiveDate,T01.ToEffectiveDate,T01.SchoolIDTo,T08.DivisionName AS SchoolNameTo,
T01.GradeIDTo, T09.GradeName AS GradeNameTo,T01.ClassIDTo, T10.ClassName AS ClassNameTo,T01.ArrangeClassIDTo,T01.Reason,T01.Approver1ID, T11.Fullname AS ApprovePerson01Name,
T01.Approver2ID,T12.Fullname AS ApprovePerson02Name, T01.Approver3ID,T13.Fullname AS ApprovePerson03Name,T01.Approver4ID,T14.Fullname AS ApprovePerson04Name,
T01.Approver5ID,T15.Fullname AS ApprovePerson05Name,T01.CreateUserID,T16.FullName AS CreateUserName, T01.CreateDate,T01.LastModifyUserID,
T17.FullName AS LastModifyUserName, T01.LastModifyDate 
FROM EDMT2140 T01 WITH (NOLOCK)
LEFT JOIN AT1103 T02 WITH (NOLOCK)   ON T02.DivisionID IN (T01.DivisionID,''@@@'') AND T01.ProponentID = T02.EmployeeID
LEFT JOIN EDMT2010 T03 WITH (NOLOCK) ON T03.DivisionID = T01.DivisionID AND T03.StudentID = T01.StudentID 
LEFT JOIN AT1101 T04 WITH (NOLOCK)   ON T04.DivisionID = T01.DivisionID 
LEFT JOIN EDMT2020 T05 WITH (NOLOCK) ON T05.DivisionID = T01.DivisionID AND T05.ArrangeClassID = T01.ArrangeClassIDFrom
LEFT JOIN EDMT1000 T06 WITH (NOLOCK) ON T06.DivisionID IN (T01.DivisionID,''@@@'') AND  T06.GradeID = T05.GradeID
LEFT JOIN EDMT1020 T07 WITH (NOLOCK) ON T07.DivisionID IN (T01.DivisionID,''@@@'') AND  T07.ClassID = T05.ClassID
LEFT JOIN AT1101 T08 WITH (NOLOCK)   ON T08.DivisionID = T01.SchoolIDTo
LEFT JOIN EDMT1000 T09 WITH (NOLOCK) ON T09.DivisionID IN (T01.DivisionID,''@@@'') AND  T09.GradeID = T01.GradeIDTo
LEFT JOIN EDMT1020 T10 WITH (NOLOCK) ON T10.DivisionID IN (T01.DivisionID,''@@@'') AND  T10.ClassID = T01.ClassIDTo
LEFT JOIN HV1400 T11 WITH (NOLOCK) ON T11.DivisionID IN (T01.DivisionID,''@@@'') AND T11.EmployeeID = T01.Approver1ID
LEFT JOIN HV1400 T12 WITH (NOLOCK) ON T12.DivisionID IN (T01.DivisionID,''@@@'') AND T12.EmployeeID = T01.Approver2ID
LEFT JOIN HV1400 T13 WITH (NOLOCK) ON T13.DivisionID IN (T01.DivisionID,''@@@'') AND T13.EmployeeID = T01.Approver3ID
LEFT JOIN HV1400 T14 WITH (NOLOCK) ON T14.DivisionID IN (T01.DivisionID,''@@@'') AND T14.EmployeeID = T01.Approver4ID
LEFT JOIN HV1400 T15 WITH (NOLOCK) ON T15.DivisionID IN (T01.DivisionID,''@@@'') AND T15.EmployeeID = T01.Approver5ID
LEFT JOIN AT1103 T16 WITH (NOLOCK) ON T16.DivisionID IN (T01.DivisionID,''@@@'') AND T16.EmployeeID = T01.CreateUserID
LEFT JOIN AT1103 T17 WITH (NOLOCK) ON T17.DivisionID IN (T01.DivisionID,''@@@'') AND T17.EmployeeID = T01.LastModifyUserID
WHERE T01.APK = '''+@APK+''' 
'


 --PRINT @sSQL
 EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
