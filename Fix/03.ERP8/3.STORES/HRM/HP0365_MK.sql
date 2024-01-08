IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0365_MK]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0365_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
----  Báo cáo Bổ nhiệm/Miễn nhiệm/ Điều chỉnh cấp bậc
-- <Param>
----  
-- <Return>
---- 
-- <Reference> HRM/ Nghiệp vụ
---- Bổ nhiệm/Miễn nhiệm/ Điều chỉnh cấp bậc
-- <History>
---- Create on 05/01/2015 by Phương Thảo 
---- Modified on 
---- Modified on 01/06/2016 by Bảo Thy: bổ sung EffectiveDate, bỏ where theo employeeid
---- Modified on 09/12/2016 by Bảo Thy: bổ sung thông tin theo yêu cầu MEIKO
-- <Example>
---- exec HP0365_MK 'MK', '%' , '%' , '%',0
CREATE PROCEDURE HP0365_MK	
(
	@DivisionID Nvarchar(50),
	@DecideNo Nvarchar(50),
	@EmployeeID Nvarchar(50),
	@DecideType Nvarchar(50),
	@Mode TINYINT = 0 -- 0: Truy vấn, 1: Xuất Excel
)
AS
SET NOCOUNT ON
IF @Mode = 0
BEGIN 
	SELECT ROW_NUMBER() OVER (ORDER BY A.DecideNo) AS RowNum, A.*
	FROM
	(	SELECT DISTINCT T1.DecideNo, T1.DecideDate, T1.DecidePerson, T1.Proposer, T3.FullName As DecidePersonName, T2.FullName As ProposerName
		FROM HT0362 T1 WITH(NOLOCK)
		LEFT JOIN HV1400 T2 ON T1.DivisionID = T2.DivisionID AND T1.Proposer = T2.EmployeeID
		LEFT JOIN HV1400 T3 ON T1.DivisionID = T3.DivisionID AND T1.DecidePerson = T3.EmployeeID
		WHERE T1.DecideNo LIKE @DecideNo 
		AND T1.EmployeeID LIKE @EmployeeID 
		AND T1.DecideType LIKE @DecideType 
		AND T1.DivisionID = @DivisionID
	)A
	ORDER BY RowNum
END
ELSE
BEGIN
	SELECT	DISTINCT ROW_NUMBER() OVER (ORDER BY T1.EmployeeID) AS RowNum, T1.DivisionID, T1.EmployeeID, T4.FullName AS EmployeeName,
	T4.DepartmentName, T4.TeamName, T5.AnaName As SubSectionName, T6.AnaName AS ProcessName, T1.[Level], T1.DutyID, T7.DutyName, T1.[NewLevel], T1.[NewDutyID], T8.DutyName As NewDutyName,
	T1.Notes, T1.EffectiveDate, T1.DecideNo, T1.DecideDate, T1.DecidePerson, T1.Proposer, T3.FullName As DecidePersonName, T2.FullName As ProposerName
	FROM HT0362 T1 WITH(NOLOCK)
	LEFT JOIN HV1400 T2 ON T1.DivisionID = T2.DivisionID AND T1.Proposer = T2.EmployeeID
	LEFT JOIN HV1400 T3 ON T1.DivisionID = T3.DivisionID AND T1.DecidePerson = T3.EmployeeID
	LEFT JOIN HV1400 T4 ON T1.DivisionID = T4.DivisionID AND T1.EmployeeID = T4.EmployeeID
	LEFT JOIN AT1011 T5 WITH (NOLOCK) ON T4.DivisionID = T5.DivisionID AND T4.Ana04ID = T5.AnaID AND T5.AnaTypeID = 'A04'
	LEFT JOIN AT1011 T6 WITH (NOLOCK) ON T4.DivisionID = T6.DivisionID AND T4.Ana05ID = T6.AnaID AND T6.AnaTypeID = 'A05'
	LEFT JOIN HT1102 T7 ON T1.DivisionID = T7.DivisionID AND T1.DutyID = T7.DutyID
	LEFT JOIN HT1102 T8 ON T1.DivisionID = T8.DivisionID AND T1.[NewDutyID] = T8.DutyID
	WHERE T1.DecideNo LIKE @DecideNo 
	AND T1.EmployeeID LIKE @EmployeeID 
	AND T1.DecideType LIKE @DecideType 
	AND T1.DivisionID = @DivisionID
	ORDER By RowNum
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
