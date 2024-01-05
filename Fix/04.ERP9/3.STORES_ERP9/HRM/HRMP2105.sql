IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2105]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2105]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Đổ nguồn lưới kế thừa đề xuất đào tạo DETAIL (Nghiệp vụ lập lịch đào tạo)
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Hải Long on 19/09/2017
----Modified by Trọng Kiên on 28/08/2020: Bỏ điều kiện Division IS NULL
---- <Example>
---- EXEC [HRMP2105] @DivisionID='AS',@UserID='ASOFTADMIN',@TrainingProposeID='TP0001',@TrainingFieldID='CNTT',@DepartmentID='%',@PageNumber = 1, @PageSize = 25
---- 

CREATE PROCEDURE [dbo].[HRMP2105]
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),
	@TrainingProposeID AS NVARCHAR(MAX),
	@TrainingFieldID AS NVARCHAR(50),
	@DepartmentID AS NVARCHAR(50),
	@PageNumber INT,
	@PageSize INT
) 
AS 
DECLARE @sSQL NVARCHAR(MAX),
		@TotalRow NVARCHAR(50) = ''

IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL' 	


SET @sSQL = N'
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY HRMT2091.TransactionID)) AS RowNum, '+@TotalRow+N' AS TotalRow,
HRMT2091.DivisionID, HRMT2091.TransactionID AS InhertTransactionID, HRMT2091.TrainingProposeID AS InheritID, HRMT2091.TrainingProposeID, 
HRMT2091.EmployeeID, HT1400.LastName + '' '' + HT1400.MiddleName + '' '' + HT1400.FirstName AS EmployeeName,
HRMT2091.ProposeAmount, HRMT2091.DepartmentID, AT1102.DepartmentName, HT1403.DutyID, HT1102.DutyName, HRMT2091.FromDate, HRMT2091.ToDate, HRMT2091.Notes
FROM HRMT2091 WITH (NOLOCK)
LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = HRMT2091.DepartmentID
LEFT JOIN HT1400 WITH (NOLOCK) ON HT1400.DivisionID = HRMT2091.DivisionID AND HT1400.EmployeeID = HRMT2091.EmployeeID
LEFT JOIN HT1403 WITH (NOLOCK) ON HT1403.DivisionID = HT1400.DivisionID AND HT1403.EmployeeID = HT1400.EmployeeID  
LEFT JOIN HT1102 WITH (NOLOCK) ON HT1102.DivisionID = HT1403.DivisionID AND HT1102.DutyID = HT1403.DutyID
LEFT JOIN HRMT2101 WITH (NOLOCK) ON HRMT2101.DivisionID = HRMT2091.DivisionID AND HRMT2101.InheritID = HRMT2091.TrainingProposeID AND HRMT2101.InheritTransactionID = HRMT2091.TransactionID
WHERE HRMT2091.DivisionID = ''' + @DivisionID + '''
AND HRMT2091.DepartmentID LIKE ''' + @DepartmentID + '''
AND HRMT2091.TrainingFieldID = ''' + @TrainingFieldID + '''
AND HRMT2091.TrainingProposeID IN (''' + @TrainingProposeID + ''')
ORDER BY HRMT2091.TransactionID
OFFSET ' + CONVERT(NVARCHAR(10), (@PageNumber - 1) * @PageSize) + ' ROWS
FETCH NEXT ' + CONVERT(NVARCHAR(10), @PageSize) + ' ROWS ONLY'


PRINT @sSQL
EXEC (@sSQL)	





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
