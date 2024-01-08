IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[HP0386]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP0386]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
----  Báo cáo Quyết định thuyên chuyển bộ phận
-- <Param>
----  
-- <Return>
---- 
-- <Reference> HRM/ Nghiệp vụ / Quản lý nhân sự
---- Quyết định thuyên chuyển bộ phận
-- <History>
---- Create on 01/06/2016 by Bảo Thy
---- Modified on 
---- Modified by Tiểu Mai on 18/05/2017: Bổ sung chỉnh sửa danh mục dùng chung
-- <Example>
---- exec HP0386 'MK', '%', '%' , '2016-06-01' , '2016-06-03'
CREATE PROCEDURE HP0386	
(
	@DivisionID Nvarchar(50),
	@DecideNo Nvarchar(50),
	@EmployeeID Nvarchar(50),
	@FromDate DATETIME,
	@ToDate DATETIME
)
AS
SET NOCOUNT ON

SELECT	T1.DivisionID,T1.HistoryID, T1.DecideNo, T1.DecideDate,T5.FullName AS ProposerName,
		T3.FullName As DecidePersonName, T1.EmployeeID, T2.FullName,
		T4.DutyName AS DutyName,A11.AnaName AS DepartmentName,A12.AnaName AS TeamName,A13.AnaName AS SubsectionName,
		A14.AnaName AS ProcessName,T1.FromDate, T1.ToDate,
		A15.AnaName AS DepartmentOldName,A16.AnaName AS TeamOldName,A17.AnaName AS SubsectionOldName,A18.AnaName AS ProcessOldName
		,T6.DutyName AS DutyOldName, T1.Notes
FROM HT1302_MK T1 WITH(NOLOCK)
LEFT JOIN HV1400 T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
LEFT JOIN HV1400 T3 ON T1.DivisionID = T3.DivisionID AND T1.DecidePerson = T3.EmployeeID
LEFT JOIN HT1102 T4 WITH(NOLOCK) ON T1.DivisionID = T4.DivisionID AND T1.DutyID = T4.DutyID
LEFT JOIN HV1400 T5 ON T1.DivisionID = T5.DivisionID AND T1.Proposer = T5.EmployeeID
LEFT JOIN HT1102 T6 WITH(NOLOCK) ON T1.DivisionID = T6.DivisionID AND T1.DutyIDOld = T6.DutyID
LEFT JOIN AT1011 A11 WITH(NOLOCK) ON A11.AnaID=T1.DepartmentID AND A11.AnaTypeID='A02'
LEFT JOIN AT1011 A12 WITH(NOLOCK) ON A12.AnaID=T1.TeamID AND A12.AnaTypeID='A03'
LEFT JOIN AT1011 A13 WITH(NOLOCK) ON A13.AnaID=T1.SectionID AND A13.AnaTypeID='A04'
LEFT JOIN AT1011 A14 WITH(NOLOCK) ON A14.AnaID=T1.ProcessID AND A14.AnaTypeID='A05'
LEFT JOIN AT1011 A15 WITH(NOLOCK) ON A15.AnaID=T1.DepartmentIDOld AND A15.AnaTypeID='A02'
LEFT JOIN AT1011 A16 WITH(NOLOCK) ON A16.AnaID=T1.TeamIDOld AND A16.AnaTypeID='A03'
LEFT JOIN AT1011 A17 WITH(NOLOCK) ON A17.AnaID=T1.SectionIDOld AND A17.AnaTypeID='A04'
LEFT JOIN AT1011 A18 WITH(NOLOCK) ON A18.AnaID=T1.ProcessIDOld AND A18.AnaTypeID='A05'
WHERE T1.DivisionID = @DivisionID
AND T1.DecideNo Like @DecideNo 
AND T1.EmployeeID LIKE @EmployeeID 
AND CONVERT(DATE,T1.DecideDate) BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO