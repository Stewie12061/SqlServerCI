IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2062]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2062]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load đổ nguồn màn hình cập nhật ngân sách đào tạo
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Hải Long on 13/09/2017
---- <Example>
---- Exec HRMP2062 @DivisionID='AS',@UserID='ASOFTADMIN',@BudgetID='TEST1'
---- 

CREATE PROCEDURE [dbo].[HRMP2062]
( 
  @DivisionID NVARCHAR(50),
  @UserID NVARCHAR(50),
  @BudgetID NVARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)

SET @sSQL = N' 		
SELECT HRMT2060.APK, HRMT2060.DivisionID, BudgetID, IsAll,  
AT1102.DepartmentID, AT1102.DepartmentName, IsBugetYear, 
CASE WHEN IsBugetYear = 1 THEN N''Năm '' + CONVERT(NVARCHAR(5), TranYear) ELSE N''Quý '' + CONVERT(NVARCHAR(5), TranQuarter) + N''/Năm '' + CONVERT(NVARCHAR(5), TranYear) END AS TranQuarterYear,
TranQuarter, TranYear, BudgetAmount, HRMT2060.Description, HRMT2060.AssignedToUserID, (SELECT TOP 1 FullName FROM AT1103 WHERE EmployeeID = HRMT2060.AssignedToUserID) AS AssignedToUserName,
HRMT2060.CreateUserID, HRMT2060.CreateDate, HRMT2060.LastModifyUserID, HRMT2060.LastModifyDate
FROM HRMT2060 WITH (NOLOCK)
LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = HRMT2060.DepartmentID
WHERE HRMT2060.DivisionID = ''' + @DivisionID + '''
AND HRMT2060.APK = ''' + @BudgetID + ''''

--PRINT(@sSQL)
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
