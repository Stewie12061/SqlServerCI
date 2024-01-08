IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2103]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2103]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load đổ nguồn màn hình xem thông tin lịch đào tạo
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Hải Long on 18/09/2017
----Modified by Anh Đô on 19/07/2023: Fix lỗi không hiển thị tên nhân viên
---- <Example>
---- EXEC HRMP2103 @DivisionID='AS',@UserID='ASOFTADMIN',@TrainingScheduleID='TS0001',@PageNumber = 1, @PageSize = 25
---- 

CREATE PROCEDURE [dbo].[HRMP2103]
( 
	@DivisionID NVARCHAR(50),
	@UserID NVARCHAR(50),
	@TrainingScheduleID NVARCHAR(50),
	@PageNumber INT,
	@PageSize INT
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)


SET @sSQL = '
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY Orders)) AS RowNum, COUNT(*) OVER () AS TotalRow, *
FROM
(
	SELECT HRMT2101.TransactionID, HRMT2101.TrainingScheduleID, HRMT2101.EmployeeID, AT1405.UserName AS EmployeeName,
	HRMT2101.DepartmentID, AT1102.DepartmentName, HT1102.DutyName, HRMT2101.ScheduleAmount AS ScheduleAmount_DT, HRMT2101.Notes, HRMT2101.Orders, HRMT2101.InheritID, HRMT2101.InheritTransactionID,
	HRMT2091.FromDate AS FromDate_DT, HRMT2091.ToDate AS ToDate_DT, HRMT2091.ProposeAmount AS ProposeAmount_DT
	FROM HRMT2101 WITH (NOLOCK)
	INNER JOIN HRMT2100 WITH (NOLOCK) ON HRMT2101.DivisionID = HRMT2100.DivisionID AND HRMT2101.TrainingScheduleID = Convert(Varchar(50),HRMT2100.APK)
	LEFT JOIN HRMT2091 WITH (NOLOCK) ON HRMT2091.DivisionID = HRMT2101.DivisionID AND HRMT2091.TrainingProposeID = HRMT2101.InheritID AND HRMT2091.TransactionID = HRMT2101.InheritTransactionID
	LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = HRMT2101.DepartmentID
	LEFT JOIN AT1405 WITH (NOLOCK) ON AT1405.UserID = HRMT2101.EmployeeID AND AT1405.DivisionID IN (HRMT2101.DivisionID, ''@@@'')
	LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = HRMT2101.EmployeeID AND AT1103.DivisionID IN (HRMT2101.DivisionID, ''@@@'')
	LEFT JOIN HT1102 WITH (NOLOCK) ON HT1102.DutyID = AT1103.DutyID AND HT1102.DivisionID IN (HRMT2101.DivisionID, ''@@@'')
	WHERE HRMT2100.DivisionID = ''' + @DivisionID + '''
	AND Convert(Varchar(50),HRMT2100.APK) = ''' + @TrainingScheduleID + '''
) A
ORDER BY Orders
OFFSET ' + CONVERT(NVARCHAR(10), (@PageNumber - 1) * @PageSize) + ' ROWS
FETCH NEXT ' + CONVERT(NVARCHAR(10), @PageSize) + ' ROWS ONLY'


PRINT(@sSQL)
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
