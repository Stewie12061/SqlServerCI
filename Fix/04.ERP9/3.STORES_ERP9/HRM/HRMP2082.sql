IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2082]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2082]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Đổ nguồn màn hình cập nhật yêu cầu đào tạo
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hải Long, Date: 18/09/2017
----Updated by: Võ Dương, Date: 09/10/2023
-- <Example>
---- 
/*-- <Example>
	EXEC HRMP2082 @DivisionID='AS',@UserID='ASOFTADMIN',@TrainingRequestID='TR0001'
----*/

CREATE PROCEDURE [HRMP2082] 
( 
	@DivisionID NVARCHAR(50),
	@UserID NVARCHAR(50),
	@TrainingRequestID NVARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)

SET @sSQL = '
SELECT HRMT2080.APK, HRMT2080.DivisionID, TrainingRequestID,

STUFF(( SELECT '','' + HRMT2080.DepartmentID
								FROM   AT1102 WITH (NOLOCK) 
								WHERE   AT1102.DepartmentID IN (SELECT Value FROM dbo.StringSplit(HRMT2080.DepartmentID,'',''))
								ORDER BY AT1102.DepartmentID
								FOR XML PATH('''')), 1, 1, '''') AS DepartmentID
,STUFF(( SELECT '','' + AT1102.DepartmentName
								FROM   AT1102 WITH (NOLOCK) 
								WHERE   AT1102.DepartmentID IN (SELECT Value FROM dbo.StringSplit(HRMT2080.DepartmentID,'',''))
								ORDER BY AT1102.DepartmentID
								FOR XML PATH('''')), 1, 1, '''') AS DepartmentName
,TrainingFieldID,
NumberEmployee, TrainingFromDate, TrainingToDate, Description1, Description2, AssignedToUserID,
(SELECT TOP 1 FullName FROM AT1103 WHERE EmployeeID = HRMT2080.AssignedToUserID) AS AssignedToUserName
FROM HRMT2080 WITH (NOLOCK)
LEFT JOIN AT1102 ON HRMT2080.DepartmentID = AT1102.DepartmentID
WHERE HRMT2080.DivisionID = '''+@DivisionID+'''
AND HRMT2080.APK = '''+@TrainingRequestID+''''

--PRINT @sSQL			
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
