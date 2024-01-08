IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP2818]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP2818]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



---------Create Date: 28/11/2023
---------Purpose: In thong tin nhan su cua nhan vien
---- Modified on 29/11/2023 by Xuân Nguyên : Bổ sung Trường và thay đổi các mục
-- <Example>
---- 
----@RegularTraining,@ServiceTraining,@Candidate,@SupplementatryTraining,@Other 
CREATE PROCEDURE [dbo].[HP2818] 	
				@DivisionID nvarchar(50),			
				@EmployeeID nvarchar(50),	
				@GroupID AS NVARCHAR(50) = 'G1', -- GroupID trong bảng AT8888
				@TypeID AS TINYINT = 10-- TypeID trong bảng AT8888
AS
DECLARE @sSQL nvarchar(MAX) ,
		@sSQL1 nvarchar(MAX) ,
		@sSQL2 nvarchar(MAX) ,
		@sSQL3 nvarchar(MAX) ,
		@sSQL4 nvarchar(MAX) ,
		@sSQL5 nvarchar(MAX) ,
		@sSQL6 nvarchar(MAX) ,
		@sSQL7 nvarchar(MAX) ,
		@sSQL8 nvarchar(MAX) ,
		@sSQL9 nvarchar(MAX) ,
		@sWHERE NVARCHAR(MAX)
SET @sWHERE = ''

IF @GroupID = 'G01' AND @TypeID = 10
BEGIN

--------------------------------------------------------------------THONG TIN CA NHAN---------------------------------------
Set @sSQL=N'SELECT HV2815.*, HV2820.*  From HV2815 HV2815, HV2820 HV2820  Where  HV2815.EmployeeID = HV2820.EmployeeID  and HV2815.DivisionID = HV2820.DivisionID   
AND  HV2815.DivisionID IN (SELECT DivisionID FROM dbo.GetDivisionID(''' + @DivisionID+ '''))'
--------------------------------------------------------------------NGƯỜI PHỤ THUỘC---------------------------------------
Set @sSQL1 = N'
 Union
Select  ''' + @DivisionID+ ''' as DivisionID,'''+@EmployeeID+''' as EmployeeID,0 as Orders,HT14.LeaveDate,HT14.FullName,HT14.Birthday,HT14.BornPlace ,HT14.IsMale ,HT14.IdentifyCardNo, 
		HT14.IdentifyDate ,HT14.IdentifyPlace,HT14.IsSingle,HT14.EmployeeStatus as Status ,HT14.FullAddress ,HT14.CityID,HT14.DistrictID ,HT14.PermanentAddress ,
		HT14.TemporaryAddress ,HT14.EthnicID,HT14.EthnicName ,HT14.ReligionID, HT14.ReligionName ,HT14.Notes ,HT14.HealthStatus ,HT14.HomePhone,HT14.HomeFax,
		HT14.MobiPhone ,HT14.Email ,HT14.EducationLevelName ,HT14.Language1ID, HT14.Language2ID ,HT14.Language3ID ,HT14.LanguageLevel1ID,HT14.LanguageLevel2ID ,
		HT14.LanguageLevel3ID  ,HT14.SoInsuranceNo,HT14.SoInsurBeginDate,HT14.HeInsuranceNo,HT14.Hobby,HT14.HospitalID,HT14.SalaryCoefficient,HT14.DutyCoefficient,
		HT14.TimeCoefficient,HT14.DepartmentID,HT14.TeamID ,HT14.DutyID,HT14.DutyName,HT14.TaxObjectID , HT14.EmployeeStatus,HT14.Experience ,HT14.RecruitDate,
		HT14.RecruitPlace, HT14.WorkDate ,0 as C01 ,0 as C02,0 as C03 ,0 as C04 , 0 as C05 , 0 as C06 , 0 as C07, 0 as C08 , 0 as C09 , 0 as C10 ,
		HT14.BaseSalary ,HT14.InsuranceSalary , HT14.Salary01,0 as Salary02,0 as Salary03,NULL as ImageID,
		HT14.DepartmentName,
		HT14.Target01ID, HT14.Target02ID, HT14.Target03ID, HT14.Target04ID, HT14.Target05ID, HT14.Target06ID, HT14.Target07ID,
		HT14.Target08ID, HT14.Target09ID, HT14.Target10ID, 
		0 as C11,  0 as C12,  0 as C13,  0 as C15,  0 as C16,  0 as C17,  0 as C14,  0 as C18,  0 as C19,  0 as C20,  0 as C21,  0 as C22,  0 as C23,  0 as C24,  0 as C25,
		0 as C26,  0 as C27,  0 as C28,  0 as C29,  0 as C30,  0 as C31,  0 as C32,  0 as C33,  0 as C34,  0 as C35, 
		0 as C36,  0 as C37,  0 as C38,  0 as C39,  0 as C40,  0 as C41,  0 as C42,  0 as C43,  0 as C44,  0 as C45, 
		0 as C46,  0 as C47,  0 as C48,  0 as C49,  0 as C50,  0 as C51,  0 as C52,  0 as C53,  0 as C54,  0 as C55, 
		0 as C56,  0 as C57,  0 as C58,  0 as C59,  0 as C60,  0 as C61,  0 as C62,  0 as C63,  0 as C64,  0 as C65, 
		0 as C66,  0 as C67,  0 as C68,  0 as C69,  0 as C70,  0 as C71,  0 as C72,  0 as C73,  0 as C74,  0 as C75, 
		0 as C76,  0 as C77,  0 as C78,  0 as C79,  0 as C80,  0 as C81,  0 as C82,  0 as C83,  0 as C84,  0 as C85, 
		0 as C86,  0 as C87,  0 as C88,  0 as C89,  0 as C90,  0 as C91,  0 as C92,  0 as C93,  0 as C94,  0 as C95, 
		0 as C96,  0 as C97,  0 as C98,  0 as C99,  0 as C100, 0 as C101, 0 as C102, 0 as C103, 0 as C104, 0 as C105, 
		0 as C106, 0 as C107, 0 as C108, 0 as C109, 0 as C110, 0 as C111, 0 as C112, 0 as C113, 0 as C114, 0 as C115, 
		0 as C116, 0 as C117, 0 as C118, 0 as C119, 0 as C120, 0 as C121, 0 as C122, 0 as C123, 0 as C124, 0 as C125, 
		0 as C126, 0 as C127, 0 as C128, 0 as C129, 0 as C130, 0 as C131, 0 as C132, 0 as C133, 0 as C134, 0 as C135, 
		0 as C136, 0 as C137, 0 as C138, 0 as C139, 0 as C140, 0 as C141, 0 as C142, 0 as C143, 0 as C144, 0 as C145, 
		0 as C146, 0 as C147, 0 as C148, 0 as C149, 0 as C150,'
SET @sSQL2 = N'
 '''' as NativeCountry,'''' as CountryID,'''' as Height,'''' as Weight,'''' as ArmyJoinDate,'''' as ArmyEndDate,
'''' as ArmyLevel,'''' as PersonalTaxID,'''' as BankName,'''' as BankAccountNo,'''' as Address,'''' as FatherName,'''' as MotherName,'''' as SpouseName
 ,'''' as FatherJob,'''' as MotherJob,'''' as SpouseJob,'''' as FatherAddress,'''' as MotherAddress,'''' as SpouseAddress,'''' as FatherYear,0 as MotherYear, 0 as SpouseYear
 , '''' as FromPeriod,'''' as ToPeriod,'''' as RelationTaxID,'''' as RelationIdentifyCardNo,''' + @DivisionID+ N''' as DivisionID,'''' as EmployeeID
, '''' as RetributionID, '''' as  IsReward , '''' as DecisionNo ,
'''' as Rank ,'''' as SuggestedPerson, '''' as Reason , '''' as Form ,
0 as Value , 0 as Value1, 0 as Value2, 0 as Value3, 0 as Value4, 0 as Value5, 0 as Value6, 0 as Value7, 0 as Value8, 0 as Value9, 0 as Value10, 
'''' as RetributeDate , '''' as  WorkEndDate,
'''' as TestFromDate, '''' as TestEndDate, N''Giảm trừ gia cảnh'' as PrintStatus, 
'''' as Works, '''' as DivisionIDOld, '''' as DepartmentIDOld,  '''' as TeamIDOld, '''' as DutyIDOld,  
'''' as WorksOld, '''' as Description, '''' as Notes, 1 as Suppress,'''' as Contactor,'''' as FromDate,'''' as ToDate, '''' as DutyNameOld,
'''' as DecideDate,'''' as DecideType, NULL  as RelationID,'''' as RelationBirthday,'''' as RelationName,0 as InsuranceSalary,0 as allowanceSalary
From HV1400 HT14
	Where HT14.DivisionID=  ''' + @DivisionID+ '''  and HT14.EmployeeID=''' + @EmployeeID+ '''
		'
Set @sSQL3 = N'
 Union
Select  ''' + @DivisionID+ ''' as DivisionID,HT34.EmployeeID,0 as Orders,HV15.LeaveDate,HV15.FullName, HV15.Birthday,HV15.BornPlace ,HV15.IsMale ,HV15.IdentifyCardNo, 
		HV15.IdentifyDate , HV15.IdentifyPlace,HV15.IsSingle,HV15.Status ,HV15.FullAddress , HV15.CityID,HV15.DistrictID ,HV15.PermanentAddress ,
		HV15.TemporaryAddress ,HV15.EthnicID,HV15.EthnicName ,HV15.ReligionID, HV15.ReligionName ,HV15.Notes ,HV15.HealthStatus ,HV15.HomePhone,HV15.HomeFax,
		HV15.MobiPhone ,HV15.Email ,HV15.EducationLevelName ,HV15.Language1ID,HV15.Language2ID ,HV15.Language3ID ,HV15.LanguageLevel1ID,HV15.LanguageLevel2ID ,
		HV15.LanguageLevel3ID  ,HV15.SoInsuranceNo,HV15.SoInsurBeginDate,HV15.HeInsuranceNo, HV15.Hobby,HV15.HospitalID,0 as SalaryCoefficient,0 as DutyCoefficient,
		0 as TimeCoefficient,HV15.DepartmentID,HV15.TeamID ,HV15.DutyID,HV15.DutyName,HV15.TaxObjectID , HV15.EmployeeStatus,HV15.Experience ,HV15.RecruitDate,
		'''' as RecruitPlace, '''' as WorkDate ,0 as C01 ,0 as C02,0 as C03 ,0 as C04 , 0 as C05 , 0 as C06 , 0 as C07, 0 as C08 , 0 as C09 , 0 as C10 ,
		0 as BaseSalary ,0 as InsuranceSalary , 0 as Salary01,0 as Salary02,0 as Salary03,NULL as ImageID,
		'''' as DepartmentName,
		'''' as Target01ID, '''' as Target02ID,'''' as Target03ID, '''' as Target04ID, '''' as Target05ID, '''' as Target06ID, '''' as Target07ID,
		'''' as Target08ID, '''' as Target09ID, '''' as Target10ID, 
		0 as C11,  0 as C12,  0 as C13,  0 as C15,  0 as C16,  0 as C17,  0 as C14,  0 as C18,  0 as C19,  0 as C20,  0 as C21,  0 as C22,  0 as C23,  0 as C24,  0 as C25,
		0 as C26,  0 as C27,  0 as C28,  0 as C29,  0 as C30,  0 as C31,  0 as C32,  0 as C33,  0 as C34,  0 as C35, 
		0 as C36,  0 as C37,  0 as C38,  0 as C39,  0 as C40,  0 as C41,  0 as C42,  0 as C43,  0 as C44,  0 as C45, 
		0 as C46,  0 as C47,  0 as C48,  0 as C49,  0 as C50,  0 as C51,  0 as C52,  0 as C53,  0 as C54,  0 as C55, 
		0 as C56,  0 as C57,  0 as C58,  0 as C59,  0 as C60,  0 as C61,  0 as C62,  0 as C63,  0 as C64,  0 as C65, 
		0 as C66,  0 as C67,  0 as C68,  0 as C69,  0 as C70,  0 as C71,  0 as C72,  0 as C73,  0 as C74,  0 as C75, 
		0 as C76,  0 as C77,  0 as C78,  0 as C79,  0 as C80,  0 as C81,  0 as C82,  0 as C83,  0 as C84,  0 as C85, 
		0 as C86,  0 as C87,  0 as C88,  0 as C89,  0 as C90,  0 as C91,  0 as C92,  0 as C93,  0 as C94,  0 as C95, 
		0 as C96,  0 as C97,  0 as C98,  0 as C99,  0 as C100, 0 as C101, 0 as C102, 0 as C103, 0 as C104, 0 as C105, 
		0 as C106, 0 as C107, 0 as C108, 0 as C109, 0 as C110, 0 as C111, 0 as C112, 0 as C113, 0 as C114, 0 as C115, 
		0 as C116, 0 as C117, 0 as C118, 0 as C119, 0 as C120, 0 as C121, 0 as C122, 0 as C123, 0 as C124, 0 as C125, 
		0 as C126, 0 as C127, 0 as C128, 0 as C129, 0 as C130, 0 as C131, 0 as C132, 0 as C133, 0 as C134, 0 as C135, 
		0 as C136, 0 as C137, 0 as C138, 0 as C139, 0 as C140, 0 as C141, 0 as C142, 0 as C143, 0 as C144, 0 as C145, 
		0 as C146, 0 as C147, 0 as C148, 0 as C149, 0 as C150,'
SET @sSQL4 = N'
 '''' as NativeCountry,'''' as CountryID,'''' as Height,'''' as Weight,HV15.ArmyJoinDate,HV15.ArmyEndDate,
  '''' as ArmyLevel,'''' as PersonalTaxID,'''' as BankName,'''' as BankAccountNo,'''' as Address,'''' as FatherName,'''' as MotherName,'''' as SpouseName
 ,'''' as FatherJob,'''' as MotherJob,'''' as SpouseJob,'''' as FatherAddress,'''' as MotherAddress,'''' as SpouseAddress,'''' as FatherYear,0 as MotherYear, 0 as SpouseYear
 , HT34.FromPeriod,HT34.ToPeriod,HT34.RelationTaxID,HT34.RelationIdentifyCardNo,''' + @DivisionID+ N''' as DivisionID,HT34.EmployeeID
, '''' as RetributionID, '''' as  IsReward , '''' as DecisionNo ,
'''' as Rank ,'''' as SuggestedPerson, '''' as Reason , '''' as Form ,
0 as Value , 0 as Value1, 0 as Value2, 0 as Value3, 0 as Value4, 0 as Value5, 0 as Value6, 0 as Value7, 0 as Value8, 0 as Value9, 0 as Value10, 
'''' as RetributeDate , '''' as  WorkEndDate,
'''' as TestFromDate, '''' as TestEndDate, N''Giảm trừ gia cảnh'' as PrintStatus, 
'''' as Works, '''' as DivisionIDOld, '''' as DepartmentIDOld,  '''' as TeamIDOld, '''' as DutyIDOld,  
'''' as WorksOld, '''' as Description, '''' as Notes, 2 as Suppress,'''' as Contactor,'''' as FromDate,'''' as ToDate, '''' as DutyNameOld,
'''' as DecideDate,'''' as DecideType,
Case when HT34.RelationID = 1 then N''Con''
when RelationID = 2 then N''Vợ/chồng''
when RelationID = 3 then N''Cha/mẹ''
when RelationID = 4 then N''Khác''
else NULL end as RelationID,HT34.RelationBirthday,HT34.RelationName,0 as InsuranceSalary,0 as allowanceSalary

		From  HT0334 HT34
		left join HV2815 HV15 ON HV15.EmployeeID = HT34.EmployeeID
		Where HT34.DivisionID=  ''' + @DivisionID+ '''  and HT34.EmployeeID=''' + @EmployeeID+ '''
		and ISNULL(IsGTGC,0) = 1
		'

Set @sSQL5 = N'
 Union
Select  ''' + @DivisionID+ ''' as DivisionID,'''+@EmployeeID+''' as EmployeeID,0 as Orders,HT14.LeaveDate,HT14.FullName,HT14.Birthday,HT14.BornPlace ,HT14.IsMale ,HT14.IdentifyCardNo, 
		HT14.IdentifyDate ,HT14.IdentifyPlace,HT14.IsSingle,HT14.EmployeeStatus as Status ,HT14.FullAddress ,HT14.CityID,HT14.DistrictID ,HT14.PermanentAddress ,
		HT14.TemporaryAddress ,HT14.EthnicID,HT14.EthnicName ,HT14.ReligionID, HT14.ReligionName ,HT14.Notes ,HT14.HealthStatus ,HT14.HomePhone,HT14.HomeFax,
		HT14.MobiPhone ,HT14.Email ,HT14.EducationLevelName ,HT14.Language1ID, HT14.Language2ID ,HT14.Language3ID ,HT14.LanguageLevel1ID,HT14.LanguageLevel2ID ,
		HT14.LanguageLevel3ID  ,HT14.SoInsuranceNo,HT14.SoInsurBeginDate,HT14.HeInsuranceNo,HT14.Hobby,HT14.HospitalID,HT14.SalaryCoefficient,HT14.DutyCoefficient,
		HT14.TimeCoefficient,HT14.DepartmentID,HT14.TeamID ,HT14.DutyID,HT14.DutyName,HT14.TaxObjectID , HT14.EmployeeStatus,HT14.Experience ,HT14.RecruitDate,
		HT14.RecruitPlace, HT14.WorkDate ,0 as C01 ,0 as C02,0 as C03 ,0 as C04 , 0 as C05 , 0 as C06 , 0 as C07, 0 as C08 , 0 as C09 , 0 as C10 ,
		HT14.BaseSalary ,HT14.InsuranceSalary , HT14.Salary01,0 as Salary02,0 as Salary03,NULL as ImageID,
		HT14.DepartmentName,
		HT14.Target01ID, HT14.Target02ID, HT14.Target03ID, HT14.Target04ID, HT14.Target05ID, HT14.Target06ID, HT14.Target07ID,
		HT14.Target08ID, HT14.Target09ID, HT14.Target10ID, 
		0 as C11,  0 as C12,  0 as C13,  0 as C15,  0 as C16,  0 as C17,  0 as C14,  0 as C18,  0 as C19,  0 as C20,  0 as C21,  0 as C22,  0 as C23,  0 as C24,  0 as C25,
		0 as C26,  0 as C27,  0 as C28,  0 as C29,  0 as C30,  0 as C31,  0 as C32,  0 as C33,  0 as C34,  0 as C35, 
		0 as C36,  0 as C37,  0 as C38,  0 as C39,  0 as C40,  0 as C41,  0 as C42,  0 as C43,  0 as C44,  0 as C45, 
		0 as C46,  0 as C47,  0 as C48,  0 as C49,  0 as C50,  0 as C51,  0 as C52,  0 as C53,  0 as C54,  0 as C55, 
		0 as C56,  0 as C57,  0 as C58,  0 as C59,  0 as C60,  0 as C61,  0 as C62,  0 as C63,  0 as C64,  0 as C65, 
		0 as C66,  0 as C67,  0 as C68,  0 as C69,  0 as C70,  0 as C71,  0 as C72,  0 as C73,  0 as C74,  0 as C75, 
		0 as C76,  0 as C77,  0 as C78,  0 as C79,  0 as C80,  0 as C81,  0 as C82,  0 as C83,  0 as C84,  0 as C85, 
		0 as C86,  0 as C87,  0 as C88,  0 as C89,  0 as C90,  0 as C91,  0 as C92,  0 as C93,  0 as C94,  0 as C95, 
		0 as C96,  0 as C97,  0 as C98,  0 as C99,  0 as C100, 0 as C101, 0 as C102, 0 as C103, 0 as C104, 0 as C105, 
		0 as C106, 0 as C107, 0 as C108, 0 as C109, 0 as C110, 0 as C111, 0 as C112, 0 as C113, 0 as C114, 0 as C115, 
		0 as C116, 0 as C117, 0 as C118, 0 as C119, 0 as C120, 0 as C121, 0 as C122, 0 as C123, 0 as C124, 0 as C125, 
		0 as C126, 0 as C127, 0 as C128, 0 as C129, 0 as C130, 0 as C131, 0 as C132, 0 as C133, 0 as C134, 0 as C135, 
		0 as C136, 0 as C137, 0 as C138, 0 as C139, 0 as C140, 0 as C141, 0 as C142, 0 as C143, 0 as C144, 0 as C145, 
		0 as C146, 0 as C147, 0 as C148, 0 as C149, 0 as C150,'
		Set @sSQL6 =N'
 '''' as NativeCountry,'''' as CountryID,'''' as Height,'''' as Weight,'''' as ArmyJoinDate,'''' as ArmyEndDate,
'''' as ArmyLevel,'''' as PersonalTaxID,'''' as BankName,'''' as BankAccountNo,'''' as Address,'''' as FatherName,'''' as MotherName,'''' as SpouseName
 ,'''' as FatherJob,'''' as MotherJob,'''' as SpouseJob,'''' as FatherAddress,'''' as MotherAddress,'''' as SpouseAddress,'''' as FatherYear,0 as MotherYear, 0 as SpouseYear
 , '''' as FromPeriod,'''' as ToPeriod,'''' as RelationTaxID,'''' as RelationIdentifyCardNo,''' + @DivisionID+ ''' as DivisionID,'''' as EmployeeID
, '''' as RetributionID, '''' as  IsReward , '''' as DecisionNo ,
'''' as Rank ,'''' as SuggestedPerson, '''' as Reason , '''' as Form ,
0 as Value , 0 as Value1, 0 as Value2, 0 as Value3, 0 as Value4, 0 as Value5, 0 as Value6, 0 as Value7, 0 as Value8, 0 as Value9, 0 as Value10, 
'''' as RetributeDate , '''' as  WorkEndDate,
'''' as TestFromDate, '''' as TestEndDate, N''Đăng kí PVI'' as PrintStatus, 
'''' as Works, '''' as DivisionIDOld, '''' as DepartmentIDOld,  '''' as TeamIDOld, '''' as DutyIDOld,  
'''' as WorksOld, '''' as Description, '''' as Notes, 3 as Suppress,'''' as Contactor,'''' as FromDate,'''' as ToDate, '''' as DutyNameOld,
'''' as DecideDate,'''' as DecideType, NULL  as RelationID,'''' as RelationBirthday,'''' as RelationName,0 as InsuranceSalary,0 as allowanceSalary
From HV1400 HT14
	Where HT14.DivisionID=  ''' + @DivisionID+ '''  and HT14.EmployeeID=''' + @EmployeeID+ '''
	
		'

Set @sSQL7 = N'
 Union
Select  ''' + @DivisionID+ ''' as DivisionID,HT34.EmployeeID,0 as Orders,HV15.LeaveDate,HV15.FullName,HV15.Birthday,HV15.BornPlace ,HV15.IsMale ,HV15.IdentifyCardNo, 
		HV15.IdentifyDate , HV15.IdentifyPlace,HV15.IsSingle,HV15.Status ,HV15.FullAddress , HV15.CityID,HV15.DistrictID ,HV15.PermanentAddress ,
		HV15.TemporaryAddress ,HV15.EthnicID,HV15.EthnicName ,HV15.ReligionID, HV15.ReligionName ,HV15.Notes ,HV15.HealthStatus ,HV15.HomePhone,HV15.HomeFax,
		HV15.MobiPhone ,HV15.Email ,HV15.EducationLevelName ,HV15.Language1ID, HV15.Language2ID ,HV15.Language3ID ,HV15.LanguageLevel1ID,HV15.LanguageLevel2ID ,
		HV15.LanguageLevel3ID  ,HV15.SoInsuranceNo,HV15.SoInsurBeginDate,HV15.HeInsuranceNo,HV15.Hobby,HV15.HospitalID,0 as SalaryCoefficient,0 as DutyCoefficient,
		0 as TimeCoefficient,HV15.DepartmentID,HV15.TeamID ,HV15.DutyID,HV15.DutyName,HV15.TaxObjectID , HV15.EmployeeStatus,HV15.Experience ,HV15.RecruitDate,
		HV15.RecruitPlace, HV15.WorkDate ,0 as C01 ,0 as C02,0 as C03 ,0 as C04 , 0 as C05 , 0 as C06 , 0 as C07, 0 as C08 , 0 as C09 , 0 as C10 ,
		0 as BaseSalary ,0 as InsuranceSalary , 0 as Salary01,0 as Salary02,0 as Salary03,NULL as ImageID,
		'''' as DepartmentName,
		'''' as Target01ID, '''' as Target02ID,'''' as Target03ID, '''' as Target04ID, '''' as Target05ID, '''' as Target06ID, '''' as Target07ID,
		'''' as Target08ID, '''' as Target09ID, '''' as Target10ID, 
		0 as C11,  0 as C12,  0 as C13,  0 as C15,  0 as C16,  0 as C17,  0 as C14,  0 as C18,  0 as C19,  0 as C20,  0 as C21,  0 as C22,  0 as C23,  0 as C24,  0 as C25,
		0 as C26,  0 as C27,  0 as C28,  0 as C29,  0 as C30,  0 as C31,  0 as C32,  0 as C33,  0 as C34,  0 as C35, 
		0 as C36,  0 as C37,  0 as C38,  0 as C39,  0 as C40,  0 as C41,  0 as C42,  0 as C43,  0 as C44,  0 as C45, 
		0 as C46,  0 as C47,  0 as C48,  0 as C49,  0 as C50,  0 as C51,  0 as C52,  0 as C53,  0 as C54,  0 as C55, 
		0 as C56,  0 as C57,  0 as C58,  0 as C59,  0 as C60,  0 as C61,  0 as C62,  0 as C63,  0 as C64,  0 as C65, 
		0 as C66,  0 as C67,  0 as C68,  0 as C69,  0 as C70,  0 as C71,  0 as C72,  0 as C73,  0 as C74,  0 as C75, 
		0 as C76,  0 as C77,  0 as C78,  0 as C79,  0 as C80,  0 as C81,  0 as C82,  0 as C83,  0 as C84,  0 as C85, 
		0 as C86,  0 as C87,  0 as C88,  0 as C89,  0 as C90,  0 as C91,  0 as C92,  0 as C93,  0 as C94,  0 as C95, 
		0 as C96,  0 as C97,  0 as C98,  0 as C99,  0 as C100, 0 as C101, 0 as C102, 0 as C103, 0 as C104, 0 as C105, 
		0 as C106, 0 as C107, 0 as C108, 0 as C109, 0 as C110, 0 as C111, 0 as C112, 0 as C113, 0 as C114, 0 as C115, 
		0 as C116, 0 as C117, 0 as C118, 0 as C119, 0 as C120, 0 as C121, 0 as C122, 0 as C123, 0 as C124, 0 as C125, 
		0 as C126, 0 as C127, 0 as C128, 0 as C129, 0 as C130, 0 as C131, 0 as C132, 0 as C133, 0 as C134, 0 as C135, 
		0 as C136, 0 as C137, 0 as C138, 0 as C139, 0 as C140, 0 as C141, 0 as C142, 0 as C143, 0 as C144, 0 as C145, 
		0 as C146, 0 as C147, 0 as C148, 0 as C149, 0 as C150,'
		Set @sSQL8 =N'
 '''' as NativeCountry,'''' as CountryID,'''' as Height,'''' as Weight,HV15.ArmyJoinDate,HV15.ArmyEndDate,
'''' as ArmyLevel,'''' as PersonalTaxID,'''' as BankName,'''' as BankAccountNo,'''' as Address,'''' as FatherName,'''' as MotherName,'''' as SpouseName
 ,'''' as FatherJob,'''' as MotherJob,'''' as SpouseJob,'''' as FatherAddress,'''' as MotherAddress,'''' as SpouseAddress,'''' as FatherYear,0 as MotherYear, 0 as SpouseYear
 , HT34.FromPeriod,HT34.ToPeriod,HT34.RelationTaxID,HT34.RelationIdentifyCardNo,''' + @DivisionID+ ''' as DivisionID,HT34.EmployeeID
, '''' as RetributionID, '''' as  IsReward , '''' as DecisionNo ,
'''' as Rank ,'''' as SuggestedPerson, '''' as Reason , '''' as Form ,
0 as Value , 0 as Value1, 0 as Value2, 0 as Value3, 0 as Value4, 0 as Value5, 0 as Value6, 0 as Value7, 0 as Value8, 0 as Value9, 0 as Value10, 
'''' as RetributeDate , '''' as  WorkEndDate,
'''' as TestFromDate, '''' as TestEndDate, N''Đăng kí PVI'' as PrintStatus, 
'''' as Works, '''' as DivisionIDOld, '''' as DepartmentIDOld,  '''' as TeamIDOld, '''' as DutyIDOld,  
'''' as WorksOld, '''' as Description, '''' as Notes, 4 as Suppress,'''' as Contactor,'''' as FromDate,'''' as ToDate, '''' as DutyNameOld,
'''' as DecideDate,'''' as DecideType,
Case when HT34.RelationID = 1 then N''Con''
when RelationID = 2 then N''Vợ/chồng''
when RelationID = 3 then N''Cha/mẹ''
when RelationID = 4 then N''Khác''
else NULL end as RelationID,HT34.RelationBirthday,HT34.RelationName,0 as InsuranceSalary,0 as allowanceSalary
		From  HT0334 HT34
		left join HV2815 HV15 ON HV15.EmployeeID = HT34.EmployeeID
		Where HT34.DivisionID=  ''' + @DivisionID+ '''  and HT34.EmployeeID=''' + @EmployeeID+ '''
		and ISNULL(IsBHSK,0) = 1
		Order by Suppress
		'

--print @sSQL print @sSQL6 

print @sSQL print @sSQL1 print @sSQL2 print @sSQL3 print @sSQL4
EXEC( @sSQL+@sSQL1+@sSQL2+@sSQL3+@sSQL4+@sSQL5+@sSQL6+@sSQL7+@sSQL8)

	
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

