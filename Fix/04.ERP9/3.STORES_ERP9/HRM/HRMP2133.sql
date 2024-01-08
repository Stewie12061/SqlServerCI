IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2133]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2133]
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
----Created by Trọng Kiên on 28/08/2020: Fix lỗi load phòng ban
----Updated by Tiến Sỹ on 18/07/2023: Fix lỗi hiển thị EmployeeName
----Updated by Võ Dương on 11/09/2023: Cập nhật hiển thị phòng ban, chức vụ
---- <Example>
---- EXEC HRMP2133 @DivisionID='AS',@UserID='ASOFTADMIN',@TrainingCostID='TC0001',@PageNumber=1,@PageSize=25
---- exec HRMP2133 @DivisionID=N'BBA-SI',@UserID=N'ADMIN',@TrainingCostID=N'GNCP2',@PageSize=25,@PageNumber=1

CREATE PROCEDURE [dbo].[HRMP2133]
( 
	@DivisionID NVARCHAR(50),
	@UserID NVARCHAR(50),
	@TrainingCostID NVARCHAR(50),
	@PageNumber INT,
	@PageSize INT	
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)

SET @sSQL = '
SELECT CONVERT(INT, ROW_NUMBER() OVER (ORDER BY Orders)) AS RowNum, COUNT(*) OVER () AS TotalRow, *
FROM
(
	SELECT HRMT2131.APK, HRMT2131.DivisionID, HRMT2131.TransactionID, HRMT2131.TrainingCostID, HRMT2131.EmployeeID, 
	AT1103.Fullname AS EmployeeName,
	AT1103.DepartmentID, AT1102.DepartmentName, HT1102.DutyID, HT1102.DutyName, HRMT2131.CostAmount, HRMT2131.Notes, 
	HRMT2131.Orders, HRMT2131.InheritID, HRMT2131.InheritTransactionID
	FROM HRMT2131 WITH (NOLOCK)
	LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = HRMT2131.EmployeeID
	LEFT JOIN HT1102 WITH (NOLOCK) ON HT1102.DivisionID = AT1103.DivisionID AND HT1102.DutyID = AT1103.DutyID 
	LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = AT1103.DepartmentID
	WHERE HRMT2131.DivisionID = ''' + @DivisionID + '''
	AND HRMT2131.TrainingCostID = ''' + @TrainingCostID + '''
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
