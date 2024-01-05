IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2063]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2063]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load đổ nguồn màn hình xem thông tin ngân sách đào tạo
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
---- Exec HRMP2063 @DivisionID='AS',@UserID='ASOFTADMIN',@BudgetID='TEST1'
---- 

CREATE PROCEDURE [dbo].[HRMP2063]
( 
  @DivisionID NVARCHAR(50),
  @UserID NVARCHAR(50),
  @BudgetID NVARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)

SET @sSQL = N' 		
SELECT HRMT2060.APK, HRMT2060.DivisionID, BudgetID, IsAll, 
CASE WHEN ISNULL(IsAll, 0) = 1 THEN N''Có'' ELSE N''Không'' END AS IsAllName, 
AT1102.DepartmentID, AT1102.DepartmentName, IsBugetYear, AssignedToUserID,
CASE WHEN ISNULL(IsBugetYear, 0) = 1 THEN N''Theo năm'' ELSE N''Theo quý'' END AS IsBugetYearName, 
CASE WHEN IsBugetYear = 1 THEN N''Năm '' + CONVERT(NVARCHAR(5), TranYear) ELSE N''Quý '' + CONVERT(NVARCHAR(5), TranQuarter) + ''/'' + CONVERT(NVARCHAR(5), TranYear) END AS TranQuarterYear,
TranQuarter, TranYear, BudgetAmount, BudgetAmount AS RemainBudgetAmount, HRMT2060.Description,
HRMT2060.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2060.CreateUserID) CreateUserID, HRMT2060.CreateDate, 
HRMT2060.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT2060.LastModifyUserID) LastModifyUserID, HRMT2060.LastModifyDate
FROM HRMT2060 WITH (NOLOCK)
LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = HRMT2060.DepartmentID
WHERE BudgetID = ''' + @BudgetID + ''''

--PRINT(@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
