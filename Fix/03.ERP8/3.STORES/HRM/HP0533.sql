IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[HP0533]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP0533]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load lưới/In form Truy vấn kết quả thử việc HF0533
-- <Param>
----  
-- <Return>
---- 
-- <Reference> HRM/ Nghiệp vụ
---- Kết quả thử việc
-- <History>
---- Create on 11/01/2019 by Bảo Anh 
---- Modified on
-- <Example>
---- exec HP0533 'APT', '%','%','%','000'

CREATE PROCEDURE HP0533	
(
	@DivisionID varchar(50),
	@DepartmentID varchar(50),
	@TeamID varchar(50),
	@EmployeeID varchar(50),
	@ResultNo varchar(50) = ''
)
AS
SET NOCOUNT ON

IF ISNULL(@ResultNo,'') = ''	--- load lưới
	SELECT	H34.ResultNo, H34.ResultDate, H14.EmployeeID, H14.FullName AS EmployeeName, H14.DepartmentName, H14.DutyName,
			H34.TestFromDate, H34.TestToDate, CONVERT(VARCHAR(10),H34.TestFromDate,101) + ' - ' + CONVERT(VARCHAR(10),H34.TestToDate,101) AS TestFromToDate,
			H34.ResultID, CASE WHEN H34.ResultID = 1 THEN N'Đạt' ELSE N'Không đạt' END AS ResultName,
			H34.IsStopBeforeEndDate, H34.EndDate, H34.Notes
	FROM HT0534 H34 WITH (NOLOCK)
	LEFT JOIN HV1400 H14 ON H34.DivisionID = H14.DivisionID AND H34.EmployeeID = H14.EmployeeID
	WHERE H34.DivisionID = @DivisionID AND H14.DepartmentID LIKE @DepartmentID
	AND ISNULL(H14.TEAMID,'%') LIKE @TeamID AND H34.EmployeeID LIKE @EmployeeID
	
ELSE	--- In báo cáo
	SELECT	H34.ResultNo, H34.ResultDate,
			H14.FullName AS EmployeeName, H14.DepartmentName, H14.DutyName, H14.IsMale,
			H34.ContractNo, H34.TestFromDate, H34.TestToDate, DATEDIFF(d,H34.TestFromDate, H34.TestToDate) AS TestDays,
			H34.EndDate, H34.Notes
	FROM HT0534 H34 WITH (NOLOCK)
	LEFT JOIN HV1400 H14 ON H34.DivisionID = H14.DivisionID AND H34.EmployeeID = H14.EmployeeID
	WHERE H34.DivisionID = @DivisionID AND H34.ResultNo = @ResultNo

GO
SET NOCOUNT OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
select * from AT0001
