IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2083]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2083]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load đổ nguồn màn hình xem thông tin yêu cầu đào tạo
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Hải Long on 18/09/2017
----Modified by Trọng Kiên on 27/08/2020: Bổ sung load người phụ trách gồm mã và tên
---- <Example>
---- EXEC HRMP2083 @DivisionID='AS',@UserID='ASOFTADMIN',@TrainingRequestID='TR0001'
---- 

CREATE PROCEDURE [dbo].[HRMP2083]
( 
  @DivisionID NVARCHAR(50),
  @UserID NVARCHAR(50),
  @TrainingRequestID NVARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)

SET @sSQL = ' 		
SELECT HRMT2080.APK, HRMT2080.DivisionID, TrainingRequestID, HRMT2080.DepartmentID, AT1102.DepartmentName, HRMT2080.TrainingFieldID, HRMT1040.TrainingFieldName,
NumberEmployee, TrainingFromDate, TrainingToDate, Description1, Description2, CONCAT(AssignedToUserID, ''_'', A1.FullName) AS AssignedToUserID,
HRMT2080.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2080.CreateUserID) CreateUserID, HRMT2080.CreateDate, 
HRMT2080.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2080.LastModifyUserID) LastModifyUserID, HRMT2080.LastModifyDate
FROM HRMT2080 WITH (NOLOCK)
LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = HRMT2080.DepartmentID
LEFT JOIN HRMT1040 WITH (NOLOCK) ON HRMT1040.TrainingFieldID = HRMT2080.TrainingFieldID
LEFT JOIN AT1103 A1 WITH (NOLOCK) ON HRMT2080.AssignedToUserID = A1.EmployeeID
WHERE HRMT2080.TrainingRequestID = ''' + @TrainingRequestID + ''''

--PRINT(@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
