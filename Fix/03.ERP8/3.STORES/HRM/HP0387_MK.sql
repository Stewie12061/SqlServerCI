IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0387_MK]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0387_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
----  Truy vấn Quyết định thuyên chuyển bộ phận
-- <Param>
----  
-- <Return>
---- 
-- <Reference> HRM/ Nghiệp vụ / Quản lý nhân sự
---- Quyết định thuyên chuyển bộ phận
-- <History>
---- Create on 01/06/2016 by Bảo Thy
---- Modified on 12/07/2023 by Kiều Nga : Fix lỗi order by
-- <Example>
---- exec HP0387_MK 'MK', '%', '%' , '2016-10-01' , '2016-12-07',0
CREATE PROCEDURE HP0387_MK	
(
	@DivisionID Nvarchar(50),
	@DecideNo Nvarchar(50),
	@EmployeeID Nvarchar(50),
	@FromDate DATETIME,
	@ToDate DATETIME,
	@Mode TINYINT -- 0: Truy vấn, 1: Xuất Excel
)
AS
SET NOCOUNT ON
IF @Mode = 0
BEGIN 
	SELECT ROW_NUMBER() OVER (ORDER BY A.DecideNo) AS RowNum, A.* FROM
	(
		SELECT DISTINCT T1.DecideNo, T1.DivisionID,T1.HistoryID, T1.DecideDate,
		ISNULL(T5.LastName,'') +' '+ ISNULL(T5.MiddleName,'') +' '+ ISNULL(T5.FirstName,'') AS ProposerName, 
		ISNULL(T3.LastName,'') +' '+ ISNULL(T3.MiddleName,'') +' '+ ISNULL(T3.FirstName,'') As DecidePersonName
		FROM HT1302_MK T1 WITH(NOLOCK)
		LEFT JOIN HT1400 T3 ON T1.DivisionID = T3.DivisionID AND T1.DecidePerson = T3.EmployeeID
		LEFT JOIN HT1400 T5 ON T1.DivisionID = T5.DivisionID AND T1.Proposer = T5.EmployeeID
		WHERE T1.DivisionID = @DivisionID
		AND T1.DecideNo Like @DecideNo 
		AND T1.EmployeeID LIKE @EmployeeID 
		AND CONVERT(DATE,T1.DecideDate) BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)
	) AS A
	ORDER BY A.DecideNo
END
ELSE --@Mode = 1
BEGIN
	SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY T1.DecideNo,T1.EmployeeID) AS RowNum, T1.DivisionID,T1.HistoryID, T1.DecideNo, T1.DecideDate,
	ISNULL(T5.LastName,'') +' '+ ISNULL(T5.MiddleName,'') +' '+ ISNULL(T5.FirstName,'') AS ProposerName, 
	ISNULL(T3.LastName,'') +' '+ ISNULL(T3.MiddleName,'') +' '+ ISNULL(T3.FirstName,'') As DecidePersonName, 
	T1.EmployeeID, T4.LastName +' '+ T4.MiddleName +' '+ T4.FirstName AS EmployeeName, T6.DepartmentName, T7.TeamName, T8.AnaName AS SubSectionName, 
	T9.AnaName AS ProcessName, T1.FromDate, T1.ToDate, T10.DepartmentName as DepartmentNameOld, T11.TeamName AS TeamNameOld, T12.AnaName AS SubSectionNameOld, 
	T13.AnaName AS ProcessNameOld, T1.Notes, T1.DutyID, T14.DutyName, T1.DutyIDOld, T15.DutyName AS DutyNameOld
	FROM HT1302_MK T1 WITH(NOLOCK)
	LEFT JOIN HT1400 T3 ON T1.DivisionID = T3.DivisionID AND T1.DecidePerson = T3.EmployeeID
	LEFT JOIN HT1400 T4 ON T1.DivisionID = T4.DivisionID AND T1.EmployeeID = T4.EmployeeID
	LEFT JOIN HT1400 T5 ON T1.DivisionID = T5.DivisionID AND T1.Proposer = T5.EmployeeID
	LEFT JOIN AT1102 T6 ON T1.DivisionID = T6.DivisionID AND T1.DepartmentID = T6.DepartmentID
	LEFT JOIN HT1101 T7 ON T1.DivisionID = T7.DivisionID AND T1.DepartmentID = T7.DepartmentID AND T1.TeamID = T7.TeamID
	LEFT JOIN AT1011 T8 WITH (NOLOCK) ON T1.DivisionID = T8.DivisionID AND T1.SectionID = T8.AnaID AND T8.AnaTypeID = 'A04'
	LEFT JOIN AT1011 T9 WITH (NOLOCK) ON T1.DivisionID = T9.DivisionID AND T1.ProcessID = T9.AnaID AND T9.AnaTypeID = 'A05'
	LEFT JOIN AT1102 T10 ON T1.DivisionID = T10.DivisionID AND T1.DepartmentIDOld = T10.DepartmentID
	LEFT JOIN HT1101 T11 ON T1.DivisionID = T11.DivisionID AND T1.DepartmentIDOld = T11.DepartmentID AND T1.TeamIDOld = T11.TeamID
	LEFT JOIN AT1011 T12 WITH (NOLOCK) ON T1.DivisionID = T12.DivisionID AND T1.SectionIDOld = T12.AnaID AND T12.AnaTypeID = 'A04'
	LEFT JOIN AT1011 T13 WITH (NOLOCK) ON T1.DivisionID = T13.DivisionID AND T1.ProcessIDOld = T13.AnaID AND T13.AnaTypeID = 'A05'
	LEFT JOIN HT1102 T14 ON T1.DivisionID = T14.DivisionID AND T1.DutyID = T14.DutyID
	LEFT JOIN HT1102 T15 ON T1.DivisionID = T15.DivisionID AND T1.DutyIDOld = T15.DutyID
	WHERE T1.DivisionID = @DivisionID
	AND T1.DecideNo Like @DecideNo 
	AND T1.EmployeeID LIKE @EmployeeID 
	AND CONVERT(DATE,T1.DecideDate) BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)
	ORDER BY T1.DecideNo, T1.EmployeeID
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
