IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2123]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2123]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load đổ nguồn màn hình xem thông tin kết quả đào tạo
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Hải Long on 18/09/2017
----Modified by Thu Hà  on 29/09/2023: Fix lỗi không hiển thị tên nhân viên và tên chức vụ
---- <Example>
---- EXEC HRMP2123 @DivisionID='AS',@UserID='ASOFTADMIN',@TrainingResultID='TR0001',@PageNumber=1,@PageSize=25
---- 

CREATE PROCEDURE [dbo].[HRMP2123]
( 
	@DivisionID NVARCHAR(50),
	@UserID NVARCHAR(50),
	@TrainingResultID NVARCHAR(50),
	@PageNumber INT,
	@PageSize INT		
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)


SET @sSQL = '
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY Orders)) AS RowNum, COUNT(*) OVER () AS TotalRow, *
FROM
(
	SELECT HRMT2121.APK, HRMT2121.DivisionID, HRMT2121.TransactionID, HRMT2121.TrainingResultID,
	HRMT2121.EmployeeID, 
	--HT1400.LastName + '' '' + HT1400.MiddleName + '' '' + HT1400.FirstName AS EmployeeName,
	 AT1405.UserName AS EmployeeName,
	HRMT2121.DepartmentID, AT1102.DepartmentName,
	--HT1403.DutyID,
	HT1102.DutyName, HRMT2121.StatusTypeID, HRMV2121.StatusTypeName, 
	HRMT2121.ResultID, HRMV2122.ResultName, HRMT2121.Notes, HRMT2121.Orders, HRMT2121.InheritID, HRMT2121.InheritTransactionID
	FROM HRMT2121 WITH (NOLOCK)
	LEFT JOIN HRMV2121 ON HRMV2121.StatusTypeID = HRMT2121.StatusTypeID
	LEFT JOIN HRMV2122 ON HRMV2122.ResultID = HRMT2121.ResultID
	LEFT JOIN HT1400 WITH (NOLOCK) ON HT1400.EmployeeID = HRMT2121.EmployeeID
	--LEFT JOIN HT1403 WITH (NOLOCK) ON HT1403.DivisionID = HT1400.DivisionID AND HT1403.EmployeeID = HT1400.EmployeeID
	LEFT JOIN AT1405 WITH (NOLOCK) ON AT1405.UserID = HRMT2121.EmployeeID AND AT1405.DivisionID IN (HRMT2121.DivisionID, ''@@@'')
	--LEFT JOIN HT1102 WITH (NOLOCK) ON HT1102.DivisionID = HT1403.DivisionID AND HT1102.DutyID = HT1403.DutyID 
	LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = HRMT2121.EmployeeID AND AT1103.DivisionID IN (HRMT2121.DivisionID, ''@@@'')
	LEFT JOIN HT1102 WITH (NOLOCK) ON HT1102.DutyID = AT1103.DutyID AND HT1102.DivisionID IN (HRMT2121.DivisionID, ''@@@'')
	LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = HRMT2121.DepartmentID 
	WHERE HRMT2121.DivisionID = ''' + @DivisionID + '''
	AND HRMT2121.TrainingResultID = ''' + @TrainingResultID + '''
) A 	
ORDER BY Orders
OFFSET ' + CONVERT(NVARCHAR(10), (@PageNumber - 1) * @PageSize) + ' ROWS
FETCH NEXT ' + CONVERT(NVARCHAR(10), @PageSize) + ' ROWS ONLY'	

--PRINT @sSQL			
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
