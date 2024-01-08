IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2021]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2021]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load tab cập nhật xếp lớp 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Minh Hòa on 21/10/2018
-- <Example>
---- 
/*-- <Example>
	EDMP2021 @DivisionID = 'BE', @UserID = 'ASOFTADMIN', @APK = '88E62B82-EE31-46FA-9870-10A7553FB4B0', @LanguageID ='vi-VN'
	 
	EDMP2021 @DivisionID, @UserID, @APK, @LanguageID
----*/
CREATE PROCEDURE EDMP2021
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50),
	 @LanguageID VARCHAR(50)
)

AS 

DECLARE @sSQL NVARCHAR(MAX)

SET @sSQL = N'
SELECT T1.APK,T1.DivisionID, 
T1.ArrangeClassID, T1.SchoolYearID, 
T1.GradeID, T1.ClassID,
T3.GradeName, T4.ClassName, 
A1.FullName as ApproverName1 , 
A2.FullName as ApproverName2 , 
A3.FullName as ApproverName3 , 
A4.FullName as ApproverName4 , 
A5.FullName as ApproverName5,
T1.CreateUserID,T5.FullName AS CreateUserName, T1.CreateDate,T1.LastModifyUserID,
T6.FullName AS LastModifyUserName, T1.LastModifyDate 

FROM EDMT2020 T1  WITH (NOLOCK)
LEFT JOIN EDMT1000  T3 WITH (NOLOCK) ON T3.DivisionID IN (T1.DivisionID,''@@@'') AND T1.GradeID = T3.GradeID 
LEFT JOIN EDMT1020  T4 WITH (NOLOCK) ON T4.DivisionID IN (T1.DivisionID,''@@@'') AND  T1.ClassID = T4.ClassID
LEFT JOIN HV1400  A1 WITH (NOLOCK) ON T1.ApproverID1 = A1.EmployeeID AND A1.DivisionID IN (T1.DivisionID,''@@@'') 
LEFT JOIN HV1400  A2 WITH (NOLOCK) ON T1.ApproverID2 = A2.EmployeeID AND A2.DivisionID IN (T1.DivisionID,''@@@'') 
LEFT JOIN HV1400  A3 WITH (NOLOCK) ON T1.ApproverID3 = A3.EmployeeID AND A3.DivisionID IN (T1.DivisionID,''@@@'') 
LEFT JOIN HV1400  A4 WITH (NOLOCK) ON T1.ApproverID4 = A4.EmployeeID AND A4.DivisionID IN (T1.DivisionID,''@@@'') 
LEFT JOIN HV1400  A5 WITH (NOLOCK) ON T1.ApproverID5 = A5.EmployeeID AND A5.DivisionID IN (T1.DivisionID,''@@@'') 
LEFT JOIN AT1103 T5 WITH (NOLOCK) ON T5.DivisionID = T1.DivisionID AND T5.EmployeeID = T1.CreateUserID
LEFT JOIN AT1103 T6 WITH (NOLOCK) ON T6.DivisionID = T1.DivisionID AND T6.EmployeeID = T1.LastModifyUserID


WHERE T1.APK = '''+@APK+'''

'
 --PRINT @sSQL
 EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO







