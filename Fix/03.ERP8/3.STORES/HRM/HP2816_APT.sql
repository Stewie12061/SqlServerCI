IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP2816_APT]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP2816_APT]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



---------Create Date: 23/06/2005
---------Purpose: In thong tin nhan su cua nhan vien
-- Edit by : Hoang Trong Khanh. Sử dụng đa ngôn ngử: @PS_RewardDicipline, @PS_WorkContractType,	@PS_Education 
-- Edit by; Tan Phu, Description; Thêm phần hiển thị thông tin quá trình đào tạo
---- Modified on 12/12/2013 by Le Thi Thu Hien : In chi tiet và in danh sach
---- Modified by Phương Thảo on 22/05/2017: Sửa danh mục dùng chung
---- Modified on 24/11/2016 by Bảo Thy : Bổ sung C11->C150 (MEIKO)
---- Modified on 22/11/2023 by Xuân Nguyên : Bổ sung Trường và thay đổi các mục
---- Modified on 29/11/2023 by Xuân Nguyên : Bổ sung Trường và thay đổi các mục
-- <Example>
---- 
----@RegularTraining,@ServiceTraining,@Candidate,@SupplementatryTraining,@Other 
CREATE PROCEDURE [dbo].[HP2816_APT] 	
				@DivisionID nvarchar(50),			
				@EmployeeID nvarchar(50),	
				@PS_RewardDicipline nvarchar(50),
				@PS_WorkContractType nvarchar(50),
				@PS_Education nvarchar(50),
				@RegularTraining nvarchar(50),  
				@ServiceTraining nvarchar(50),
				@Candidate nvarchar(50), 
				@SupplementatryTraining nvarchar(50), 
				@Other nvarchar(50),
				@StatusID AS TINYINT = 99,
				@FromDepartment AS NVARCHAR(50) = '%',
				@ToDepartment AS NVARCHAR(50) = '%',
				@TeamID AS NVARCHAR(50) = '%',
				@GroupID AS NVARCHAR(50) = 'G1', -- GroupID trong bảng AT8888
				@TypeID AS TINYINT = 10,-- TypeID trong bảng AT8888
				@SQLWhere AS NVARCHAR(4000) = ''
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
		@sWHERE NVARCHAR(MAX),
		@TranMonth NVARCHAR(MAX),
		@TranYear NVARCHAR(MAX)
SET @sWHERE = ''	

select top 1 @TranMonth = TranMonth, @TranYear = TranYear from HT9999 order by TranYear desc,TranMonth desc 

IF @GroupID = 'G01' AND @TypeID = 10
BEGIN

--------------------------------------------------------------------THONG TIN CA NHAN---------------------------------------
Set @sSQL=N'Select HV00.DivisionID,HV00.EmployeeID,HV00.Orders,HV00.LeaveDate,HV00.FullName, HV00.Birthday,HV00.BornPlace ,HV00.IsMale ,HV00.IdentifyCardNo, 
		HV00.IdentifyDate , HV00.IdentifyPlace,HV00.IsSingle,HT00.EmployeeStatus as Status ,HV00.FullAddress , HV00.CityID,HV00.DistrictID ,HV00.PermanentAddress ,
		HV00.TemporaryAddress ,HV00.EthnicID,HV00.EthnicName ,HV00.ReligionID, HV00.ReligionName ,HV00.Notes ,HV00.HealthStatus ,HV00.HomePhone,HV00.HomeFax,
		HV00.MobiPhone ,HV00.Email ,HV00.EducationLevelName ,HV00.Language1ID, HV00.Language2ID ,HV00.Language3ID ,HV00.LanguageLevel1ID,HV00.LanguageLevel2ID ,
		HV00.LanguageLevel3ID  ,HV00.SoInsuranceNo,HV00.SoInsurBeginDate,HV00.HeInsuranceNo, HV00.Hobby,HV00.HospitalID,HV00.SalaryCoefficient,HV00.DutyCoefficient,
		HV00.TimeCoefficient,HV00.DepartmentID,HV00.TeamID ,HV00.DutyID,HV00.DutyName,HV00.TaxObjectID ,HV00.EmployeeStatus,HV00.Experience ,HV00.RecruitDate,
		HV00.RecruitPlace, HV00.WorkDate ,HV00.C01 ,HV00.C02,HV00.C03 ,HV00.C04 ,HV00.C05 ,HV00.C06 ,HV00.C07,HV00.C08 ,HV00.C09 ,HV00.C10 ,
		HV00.BaseSalary ,HV00.InsuranceSalary , HV00.Salary01,HV00.Salary02,HV00.Salary03, convert(varchar(max), cast(HV00.ImageID as varbinary(max)), 1) as ImageID,
		T02.DepartmentName,
		HV00.Target01ID, HV00.Target02ID,HV00.Target03ID, HV00.Target04ID, HV00.Target05ID, HV00.Target06ID, HV00.Target07ID,
		HV00.Target08ID, HV00.Target09ID, HV00.Target10ID, HV00.C11, HV00.C12, HV00.C13, HV00.C15, HV00.C16, HV00.C17, HV00.C14, HV00.C18, HV00.C19, 
		HV00.C20, HV00.C21, HV00.C22, HV00.C23, HV00.C24, HV00.C25,
		T01.C26, T01.C27, T01.C28, T01.C29, T01.C30, T01.C31, T01.C32, T01.C33, T01.C34, T01.C35, 
		T01.C36, T01.C37, T01.C38, T01.C39, T01.C40, T01.C41, T01.C42, T01.C43, T01.C44, T01.C45, 
		T01.C46, T01.C47, T01.C48, T01.C49, T01.C50, T01.C51, T01.C52, T01.C53, T01.C54, T01.C55, 
		T01.C56, T01.C57, T01.C58, T01.C59, T01.C60, T01.C61, T01.C62, T01.C63, T01.C64, T01.C65, 
		T01.C66, T01.C67, T01.C68, T01.C69, T01.C70, T01.C71, T01.C72, T01.C73, T01.C74, T01.C75, 
		T01.C76, T01.C77, T01.C78, T01.C79, T01.C80, T01.C81, T01.C82, T01.C83, T01.C84, T01.C85, 
		T01.C86, T01.C87, T01.C88, T01.C89, T01.C90, T01.C91, T01.C92, T01.C93, T01.C94, T01.C95, 
		T01.C96, T01.C97, T01.C98, T01.C99, T01.C100,T01.C101, T01.C102, T01.C103, T01.C104, T01.C105, 
		T01.C106, T01.C107, T01.C108, T01.C109, T01.C110, T01.C111, T01.C112, T01.C113, T01.C114, T01.C115, T01.C116, T01.C117, 
		T01.C118, T01.C119, T01.C120, T01.C121, T01.C122, T01.C123, T01.C124, T01.C125, T01.C126, T01.C127, T01.C128, T01.C129, 
		T01.C130, T01.C131, T01.C132, T01.C133, T01.C134, T01.C135, T01.C136, T01.C137, T01.C138, T01.C139, T01.C140, T01.C141, 
		T01.C142, T01.C143, T01.C144, T01.C145, T01.C146, T01.C147, T01.C148, T01.C149, T01.C150,
		 HT00.NativeCountry,HT00.CountryID,HT1402.Height,HT1402.Weight,HT1402.ArmyJoinDate,HT1402.ArmyEndDate,
  HT1402.ArmyLevel,HT1402.PersonalTaxID,HT1008.BankName,HT1402.BankAccountNo,HT1008.Address,HT1401.FatherName,HT1401.MotherName,HT1401.SpouseName
 ,HT1401.FatherJob,HT1401.MotherJob,HT1401.SpouseJob,HT1401.FatherAddress,HT1401.MotherAddress,HT1401.SpouseAddress,HT1401.FatherYear,HT1401.MotherYear,HT1401.SpouseYear
 ,'''' as FromPeriod,'''' as ToPeriod,'''' as RelationTaxID,'''' as RelationIdentifyCardNo
'
SET @sSQL6 =N'
		From HV1400 HV00 
		LEFT JOIN HT1403_1 T01 ON HV00.DivisionID=T01.DivisionID and HV00.EmployeeID=T01.EmployeeID
		left join HT1401  ON HT1401.EmployeeID = HV00.EmployeeID
		left join HT1402  ON HT1402.EmployeeID = HV00.EmployeeID
		left join HT1008 on HT1402.BankID = HT1008.BankID
		Left Join AT1102 T02 on HV00.DivisionID=T02.DivisionID and HV00.DepartmentID=T02.DepartmentID
		inner join HT1400 HT00 on HT00.DivisionID = HV00.DivisionID and HV00.EmployeeID = HT00.EmployeeID
		Where HV00.DivisionID=  ''' + @DivisionID+ '''  and HV00.EmployeeID=''' + @EmployeeID+ ''' 
		'
--print @sSQL print @sSQL6 
If exists(Select Top 1 1 From sysObjects Where XType = 'V' and Name = 'HV2815')
	Drop view HV2815
EXEC('Create view HV2815 ---tao boi HP2816
			as ' + @sSQL+@sSQL6)

-------------------------------------------------------------------QUAN HỆ GIA ĐÌNH--------------------------------------------------

Set @sSQL= N' Select HT06.DivisionID, HT06.EmployeeID, '''' as RetributionID, '''' as IsReward , '''' as DecisionNo ,
		'''' as Rank ,'''' as SuggestedPerson, '''' as Reason ,'''' as Form , 
		0 as Value , 0 as Value1, 0 as Value2, 0 as Value3, 0 as Value4, 0 as Value5, 0 as Value6, 0 as Value7, 0 as Value8, 0 as Value9, 0 as Value10, 
		'''' as RetributeDate, 
	 	'''' as WorkEndDate, '''' as TestFromDate, '''' as TestEndDate, N''Quan hệ gia đình''  as PrintStatus,  
		'''' as Works, '''' as DivisionIDOld, '''' as DepartmentIDOld,  '''' as TeamIDOld, '''' as DutyIDOld,  
		'''' as WorksOld, '''' as Description, '''' as Notes, 6 as Suppress,'''' as Contactor,'''' as FromDate,'''' as ToDate, '''' as DutyNameOld,
'''' as DecideDate,'''' as DecideType,
Case when HT06.RelationType = 1 then N''Con''
when RelationType = 2 then N''Vợ/chồng''
when RelationType = 3 then N''Cha/mẹ''
when RelationType = 4 then N''Khác''
else NULL end as RelationID , RelationDate as RelationBirthday,RelationName,0 as InsuranceSalary,0 as allowanceSalary
	From HT1404 HT06
	Where DivisionID=  ''' + @DivisionID+ ''' and EmployeeID= ''' + @EmployeeID + ''' 

	Union 
		Select '''+ @DivisionID+ ''' as DivisionID ,''' + @EmployeeID + ''' as EmployeeID, ''' + ''' as RetributionID, ''' + ''' as  IsReward , ''' + ''' as DecisionNo ,
		''' + ''' as Rank ,''' + ''' as SuggestedPerson, ''' + ''' as Reason , ''' + ''' as Form ,
		0 as Value , 0 as Value1, 0 as Value2, 0 as Value3, 0 as Value4, 0 as Value5, 0 as Value6, 0 as Value7, 0 as Value8, 0 as Value9, 0 as Value10, 
		''' + ''' as RetributeDate , ''' + ''' as  WorkEndDate,
		'''+ ''' as TestFromDate, ''' + N''' as TestEndDate,  N''Quan hệ gia đình'' as PrintStatus, 
		''' + ''' as Works, ''' + ''' as DivisionIDOld, ''' + ''' as DepartmentIDOld,  ''' + ''' as TeamIDOld, '''+ ''' as DutyIDOld,  
		''' + ''' as WorksOld, ''' + ''' as Description, ''' + ''' as Notes, 5 as Suppress ,'''' as Contactor,'''' as FromDate,'''' as ToDate, '''' as DutyNameOld,
'''' as DecideDate,'''' as DecideType, '''' as RelationID,NULL  as RelationBirthday,'''' as RelationName,0 as InsuranceSalary,0 as allowanceSalary'

---------------------------------------------------------------------------QUA TRINH HOC TAP---------------------------------------------------------

Set @sSQL1=N' Union 
		Select HT01.DivisionID ,HT01.EmployeeID, HT01.HistoryID as RetributionID , '''' as IsReward, HT01.SchoolID as DecisionNo , 
			'''' as Rank, HT03.SchoolName as SuggestedPerson ,  HT04.MajorName as Reason,  	
			Case  HT01.TypeID When  1 then N'''+@RegularTraining+'''
						 When  2 then N'''+@ServiceTraining+'''
						 When  3 then N'''+@Candidate+'''
						 When  4 then N'''+@SupplementatryTraining+'''
						 When  9 then N'''+@Other+'''
			         End as Form, 
			0 as Value , 0 as Value1, 0 as Value2, 0 as Value3, 0 as Value4, 0 as Value5, 0 as Value6, 0 as Value7, 0 as Value8, 0 as Value9, 0 as Value10, 
 			cast(HT01.FromMonth as varchar(20))  as RetributeDate,  cast(HT01.FromYear as varchar(20)) as  WorkEndDate,
			cast(HT01.ToMonth as varchar(20)) as TestFromDate, cast(HT01.ToYear as varchar(20)) as TestEndDate,
			 N'''+@PS_Education+''' as PrintStatus, 
			'''' as Works, '''' as DivisionIDOld, '''' as DepartmentIDOld,  '''' as TeamIDOld, '''' as DutyIDOld,  
			'''' as WorksOld, HT01.Description as Description, '''' as Notes, 8 as Suppress		,'''' as Contactor,'''' as FromDate,'''' as ToDate, '''' as DutyNameOld,
'''' as DecideDate,'''' as DecideType, '''' as RelationID,NULL  as RelationBirthday,'''' as RelationName,0 as InsuranceSalary,0 as allowanceSalary
		From HT1301 as HT01 
		Left Join HT1003 HT03 On HT03.SchoolID = HT01.SchoolID AND HT03.DivisionID = HT01.DivisionID
		Left Join HT1004 HT04 On HT04.MajorID = HT01.MajorID AND HT04.DivisionID = HT01.DivisionID
		Where HT01.EmployeeID = '''+@EmployeeID+''' And HT01.DivisionID = ''' + @DivisionID + '''

	Union 
		Select '''+ @DivisionID +''' as DivisionID ,''' +@EmployeeID + ''' as EmployeeID, ''' + ''' as RetributionID, ''' + ''' as  IsReward , ''' + ''' as DecisionNo ,
		''' + ''' as Rank ,''' + ''' as SuggestedPerson, ''' + ''' as Reason , ''' + ''' as Form ,
		0 as Value , 0 as Value1, 0 as Value2, 0 as Value3, 0 as Value4, 0 as Value5, 0 as Value6, 0 as Value7, 0 as Value8, 0 as Value9, 0 as Value10, 
		''' + ''' as RetributeDate , ''' + ''' as  WorkEndDate,
		'''+ ''' as TestFromDate, ''' + N''' as TestEndDate, N''Quá trình học tập'' as PrintStatus, 
		''' + ''' as Works, ''' + ''' as DivisionIDOld, ''' + ''' as DepartmentIDOld,  ''' + ''' as TeamIDOld, '''+ ''' as DutyIDOld,  
		''' + ''' as WorksOld, ''' + ''' as Description, ''' + ''' as Notes,  7 as Suppress,'''' as Contactor,'''' as FromDate,'''' as ToDate, '''' as DutyNameOld,
'''' as DecideDate,'''' as DecideType, '''' as RelationID,NULL  as RelationBirthday,'''' as RelationName,0 as InsuranceSalary,0 as allowanceSalary'

--------------------------------------------------------------------QUA TRINH DAO TAO-----------------------------------------------------------------

Set @sSQL2=N' Union 
 Select HT01.DivisionID ,HT00.EmployeeID, '''' as RetributionID , '''' as IsReward, '''' as DecisionNo , 
	'''' as Rank, '''' as SuggestedPerson , HT01.CourseName as Reason,  	
	'''' AS Form, HT01.Status  as Value,  
	 0 as Value1, 0 as Value2, 0 as Value3, 0 as Value4, 0 as Value5, 0 as Value6, 0 as Value7, 0 as Value8, 0 as Value9, 0 as Value10, 
 	HT1003.SchoolName as RetributeDate, HT1004.MajorName as  WorkEndDate,
	convert(varchar(20), HT01.BeginDate , 103) as TestFromDate,convert(varchar(20), HT01.EndDate , 103) as TestEndDate,
	HT02.Notes as PrintStatus, 
	'''' as Works, '''' as DivisionIDOld, '''' as DepartmentIDOld,  '''' as TeamIDOld, '''' as DutyIDOld,  
	'''' as WorksOld, '''' as Description, '''' as Notes,10 as Suppress,'''' as Contactor,'''' as FromDate,'''' as ToDate, '''' as DutyNameOld,
'''' as DecideDate,'''' as DecideType, '''' as RelationID,NULL  as RelationBirthday,'''' as RelationName,0 as InsuranceSalary,0 as allowanceSalary
From HT1330 as HT01 
inner join HT1331 HT02 on HT01.DivisionID = HT02.DivisionID and HT01.CourseID = HT02.CourseID
inner join HT1400 HT00 on HT02.DivisionID = HT00.DivisionID and HT02.EmployeeID = HT00.EmployeeID
Inner Join HT1003 On HT01.SchoolID=HT1003.SchoolID and HT01.DivisionID=HT1003.DivisionID
Inner Join HT1004 On HT01.MajorID=HT1004.MajorID and HT01.DivisionID=HT1004.DivisionID		
Where HT00.EmployeeID = '''+@EmployeeID+''' And HT00.DivisionID = ''' + @DivisionID + '''
Union 
Select '''+ @DivisionID +''' as DivisionID ,''' +@EmployeeID + ''' as EmployeeID, ''' + ''' as RetributionID, ''' + ''' as  IsReward , ''' + ''' as DecisionNo ,
''' + ''' as Rank ,''' + ''' as SuggestedPerson, ''' + ''' as Reason , ''' + ''' as Form ,
0 as Value , 0 as Value1, 0 as Value2, 0 as Value3, 0 as Value4, 0 as Value5, 0 as Value6, 0 as Value7, 0 as Value8, 0 as Value9, 0 as Value10, 
''' + ''' as RetributeDate , ''' + ''' as  WorkEndDate,
'''+ ''' as TestFromDate, ''' + N''' as TestEndDate, N''Quá trình đào tạo'' as PrintStatus, 
''' + ''' as Works, ''' + ''' as DivisionIDOld, ''' + ''' as DepartmentIDOld,  ''' + ''' as TeamIDOld, '''+ ''' as DutyIDOld,  
''' + ''' as WorksOld, ''' + ''' as Description, ''' + ''' as Notes, 9 as Suppress,'''' as Contactor,'''' as FromDate,'''' as ToDate, '''' as DutyNameOld,
'''' as DecideDate,'''' as DecideType, '''' as RelationID,NULL  as RelationBirthday,'''' as RelationName,0 as InsuranceSalary,0 as allowanceSalary'

--------------------------------------------------------------------QUÁ TRÌNH LÀM VIỆC-----------------------------------------------------------------
----------TRƯỚC KHI GIA NHẬP CÔNG TY---------------------------
Set @sSQL3 = N' Union 
	
Select  T00.DivisionID, T00.EmployeeID, HistoryID as RetributionID , cast( T00.IsPast as varchar(20) ) as IsReward, 
	cast(T00.IsBeforeTranfer as varchar(20)) as DecisionNo, 
case when IsPast = 1 then T00.DivisionName else T01.DivisionName end as Rank,  
case when IsPast = 1  then T00.DepartmentName else T02.DepartmentName end as SuggestedPerson , 
case when IsPast = 1  then T00.TeamName else T03.TeamName end as Reason,
case when IsPast = 1 then T00.DutyName else T04.DutyName end as Form,
IsNull(T00.SalaryAmounts,0)  as Value,
IsNull(T00.SalaryCoefficient,0)   as Value1,  0 as Value2, 0 as Value3, 0 as Value4, 0 as Value5, 0 as Value6, 0 as Value7, 0 as Value8, 0 as Value9, 0 as Value10, 
cast(T00.FromMonth as varchar(20)) as RetributeDate , cast(T00.FromYear as varchar(20)) as WorkEndDate, 
cast(T00.ToMonth as varchar(20)) as TestFromDate , cast(T00.ToYear as varchar(20)) as TestEndDate,  
T00.DutyID as PrintStatus, Works,
T00.DivisionIDOld, T00.DepartmentIDOld,  T00.TeamIDOld, T00.DutyIDOld,  T00.WorksOld, T00.Description, T00.Notes,
12 as Suppress,T00.Contactor,T00.FromDate,T00.ToDate,T05.DutyName as DutyNameOld,
'''' as DecideDate,'''' as DecideType, '''' as RelationID,NULL  as RelationBirthday,'''' as RelationName,0 as InsuranceSalary,0 as allowanceSalary
From HT1302 T00 
left join AT1101 T01 on T00.DivisionID = T01.DivisionID
left join AT1102  T02 on T02.DepartmentID = T00.DepartmentID
left join HT1101 T03 on T03.DivisionID = T00.DivisionID and T03.DepartmentID = T00.DepartmentID and  T03.TeamID = T00.TeamID
left join  HT1102 T04 on T04.DutyID = T00.DutyID AND T04.DivisionID = T00.DivisionID
left join  HT1102 T05 on T05.DutyID = T00.DutyIDOld AND T04.DivisionID = T00.DivisionID
inner join HV1400 V00 on V00.EmployeeID = T00.EmployeeID AND V00.DivisionID = T00.DivisionID
Where T00.EmployeeID= ''' + @EmployeeID+ '''  AND T00.DivisionID = ''' +  @DivisionID + '''
and IsPast = 1
Union 
Select '''+ @DivisionID +''' ,''' +@EmployeeID + ''' as EmployeeID, ''' + ''' as RetributionID, ''' + ''' as  IsReward , ''' + ''' as DecisionNo ,
''' + ''' as Rank ,''' + ''' as SuggestedPerson, ''' + ''' as Reason , ''' + ''' as Form ,
0 as Value , ''0'' as Value1, ''0'' as Value2, ''0'' as Value3, ''0'' as Value4, ''0'' as Value5, ''0'' as Value6, ''0'' as Value7, ''0'' as Value8, ''0'' as Value9, ''0'' as Value10, 
''' + ''' as RetributeDate , ''' + ''' as  WorkEndDate,
'''+ ''' as TestFromDate, ''' + N''' as TestEndDate, N''Trước khi gia nhập công ty'' as PrintStatus, 
''' + ''' as Works, ''' + ''' as DivisionIDOld, ''' + ''' as DepartmentIDOld,  ''' + ''' as TeamIDOld, '''+ ''' as DutyIDOld,  
''' + ''' as WorksOld, ''' + ''' as Description, ''' + ''' as Notes,  11 as Suppress,'''' as Contactor,'''' as FromDate,'''' as ToDate , '''' as DutyNameOld,
'''' as DecideDate,'''' as DecideType, '''' as RelationID,NULL  as RelationBirthday,'''' as RelationName,0 as InsuranceSalary,0 as allowanceSalary'	

----------QUÁ TRÌNH CÔNG TÁC---------------------------
Set @sSQL4 =N' Union 
	
Select  T00.DivisionID, T00.EmployeeID, HistoryID as RetributionID , cast( T00.IsPast as varchar(20) ) as IsReward, 
	cast(T00.IsBeforeTranfer as varchar(20)) as DecisionNo, 
case when IsPast = 1 then T00.DivisionName else T01.DivisionName end as Rank,  
case when IsPast = 1  then T00.DepartmentName else T02.DepartmentName end as SuggestedPerson , 
case when IsPast = 1  then T00.TeamName else T03.TeamName end as Reason,
case when IsPast = 1 then T00.DutyName else T04.DutyName end as Form,
IsNull(T00.SalaryAmounts,0) as Value,
IsNull(T00.SalaryCoefficient,0)  as Value1,  0 as Value2, 0 as Value3, 0 as Value4, 0 as Value5, 0 as Value6, 0 as Value7, 0 as Value8, 0 as Value9, 0 as Value10, 
cast(T00.FromMonth as varchar(20)) as RetributeDate , cast(T00.FromYear as varchar(20)) as WorkEndDate, 
cast(T00.ToMonth as varchar(20)) as TestFromDate , cast(T00.ToYear as varchar(20)) as TestEndDate,  
T00.DutyID as PrintStatus, Works,
T00.DivisionIDOld, T00.DepartmentIDOld,  T00.TeamIDOld, T00.DutyIDOld,  T00.WorksOld, T00.Description, T00.Notes,
14 as Suppress,T00.Contactor,T00.FromDate,T00.ToDate,T05.DutyName as DutyNameOld,
'''' as DecideDate,'''' as DecideType, '''' as RelationID,NULL  as RelationBirthday,'''' as RelationName,0 as InsuranceSalary,0 as allowanceSalary
From HT1302 T00 
left join AT1101 T01 on T00.DivisionID = T01.DivisionID
left join AT1102  T02 on T02.DepartmentID = T00.DepartmentID
left join HT1101 T03 on T03.DivisionID = T00.DivisionID and T03.DepartmentID = T00.DepartmentID and  T03.TeamID = T00.TeamID
left join  HT1102 T04 on T04.DutyID = T00.DutyID AND T04.DivisionID = T00.DivisionID
left join  HT1102 T05 on T05.DutyID = T00.DutyIDOld AND T04.DivisionID = T00.DivisionID
inner join HV1400 V00 on V00.EmployeeID = T00.EmployeeID AND V00.DivisionID = T00.DivisionID
Where T00.EmployeeID= ''' + @EmployeeID+ '''  AND T00.DivisionID = ''' +  @DivisionID + '''
and IsPast = 0
Union 
Select '''+ @DivisionID +''' ,''' +@EmployeeID + ''' as EmployeeID, ''' + ''' as RetributionID, ''' + ''' as  IsReward , ''' + ''' as DecisionNo ,
''' + ''' as Rank ,''' + ''' as SuggestedPerson, ''' + ''' as Reason , ''' + ''' as Form ,
0 as Value , 0 as Value1, 0 as Value2, 0 as Value3, 0 as Value4, 0 as Value5, 0 as Value6, 0 as Value7, 0 as Value8, 0 as Value9, 0 as Value10, 
''' + ''' as RetributeDate , ''' + ''' as  WorkEndDate,
'''+ ''' as TestFromDate, ''' + N''' as TestEndDate, N''Quá trình công tác'' as PrintStatus, 
''' + ''' as Works, ''' + ''' as DivisionIDOld, ''' + ''' as DepartmentIDOld,  ''' + ''' as TeamIDOld, '''+ ''' as DutyIDOld,  
''' + ''' as WorksOld, ''' + ''' as Description, ''' + ''' as Notes,  13 as Suppress,'''' as Contactor,'''' as FromDate,'''' as ToDate , '''' as DutyNameOld,
'''' as DecideDate,'''' as DecideType, '''' as RelationID,NULL  as RelationBirthday,'''' as RelationName,0 as InsuranceSalary,0 as allowanceSalary'		

-------------------------------------------------------------------------HOP DONG LAO DONG------------------------------------------------

Set @sSQL5=N' Union 
		Select  H00.DivisionID,H00.EmployeeID, H00.ContractTypeID as RetributionID,'''' as IsReward, H02.DutyName as DecisionNo,
		H00.ContractNo as Rank, HV01.FullName as SuggestedPerson, ContractTypeName as Reason ,  convert(varchar(20), H00.SignDate , 103) as Form,
		IsNull( H00.BaseSalary,0) as Value,
		IsNull(H00.Salary01,0) as Value1,
		IsNull(H00.Salary02,0) as Value2,
		IsNull(H00.Salary03,0) as Value3,
		IsNull(H00.Salary04,0) as Value4,
		IsNull(H00.Salary05,0) as Value5,
		IsNull(H00.Salary06,0) as Value6,
		IsNull(H00.Salary07,0) as Value7,
		IsNull(H00.Salary08,0) as Value8,
		IsNull(H00.Salary09,0) as Value9,
		IsNull(H00.Salary10,0) as Value10,
		convert(varchar(20), H00.WorkDate , 103) as RetributeDate,
		Convert(varchar(20), WorkEndDate,103) as WorkEndDate, 
		convert(varchar(20), TestFromDate, 103) as TestFromDate, 
		convert(varchar(20), TestEndDate,103) as TestEndDate, N'''+@PS_WorkContractType+''' as PrintStatus, 
		H00.Works as Works, IsNull(convert(varchar(20), H00.Salary02),'''')  as DivisionIDOld,
		IsNull(convert(varchar(20), H00.Salary03),'''') as DepartmentIDOld,  '''' as TeamIDOld, convert(varchar(20), H00.WorkTime) as DutyIDOld,  
		 H00.PayForm as WorksOld, H00.RestRegulation as Description, H00.Notes as Notes, 16 as Suppress	,'''' as Contactor,'''' as FromDate,'''' as ToDate, '''' as DutyNameOld,
'''' as DecideDate,'''' as DecideType, '''' as RelationID,NULL  as RelationBirthday,'''' as RelationName,0 as InsuranceSalary,0 as allowanceSalary
	From HT1360 H00 left join HT1102 H02 on H02.DutyID = H00.DutyID AND H02.DivisionID = H00.DivisionID
	Left join HV1400 HV00 on HV00.EmployeeID= H00.EmployeeID AND HV00.DivisionID= H00.DivisionID
	left join HV1400 HV01 on HV01.EmployeeID=H00.SignPersonID AND HV01.DivisionID=H00.DivisionID
	left join HT1105 HT05 on HT05.ContractTypeID=H00.ContractTypeID AND HT05.DivisionID=H00.DivisionID
	Where H00.DivisionID=  ''' + @DivisionID+ '''  and H00.EmployeeID =  ''' + @EmployeeID+ ''' 

	Union Select '''+ @DivisionID +''' as DivisionID ,''' + @EmployeeID + ''' as EmployeeID, ''' + ''' as RetributionID, ''' + ''' as  IsReward , ''' + ''' as DecisionNo ,
		''' + ''' as Rank ,''' + ''' as SuggestedPerson, ''' + ''' as Reason , ''' + ''' as Form ,
		0 as Value , 0 as Value1, 0 as Value2, 0 as Value3, 0 as Value4, 0 as Value5, 0 as Value6, 0 as Value7, 0 as Value8, 0 as Value9, 0 as Value10, 
		''' + ''' as RetributeDate , ''' + ''' as  WorkEndDate,
		'''+ ''' as TestFromDate, ''' + N''' as TestEndDate, N''Hợp đồng lao động'' as PrintStatus, 
		''' + ''' as Works, ''' + ''' as DivisionIDOld, ''' + ''' as DepartmentIDOld,  ''' + ''' as TeamIDOld, '''+ ''' as DutyIDOld,  
		''' + ''' as WorksOld, ''' + ''' as Description, ''' + ''' as Notes, 15 as Suppress,'''' as Contactor,'''' as FromDate,'''' as ToDate, '''' as DutyNameOld,
'''' as DecideDate,'''' as DecideType, '''' as RelationID,NULL  as RelationBirthday,'''' as RelationName,0 as InsuranceSalary,0 as allowanceSalary
		' 
		
-------------------------------------------------------------------------THU NHẬP TẠI CÔNG CÔNG TY------------------------------------------------

Set @sSQL6=N' Union 
		Select  H00.DivisionID,H00.EmployeeID, '''' as RetributionID,'''' as IsReward, '''' as DecisionNo,
		H02.DutyName as Rank, '''' as SuggestedPerson, '''' as Reason ,  '''' as Form,
		IsNull(H00.BaseSalary,0) as Value,
		IsNull(H00.Salary01,0) as Value1,
		IsNull(H00.Salary02,0) as Value2,
		IsNull(H00.Salary03,0) as Value3,
		0 as Value4,
		0 as Value5,
		0 as Value6,
		0 as Value7,
		0 as Value8,
		0 as Value9,
		0 as Value10,
		cast(H00.TranMonth as varchar(20)) as RetributeDate,
		cast(H00.TranYear as varchar(20)) as WorkEndDate, 
		cast(H00.TranMonth as varchar(20)) as TestFromDate, 
		cast(H00.TranYear as varchar(20)) as TestEndDate, N''Thu nhập tại công ty'' as PrintStatus, 
		'''' as Works, '''' as DivisionIDOld,
		'''' as DepartmentIDOld,  '''' as TeamIDOld, '''' as DutyIDOld,  
		 '''' as WorksOld, '''' as Description, '''' as Notes, 18 as Suppress	,'''' as Contactor,'''' as FromDate,'''' as ToDate, '''' as DutyNameOld,
'''' as DecideDate,'''' as DecideType, '''' as RelationID,NULL  as RelationBirthday,'''' as RelationName,
ISNULL(H00.InsuranceSalary,0) as InsuranceSalary,(
 ISNULL(H00.C01,0) + ISNULL(H00.C02,0) + ISNULL(H00.C03,0) + ISNULL(H00.C04,0) + ISNULL(H00.C05,0) +
 ISNULL(H00.C06,0) + ISNULL(H00.C07,0) + ISNULL(H00.C08,0) + ISNULL(H00.C09,0) + ISNULL(H00.C10,0) +
 ISNULL(H00.C11,0) + ISNULL(H00.C12,0) + ISNULL(H00.C13,0) + ISNULL(H00.C14,0) + ISNULL(H00.C15,0) +
 ISNULL(H00.C16,0) + ISNULL(H00.C17,0) + ISNULL(H00.C18,0) + ISNULL(H00.C19,0) + ISNULL(H00.C20,0) +
 ISNULL(H00.C21,0) + ISNULL(H00.C22,0) + ISNULL(H00.C23,0) + ISNULL(H00.C24,0) + ISNULL(H00.C25,0) +
 ISNULL(HT2499.C26,0) + ISNULL(HT2499.C27,0) + ISNULL(HT2499.C28,0) + ISNULL(HT2499.C29,0) + ISNULL(HT2499.C30,0) 
) as allowanceSalary

	From HT2400 H00 
	Left join HV1400 HV00 on HV00.EmployeeID= H00.EmployeeID AND HV00.DivisionID= H00.DivisionID
	left join HT1102 H02 on H02.DutyID = HV00.DutyID AND H02.DivisionID = H00.DivisionID
	left join HT2499 ON H00.EmpFileID = HT2499.EmpFileID AND HV00.EmployeeID= H00.EmployeeID 
	Where H00.DivisionID=  ''' + @DivisionID+ '''  and H00.EmployeeID =  ''' + @EmployeeID+ ''' 
	AND H00.TranYear=  '''+@TranYear+''' AND H00.TranMonth = '''+@TranMonth+'''

	Union Select '''+ @DivisionID +''' as DivisionID ,''' + @EmployeeID + ''' as EmployeeID, ''' + ''' as RetributionID, ''' + ''' as  IsReward , ''' + ''' as DecisionNo ,
		''' + ''' as Rank ,''' + ''' as SuggestedPerson, ''' + ''' as Reason , ''' + ''' as Form ,
		0 as Value , 0 as Value1, 0 as Value2, 0 as Value3, 0 as Value4, 0 as Value5, 0 as Value6, 0 as Value7, 0 as Value8, 0 as Value9, 0 as Value10, 
		''' + ''' as RetributeDate , ''' + ''' as  WorkEndDate,
		'''+ ''' as TestFromDate, ''' + N''' as TestEndDate, N''Thu nhập tại công ty'' as PrintStatus, 
		''' + ''' as Works, ''' + ''' as DivisionIDOld, ''' + ''' as DepartmentIDOld,  ''' + ''' as TeamIDOld, '''+ ''' as DutyIDOld,  
		''' + ''' as WorksOld, ''' + ''' as Description, ''' + ''' as Notes, 17 as Suppress,'''' as Contactor,'''' as FromDate,'''' as ToDate, '''' as DutyNameOld,
'''' as DecideDate,'''' as DecideType, '''' as RelationID,NULL  as RelationBirthday,'''' as RelationName,
0 as InsuranceSalary,0 as allowanceSalary
		'
--------------------------------------------------------------------QUYẾT ĐỊNH BỔ NHIỆM - MIỄN NHIỆM - ĐIỀU CHỈNH CẤP BẶC-----------------------------------------------------------------

Set @sSQL7=' Union 
Select HT01.DivisionID ,HT01.EmployeeID, '''' as RetributionID , '''' as IsReward, HT01.DecideNo as DecisionNo , 
	'''' as Rank, '''' as SuggestedPerson ,'''' as Reason,  	
	 HT1102.DutyName AS Form,  
	0 as Value , 0 as Value1, 0 as Value2, 0 as Value3, 0 as Value4, 0 as Value5, 0 as Value6, 0 as Value7, 0 as Value8, 0 as Value9, 0 as Value10, 
 	'''' as RetributeDate, '''' as  WorkEndDate,
	'''' as TestFromDate,'''' as TestEndDate,
	HT01.Notes as PrintStatus, 
	'''' as Works, '''' as DivisionIDOld, '''' as DepartmentIDOld,  '''' as TeamIDOld, '''' as DutyIDOld,  
	'''' as WorksOld, '''' as Description,HT01.Notes as Notes,20 as Suppress,'''' as Contactor,'''' as FromDate,'''' as ToDate, '''' as DutyNameOld,
	HT01.DecideDate,HT01.DecideType, '''' as RelationID , NULL  as RelationBirthday,'''' as RelationName,0 as InsuranceSalary,0 as allowanceSalary
From HT0362 as HT01 	
left join HT1102 ON HT1102.DutyID = HT01.DutyID
Where HT01.EmployeeID = '''+@EmployeeID+''' And HT01.DivisionID = ''' + @DivisionID + '''
Union 
Select '''+ @DivisionID +''' as DivisionID ,''' +@EmployeeID + ''' as EmployeeID, ''' + ''' as RetributionID, ''' + ''' as  IsReward , ''' + ''' as DecisionNo ,
''' + ''' as Rank ,''' + ''' as SuggestedPerson, ''' + ''' as Reason , ''' + ''' as Form ,
0 as Value , 0 as Value1, 0 as Value2, 0 as Value3, 0 as Value4, 0 as Value5, 0 as Value6, 0 as Value7, 0 as Value8, 0 as Value9, 0 as Value10, 
''' + ''' as RetributeDate , ''' + ''' as  WorkEndDate,
'''+ ''' as TestFromDate, ''' + ''' as TestEndDate, ''' + ''' as PrintStatus, 
''' + ''' as Works, ''' + ''' as DivisionIDOld, ''' + ''' as DepartmentIDOld,  ''' + ''' as TeamIDOld, '''+ ''' as DutyIDOld,  
''' + ''' as WorksOld, ''' + ''' as Description, ''' + ''' as Notes, 19 as Suppress ,'''' as Contactor,'''' as FromDate,'''' as ToDate, '''' as DutyNameOld,
'''' as DecideDate,'''' as DecideType, '''' as RelationID,NULL as RelationBirthday,'''' as RelationName,0 as InsuranceSalary,0 as allowanceSalary '



-------------------------------------------------------------------KHEN THUONG KY LUAT--------------------------------------------------

Set @sSQL8= ' Union

Select HT06.DivisionID, HT06.EmployeeID, HT06.RetributionID, cast(HT06.IsReward as varchar(20)) as IsReward , HT06.DecisionNo ,
		HT06.Rank ,HT06.SuggestedPerson, HT06.Reason ,HT06.Form , HT06.Value as Value , 
		 0 as Value1, 0 as Value2, 0 as Value3, 0 as Value4, 0 as Value5, 0 as Value6, 0 as Value7, 0 as Value8, 0 as Value9, 0 as Value10, 
		convert(varchar(20), HT06.RetributeDate, 103) as RetributeDate, 
	 	'''' as WorkEndDate, '''' as TestFromDate, '''' as TestEndDate, N'''+@PS_RewardDicipline+'''  as PrintStatus,  
		'''' as Works, '''' as DivisionIDOld, '''' as DepartmentIDOld,  '''' as TeamIDOld, '''' as DutyIDOld,  
		'''' as WorksOld, HT1108.Description as Description, '''' as Notes, 22 as Suppress,'''' as Contactor,'''' as FromDate,'''' as ToDate, '''' as DutyNameOld,
'''' as DecideDate,'''' as DecideType, '''' as RelationID,NULL  as RelationBirthday,'''' as RelationName,0 as InsuranceSalary,0 as allowanceSalary
	From HT1406 HT06
	left join HT1108 ON HT1108.FormID = HT06.FormID
	Where HT06.DivisionID=  ''' + @DivisionID+ ''' and EmployeeID= ''' + @EmployeeID + ''' 

	Union 
		Select '''+ @DivisionID+ ''' as DivisionID ,''' + @EmployeeID + ''' as EmployeeID, ''' + ''' as RetributionID, ''' + ''' as  IsReward , ''' + ''' as DecisionNo ,
		''' + ''' as Rank ,''' + ''' as SuggestedPerson, ''' + ''' as Reason , ''' + ''' as Form ,
		0 as Value , 0 as Value1, 0 as Value2, 0 as Value3, 0 as Value4, 0 as Value5, 0 as Value6, 0 as Value7, 0 as Value8, 0 as Value9, 0 as Value10, 
		''' + ''' as RetributeDate , ''' + ''' as  WorkEndDate,
		'''+ ''' as TestFromDate, ''' + ''' as TestEndDate, ''' + ''' as PrintStatus, 
		''' + ''' as Works, ''' + ''' as DivisionIDOld, ''' + ''' as DepartmentIDOld,  ''' + ''' as TeamIDOld, '''+ ''' as DutyIDOld,  
		''' + ''' as WorksOld, ''' + ''' as Description, ''' + ''' as Notes, 21 as Suppress ,'''' as Contactor,'''' as FromDate,'''' as ToDate, '''' as DutyNameOld,
'''' as DecideDate,'''' as DecideType, '''' as RelationID,NULL  as RelationBirthday,'''' as RelationName,0 as InsuranceSalary,0 as allowanceSalary'




print @sSQL print @sSQL1 print @sSQL2 print @sSQL3 print @sSQL4 print @sSQL5 print @sSQL6 print @sSQL7 print @sSQL8

IF EXISTS(SELECT TOP 1 1 FROM SYSOBJECTS WHERE XTYPE = 'V' AND NAME = 'HV2820')
	DROP VIEW HV2820
EXEC(N'CREATE VIEW HV2820 ---tao boi HP2816
			as ' + @sSQL + @sSQL1 + @sSQL2 + @sSQL3 + @sSQL4 + @sSQL5 + @sSQL6 + @sSQL7 +@sSQL8)

--EXEC HP2818 @DivisionID,@EmployeeID,@GroupID,@TypeID
	
END
ELSE
BEGIN
	IF  @StatusID <> 99
		SET @sWHERE = '	
		AND StatusID = '+STR(@StatusID)+' 		'
	IF @FromDepartment <> '' AND @FromDepartment <> '%' AND @ToDepartment <> '' AND @ToDepartment <> '%'
		SET @sWHERE = @sWHERE +'	
		AND DepartmentID >= '''+@FromDepartment+''' 
		AND	DepartmentID >= '''+@ToDepartment+''' 	'
	IF @TeamID <> '' AND @TeamID <> '%'
		SET @sWHERE = @sWHERE +'	
		AND TeamID  >= '''+@TeamID+'''  '
		
	SET @sSQL = '
	SELECT * FROM HV1400 
	WHERE DivisionID = '''+@DivisionID+''' '
	
	--PRINT(@sSQL)
	--PRINT(@sWHERE)
	--PRINT(@SQLWhere)
	
	EXEC (@sSQL + @sWHERE+ @SQLWhere)
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

