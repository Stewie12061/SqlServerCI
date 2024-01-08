IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2124]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2124]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Đổ nguồn lưới chi tiết màn hình cập nhật ghi nhận kết quả
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Hải Long on 26/09/2017
----Updated by Tiến Sỹ on 18/07/2023 : sửa lỗi không hiển thị tên nhân viên
----Updated by Thu Hà  on 28/09/2023 : sửa lỗi không hiển thị tên chức vụ
---- <Example>
---- EXEC [HRMP2124] @DivisionID='AS',@UserID='ASOFTADMIN',@TrainingScheduleID='TS00003', @PageNumber = 1, @PageSize = 25
---- 

CREATE PROCEDURE [dbo].[HRMP2124]
( 
  @DivisionID AS NVARCHAR(50),
  @UserID AS NVARCHAR(50),
  @TrainingScheduleID AS NVARCHAR(50),
  @PageNumber INT,
  @PageSize INT
) 
AS 
DECLARE @sSQL NVARCHAR(MAX),
		@IsAll TINYINT,
		@sSQL1 NVARCHAR(MAX), 
		@TotalRow NVARCHAR(50)=N''
		
		
SET @TotalRow = 'COUNT(*) OVER ()'
SET @sSQL1 = N'OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
		
SELECT @IsAll = IsAll 
FROM HRMT2100 WITH (NOLOCK)
WHERE DivisionID = @DivisionID
AND APK = @TrainingScheduleID	

IF @IsAll = 0 -- Trường hợp lịch đào tạo cho từng phòng ban
BEGIN
	SET @sSQL = N'
	SELECT ROW_NUMBER() OVER (ORDER BY HRMT2101.Orders) AS RowNum, '+@TotalRow+N' AS TotalRow, 
	HRMT2101.TransactionID AS InheritTransactionID, HRMT2101.TrainingScheduleID AS InheritID, HRMT2101.TrainingScheduleID, HRMT2101.EmployeeID, 
	AT1103.FullName AS EmployeeName, HRMT2101.DepartmentID, AT1102.DepartmentName, 
	HT1403.DutyID, HT1102.DutyName, ''1'' AS StatusTypeID, N''Tham gia'' AS StatusTypeName, ''1'' AS ResultID, N''Đạt'' AS ResultName
	FROM HRMT2101 WITH (NOLOCK)
	LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.EmployeeID = HRMT2101.EmployeeID
	LEFT JOIN HT1403 WITH (NOLOCK) ON HT1403.DivisionID = AT1103.DivisionID AND HT1403.EmployeeID = AT1103.EmployeeID
	----LEFT JOIN HT1102 WITH (NOLOCK) ON HT1102.DivisionID = HT1403.DivisionID AND HT1102.DutyID = HT1403.DutyID 
	LEFT JOIN HT1102 WITH (NOLOCK) ON  HT1102.DutyID = AT1103.DutyID  AND HT1102.DivisionID IN (HRMT2101.DivisionID, ''@@@'')
	----HT1102.DivisionID = HT1403.DivisionID AND HT1102.DutyID = HT1403.DutyID 
	LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DepartmentID = HRMT2101.DepartmentID
	WHERE HRMT2101.DivisionID = ''' + @DivisionID + '''	
	AND HRMT2101.TrainingScheduleID = ''' + @TrainingScheduleID + '''
	ORDER BY HRMT2101.Orders'	
END
ELSE -- Trường hợp lịch đào tạo cho toàn công ty (Lấy những nhân viên đang làm hoặc thử việc)
BEGIN
	SET @sSQL = N'	
	SELECT ROW_NUMBER() OVER (ORDER BY HV1400.DepartmentID) AS RowNum, '+@TotalRow+N' AS TotalRow, 
	NULL AS InheritTransactionID, TrainingScheduleID AS InheritID, TrainingScheduleID, HV1400.EmployeeID, HV1400.FullName AS EmployeeName, 
	HV1400.DepartmentID, HV1400.DepartmentName, HV1400.DutyID, HV1400.DutyName, ''1'' AS StatusTypeID, N''Tham gia'' AS StatusTypeName, 
	''1'' AS ResultID,  N''Đạt'' AS ResultName
	FROM HV1400
	INNER JOIN HRMT2100 WITH (NOLOCK) ON HV1400.DivisionID = HRMT2100.DivisionID 
	WHERE HRMT2100.DivisionID = ''' + @DivisionID + '''	
	AND HRMT2100.TrainingScheduleID = ''' + @TrainingScheduleID + '''
	AND HV1400.StatusID IN (1,2)
	ORDER BY HV1400.DepartmentID' 
END 


--PRINT @sSQL
EXEC (@sSQL + ' ' + @sSQL1)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
