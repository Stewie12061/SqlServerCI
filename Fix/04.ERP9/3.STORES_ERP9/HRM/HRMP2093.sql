IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2093]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2093]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load đổ nguồn màn hình xem thông tin đề xuất đào tạo
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Hải Long on 18/09/2017
----Modified by Trọng Kiên on 06/08/2020: Fix lỗi trùng dữ liệu trả về
---- <Example>
---- EXEC HRMP2093 @DivisionID='AS',@UserID='ASOFTADMIN',@TrainingProposeID='TP0001',@PageNumber=1,@PageSize=25
---- 

CREATE PROCEDURE [dbo].[HRMP2093]
( 
	@DivisionID NVARCHAR(50),
	@UserID NVARCHAR(50),
	@TrainingProposeID NVARCHAR(50),
	@PageNumber INT,
	@PageSize INT  
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)

SET @sSQL = ' 
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY Orders)) AS RowNum, COUNT(*) OVER () AS TotalRow, *
FROM
(
	SELECT HRMT2091.DivisionID, HRMT2091.TransactionID, HRMT2091.TrainingProposeID, HRMT2091.EmployeeID, HV1400.FullName AS EmployeeName, HV1400.DutyName, HRMT2091.DepartmentID, HV1400.DepartmentName,
	HRMT2091.TrainingFieldID, HRMT1040.TrainingFieldName, HRMT2091.ProposeAmount_DT AS ProposeAmount, HRMT2091.FromDate, HRMT2091.ToDate, HRMT2091.Notes, HRMT2091.InheritID, HRMT2091.InheritTableID, HRMT2091.ID,
	HRMT2091.TranQuarter, HRMT2091.TranYear, HRMT2091.Orders
	FROM HRMT2091 WITH (NOLOCK)
	LEFT JOIN HV1400 ON HV1400.DivisionID = HRMT2091.DivisionID AND HV1400.EmployeeID = HRMT2091.EmployeeID
	LEFT JOIN HRMT1040 WITH (NOLOCK) ON HRMT1040.TrainingFieldID = HRMT2091.TrainingFieldID
	WHERE HRMT2091.DivisionID = '''+@DivisionID+''' 
	AND HRMT2091.TrainingProposeID = '''+@TrainingProposeID+'''
	GROUP BY HRMT2091.DivisionID, HRMT2091.TransactionID, HRMT2091.TrainingProposeID, HRMT2091.EmployeeID, HV1400.FullName, HV1400.DutyName, HRMT2091.DepartmentID, HV1400.DepartmentName,
			 HRMT2091.TrainingFieldID, HRMT1040.TrainingFieldName, HRMT2091.ProposeAmount_DT, HRMT2091.FromDate, HRMT2091.ToDate, HRMT2091.Notes, HRMT2091.InheritID, HRMT2091.InheritTableID, HRMT2091.ID,
			 HRMT2091.TranQuarter, HRMT2091.TranYear, HRMT2091.Orders
) A 	
ORDER BY Orders
OFFSET ' + CONVERT(NVARCHAR(10), (@PageNumber - 1) * @PageSize) + ' ROWS
FETCH NEXT ' + CONVERT(NVARCHAR(10), @PageSize) + ' ROWS ONLY'			

--PRINT(@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
