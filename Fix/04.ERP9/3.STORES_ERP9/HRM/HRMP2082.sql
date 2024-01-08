IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2082]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
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
SELECT DivisionID, TrainingRequestID, DepartmentID, TrainingFieldID,
NumberEmployee, TrainingFromDate, TrainingToDate, Description1, Description2, AssignedToUserID,
(SELECT TOP 1 FullName FROM AT1103 WHERE EmployeeID = HRMT2080.AssignedToUserID) AS AssignedToUserName
FROM HRMT2080 WITH (NOLOCK)
WHERE HRMT2080.DivisionID = '''+@DivisionID+'''
AND HRMT2080.TrainingRequestID = '''+@TrainingRequestID+''''

--PRINT @sSQL			
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

