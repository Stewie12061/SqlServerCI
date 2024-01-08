IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP1404]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP1404]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--- Created by: Nguyen Van Nhan and Vo Thanh Huong
-- Created date: 25/05/2004
-- Purpose:  Nhom theo nhan chi tieu thong ke, du lieu duoc tra ra HV1404
---- Modified on 23/11/2016 by Bảo Thy: Bổ sung lưu C26->C150 (MEIKO)
/***************************************************************
'* Edited by : [GS] [Quoc Cuong] [30/07/2010]

EXEC [HP1404] 'MK',  'HT1400', 'EducationLevelID', 0
select * from HV1404
'**************************************************************/

CREATE PROCEDURE [dbo].[HP1404]  @DivisionID nvarchar(50),
				 @TablesName nvarchar(50),
				 @FieldID nvarchar(100),
				 @Type tinyint

 AS

Declare  @strSQL as nvarchar(MAX),
		@strSQL1 as nvarchar(MAX),
		@TypeID as nvarchar(50),
		@CustomerIndex INT

SELECT @CustomerIndex = CustomerName From CustomerIndex

Set @TablesName = Ltrim(Rtrim(@TablesName))
Set @FieldID = Ltrim(Rtrim(@FieldID))

SET @strSQL1 = '
		-- Thong tin ve he so chi tieu
		HT00.SalaryCoefficient, HT00.DutyCoefficient, HT00.TimeCoefficient, HT00.DepartmentID, isnull(HT00.TeamID,'''') as TeamID, HT00.TeamName,
		HT00.DutyID, HT00.TaxObjectID, HT00.EmployeeStatus, HT00.Experience,HT00.SuggestSalary, HT00.RecruitDate, HT00.RecruitPlace, HT00.WorkDate, 
		HT00.C01, HT00.C02, HT00.C03, HT00.C04, HT00.C05, HT00.C06, HT00.C07,HT00.C08, HT00.C09, HT00.C10, 
		HT03.C26, HT03.C27, HT03.C28, HT03.C29, HT03.C30, HT03.C31, HT03.C32, HT03.C33, HT03.C34, HT03.C35, HT03.C36, HT03.C37, HT03.C38, HT03.C39, 
		HT03.C40, HT03.C41, HT03.C42, HT03.C43, HT03.C44, HT03.C45, HT03.C46, HT03.C47, HT03.C48, HT03.C49, HT03.C50, HT03.C51, HT03.C52, HT03.C53, 
		HT03.C54, HT03.C55, HT03.C56, HT03.C57, HT03.C58, HT03.C59, HT03.C60, HT03.C61, HT03.C62, HT03.C63, HT03.C64, HT03.C65, HT03.C66, HT03.C67, 
		HT03.C68, HT03.C69, HT03.C70, HT03.C71, HT03.C72, HT03.C73, HT03.C74, HT03.C75, HT03.C76, HT03.C77, HT03.C78, HT03.C79, HT03.C80, HT03.C81, 
		HT03.C82, HT03.C83, HT03.C84, HT03.C85, HT03.C86, HT03.C87, HT03.C88, HT03.C89, HT03.C90, HT03.C91, HT03.C92, HT03.C93, HT03.C94, HT03.C95, 
		HT03.C96, HT03.C97, HT03.C98, HT03.C99, HT03.C100,HT03.C101, HT03.C102, HT03.C103, HT03.C104, HT03.C105, HT03.C106, HT03.C107, HT03.C108, 
		HT03.C109, HT03.C110, HT03.C111, HT03.C112, HT03.C113, HT03.C114, HT03.C115, HT03.C116, HT03.C117, HT03.C118, HT03.C119, HT03.C120, 
		HT03.C121, HT03.C122, HT03.C123, HT03.C124, HT03.C125, HT03.C126, HT03.C127, HT03.C128, HT03.C129, HT03.C130, HT03.C131, HT03.C132, 
		HT03.C133, HT03.C134, HT03.C135, HT03.C136, HT03.C137, HT03.C138, HT03.C139, HT03.C140, HT03.C141, HT03.C142, HT03.C143, HT03.C144, 
		HT03.C145, HT03.C146, HT03.C147, HT03.C148, HT03.C149, HT03.C150, HT00.BaseSalary, HT00.InsuranceSalary,
		HT00.Salary01, HT00.Salary02, HT00.Salary03, HT00.Target01ID, HT00.Target02ID, HT00.Target03ID, HT00.Target04ID, HT00.Target05ID, HT00.Target06ID, 
		HT00.Target07ID, HT00.Target08ID, HT00.Target09ID, HT00.Target10ID, HT00.TargetAmount01, HT00.TargetAmount02, HT00.TargetAmount03, HT00.TargetAmount04, 
		HT00.TargetAmount05, HT00.TargetAmount06, HT00.TargetAmount07, HT00.TargetAmount08, HT00.TargetAmount09, HT00.TargetAmount10
		From HV1405 HT00  
		Left join  HV2222  T on T.'+@FieldID+' = HT00.'+@FieldID+' 
		LEFT JOIN HT1403_1 HT03 ON HT00.DivisionID = HT03.DivisionID AND HT00.EmployeeID = HT03.EmployeeID
		Where HT00.EmployeeStatus=1 and HT00.DivisionID = '''+@DivisionID+'''
	'

	
If  @Type =0 or @Type =99
	Set @strSQL ='
	Select 
		-- C¸ nh©n
		HT00.'+@FieldID+' as GroupID,
		T.'+left(@FieldID, len(@FieldID) - 2) +'Name as  GroupName,
		T.EmployeeAmount as EmployeeAmount,
		HT00.DivisionID, HT00.EmployeeID, 
		Ltrim(RTrim(isnull(HT00.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT00.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT00.FirstName,''''))) As FullName,
		HT00.LastName, HT00.MiddleName, HT00.FirstName,HT00.ShortName, HT00.Alias, HT00.Birthday, year(HT00.Birthday) as Year, HT00.BornPlace, 
		--(Case when HT00.IsMale =0 then 1 else 0 end) as IsMale, 
		HT00.IsMale, HT00.NativeCountry, HT00.PassportNo, HT00.PassportDate, 
		HT00.PassportEnd, HT00.IdentifyCardNo, HT00.IdentifyDate, HT00.IdentifyPlace, HT00.IsSingle,HT00.ImageID, HT00.CountryID, 
		LTrim(RTrim(Isnull(HT00.PermanentAddress,''''))) + '' '' + LTrim(RTrim(Isnull(HT00.DistrictID,''''))) + '' '' +  LTrim(RTrim(isnull(HT00.CityID,'''')))  As FullAddress, 
		HT00.CityID, HT00.DistrictID, HT00.PermanentAddress, HT00.TemporaryAddress,HT00.EthnicID, HT00.EthnicName, HT00.ReligionID, HT00.ReligionName, 
		HT00.Notes, HT00.HealthStatus, HT00.HomePhone, HT00.HomeFax, HT00.MobiPhone, HT00.Email,
		HT00.CreateDate, HT00.CreateUserID, HT00.LastModifyDate, HT00.LastModifyUserID,
	
		-- Gia ®×nh
		HT00.FatherName, HT00.FatherYear, HT00.FatherJob, HT00.FatherAddress, HT00.FatherNote,HT00.IsFatherDeath, HT00.MotherName, HT00.MotherYear, HT00.MotherJob,
		HT00.MotherAddress, HT00.MotherNote, HT00.IsMotherDeath,HT00.SpouseName, HT00.SpouseYear, HT00.SpouseAddress, HT00.SpouseNote,
		HT00.SpouseJob, HT00.IsSpouseDeath, HT00.EducationLevelID, HT00.PoliticsID, HT00.Language1ID, HT00.Language2ID, HT00.Language3ID, HT00.LanguageLevel1ID,
		HT00.LanguageLevel2ID, HT00.LanguageLevel3ID,
	
		-- Th«ng tin x· héi
		HT00.BankID, HT00.BankAccountNo, HT00.SoInsuranceNo, HT00.SoInsurBeginDate,HT00.HeInsuranceNo, HT00.ArmyJoinDate, HT00.ArmyEndDate, HT00.ArmyLevel,
		HT00.Hobby, HT00.HospitalID, HT00.Height, HT00.Weight, HT00.BloodGroup,
'
	
Else
	Set @strSQL ='
	Select 
		-- C¸ nh©n
		HT00.'+@FieldID+' as GroupID,
		T.Description  as  GroupName,
		T.EmployeeAmount as EmployeeAmount,
		HT00.DivisionID, HT00.EmployeeID, 
		Ltrim(RTrim(isnull(HT00.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT00.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT00.FirstName,''''))) As FullName,
		HT00.LastName, HT00.MiddleName, HT00.FirstName,
		HT00.ShortName, HT00.Alias, HT00.Birthday, year(HT00.Birthday) as Year, HT00.BornPlace, 
	
		--(Case when HT00.IsMale =0 then 1 else 0 end) as IsMale, 
		HT00.IsMale,
		HT00.NativeCountry, HT00.PassportNo, HT00.PassportDate, 
		HT00.PassportEnd, HT00.IdentifyCardNo, HT00.IdentifyDate, HT00.IdentifyPlace, 
	
		HT00.IsSingle,
		
		HT00.ImageID, HT00.CountryID, 
		LTrim(RTrim(Isnull(HT00.PermanentAddress,''''))) + '' '' + LTrim(RTrim(Isnull(HT00.DistrictID,''''))) + '' '' +  LTrim(RTrim(isnull(HT00.CityID,'''')))  As FullAddress, 
		HT00.CityID, HT00.DistrictID, HT00.PermanentAddress, HT00.TemporaryAddress,
	
		HT00.EthnicID, HT00.EthnicName, HT00.ReligionID, HT00.ReligionName, 
	
		HT00.Notes, HT00.HealthStatus, HT00.HomePhone, 
		HT00.HomeFax, HT00.MobiPhone, HT00.Email,
		HT00.CreateDate, HT00.CreateUserID, HT00.LastModifyDate, HT00.LastModifyUserID,
	
		-- Gia ®×nh
		HT00.FatherName, HT00.FatherYear, HT00.FatherJob, HT00.FatherAddress, HT00.FatherNote,
		HT00.IsFatherDeath, 
		HT00.MotherName, HT00.MotherYear, HT00.MotherJob,HT00.MotherAddress, HT00.MotherNote,
		HT00.IsMotherDeath,
		HT00.SpouseName, HT00.SpouseYear, HT00.SpouseAddress, HT00.SpouseNote,
		HT00.SpouseJob, HT00.IsSpouseDeath, 
		HT00.EducationLevelID, HT00.PoliticsID, 
		HT00.Language1ID, HT00.Language2ID, HT00.Language3ID, HT00.LanguageLevel1ID,
		HT00.LanguageLevel2ID, HT00.LanguageLevel3ID,
	
		-- Th«ng tin x· héi
		HT00.BankID, HT00.BankAccountNo, HT00.SoInsuranceNo, HT00.SoInsurBeginDate,
		HT00.HeInsuranceNo, HT00.ArmyJoinDate, HT00.ArmyEndDate, HT00.ArmyLevel,
		HT00.Hobby, HT00.HospitalID, HT00.Height, HT00.Weight, HT00.BloodGroup,
'

--Print @strSQL
--Print @strSQL1
If not exists (Select name from sysObjects Where id = Object_ID(N'[dbo].[HV1404]') and OBJECTPROPERTY(id,N'IsView')=1)
	Exec (' Create View HV1404 as ' + @strSQL+@strSQL1)
Else
	Exec (' Alter  View HV1404 as ' + @strSQL+@strSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
