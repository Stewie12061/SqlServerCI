IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[HP1500]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP1500]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load Grid HF0081 khi goi tu HF0359
-- <Param>
---- 
-- <Return>
---- 
-- <Reference> HRM/Danh muc/
---- Lich su nhan vien/Xem
-- <History>
----Created by: Phuong Thao, Date: 21/01/2016
---- Modified by Phương Thảo on 18/05/2017: Sửa danh mục dùng chung
-- <Example>
---- 
/*-- <Example>
exec HP1359 @DivisionID=N'CTY',@EmployeeIDFrom=N'006001',@EmployeeIDTo=N'006001',@DateFrom='2016-02-17 00:00:00',@DateTo='2016-02-17 00:00:00'
exec HP1500 @DivisionID=N'MK',@EmployeeID=N'000041',@ModifyDate='2016-05-04 00:00:00'
----*/

CREATE PROCEDURE HP1500
( 
	 @DivisionID NVARCHAR(50),
	 @EmployeeID NVARCHAR(50), 
	 @ModifyDate Datetime
)
AS 
DECLARE @sSQL VARCHAR (8000), 
		@sSQL11 VARCHAR (8000), @sSQL12 VARCHAR (8000), @sSQL13 VARCHAR (8000), 
		@sSQL21 VARCHAR (8000), @sSQL22 VARCHAR (8000), @sSQL23 VARCHAR (8000), 
		@sSQL31 VARCHAR (8000), @sSQL32 VARCHAR (8000), @sSQL33 VARCHAR (8000), 
		@sSQL41 VARCHAR (8000), @sSQL42 VARCHAR (8000), @sSQL43 VARCHAR (8000), 
		@sSQL5 NVARCHAR (4000), @sSQL6 NVARCHAR (4000)

SET @sSQL = '
SELECT	HT00.DivisionID, HT00.EmployeeID, HT00.TeamID, HT00.DepartmentID,
		HT00.Orders,HT00.S1,HT00.S2,HT00.S3,	HT00.LastName, HT00.MiddleName, HT00.FirstName,
		HT00.ShortName, HT00.Alias, HT00.Birthday, HT00.BornPlace, HT00.IsMale, HT00.NativeCountry, HT00.PassportNo, HT00.PassportDate, 
		HT00.PassportEnd, HT00.IdentifyCardNo, HT00.IdentifyDate, HT00.IdentifyPlace, HT00.IdentifyEnd, 
		HT00.DrivingLicenceNo, HT00.DrivingLicenceDate, HT00.DrivingLicenceEnd, HT00.DrivingLicencePlace,			
		HT00.CityID, HT00.DistrictID, HT00.PermanentAddress, HT00.TemporaryAddress, HT00.EthnicID, HT00.ReligionID, HT00.Notes, HT00.HealthStatus, HT00.HomePhone, 
		HT00.HomeFax, HT00.MobiPhone, HT00.Email, HT00.CreateDate, HT00.CreateUserID, HT00.LastModifyDate, HT00.LastModifyUserID, 
		HT00.IsSingle, HT00.IsForeigner,HT00.RecruitTimeID, HT00.IdentifyCityID, HT00.EmployeeStatus, HT00.ImageID, HT00.CountryID,		 		
		HT00.IsAutoCreateUser, HT00.Ana01ID, HT00.Ana02ID, HT00.Ana03ID, HT00.Ana04ID,HT00.Ana05ID, HT00.Ana06ID, HT00.Ana07ID, HT00.Ana08ID, HT00.Ana09ID,HT00.Ana10ID
INTO #HP1500_HT1400
FROM HT1400_CT HT00
WHERE 1 = 0

SELECT	HT01.EmployeeID, HT01.DivisionID,
		HT01.FatherName, HT01.FatherYear, HT01.FatherJob, HT01.FatherAddress, HT01.FatherNote,
		HT01.IsFatherDeath, 
		HT01.MotherName, HT01.MotherYear, HT01.MotherJob,HT01.MotherAddress, HT01.MotherNote,
		HT01.IsMotherDeath,
		HT01.SpouseName, HT01.SpouseYear, HT01.SpouseAddress, HT01.SpouseNote,
		HT01.SpouseJob, HT01.IsSpouseDeath, 
		HT01.EducationLevelID, HT01.PoliticsID, HT01.Language1ID, HT01.Language2ID, HT01.Language3ID, HT01.LanguageLevel1ID,
		HT01.LanguageLevel2ID, HT01.LanguageLevel3ID,
		CreateDate, CreateUserID, LastModifyDate, LastModifyUserID
INTO #HP1500_HT1401
FROM HT1401_CT HT01
WHERE 1 = 0

SELECT	HT02.EmployeeID, HT02.DivisionID,
		HT02.BankID, HT02.BankAccountNo, HT02.PersonalTaxID,HT02.SoInsuranceNo, HT02.SoInsurBeginDate,
		HT02.HeInsuranceNo, HT02.ArmyJoinDate, HT02.ArmyEndDate, HT02.ArmyLevel,
		HT02.Hobby, HT02.HospitalID,  HT02.Height, HT02.Weight, HT02.BloodGroup,
		HT02.HFromDate, HT02.HToDate, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID
INTO #HP1500_HT1402
FROM HT1402_CT HT02
WHERE 1 = 0

SELECT	HT03.EmployeeID, HT03.DivisionID, HT03.IsJobWage,HT03.IsPiecework, HT03.IsOtherDayPerMonth, HT03.QuitJobID,
		HT03.SalaryCoefficient, HT03.DutyCoefficient, HT03.TimeCoefficient, HT03.DutyID, HT03.TaxObjectID, HT03.Experience,
		HT03.SuggestSalary, HT03.RecruitDate, HT03.RecruitPlace, HT03.WorkDate,HT03.LeaveDate, 
		HT03.C01, HT03.C02, HT03.C03, HT03.C04, HT03.C05, HT03.C06, HT03.C07, HT03.C08, HT03.C09, HT03.C10, HT03.C11, HT03.C12, HT03.C13,
		HT03.C14, HT03.C15, HT03.C16, HT03.C17, HT03.C18, HT03.C19, HT03.C20, HT03.C21, HT03.C22, HT03.C23, HT03.C24, HT03.C25,
		HT03.BaseSalary, HT03.InsuranceSalary, HT03.SalaryLevel, HT03.SalaryLevelDate, HT03.CompanyDate,
		HT03.Salary01, HT03.Salary02, HT03.Salary03, HT03.Target01ID, HT03.Target02ID,
		HT03.Target03ID, HT03.Target04ID, HT03.Target05ID, HT03.Target06ID, HT03.Target07ID,
		HT03.Target08ID, HT03.Target09ID, HT03.Target10ID, HT03.TargetAmount01, 
		HT03.TargetAmount02, HT03.TargetAmount03, HT03.TargetAmount04, HT03.TargetAmount05,
		HT03.TargetAmount06, HT03.TargetAmount07, HT03.TargetAmount08, HT03.TargetAmount09, HT03.TargetAmount10, HT03.LoaCondID,
		HT03.ApplyDate, HT03.BeginProbationDate, HT03.EndProbationDate, HT03.ProbationNote, 
		HT03. FileID, HT03.ExpenseAccountID,HT03.PayableAccountID, HT03.PerInTaxID,
		HT03.MidEmployeeID, HT03.LeaveToDate, HT03.Notes, HT03.IsManager,
		CreateDate, CreateUserID, LastModifyDate, LastModifyUserID 
INTO #HP1500_HT1403
FROM HT1403_CT HT03
WHERE 1 = 0
'

SET @sSQL11 = '
IF EXISTS (	SELECT TOP 1 1 FROM HT1400_CT 
			WHERE	DivisionID = '''+@DivisionID+''' 
					AND EmployeeID = '''+@EmployeeID+''' AND Convert(Datetime,left(convert(varchar(50),Convert(Datetime2(0),LastModifyDate),20),22)) = Convert(Datetime,'''+Convert(Varchar(50),@ModifyDate,22)+'''))
begin 
--select 11111111
	INSERT INTO #HP1500_HT1400 	
	SELECT t2.DivisionID, t2.EmployeeID, t2.TeamID, t2.DepartmentID, t2.Orders, t2.S1, t2.S2, t2.S3, t2.LastName, t2.MiddleName, t2.FirstName,
		t2.ShortName, t2.Alias, t2.Birthday, t2.BornPlace, t2.IsMale, t2.NativeCountry, t2.PassportNo, t2.PassportDate, 
		t2.PassportEnd, t2.IdentifyCardNo, t2.IdentifyDate, t2.IdentifyPlace, t2.IdentifyEnd, 
		t2.DrivingLicenceNo, t2.DrivingLicenceDate, t2.DrivingLicenceEnd, t2.DrivingLicencePlace,			
		t2.CityID, t2.DistrictID, t2.PermanentAddress, t2.TemporaryAddress, t2.EthnicID, t2.ReligionID, t2.Notes, t2.HealthStatus, t2.HomePhone, 
		t2.HomeFax, t2.MobiPhone, t2.Email, t2.CreateDate, t2.CreateUserID, t2.LastModifyDate, t2.LastModifyUserID, 
		t2.IsSingle, t2.IsForeigner, t2.RecruitTimeID, t2.IdentifyCityID, t2.EmployeeStatus, t2.ImageID, t2.CountryID,		 		
		t2.IsAutoCreateUser, t2.Ana01ID, t2.Ana02ID, t2.Ana03ID, t2.Ana04ID, t2.Ana05ID, t2.Ana06ID, t2.Ana07ID, t2.Ana08ID, t2.Ana09ID, t2.Ana10ID	
	FROM HT1400_CT t1
	inner join HT1400_CT t2 on  t1.LastmodifyDate = t2.LastmodifyDate and t2.Operation = 3
	WHERE	t1.DivisionID = '''+@DivisionID+''' AND t1.EmployeeID = '''+@EmployeeID+''' AND t1.Operation = 4 AND Convert(Datetime,left(convert(varchar(50),Convert(Datetime2(0),t1.LastModifyDate),20),22)) = Convert(Datetime,'''+Convert(Varchar(50),@ModifyDate,22)+''')

	INSERT INTO #HP1500_HT1400 	
	SELECT t1.DivisionID, t1.EmployeeID, t1.TeamID, t1.DepartmentID, t1.Orders, t1.S1, t1.S2, t1.S3, t1.LastName, t1.MiddleName, t1.FirstName,
		t1.ShortName, t1.Alias, t1.Birthday, t1.BornPlace, t1.IsMale, t1.NativeCountry, t1.PassportNo, t1.PassportDate, 
		t1.PassportEnd, t1.IdentifyCardNo, t1.IdentifyDate, t1.IdentifyPlace, t1.IdentifyEnd, 
		t1.DrivingLicenceNo, t1.DrivingLicenceDate, t1.DrivingLicenceEnd, t1.DrivingLicencePlace,			
		t1.CityID, t1.DistrictID, t1.PermanentAddress, t1.TemporaryAddress, t1.EthnicID, t1.ReligionID, t1.Notes, t1.HealthStatus, t1.HomePhone, 
		t1.HomeFax, t1.MobiPhone, t1.Email, t1.CreateDate, t1.CreateUserID, t1.LastModifyDate, t1.LastModifyUserID, 
		t1.IsSingle, t1.IsForeigner, t1.RecruitTimeID, t1.IdentifyCityID, t1.EmployeeStatus, t1.ImageID, t1.CountryID,		 		
		t1.IsAutoCreateUser, t1.Ana01ID, t1.Ana02ID, t1.Ana03ID, t1.Ana04ID, t1.Ana05ID, t1.Ana06ID, t1.Ana07ID, t1.Ana08ID, t1.Ana09ID, t1.Ana10ID	
	FROM HT1400_CT t1
	WHERE	t1.DivisionID = '''+@DivisionID+''' AND t1.EmployeeID = '''+@EmployeeID+''' AND t1.Operation = 1 AND Convert(Datetime,left(convert(varchar(50),Convert(Datetime2(0),LastModifyDate),20),22)) = Convert(Datetime,'''+Convert(Varchar(50),@ModifyDate,22)+''')
end
else  '
SET @sSQL12 = '
IF EXISTS (	SELECT TOP 1 1 FROM HT1400_CT 
			WHERE	DivisionID = '''+@DivisionID+''' 
					AND EmployeeID = '''+@EmployeeID+''' AND  Convert(Datetime,left(convert(varchar(50),Convert(Datetime2(0),LastModifyDate),20),22)) > Convert(Datetime,'''+COnvert(Varchar(50),@ModifyDate,22)+'''))
begin 
--select 22222
	INSERT INTO #HP1500_HT1400	
	SELECT TOP 1 DivisionID, EmployeeID, TeamID, DepartmentID,
		Orders,S1,S2,S3,	LastName, MiddleName, FirstName,
		ShortName, Alias, Birthday, BornPlace, IsMale, NativeCountry, PassportNo, PassportDate, 
		PassportEnd, IdentifyCardNo, IdentifyDate, IdentifyPlace, IdentifyEnd, 
		DrivingLicenceNo, DrivingLicenceDate, DrivingLicenceEnd, DrivingLicencePlace,			
		CityID, DistrictID, PermanentAddress, TemporaryAddress, EthnicID, ReligionID, Notes, HealthStatus, HomePhone, 
		HomeFax, MobiPhone, Email, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, 
		IsSingle, IsForeigner,RecruitTimeID, IdentifyCityID, EmployeeStatus, ImageID, CountryID,		 		
		IsAutoCreateUser, Ana01ID, Ana02ID, Ana03ID, Ana04ID,Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID,Ana10ID
	FROM HT1400_CT 
	WHERE	DivisionID = '''+@DivisionID+''' AND EmployeeID = '''+@EmployeeID+''' AND  Convert(Datetime,left(convert(varchar(50),Convert(Datetime2(0),LastModifyDate),20),22)) > Convert(Datetime,'''+COnvert(Varchar(50),@ModifyDate,22)+''')
			AND Operation = 3
	ORDER BY LastModifyDate
end
else  '
SET @sSQL13 = '
IF NOT EXISTS (	SELECT TOP 1 1 FROM HT1400_CT 
				WHERE	DivisionID = '''+@DivisionID+''' 
					AND EmployeeID = '''+@EmployeeID+''' AND  Convert(Datetime,left(convert(varchar(50),Convert(Datetime2(0),LastModifyDate),20),22)) >= Convert(Datetime,'''+COnvert(Varchar(50),@ModifyDate,22)+'''))
begin 
--select 333333
	INSERT INTO #HP1500_HT1400
	SELECT	DivisionID, EmployeeID, TeamID, DepartmentID,
		Orders,S1,S2,S3,	LastName, MiddleName, FirstName,
		ShortName, Alias, Birthday, BornPlace, IsMale, NativeCountry, PassportNo, PassportDate, 
		PassportEnd, IdentifyCardNo, IdentifyDate, IdentifyPlace, IdentifyEnd, 
		DrivingLicenceNo, DrivingLicenceDate, DrivingLicenceEnd, DrivingLicencePlace,			
		CityID, DistrictID, PermanentAddress, TemporaryAddress, EthnicID, ReligionID, Notes, HealthStatus, HomePhone, 
		HomeFax, MobiPhone, Email, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, 
		IsSingle, IsForeigner,RecruitTimeID, IdentifyCityID, EmployeeStatus, ImageID, CountryID,		 		
		IsAutoCreateUser, Ana01ID, Ana02ID, Ana03ID, Ana04ID,Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID,Ana10ID	
	FROM HT1400 
	WHERE	DivisionID = '''+@DivisionID+''' AND EmployeeID = '''+@EmployeeID+'''
end
'
SET @sSQL21 = '
IF EXISTS (	SELECT TOP 1 1 FROM HT1401_CT 
			WHERE	DivisionID = '''+@DivisionID+''' 
					AND EmployeeID = '''+@EmployeeID+''' AND Convert(Datetime,left(convert(varchar(50),Convert(Datetime2(0),LastModifyDate),20),22)) = Convert(Datetime,'''+Convert(Varchar(50),@ModifyDate,22)+'''))
begin
	INSERT INTO #HP1500_HT1401 	
	SELECT	t2.EmployeeID, t2.DivisionID, t2.FatherName, t2.FatherYear, t2.FatherJob, t2.FatherAddress, t2.FatherNote,
			t2.IsFatherDeath, 
			t2.MotherName, t2.MotherYear, t2.MotherJob, t2.MotherAddress, t2.MotherNote,
			t2.IsMotherDeath,
			t2.SpouseName, t2.SpouseYear, t2.SpouseAddress, t2.SpouseNote,
			t2.SpouseJob, t2.IsSpouseDeath, 
			t2.EducationLevelID, t2.PoliticsID, t2.Language1ID, t2.Language2ID, t2.Language3ID, t2.LanguageLevel1ID,
			t2.LanguageLevel2ID, t2.LanguageLevel3ID,
			t2.CreateDate, t2.CreateUserID, t2.LastModifyDate, t2.LastModifyUserID 	
	FROM HT1401_CT t1
	inner join HT1401_CT t2 on t1.LastmodifyDate = t2.LastmodifyDate and t2.Operation = 3
	WHERE	t1.DivisionID = '''+@DivisionID+''' 
					AND t1.EmployeeID = '''+@EmployeeID+''' AND t1.Operation = 4 AND Convert(Datetime,left(convert(varchar(50),Convert(Datetime2(0),t1.LastModifyDate),20),22)) = Convert(Datetime,'''+Convert(Varchar(50),@ModifyDate,22)+''')

	INSERT INTO #HP1500_HT1401 	
	SELECT	t1.EmployeeID, t1.DivisionID, t1.FatherName, t1.FatherYear, t1.FatherJob, t1.FatherAddress, t1.FatherNote,
			t1.IsFatherDeath, 
			t1.MotherName, t1.MotherYear, t1.MotherJob, t1.MotherAddress, t1.MotherNote,
			t1.IsMotherDeath,
			t1.SpouseName, t1.SpouseYear, t1.SpouseAddress, t1.SpouseNote,
			t1.SpouseJob, t1.IsSpouseDeath, 
			t1.EducationLevelID, t1.PoliticsID, t1.Language1ID, t1.Language2ID, t1.Language3ID, t1.LanguageLevel1ID,
			t1.LanguageLevel2ID, t1.LanguageLevel3ID,
			t1.CreateDate, t1.CreateUserID, t1.LastModifyDate, t1.LastModifyUserID 	
	FROM HT1401_CT t1 
	WHERE	t1.DivisionID = '''+@DivisionID+''' 
					AND t1.EmployeeID = '''+@EmployeeID+''' AND t1.Operation = 1 AND Convert(Datetime,left(convert(varchar(50),Convert(Datetime2(0),LastModifyDate),20),22)) = Convert(Datetime,'''+Convert(Varchar(50),@ModifyDate,22)+''')
end
else  '

SET @sSQL22 = '
IF EXISTS (	SELECT TOP 1 1 FROM HT1401_CT 
			WHERE	DivisionID = '''+@DivisionID+''' 
					AND EmployeeID = '''+@EmployeeID+''' AND Convert(Datetime,left(convert(varchar(50),Convert(Datetime2(0),LastModifyDate),20),22)) > Convert(Datetime,'''+Convert(Varchar(50),@ModifyDate,22)+'''))
begin
	INSERT INTO #HP1500_HT1401	
	SELECT TOP 1 EmployeeID, DivisionID, FatherName, FatherYear, FatherJob, FatherAddress, FatherNote,
				IsFatherDeath, 
				MotherName, MotherYear, MotherJob,MotherAddress, MotherNote,
				IsMotherDeath,
				SpouseName, SpouseYear, SpouseAddress, SpouseNote,
				SpouseJob, IsSpouseDeath, 
				EducationLevelID, PoliticsID, Language1ID, Language2ID, Language3ID, LanguageLevel1ID,
				LanguageLevel2ID, LanguageLevel3ID,
				CreateDate, CreateUserID, LastModifyDate, LastModifyUserID  
	FROM HT1401_CT 
	WHERE	DivisionID = '''+@DivisionID+''' AND EmployeeID = '''+@EmployeeID+''' 
			AND Convert(Datetime,left(convert(varchar(50),Convert(Datetime2(0),LastModifyDate),20),22)) > Convert(Datetime,'''+Convert(Varchar(50),@ModifyDate,22)+''') AND Operation = 3
	ORDER BY LastModifyDate
end
else

' 

SET @sSQL23 = '
IF NOT EXISTS (	SELECT TOP 1 1 FROM HT1401_CT 
				WHERE	DivisionID = '''+@DivisionID+''' 
					AND EmployeeID = '''+@EmployeeID+''' AND Convert(Datetime,left(convert(varchar(50),Convert(Datetime2(0),LastModifyDate),20),22)) >= Convert(Datetime,'''+Convert(Varchar(50),@ModifyDate,22)+'''))
begin
	INSERT INTO #HP1500_HT1401
	SELECT	EmployeeID, DivisionID, FatherName, FatherYear, FatherJob, FatherAddress, FatherNote,
			IsFatherDeath, 
			MotherName, MotherYear, MotherJob,MotherAddress, MotherNote,
			IsMotherDeath,
			SpouseName, SpouseYear, SpouseAddress, SpouseNote,
			SpouseJob, IsSpouseDeath, 
			EducationLevelID, PoliticsID, Language1ID, Language2ID, Language3ID, LanguageLevel1ID,
			LanguageLevel2ID, LanguageLevel3ID,
			CreateDate, CreateUserID, LastModifyDate, LastModifyUserID 	
	FROM HT1401 
	WHERE	DivisionID = '''+@DivisionID+''' 
					AND EmployeeID = '''+@EmployeeID+'''
end
'

SET @sSQL31= '
IF EXISTS (	SELECT TOP 1 1 FROM HT1402_CT  t1 
			WHERE	t1.DivisionID = '''+@DivisionID+''' 
					AND t1.EmployeeID = '''+@EmployeeID+''' AND Convert(Datetime,left(convert(varchar(50),Convert(Datetime2(0),t1.LastModifyDate),20),22))  = Convert(Datetime,'''+Convert(Varchar(50),@ModifyDate,22)+'''))
begin
	INSERT INTO #HP1500_HT1402	
	SELECT	t2.EmployeeID, t2.DivisionID, t2.BankID, t2.BankAccountNo, t2.PersonalTaxID, t2.SoInsuranceNo, t2.SoInsurBeginDate,
			t2.HeInsuranceNo, t2.ArmyJoinDate, t2.ArmyEndDate, t2.ArmyLevel,
			t2.Hobby, t2.HospitalID,  t2.Height, t2.Weight, t2.BloodGroup,
			t2.HFromDate, t2.HToDate, t2.CreateDate, t2.CreateUserID, t2.LastModifyDate, t2.LastModifyUserID
	FROM HT1402_CT t1
	inner join HT1402_CT t2 on t1.LastmodifyDate = t2.LastmodifyDate and t2.Operation = 3
	WHERE	t1.DivisionID = '''+@DivisionID+''' 
					AND t1.EmployeeID = '''+@EmployeeID+''' AND t1.Operation = 4 AND Convert(Datetime,left(convert(varchar(50),Convert(Datetime2(0),t1.LastModifyDate),20),22))  = Convert(Datetime,'''+Convert(Varchar(50),@ModifyDate,22)+''')

	INSERT INTO #HP1500_HT1402	
	SELECT	t1.EmployeeID, t1.DivisionID, t1.BankID, t1.BankAccountNo, t1.PersonalTaxID, t1.SoInsuranceNo, t1.SoInsurBeginDate,
			t1.HeInsuranceNo, t1.ArmyJoinDate, t1.ArmyEndDate, t1.ArmyLevel,
			t1.Hobby, t1.HospitalID,  t1.Height, t1.Weight, t1.BloodGroup,
			t1.HFromDate, t1.HToDate, t1.CreateDate, t1.CreateUserID, t1.LastModifyDate, t1.LastModifyUserID
	FROM HT1402_CT t1 
	WHERE	t1.DivisionID = '''+@DivisionID+''' 
					AND t1.EmployeeID = '''+@EmployeeID+''' AND t1.Operation = 1 AND Convert(Datetime,left(convert(varchar(50),Convert(Datetime2(0),t1.LastModifyDate),20),22))  = Convert(Datetime,'''+Convert(Varchar(50),@ModifyDate,22)+''')
end
else 
'

SET @sSQL32 = '
IF EXISTS (	SELECT TOP 1 1 FROM HT1402_CT 
			WHERE	DivisionID = '''+@DivisionID+''' 
					AND EmployeeID = '''+@EmployeeID+''' AND Convert(Datetime,left(convert(varchar(50),Convert(Datetime2(0),LastModifyDate),20),22))  > Convert(Datetime,'''+Convert(Varchar(50),@ModifyDate,22)+'''))
begin
	INSERT INTO #HP1500_HT1402	
	SELECT TOP 1  EmployeeID, DivisionID, BankID, BankAccountNo, PersonalTaxID,SoInsuranceNo, SoInsurBeginDate,
			HeInsuranceNo, ArmyJoinDate, ArmyEndDate, ArmyLevel,
			Hobby, HospitalID,  Height, Weight, BloodGroup,
			HFromDate, HToDate, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID
	FROM HT1402_CT 
	WHERE	DivisionID = '''+@DivisionID+''' AND EmployeeID = '''+@EmployeeID+''' 
			AND Convert(Datetime,left(convert(varchar(50),Convert(Datetime2(0),LastModifyDate),20),22))  > Convert(Datetime,'''+Convert(Varchar(50),@ModifyDate,22)+''') 
			AND Operation = 3
	ORDER BY LastModifyDate
end
else 
'
SET @sSQL33 = '
IF NOT EXISTS (	SELECT TOP 1 1 FROM HT1402_CT 
				WHERE	DivisionID = '''+@DivisionID+''' 
					AND EmployeeID = '''+@EmployeeID+''' AND Convert(Datetime,left(convert(varchar(50),Convert(Datetime2(0),LastModifyDate),20),22))  >= Convert(Datetime,'''+Convert(Varchar(50),@ModifyDate,22)+'''))
begin
	INSERT INTO #HP1500_HT1402	
	SELECT	EmployeeID, DivisionID, BankID, BankAccountNo, PersonalTaxID,SoInsuranceNo, SoInsurBeginDate,
			HeInsuranceNo, ArmyJoinDate, ArmyEndDate, ArmyLevel,
			Hobby, HospitalID,  Height, Weight, BloodGroup,
			HFromDate, HToDate, CreateDate, CreateUserID, Convert(Datetime2(0),LastModifyDate), LastModifyUserID
	FROM HT1402 
	WHERE	DivisionID = '''+@DivisionID+''' 
					AND EmployeeID = '''+@EmployeeID+'''
end
	'
SET @sSQL41= '
IF EXISTS (	SELECT TOP 1 1 FROM HT1403_CT t1 
			WHERE	t1.DivisionID = '''+@DivisionID+''' 
					AND t1.EmployeeID = '''+@EmployeeID+''' AND Convert(Datetime,left(convert(varchar(50),Convert(Datetime2(0),t1.LastModifyDate),20),22)) = Convert(Datetime,'''+Convert(Varchar(50),@ModifyDate,22)+'''))
begin
	INSERT INTO #HP1500_HT1403	
	SELECT t2.EmployeeID, t2.DivisionID, t2.IsJobWage, t2.IsPiecework, t2.IsOtherDayPerMonth, t2.QuitJobID, t2.SalaryCoefficient, t2.DutyCoefficient, 
		t2.TimeCoefficient, t2.DutyID, t2.TaxObjectID, t2.Experience, t2.SuggestSalary, t2.RecruitDate, t2.RecruitPlace, t2.WorkDate, t2.LeaveDate, 
		t2.C01, t2.C02, t2.C03, t2.C04, t2.C05, t2.C06, t2.C07, t2.C08, t2.C09, t2.C10, t2.C11, t2.C12, t2.C13, t2.C14, t2.C15, 
		t2.C16, t2.C17, t2.C18, t2.C19, t2.C20, t2.C21, t2.C22, t2.C23, t2.C24, t2.C25,
		t2.BaseSalary, t2.InsuranceSalary, t2.SalaryLevel, t2.SalaryLevelDate, t2.CompanyDate, 
		t2.Salary01, t2.Salary02, t2.Salary03, t2.Target01ID, t2.Target02ID,
		t2.Target03ID, t2.Target04ID, t2.Target05ID, t2.Target06ID, t2.Target07ID,	t2.Target08ID, t2.Target09ID, t2.Target10ID, t2.TargetAmount01, 
		t2.TargetAmount02, t2.TargetAmount03, t2.TargetAmount04, t2.TargetAmount05, t2.TargetAmount06, t2.TargetAmount07, t2.TargetAmount08, t2.TargetAmount09, t2.TargetAmount10, 
		t2.LoaCondID, t2.ApplyDate, t2.BeginProbationDate, t2.EndProbationDate, t2.ProbationNote, t2.FileID, t2.ExpenseAccountID, t2.PayableAccountID, t2.PerInTaxID,
		t2.MidEmployeeID, t2.LeaveToDate, t2.Notes, t2.IsManager, t2.CreateDate, t2.CreateUserID, t2.LastModifyDate, t2.LastModifyUserID  	
	FROM HT1403_CT t1
	inner join HT1403_CT t2 on  t1.LastmodifyDate = t2.LastmodifyDate and t2.Operation = 3
	WHERE	t1.DivisionID = '''+@DivisionID+'''  AND t1.EmployeeID = '''+@EmployeeID+''' AND t1.Operation = 4 AND Convert(Datetime,left(convert(varchar(50),Convert(Datetime2(0),t1.LastModifyDate),20),22)) = Convert(Datetime,'''+Convert(Varchar(50),@ModifyDate,22)+''')

	INSERT INTO #HP1500_HT1403	
	SELECT t1.EmployeeID, t1.DivisionID, t1.IsJobWage, t1.IsPiecework, t1.IsOtherDayPerMonth, t1.QuitJobID, t1.SalaryCoefficient, t1.DutyCoefficient, 
		t1.TimeCoefficient, t1.DutyID, t1.TaxObjectID, t1.Experience, t1.SuggestSalary, t1.RecruitDate, t1.RecruitPlace, t1.WorkDate, t1.LeaveDate, 
		t1.C01, t1.C02, t1.C03, t1.C04, t1.C05, t1.C06, t1.C07, t1.C08, t1.C09, t1.C10, t1.C11, t1.C12, t1.C13, t1.C14, t1.C15, 
		t1.C16, t1.C17, t1.C18, t1.C19, t1.C20, t1.C21, t1.C22, t1.C23, t1.C24, t1.C25,
		t1.BaseSalary, t1.InsuranceSalary, t1.SalaryLevel, t1.SalaryLevelDate, t1.CompanyDate, 
		t1.Salary01, t1.Salary02, t1.Salary03, t1.Target01ID, t1.Target02ID,
		t1.Target03ID, t1.Target04ID, t1.Target05ID, t1.Target06ID, t1.Target07ID,	t1.Target08ID, t1.Target09ID, t1.Target10ID, t1.TargetAmount01, 
		t1.TargetAmount02, t1.TargetAmount03, t1.TargetAmount04, t1.TargetAmount05, t1.TargetAmount06, t1.TargetAmount07, t1.TargetAmount08, t1.TargetAmount09, t1.TargetAmount10, 
		t1.LoaCondID, t1.ApplyDate, t1.BeginProbationDate, t1.EndProbationDate, t1.ProbationNote, t1.FileID, t1.ExpenseAccountID, t1.PayableAccountID, t1.PerInTaxID,
		t1.MidEmployeeID, t1.LeaveToDate, t1.Notes, t1.IsManager, t1.CreateDate, t1.CreateUserID, t1.LastModifyDate, t1.LastModifyUserID  	
	FROM HT1403_CT t1 
	WHERE	t1.DivisionID = '''+@DivisionID+'''  AND t1.EmployeeID = '''+@EmployeeID+''' AND t1.Operation = 1 AND Convert(Datetime,left(convert(varchar(50),Convert(Datetime2(0),t1.LastModifyDate),20),22)) = Convert(Datetime,'''+Convert(Varchar(50),@ModifyDate,22)+''')
end
else

'

SET @sSQL42= '
IF EXISTS (	SELECT TOP 1 1 FROM HT1403_CT 
			WHERE	DivisionID = '''+@DivisionID+''' 
					AND EmployeeID = '''+@EmployeeID+''' AND Convert(Datetime,left(convert(varchar(50),Convert(Datetime2(0),LastModifyDate),20),22)) > Convert(Datetime,'''+Convert(Varchar(50),@ModifyDate,22)+'''))
begin	
	INSERT INTO #HP1500_HT1403	
	SELECT TOP 1 EmployeeID, DivisionID, IsJobWage, IsPiecework, IsOtherDayPerMonth, QuitJobID, SalaryCoefficient, DutyCoefficient, 
				TimeCoefficient, DutyID, TaxObjectID, Experience, SuggestSalary, RecruitDate, RecruitPlace, WorkDate,LeaveDate, 
		C01, C02, C03, C04, C05, C06, C07, C08, C09, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25,
		BaseSalary, InsuranceSalary, SalaryLevel, SalaryLevelDate, CompanyDate, Salary01, Salary02, Salary03, 
		Target01ID, Target02ID, Target03ID, Target04ID, Target05ID, Target06ID, Target07ID, Target08ID, Target09ID, Target10ID, 
		TargetAmount01, TargetAmount02, TargetAmount03, TargetAmount04, TargetAmount05, TargetAmount06, TargetAmount07, TargetAmount08, TargetAmount09, TargetAmount10, 
		LoaCondID, ApplyDate, BeginProbationDate, EndProbationDate, ProbationNote, FileID, ExpenseAccountID,PayableAccountID, PerInTaxID,
		MidEmployeeID, LeaveToDate, Notes, IsManager, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID  
	FROM HT1403_CT 
	WHERE	DivisionID = '''+@DivisionID+''' AND EmployeeID = '''+@EmployeeID+''' 
			AND Convert(Datetime,left(convert(varchar(50),Convert(Datetime2(0),LastModifyDate),20),22)) > Convert(Datetime,'''+Convert(Varchar(50),@ModifyDate,22)+''')
			AND Operation = 3
	ORDER BY LastModifyDate
end
else
'
SET @sSQL43= '

IF NOT EXISTS (	SELECT TOP 1 1 FROM HT1403_CT 
				WHERE	DivisionID = '''+@DivisionID+''' 
					AND EmployeeID = '''+@EmployeeID+''' AND Convert(Datetime,left(convert(varchar(50),Convert(Datetime2(0),LastModifyDate),20),22)) >= Convert(Datetime,'''+Convert(Varchar(50),@ModifyDate,22)+'''))
begin	
	INSERT INTO #HP1500_HT1403	
	SELECT	EmployeeID, DivisionID, IsJobWage, IsPiecework, IsOtherDayPerMonth, QuitJobID, SalaryCoefficient, DutyCoefficient, TimeCoefficient, DutyID, TaxObjectID, 
			Experience, SuggestSalary, RecruitDate, RecruitPlace, WorkDate,LeaveDate, 
		C01, C02, C03, C04, C05, C06, C07, C08, C09, C10, C11, C12, C13,C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25,
		BaseSalary, InsuranceSalary, SalaryLevel, SalaryLevelDate, CompanyDate,
		Salary01, Salary02, Salary03, Target01ID, Target02ID,Target03ID, Target04ID, Target05ID, Target06ID, Target07ID,
		Target08ID, Target09ID, Target10ID, TargetAmount01, TargetAmount02, TargetAmount03, TargetAmount04, TargetAmount05,
		TargetAmount06, TargetAmount07, TargetAmount08, TargetAmount09, TargetAmount10, LoaCondID,	ApplyDate, BeginProbationDate, EndProbationDate, ProbationNote, 
		 FileID, ExpenseAccountID,PayableAccountID, PerInTaxID,	MidEmployeeID, LeaveToDate, Notes, IsManager,CreateDate, CreateUserID, LastModifyDate, LastModifyUserID  	
	FROM HT1403 
	WHERE	DivisionID = '''+@DivisionID+''' AND EmployeeID = '''+@EmployeeID+'''
end
'


SET @sSQL5 = N'
--select * from #HP1500_HT1400
--select * from #HP1500_HT1401
--select * from #HP1500_HT1402
--select * from #HP1500_HT1403

Select 
	-- Ca nhan
	HT00.DivisionID, HT00.EmployeeID, 
	HT00.Orders,HT00.S1,HT00.S2,HT00.S3,
	Ltrim(RTrim(isnull(HT00.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT00.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT00.FirstName,''''))) As FullName,
	HT00.LastName, HT00.MiddleName, HT00.FirstName,
	HT00.ShortName, HT00.Alias, HT00.Birthday, HT00.BornPlace, 
    HT03.IsJobWage,HT03.IsPiecework,
	HT00.IsMale,
	(Case When HT00.IsMale=1 then N''Nam'' else N''Nữ'' End) as IsMaleName, 
	
	HT00.NativeCountry, HT00.PassportNo, HT00.PassportDate, 
	HT00.PassportEnd, HT00.IdentifyCardNo, HT00.IdentifyDate, HT00.IdentifyPlace, HT00.IdentifyEnd, 

	HT00.DrivingLicenceNo, HT00.DrivingLicenceDate, HT00.DrivingLicenceEnd, HT00.DrivingLicencePlace, 

	HT00.IsSingle,
	(Case When HT00.IsSingle=1 then N''Độc thân'' else N''Đã lập gia đình'' End) as IsSingleName, 
	HT00.EmployeeStatus AS StatusID ,
	(Case HT00.EmployeeStatus
		when 0 then N''Tuyển dụng''
		when 1 then N''Đang làm''
		when 2 then N''Thử việc''
		when 3 then N''Tạm nghỉ''
		else N''Nghỉ việc'' end) as Status,
	
	HT00.ImageID, HT00.CountryID, AT01.CountryName, 
	LTrim(RTrim(Isnull(HT00.PermanentAddress,''''))) + '' '' + LTrim(RTrim(Isnull(HT00.DistrictID,''''))) + '' '' +
	(Case when isnull(HT00.CityID,'''') <> '''' then  LTrim(RTrim(isnull(AT02.CityName,'''')))  else  ''''  End  ) As FullAddress,
	--LTrim(RTrim(isnull(HT00.CityID,'''')))  As FullAddress, 
	HT00.CityID, AT02.CityName, HT00.DistrictID, HT00.PermanentAddress, HT00.TemporaryAddress,

	HT00.EthnicID, HT1001.EthnicName, HT00.ReligionID, HT1002.ReligionName, 

	HT00.Notes, HT00.HealthStatus, HT00.HomePhone, 
	HT00.HomeFax, HT00.MobiPhone, HT00.Email,
	HT00.CreateDate, HT00.CreateUserID, HT00.LastModifyDate, HT00.LastModifyUserID, HT03.IsOtherDayPerMonth,
	HT00.IsMale as IsMaleID, HT00.IsSingle as IsSingleID,HT00.IsForeigner,HT00.RecruitTimeID, HT00.IdentifyCityID,
	
	-- Gia Dinh
	HT01.FatherName, HT01.FatherYear, HT01.FatherJob, HT01.FatherAddress, HT01.FatherNote,
	HT01.IsFatherDeath, 
	HT01.MotherName, HT01.MotherYear, HT01.MotherJob,HT01.MotherAddress, HT01.MotherNote,
	HT01.IsMotherDeath,
	HT01.SpouseName, HT01.SpouseYear, HT01.SpouseAddress, HT01.SpouseNote,
	HT01.SpouseJob, HT01.IsSpouseDeath, 
	HT01.EducationLevelID, HT05.EducationLevelName, 
	HT01.PoliticsID, 
	HT01.Language1ID, HT01.Language2ID, HT01.Language3ID, HT01.LanguageLevel1ID,
	HT01.LanguageLevel2ID, HT01.LanguageLevel3ID, --HT07.LanguageLevelName as LanguageLevelName1,
	(select top 1 MajorID From HT1301 Where HT1301.DivisionID = HT00.DivisionID And HT1301.EmployeeID = HT00.EmployeeID) as MajorID, '

SET @sSQL6 = N'
	
	-- Thong tin xa hoi
	HT02.BankID, HT02.BankAccountNo, HT02.PersonalTaxID,HT02.SoInsuranceNo, HT02.SoInsurBeginDate,
	HT02.HeInsuranceNo, HT02.ArmyJoinDate, HT02.ArmyEndDate, HT02.ArmyLevel,
	HT02.Hobby, HT02.HospitalID, HT1009.HospitalName, HT02.Height, HT02.Weight, HT02.BloodGroup,-- T05.AssociationID,
	HT02.HFromDate, HT02.HToDate,
	
	-- Thong tin ve he so chi tieu
	HT03.SalaryCoefficient, HT03.DutyCoefficient, HT03.TimeCoefficient, HT00.DepartmentID, A03.DepartmentName,
	ISNULL(HT00.TeamID,'''') AS TEAMID,T01.TeamName, HT03.DutyID, DutyName, HT03.TaxObjectID, HT00.EmployeeStatus, HT03.Experience,
	HT03.SuggestSalary, HT03.RecruitDate, HT03.RecruitPlace, HT03.WorkDate,HT03.LeaveDate, HT07.QuitJobID, HT07.QuitJobName,
	HT03.C01, HT03.C02, HT03.C03, HT03.C04, HT03.C05, HT03.C06, HT03.C07, HT03.C08, HT03.C09, HT03.C10, HT03.C11, HT03.C12, HT03.C13,
	HT03.C14, HT03.C15, HT03.C16, HT03.C17, HT03.C18, HT03.C19, HT03.C20, HT03.C21, HT03.C22, HT03.C23, HT03.C24, HT03.C25,
	HT03.BaseSalary, HT03.InsuranceSalary, HT03.SalaryLevel, HT03.SalaryLevelDate, HT03.CompanyDate,
	HT03.Salary01, HT03.Salary02, HT03.Salary03, HT03.Target01ID, HT03.Target02ID,
	HT03.Target03ID, HT03.Target04ID, HT03.Target05ID, HT03.Target06ID, HT03.Target07ID,
	HT03.Target08ID, HT03.Target09ID, HT03.Target10ID, HT03.TargetAmount01, 
	HT03.TargetAmount02, HT03.TargetAmount03, HT03.TargetAmount04, HT03.TargetAmount05,
	HT03.TargetAmount06, HT03.TargetAmount07, HT03.TargetAmount08, HT03.TargetAmount09, HT03.TargetAmount10, HT03.LoaCondID, HT06.LoaCondName, 
	HT03.ApplyDate, HT03.BeginProbationDate, HT03.EndProbationDate, HT03.ProbationNote, HT03. FileID, HT03.ExpenseAccountID,HT03.PayableAccountID, HT03.PerInTaxID,
	HT03.MidEmployeeID, HT03.LeaveToDate, HT03.Notes as StatusNotes,
	HT03.IsManager,
	HT00.IsAutoCreateUser, 
	HT00.Ana01ID, HT00.Ana02ID, HT00.Ana03ID, HT00.Ana04ID,HT00.Ana05ID,
	HT00.Ana06ID, HT00.Ana07ID, HT00.Ana08ID, HT00.Ana09ID,HT00.Ana10ID
From #HP1500_HT1400 As HT00 
LEFT JOIN #HP1500_HT1401 As HT01 On HT00.EmployeeID = HT01.EmployeeID and  HT00.DivisionID = HT01.DivisionID
LEFT JOIN #HP1500_HT1402 As HT02 On HT00.EmployeeID = HT02.EmployeeID and  HT00.DivisionID = HT02.DivisionID
LEFT JOIN #HP1500_HT1403 As HT03 On HT00.EmployeeID = HT03.EmployeeID and  HT00.DivisionID = HT03.DivisionID
--	LEFT JOIN HT1405 As T05 On HT00.EmployeeID = T05.EmployeeID and HT00.DivisionID = T05.DivisionID 
LEFT JOIN HT1101 As T01 On HT00.TeamID = T01.TeamID and HT00.DepartmentID =T01.DepartmentID and  HT00.DivisionID = T01.DivisionID
LEFT JOIN HT1107 HT07 On HT03.QuitJobID = HT07.QuitJobID and  HT03.DivisionID = HT07.DivisionID
LEFT JOIN HT1001  On HT00.EthnicID = HT1001.EthnicID  and  HT00.DivisionID = HT1001.DivisionID
LEFT JOIN HT1002  On HT00.ReligionID = HT1002.ReligionID and  HT00.DivisionID = HT1002.DivisionID
LEFT JOIN HT1102 on HT03.DutyID = HT1102.DutyID  and  HT03.DivisionID = HT1102.DivisionID
LEFT JOIN HT1005 HT05 on HT05.EducationLevelID = HT01.EducationLevelID and  HT05.DivisionID = HT01.DivisionID
--		LEFT JOIN HT1007 HT07 on HT07.LanguageLevelID = HT01.LanguageLevel1ID
LEFT JOIN AT1001 AT01 on HT00.CountryID = AT01.CountryID
LEFT JOIN AT1002 AT02 on isnull(HT00.CityID,'''') = isnull(AT02.CityID,'''')
LEFT JOIN AT1102 A03 on A03.DivisionID = HT00.DivisionID and A03.DepartmentID = HT00.DepartmentID
LEFT JOIN HT2806 HT06 on  HT03.LoaCondID = HT06.LoaCondID  and  HT03.DivisionID = HT06.DivisionID
LEFT JOIN HT1009 On HT02.DivisionID = HT1009.DivisionID and HT02.HospitalID = HT1009.HospitalID


DROP TABLE #HP1500_HT1400
DROP TABLE #HP1500_HT1401
DROP TABLE #HP1500_HT1402
DROP TABLE #HP1500_HT1403
'
--print @sSQL
--print @sSQL11
--print @sSQL12
--print @sSQL13
--print @sSQL21
--print @sSQL22
--print @sSQL23
--print @sSQL31
--print @sSQL32
--print @sSQL33
--print @sSQL41
--print @sSQL42
--print @sSQL43
--print @sSQL5
--print @sSQL6
EXEC (@sSQL + @sSQL11 + @sSQL12 +@sSQL13 + @sSQL21 +  @sSQL22 + @sSQL23 + @sSQL31 + @sSQL32 + @sSQL33 + @sSQL41 + @sSQL42 + @sSQL43+ @sSQL5+@sSQL6)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

