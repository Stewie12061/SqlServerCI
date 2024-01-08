IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HV1400]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[HV1400]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---- Summary: View dữ liệu hồ sơ nhân viên
---- Edited by Bao Anh Date: 19/12/2012 Bo sung truong MajorID
---- Edited by Bao Anh Date: 31/07/2013 Bo sung cac he so C14 -> C25
---- Edited by Bao Anh Date: 26/08/2013 Bo sung HFromDate, HToDate
---- Modified by Thanh Sơn on 04/11/2013: Bổ sung thêm 2 trường HT03.IsJobWage,HT03.IsPiecework
---- Modified on 13/12/2013 by Le Thi Thu Hien : Bo sung them StatusID
---- Modified on 19/12/2013 by Thanh Sơn : Bo sung them SalaryLevel, SalaryLevelDate
---- Modified on 23/12/2013 by Bảo Anh : Bổ sung IdentifyCityID
---- Modified on 03/01/2013 by Bảo Anh : Bổ sung MidEmployeeID
---- Modified on 17/06/2014 by Bảo Anh : Bổ sung HospitalName
---- Modified on 30/09/2014 by Bảo Anh : Bổ sung LeaveToDate, StatusNotes
---- Modified on 12/11/2015 by Thanh Thịnh : Bổ sung 
---- Modified on 14/12/2015 by Phương Thảo : Bổ sung IsManager
---- Modified on 29/12/2015 by Phương Thảo : Bổ sung IsAutoCreateUser, 10 truong AnaID
---- Modified on 02/12/2016 by Bảo Thy : Bổ sung HT03.FromApprenticeTime, HT03.ToApprenticeTime
---- Modified on 26/12/2016 by Tiểu Mai: Bổ sung trường RatePerTax
---- Modified on 22/05/2017 by Phương Thảo: Sửa danh mục dùng chung
---- Modified on 19/04/2018 by Khả Vi: Bổ sung WITH (NOLOCK), Bổ sung trường chức danh (TitleID, TitleName)
---- Modified on 17/01/2019 by Bảo Anh: Bổ sung trình độ chuyên môn SpecialID, SpecialName, BankName
---- Modified on 03/04/2019 by Kim Thư: Bổ sung các hệ số từ C26 -> C150
---- Modified on 22/10/2020 by Văn Tài: Format SQL, không thay đổi về code.
---- Modified on 28/12/2020 by Hoài Phong: Bổ sung lấy thêm các trường liên quan
---- Modified by Hồng Thắm on 18/12/2023: Customize lọc hồ sơ nhân sự (Customize Gree)

CREATE  View [dbo].[HV1400] As 
Select 
	-- Cá nhân
	HT00.DivisionID
	, HT00.EmployeeID
	, HT00.Orders
	, HT00.S1
	, HT00.S2
	, HT00.S3
	, LTRIM(RTRIM(ISNULL(HT00.LastName, ''))) + ' ' + LTRIM(RTRIM(ISNULL(HT00.MiddleName, ''))) + ' ' + LTRIM(RTRIM(ISNULL(HT00.FirstName,''))) As FullName
	, HT00.LastName
	, HT00.MiddleName
	, HT00.FirstName
	, HT00.ShortName
	, HT00.Alias
	, HT00.Birthday
	, HT00.BornPlace
	, HT03.IsJobWage
	, HT03.IsPiecework
	, HT00.IsMale
	, (CASE WHEN HT00.IsMale = 1 THEN N'Nam' ELSE N'Nữ' END) AS IsMaleName
	, HT00.NativeCountry
	, HT00.PassportNo
	, HT00.PassportDate
	, HT00.PassportEnd
	, HT00.IdentifyCardNo
	, HT00.IdentifyDate
	, HT00.IdentifyPlace
	, HT00.IdentifyEnd
	, HT00.DrivingLicenceNo
	, HT00.DrivingLicenceDate
	, HT00.DrivingLicenceEnd
	, HT00.DrivingLicencePlace
	, HT00.IsSingle
	, (CASE WHEN HT00.IsSingle = 1 THEN N'Độc thân' ELSE N'Đã lập gia đình' END) AS IsSingleName
	, HT00.EmployeeStatus AS StatusID
	, (CASE HT00.EmployeeStatus
		WHEN 0 THEN N'Tuyển dụng'
		WHEN 1 THEN N'Đang làm'
		WHEN 2 THEN N'Thử việc'
		WHEN 3 THEN N'Tạm nghỉ'
		ELSE N'Nghỉ việc' END) AS STATUS
	, HT00.ImageID
	, HT00.CountryID
	, AT01.CountryName
	, LTRIM(RTRIM(ISNULL(HT00.PermanentAddress, ''))) + ' ' + LTRIM(RTRIM(ISNULL(HT00.DistrictID, ''))) + ' ' +
		(CASE WHEN ISNULL(HT00.CityID, '') <> '' THEN LTRIM(RTRIM(ISNULL(AT02.CityName, '')))  ELSE  ''  END  ) AS FullAddress
	--, LTRIM(RTRIM(ISNULL(HT00.CityID,''))) As FullAddress
	, HT00.CityID
	, AT02.CityName
	, HT00.DistrictID
	, HT00.PermanentAddress
	, HT00.TemporaryAddress
	, HT00.EthnicID
	, HT1001.EthnicName
	, HT00.ReligionID
	, HT1002.ReligionName
	, HT00.Notes
	, HT00.HealthStatus
	, HT00.HomePhone
	, HT00.HomeFax
	, HT00.MobiPhone
	, HT00.Email
	, HT00.CreateDate
	, HT00.CreateUserID
	, HT00.LastModifyDate
	, HT00.LastModifyUserID
	, HT03.IsOtherDayPerMonth
	, HT00.IsMale AS IsMaleID
	, HT00.IsSingle AS IsSingleID
	, HT00.IsForeigner
	, HT00.RecruitTimeID
	, HT00.IdentifyCityID

	-- Gia đình
	, HT01.FatherName
	, HT01.FatherYear
	, HT01.FatherJob
	, HT01.FatherAddress
	, HT01.FatherNote
	, HT01.IsFatherDeath
	, HT01.MotherName
	, HT01.MotherYear
	, HT01.MotherJob
	, HT01.MotherAddress
	, HT01.MotherNote
	, HT01.IsMotherDeath
	, HT01.SpouseName
	, HT01.SpouseYear
	, HT01.SpouseAddress
	, HT01.SpouseNote
	, HT01.SpouseJob
	, HT01.IsSpouseDeath
	, HT01.EducationLevelID
	, HT05.EducationLevelName
	, HT01.PoliticsID
	, HT01.SpecialID
	, HT0536.SpecialName
	, HT01.Language1ID
	, HT01.Language2ID
	, HT01.Language3ID
	, HT01.LanguageLevel1ID
	, HT01.LanguageLevel2ID
	, HT01.LanguageLevel3ID
	, --HT07.LanguageLevelName as LanguageLevelName1,
	 (SELECT TOP 1 MajorID FROM HT1301 WHERE HT1301.DivisionID = HT00.DivisionID AND HT1301.EmployeeID = HT00.EmployeeID) AS MajorID
	 
	-- Thông tin xã hội
	, HT02.BankID
	, AT1016.BankName
	, HT02.BankAccountNo
	, HT02.PersonalTaxID
	, HT02.SoInsuranceNo
	, HT02.SoInsurBeginDate
	, HT02.HeInsuranceNo
	, HT02.ArmyJoinDate
	, HT02.ArmyEndDate
	, HT02.ArmyLevel
	, HT02.Hobby
	, HT02.HospitalID
	, HT1009.HospitalName
	, HT02.Height
	, HT02.Weight
	, HT02.BloodGroup
	-- T05.AssociationID,
	, HT02.HFromDate
	, HT02.HToDate
	
	-- Thông tin về hệ số chỉ tiêu
	, HT03.SalaryCoefficient
	, HT03.DutyCoefficient
	, HT03.TimeCoefficient
	, HT00.DepartmentID
	, Case (select CustomerName from customerindex) when 162 then (select AnaName from AT1011 where AnaID = HT00.DepartmentID) 
													else A03.DepartmentName end  AS DepartmentName
	,T02.AnaID
	,T02.AnaName
	, ISNULL(HT00.TeamID, '') AS TEAMID
	, Case (select CustomerName from customerindex) when 162 then (select AnaName from AT1011 where AnaID = HT00.TeamID) 
													else T01.TeamName end  AS TeamName
	, ISNULL(HT03.SectionID, '') AS SECTIONID
	, Case (select CustomerName from customerindex) when 162 then (select AnaName from AT1011 where AnaID = HT03.SectionID) 
													else '' end  AS SectionName
	, HT03.DutyID
	, DutyName
	, HT03.TitleID
	, HT1106.TitleName
	, HT03.TaxObjectID
	, HT00.EmployeeStatus
	, HT03.Experience
	, HT03.SuggestSalary
	, HT03.RecruitDate
	, HT03.RecruitPlace
	, HT03.WorkDate
	, HT03.LeaveDate
	, HT07.QuitJobID
	, HT07.QuitJobName
	, HT03.C01
	, HT03.C02
	, HT03.C03
	, HT03.C04
	, HT03.C05
	, HT03.C06
	, HT03.C07
	, HT03.C08
	, HT03.C09
	, HT03.C10
	, HT03.C11
	, HT03.C12
	, HT03.C13
	, HT03.C14
	, HT03.C15
	, HT03.C16
	, HT03.C17
	, HT03.C18
	, HT03.C19
	, HT03.C20
	, HT03.C21
	, HT03.C22
	, HT03.C23
	, HT03.C24
	, HT03.C25
	, HT03.BaseSalary
	, HT03.InsuranceSalary
	, HT03.SalaryLevel
	, HT03.SalaryLevelDate
	, HT03.CompanyDate
	, HT03.Salary01
	, HT03.Salary02
	, HT03.Salary03
	, HT03.Target01ID
	, HT03.Target02ID
	, HT03.Target03ID
	, HT03.Target04ID
	, HT03.Target05ID
	, HT03.Target06ID
	, HT03.Target07ID
	, HT03.Target08ID
	, HT03.Target09ID
	, HT03.Target10ID
	, HT03.TargetAmount01
	, HT03.TargetAmount02
	, HT03.TargetAmount03
	, HT03.TargetAmount04
	, HT03.TargetAmount05
	, HT03.TargetAmount06
	, HT03.TargetAmount07
	, HT03.TargetAmount08
	, HT03.TargetAmount09
	, HT03.TargetAmount10
	, HT03.LoaCondID
	, HT06.LoaCondName
	, HT03.ApplyDate
	, HT03.BeginProbationDate
	, HT03.EndProbationDate
	, HT03.ProbationNote
	, HT03.FileID
	, HT03.ExpenseAccountID
	, HT03.PayableAccountID
	, HT03.PerInTaxID
	, HT03.MidEmployeeID
	, HT03.LeaveToDate
	, HT03.Notes as StatusNotes
	, HT03.IsManager
	, HT00.IsAutoCreateUser
	, HT00.Ana01ID
	, HT00.Ana02ID
	, HT00.Ana03ID
	, HT00.Ana04ID
	, HT00.Ana05ID
	, HT00.Ana06ID
	, HT00.Ana07ID
	, HT00.Ana08ID
	, HT00.Ana09ID
	, HT00.Ana10ID
	, HT00.RatePerTax
	, HT03.FromApprenticeTime
	, HT03.ToApprenticeTime
	, HT1403_1.C26
	, HT1403_1.C27
	, HT1403_1.C28
	, HT1403_1.C29
	, HT1403_1.C30
	, HT1403_1.C31
	, HT1403_1.C32
	, HT1403_1.C33
	, HT1403_1.C34
	, HT1403_1.C35
	, HT1403_1.C36
	, HT1403_1.C37
	, HT1403_1.C38
	, HT1403_1.C39
	, HT1403_1.C40
	, HT1403_1.C41
	, HT1403_1.C42
	, HT1403_1.C43
	, HT1403_1.C44
	, HT1403_1.C45
	, HT1403_1.C46
	, HT1403_1.C47
	, HT1403_1.C48
	, HT1403_1.C49
	, HT1403_1.C50
	, HT1403_1.C51
	, HT1403_1.C52
	, HT1403_1.C53
	, HT1403_1.C54
	, HT1403_1.C55
	, HT1403_1.C56
	, HT1403_1.C57
	, HT1403_1.C58
	, HT1403_1.C59
	, HT1403_1.C60
	, HT1403_1.C61
	, HT1403_1.C62
	, HT1403_1.C63
	, HT1403_1.C64
	, HT1403_1.C65
	, HT1403_1.C66
	, HT1403_1.C67
	, HT1403_1.C68
	, HT1403_1.C69
	, HT1403_1.C70
	, HT1403_1.C71
	, HT1403_1.C72
	, HT1403_1.C73
	, HT1403_1.C74
	, HT1403_1.C75
	, HT1403_1.C76
	, HT1403_1.C77
	, HT1403_1.C78
	, HT1403_1.C79
	, HT1403_1.C80
	, HT1403_1.C81
	, HT1403_1.C82
	, HT1403_1.C83
	, HT1403_1.C84
	, HT1403_1.C85
	, HT1403_1.C86
	, HT1403_1.C87
	, HT1403_1.C88
	, HT1403_1.C89
	, HT1403_1.C90
	, HT1403_1.C91
	, HT1403_1.C92
	, HT1403_1.C93
	, HT1403_1.C94
	, HT1403_1.C95
	, HT1403_1.C96
	, HT1403_1.C97
	, HT1403_1.C98
	, HT1403_1.C99
	, HT1403_1.C100
	, HT1403_1.C101
	, HT1403_1.C102
	, HT1403_1.C103
	, HT1403_1.C104
	, HT1403_1.C105
	, HT1403_1.C106
	, HT1403_1.C107
	, HT1403_1.C108
	, HT1403_1.C109
	, HT1403_1.C110
	, HT1403_1.C111
	, HT1403_1.C112
	, HT1403_1.C113
	, HT1403_1.C114
	, HT1403_1.C115
	, HT1403_1.C116
	, HT1403_1.C117
	, HT1403_1.C118
	, HT1403_1.C119
	, HT1403_1.C120
	, HT1403_1.C121
	, HT1403_1.C122
	, HT1403_1.C123
	, HT1403_1.C124
	, HT1403_1.C125
	, HT1403_1.C126
	, HT1403_1.C127
	, HT1403_1.C128
	, HT1403_1.C129
	, HT1403_1.C130
	, HT1403_1.C131
	, HT1403_1.C132
	, HT1403_1.C133
	, HT1403_1.C134
	, HT1403_1.C135
	, HT1403_1.C136
	, HT1403_1.C137
	, HT1403_1.C138
	, HT1403_1.C139
	, HT1403_1.C140
	, HT1403_1.C141
	, HT1403_1.C142
	, HT1403_1.C143
	, HT1403_1.C144
	, HT1403_1.C145
	, HT1403_1.C146
	, HT1403_1.C147
	, HT1403_1.C148
	, HT1403_1.C149
	, HT1403_1.C150
From HT1400 AS HT00 WITH (NOLOCK)
LEFT JOIN HT1401 AS HT01 WITH (NOLOCK) ON HT00.DivisionID = HT01.DivisionID AND HT00.EmployeeID = HT01.EmployeeID
LEFT JOIN HT1402 AS HT02 WITH (NOLOCK) ON HT00.DivisionID = HT02.DivisionID AND HT00.EmployeeID = HT02.EmployeeID
LEFT JOIN HT1403 AS HT03 WITH (NOLOCK) ON HT00.DivisionID = HT03.DivisionID AND HT00.EmployeeID = HT03.EmployeeID
--	LEFT JOIN HT1405 As T05 On HT00.EmployeeID = T05.EmployeeID and HT00.DivisionID = T05.DivisionID 
LEFT JOIN HT1101 T01 WITH (NOLOCK) ON HT00.DivisionID = T01.DivisionID AND HT00.TeamID = T01.TeamID AND HT00.DepartmentID = T01.DepartmentID 
LEFT JOIN AT1011 T02 WITH (NOLOCK) ON HT00.DivisionID = T02.DivisionID AND HT00.Ana04ID=T02.AnaID
LEFT JOIN HT1107 HT07 WITH (NOLOCK) ON HT03.DivisionID = HT07.DivisionID AND HT03.QuitJobID = HT07.QuitJobID
LEFT JOIN HT1001 WITH (NOLOCK) ON HT00.DivisionID = HT1001.DivisionID AND HT00.EthnicID = HT1001.EthnicID
LEFT JOIN HT1002 WITH (NOLOCK) ON HT00.DivisionID = HT1002.DivisionID AND HT00.ReligionID = HT1002.ReligionID
LEFT JOIN HT1102 WITH (NOLOCK) ON HT03.DivisionID = HT1102.DivisionID AND HT03.DutyID = HT1102.DutyID
LEFT JOIN HT1005 HT05  WITH (NOLOCK) ON HT05.DivisionID = HT01.DivisionID AND HT05.EducationLevelID = HT01.EducationLevelID
--		LEFT JOIN HT1007 HT07 on HT07.LanguageLevelID = HT01.LanguageLevel1ID
LEFT JOIN AT1001 AT01  WITH (NOLOCK) ON HT00.CountryID = AT01.CountryID
LEFT JOIN AT1002 AT02  WITH (NOLOCK) ON ISNULL(HT00.CityID,'') = ISNULL(AT02.CityID,'')
LEFT JOIN AT1102 A03  WITH (NOLOCK) ON A03.DepartmentID = HT00.DepartmentID
LEFT JOIN HT2806 HT06  WITH (NOLOCK) ON  HT03.DivisionID = HT06.DivisionID AND HT03.LoaCondID = HT06.LoaCondID
LEFT JOIN HT1009 WITH (NOLOCK) ON HT02.DivisionID = HT1009.DivisionID AND HT02.HospitalID = HT1009.HospitalID
LEFT JOIN HT1106 WITH (NOLOCK) ON HT00.DivisionID = HT1106.DivisionID AND HT03.TitleID = HT1106.TitleID
LEFT JOIN HT0536 WITH (NOLOCK) ON HT01.DivisionID = HT0536.DivisionID AND HT01.SpecialID = HT0536.SpecialID
LEFT JOIN AT1016 WITH (NOLOCK) ON HT02.BankID = AT1016.BankID
LEFT JOIN HT1403_1 WITH (NOLOCK) ON HT00.DivisionID = HT1403_1.DivisionID AND HT00.EmployeeID = HT1403_1.EmployeeID


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON

