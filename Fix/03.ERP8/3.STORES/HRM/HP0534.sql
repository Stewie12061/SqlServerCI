IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[HP0534]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP0534]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load edit form Cập nhật kết quả thử việc HF0534
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
---- exec HP0534 'AIC', '000'

CREATE PROCEDURE HP0534	
(
	@DivisionID varchar(50),
	@ResultNo varchar(50)
)
AS
SET NOCOUNT ON

SELECT	T1.*,
		Ltrim(RTrim(isnull(HT00.LastName,'')))+ ' ' + LTrim(RTrim(isnull(HT00.MiddleName,''))) + ' ' + LTrim(RTrim(Isnull(HT00.FirstName,''))) As EmployeeName,
		T3.FullName AS ReviewPersonName, T3.DutyName AS ReviewPersonDuty, T5.FullName AS DecidePersonName, T5.DutyName AS DecidePersonDuty,
		T1.ContractNo, T1.TestFromDate, T1.TestToDate
FROM HT0534 T1 WITH(NOLOCK)
LEFT JOIN HT1400 HT00 WITH (NOLOCK) ON T1.DivisionID = HT00.DivisionID AND T1.EmployeeID = HT00.EmployeeID
LEFT JOIN HV1400 T3 ON T1.DivisionID = T3.DivisionID AND T1.ReviewPerson = T3.EmployeeID
LEFT JOIN HV1400 T5 ON T1.DivisionID = T5.DivisionID AND T1.DecidePerson = T5.EmployeeID
WHERE T1.DivisionID = @DivisionID AND T1.ResultNo = @ResultNo



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

