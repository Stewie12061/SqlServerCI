IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP2815]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP2815]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



---------Create Date: 23/06/2005
---------Purpose: In thong tin nhan su cua nhan vien
/**********************************************
** Edited by: [GS] [Cẩm Loan] [02/08/2010]
***********************************************/
---- Modified by Phương Thảo on 22/05/2017: Sửa danh mục dùng chung
----- Modified by Bảo Thy on 24/11/2016: Bổ sung C11->C150 (MEIKO)


CREATE PROCEDURE [dbo].[HP2815] 	@DivisionID nvarchar(50),				
				@EmployeeID nvarchar(50)			
AS
DECLARE @sSQL nvarchar(4000),
		@CustomerIndex INT

SELECT @CustomerIndex = CustomerName From CustomerIndex		

--------------------------------------------------------------------THONG TIN CA NHAN---------------------------------------
Set @sSQL='Select HV00.DivisionID,HV00.EmployeeID,HV00.Orders,HV00.LeaveDate,HV00.FullName ,
		HV00.Birthday,HV00.BornPlace ,HV00.IsMale ,HV00.IdentifyCardNo,HV00.IdentifyDate,
		HV00.IdentifyPlace,HV00.IsSingle,HV00.Status ,HV00.FullAddress , HV00.CityID,HV00.DistrictID ,HV00.PermanentAddress ,
		HV00.TemporaryAddress ,HV00.EthnicID,HV00.EthnicName ,HV00.ReligionID,   
		HV00.ReligionName ,HV00.Notes ,HV00.HealthStatus ,HV00.HomePhone,HV00.HomeFax, HV00.MobiPhone ,HV00.Email ,HV00.EducationLevelName ,
		HV00.Language1ID, HV00.Language2ID ,HV00.Language3ID ,HV00.LanguageLevel1ID,HV00.LanguageLevel2ID , HV00.LanguageLevel3ID  ,HV00.SoInsuranceNo,HV00.SoInsurBeginDate,HV00.HeInsuranceNo,
		HV00.Hobby,HV00.HospitalID,HV00.SalaryCoefficient,HV00.DutyCoefficient, HV00.TimeCoefficient,HV00.DepartmentID,HV00.TeamID ,HV00.DutyID,HV00.DutyName ,
		HV00.TaxObjectID ,HV00.EmployeeStatus,HV00.Experience ,HV00.RecruitDate,HV00.RecruitPlace, HV00.BaseSalary, HV00.InsuranceSalary,
		HV00.WorkDate ,HV00.C01 ,HV00.C02,HV00.C03 ,HV00.C04 ,HV00.C05 ,HV00.C06 ,HV00.C07, HV00.C08 ,HV00.C09 ,HV00.C10 ,
		HV00.Salary01,HV00.Salary02,HV00.Salary03,HV00.ImageID,T02.DepartmentName, 0 as PrintStatus,
		HV00.C11, HV00.C12, HV00.C13, HV00.C15, HV00.C16, HV00.C17, HV00.C14, HV00.C18, HV00.C19, 
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
		T01.C142, T01.C143, T01.C144, T01.C145, T01.C146, T01.C147, T01.C148, T01.C149, T01.C150
		From HV1400 HV00 
		LEFT JOIN HT1403_1 T01 ON HV00.DivisionID=T01.DivisionID and HV00.EmployeeID=T01.EmployeeID
		Left Join AT1102 T02 on HV00.DivisionID=T02.DivisionID and HV00.DepartmentID=T02.DepartmentID
		Where HV00.DivisionID=  ''' + @DivisionID+ '''  and HV00.EmployeeID=''' + @EmployeeID+ ''' '

If exists(Select Top 1 1 From sysObjects Where XType = 'V' and Name = 'HV2815')
	Drop view HV2815
EXEC('Create view HV2815 ---tao boi HP2815
			as ' + @sSQL)
--print @sSQL
-------------------------------------------------------------------KHEN THUONG KY LUAT--------------------------------------------------

Set @sSQL= 'Select DISTINCT HT06.DivisionID, HT06.DepartmentID,HT06.TeamID, HT06.EmployeeID, HT06.RetributionID,HT06.IsReward ,HT06.DecisionNo ,
		HT06.RetributeDate ,HT06.Rank ,HT06.SuggestedPerson, HT06.Reason ,HT06.Form ,HT06.Value ,HT06.DutyID As Promotion,
		1 as PrintStatus
	From HT1406 HT06
	Where DivisionID=  ''' + @DivisionID+ ''' and EmployeeID= ''' + @EmployeeID + ''' '

If exists(Select Top 1 1 From sysObjects Where XType = 'V' and Name = 'HV2816')
	Drop view HV2816
EXEC('Create view HV2816 ---tao boi HP2815
			as ' + @sSQL)

---------------------------------------------------------------------QUA TRINH CONG TAC------------------------------------------

Set @sSQL = 'Select DISTINCT HistoryID,  T00.DivisionID, T00.DepartmentID, T00.TeamID, T00.EmployeeID, T00.IsPast, T00.IsBeforeTranfer, 
	T00.FromMonth, T00.FromYear, T00.ToMonth, T00.ToYear,  T00.DutyID, Works, 
	case when IsPast = 1 then T00.DivisionName else T01.DivisionName end as DivisionName,  
	case when IsPast = 1  then T00.DepartmentName else T02.DepartmentName end as DepartmentName, 
	case when IsPast = 1  then T00.TeamName else T03.TeamName end as TeamName,
	case when IsPast = 1 then T00.DutyName else T04.DutyName end as DutyName,
	T00.SalaryAmounts, T00.SalaryCoefficient, T00.Description, T00.Notes, 
	T00.DivisionIDOld, T00.DepartmentIDOld, T00.TeamIDOld, T00.DutyIDOld,  T00.WorksOld, T00.ContactTelephone,
	T00.Contactor, T00.ContactAddress, 2 as PrintStatus
From HT1302 T00 
left join AT1101 T01 on T00.DivisionID = T01.DivisionID
left join AT1102  T02 on T02.DepartmentID = T00.DepartmentID
left join HT1101 T03 on T03.DivisionID = T00.DivisionID and T03.DepartmentID = T00.DepartmentID and  T03.TeamID = T00.TeamID
left join  HT1102 T04 on T04.DutyID = T00.DutyName and T04.DivisionID = T00.DivisionID 
inner join HV1400 V00 on V00.EmployeeID = T00.EmployeeID AND V00.DivisionID = T00.DivisionID
Where T00.EmployeeID= ''' + @EmployeeID+ ''' AND T00.DivisionID = ''' + @DivisionID + ''''

if exists(Select Top 1 1 From sysObjects Where XType = 'V' and Name = 'HV2817')
	Drop view HV2817
EXEC('Create view HV2817 ---tao boi HP2815
			as ' + @sSQL)

-------------------------------------------------------------------------HOP DONG LAO DONG------------------------------------------------

Set @sSQL=' Select H00.*,H02.DutyName,HV00.FullName, HV01.FullName as SignPersonName,ContractTypeName , 3 as PrintStatus
	From HT1360 H00 left join HT1102 H02 on H02.DutyID = H00.DutyID AND H02.DivisionID = H00.DivisionID
		Left join HV1400 HV00 on HV00.EmployeeID= H00.EmployeeID AND HV00.DivisionID= H00.DivisionID
		left join HV1400 HV01 on HV01.EmployeeID=H00.SignPersonID AND HV01.DivisionID=H00.DivisionID 
		left join HT1105 HT05 on HT05.ContractTypeID=H00.ContractTypeID AND HT05.DivisionID=H00.DivisionID
		Where H00.DivisionID=  ''' + @DivisionID+ '''  and H00.EmployeeID =  ''' + @EmployeeID+ ''' '

if exists(Select Top 1 1 From sysObjects Where XType = 'V' and Name = 'HV2818')
	Drop view HV2818
EXEC('Create view HV2818 ---tao boi HP2815
			as ' + @sSQL)



---------------------------------------------------------------------------QUA TRINH HOC TAP---------------------------------------------------------

Set @sSQL='Select HT01.DivisionID, HT01.EmployeeID, HT01.HistoryID, 
		HT01.SchoolID, HT03.SchoolName,
		HT01.MajorID, HT04.MajorName, 
		TypeName = Case  HT01.TypeID When  1 then ''Chính quy taäp chung''
						 When  2 then ''Taïi chöùc''
						 When  3 then ''Cöû tuyeån''
						 When  4 then ''Boå tuùc''
						 When  9 then ''Khaùc''
			         End,
		HT01.FromMonth, HT01.FromYear,
		HT01.ToMonth,HT01.ToYear,
  		HT01.Description, HT01.Notes, 4 as PrintStatus
From HT1301 as HT01 
		Left Join HT1003 HT03 On HT03.SchoolID = HT01.SchoolID AND HT03.DivisionID = HT01.DivisionID
		Left Join HT1004 HT04 On HT04.MajorID = HT01.MajorID AND HT04.DivisionID = HT01.DivisionID
Where HT01.EmployeeID = '''+@EmployeeID+''' AND HT01.DivisionID = ''' + @DivisionID + ''''

if exists(Select Top 1 1 From sysObjects Where XType = 'V' and Name = 'HV2819')
	Drop view HV2819
EXEC('Create view HV2819 ---tao boi HP2815
			as ' + @sSQL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
