IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[HP0365]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP0365]
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
---- Modified on 11/01/2019 by Bảo Anh: Bổ sung DecideType
---- Modified on 10/09/2020 by Nhựt Trường: tách store cho customer Meiko.
---- Modified on 12/07/2023 by Kiều Nga: Bổ sung param @Mode.
---- Modified on 09/11/2023 by Thanh Sang: Bổ sung điều kiện hợp HT1102,HV1400 và thêm các trường DecideType,DutyName,Level, Salary,NewDutyName, NewLevel,NewSalary,EffectiveDate,Notes
-- <Example>
---- exec HP0365 'MK', '%' , '%' , '%'

CREATE PROCEDURE HP0365	
(
	@DivisionID Nvarchar(50),
	@DecideNo Nvarchar(50),
	@EmployeeID Nvarchar(50),
	@DecideType Nvarchar(50),
	@Mode TINYINT = 0 -- 0: Truy vấn, 1: Xuất Excel
)
AS
SET NOCOUNT ON

DECLARE @CustomerName INT
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

IF @CustomerName = 50 ---- Customize Meiko
BEGIN
	EXEC HP0365_MK @DivisionID, @DecideNo, @EmployeeID, @DecideType, @Mode
END
ELSE
BEGIN	
	SELECT	Distinct T1.DivisionID,T1.DecideNo, T1.DecideDate, T1.DecidePerson, T1.Proposer,
		T3.FullName As DecidePersonName, T2.FullName As ProposerName, T1.DecideType,T1.EmployeeID, T6.FullName,
		T5.DutyName As DutyName, T1.Level As Level, T1.Salary,T4.DutyName As NewDutyName, T1.NewLevel,T1.NewSalary,T1.EffectiveDate, T1.Notes
	FROM HT0362 T1 WITH(NOLOCK)
	LEFT JOIN HV1400 T2 ON T1.DivisionID = T2.DivisionID AND T1.Proposer = T2.EmployeeID
	LEFT JOIN HV1400 T3 ON T1.DivisionID = T3.DivisionID AND T1.DecidePerson = T3.EmployeeID
	Left join HT1102 T4 on T1.DivisionID = T4.DivisionID AND T1.NewDutyID = T4.DutyID
	Left join HV1400 T5 on T1.DivisionID = T5.DivisionID AND T1.DutyID = T5.DutyID
	LEFT JOIN HV1400 T6 ON T1.DivisionID = T6.DivisionID AND T1.EmployeeID = T6.EmployeeID
	WHERE T1.DecideNo LIKE @DecideNo 
	AND T1.EmployeeID LIKE @EmployeeID 
	AND T1.DecideType LIKE @DecideType 
	AND T1.DivisionID = @DivisionID

END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

