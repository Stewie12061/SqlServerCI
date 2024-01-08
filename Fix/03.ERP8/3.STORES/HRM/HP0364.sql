IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[HP0364]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP0364]
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
---- Modified on 11/01/2019 by Bảo Anh: Bổ sung Loại quyết định Điều chỉnh lương, lấy các cột Mức lương cũ và mới
---- Modified on 09/08/2023 by Kiều Nga: [2023/08/IS/0019] Bổ sung lấy thêm cột Ana02Name, Ana03Name, Ana04Name, Ana05Name
---- Modified on 01/11/2023 by Hoàng Lâm: [2023/11/IS/0002] Bổ sung lấy thêm các cột DepartmentOld, Department, IdentifyCardNo, IdentifyDate, IdentifyPlace
-- <Example>
---- exec HP0364 'MK', '%' , '%' , '%' 
CREATE PROCEDURE HP0364	
(
	@DivisionID Nvarchar(50),
	@DecideNo Nvarchar(50),
	@EmployeeID Nvarchar(50),
	@DecideType Nvarchar(50)
)
AS
SET NOCOUNT ON

SELECT	T1.DivisionID,T1.DecideNo, T1.DecideDate, T1.DecidePerson, 
		T3.FullName As DecidePersonName, T1.EffectiveDate, T1.Proposer,T5.FullName As ProposerName,
		T1.EmployeeID, T2.FullName,
		T1.DutyID, T4.DutyName AS DutyName,	T1.Level,
		CASE T1.DecideType WHEN 'BN' THEN N'Bổ nhiệm' WHEN 'MN' THEN N'Miễn nhiệm'
			WHEN 'DC' THEN N'Điều chỉnh cấp bậc' ELSE N'Điều chỉnh lương' END AS DecideType, 
		T1.NewDutyID, T2.DutyName AS NewDutyName, 
		T7.DepartmentName AS DepartmentNameOld, T5.DepartmentName, T5.IdentifyCardNo,T5.IdentifyDate,T5.IdentifyPlace,
		T1.NewLevel, T1.Notes, T1.Salary, T1.NewSalary,
		T2.Ana02ID, T2.Ana03ID,T2.Ana04ID, T2.Ana05ID,A01.AnaName as Ana02Name, A02.AnaName as Ana03Name,
		A03.AnaName as Ana04Name, A04.AnaName as Ana05Name
FROM HT0362 T1 WITH(NOLOCK)
LEFT JOIN HV1400 T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
LEFT JOIN HV1400 T3 ON T1.DivisionID = T3.DivisionID AND T1.DecidePerson = T3.EmployeeID
LEFT JOIN HT1102 T4 WITH(NOLOCK) ON T1.DivisionID = T4.DivisionID AND T1.DutyID = T4.DutyID
LEFT JOIN HV1400 T5 ON T1.DivisionID = T5.DivisionID AND T1.Proposer = T5.EmployeeID
LEFT JOIN HT1302 T6 ON T6.DivisionID = T1.DivisionID AND T2.EmployeeID = T6.EmployeeID
LEFT JOIN AT1102 T7 ON T7.DivisionID = T1.DivisionID AND T7.DepartmentID = T6.DepartmentIDOld
LEFT JOIN AT1011 A01 WITH (NOLOCK) ON A01.DivisionID = T2.DivisionID And A01.AnaID = T2.Ana02ID and A01.AnaTypeID = 'A02'
LEFT JOIN AT1011 A02 WITH (NOLOCK) ON A01.DivisionID = T2.DivisionID And A02.AnaID = T2.Ana03ID and A02.AnaTypeID = 'A03'
LEFT JOIN AT1011 A03 WITH (NOLOCK) ON A01.DivisionID = T2.DivisionID And A03.AnaID = T2.Ana04ID and A03.AnaTypeID = 'A04'
LEFT JOIN AT1011 A04 WITH (NOLOCK) ON A01.DivisionID = T2.DivisionID And A04.AnaID = T2.Ana05ID and A04.AnaTypeID = 'A05' 
WHERE T1.DecideNo LIKE @DecideNo 
AND T1.EmployeeID LIKE @EmployeeID 
AND T1.DecideType LIKE @DecideType 
AND T1.DivisionID = @DivisionID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

