IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP1402]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP1402]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---Created by: Vo Thanh Huong, date: 06/03/2006
---Purpose:XU ly so lieu in ho so nhan vien
---Edit by : Dang Le Bao Quynh; Date: 29/0/2006
---Purpose: Sua dieu kien tu phong ban den phong ban
---Edit by: Dang Le Bao Quynh; Date: 06/10/2007
---Purpose: Don gian hoa viec tao view
/***************************************************************
'* Edited by : [GS] [Quoc Cuong] [30/07/2010]
'**************************************************************/
---- Modified on 04/01/2013 by Lê Thị Thu Hiền : Bổ sung thêm strDivisionID
---- Modified on 30/09/2014 by Bảo Anh : Bổ sung in danh sách nghỉ việc và tạm nghỉ
---- Modified on 29/03/2016 by Kim Vu: Bo sung in danh sach tat ca trang thai
---- Modified on 23/11/2016 by Bảo Thy: Bổ sung C26 -> C150 (MEIKO)
---- Modified on 17/01/2019 by Bảo Anh: Bổ sung store customize cho APT
---- EXEC [HP1402] 'MK', '2016-10-01', '2016-10-31', 'A000000', 'C000000', NULL, 1, 'MK'

CREATE PROCEDURE [dbo].[HP1402] 
		@DivisionID nvarchar(50),
		@FromDate datetime,
		@ToDate datetime,
		@FromDepartmentID nvarchar(50),
		@ToDepartmentID nvarchar(50),
		@TeamID nvarchar(50),
		@EmployeeStatus NVARCHAR(50),
		@StrDivisionID AS NVARCHAR(4000) = ''
 AS
DECLARE @sSQL nvarchar(4000)

DECLARE @StrDivisionID_New AS NVARCHAR(4000),
		@CustomerIndex INT

SELECT @CustomerIndex = CustomerName From CustomerIndex

IF @CustomerIndex = 27	--- APT
BEGIN
	EXEC HP1402_APT @DivisionID, @FromDate, @ToDate, @FromDepartmentID, @ToDepartmentID, @TeamID, @EmployeeStatus, @StrDivisionID
	return
END

SET @StrDivisionID_New = ''		

IF ISNULL(@StrDivisionID,'') <> ''
	SELECT @StrDivisionID_New = CASE WHEN @StrDivisionID = '%' THEN ' LIKE ''' + 
	@StrDivisionID + '''' ELSE ' IN (''' + replace(@StrDivisionID, ',',''',''') + ''')' END
ELSE
	SELECT @StrDivisionID_New = CASE WHEN @DivisionID = '%' THEN ' LIKE ''' + 
	@DivisionID + '''' ELSE ' IN (''' + replace(@DivisionID, ',',''',''')+ ''')' END
	

/* Rem by : Dang Le Bao Quynh
If Exists (Select * From sysobjects Where name = 'HT1444' and xtype ='U') 
	Drop Table HT1444

Select * Into HT1444  From HV1400

Set @sSQL = '
Select 		HV1400.DivisionID, 
		HV1400.EmployeeID, 
		HV1400.Orders, 
		HV1400.S1, 
		HV1400.S2, 
		HV1400.S3, 
		HV1400.FullName, 
		HV1400.LastName, 
		HV1400.MiddleName, 
		HV1400.FirstName, 
		HV1400.ShortName, 
		HV1400.Alias, 
		HV1400.Birthday, 
		HV1400.BornPlace, 
		HV1400.IsMale, 
		HV1400.NativeCountry, 
		HV1400.PassportNo, 
		HV1400.PassportDate, 
		HV1400.PassportEnd, 
		HV1400.IdentifyCardNo, 
		HV1400.IdentifyDate, 
		HV1400.IdentifyPlace, 
		HV1400.IsSingle, 
		HV1400.Status, 
		HV1400.ImageID, 
		HV1400.CountryID, 
		HV1400.FullAddress, 
		HV1400.CityID, 
		HV1400.DistrictID, 
		HV1400.PermanentAddress, 
		HV1400.TemporaryAddress, 
		HV1400.EthnicID, 
		HV1400.EthnicName, 
		HV1400.ReligionID, 
		HV1400.ReligionName, 
		HV1400.Notes, 
		HV1400.HealthStatus, 
		HV1400.HomePhone,
		HV1400.HomeFax, 
		HV1400.MobiPhone, 
		HV1400.Email, 		
		HV1400.IsOtherDayPerMonth, 
		HV1400.IsMaleID, 
		HV1400.IsSingleID, 
		HV1400.IsForeigner, 
		HV1400.RecruitTimeID, 
		HV1400.FatherName, 
		HV1400.FatherYear, 
		HV1400.FatherJob, 
		HV1400.FatherAddress, 
		HV1400.FatherNote, 
		HV1400.IsFatherDeath, 
		HV1400.MotherName, 
		HV1400.MotherYear, 
		HV1400.MotherJob, 
		HV1400.MotherAddress, 
		HV1400.MotherNote, 
		HV1400.IsMotherDeath, 
		HV1400.SpouseName, 
		HV1400.SpouseYear, 
		HV1400.SpouseAddress, 
		HV1400.SpouseNote, 
		HV1400.SpouseJob, 
		HV1400.IsSpouseDeath, 
		HV1400.EducationLevelID, 
		HV1400.EducationLevelName, 
		HV1400.PoliticsID, 
		HV1400.Language1ID, 
		HV1400.Language2ID, 
		HV1400.Language3ID, 
		HV1400.LanguageLevel1ID, 
		HV1400.LanguageLevel2ID, 
		HV1400.LanguageLevel3ID, 
		HV1400.BankID, 
		HV1400.BankAccountNo, 
		HV1400.SoInsuranceNo, 
		HV1400.SoInsurBeginDate, 
		HV1400.HeInsuranceNo, 
		HV1400.ArmyJoinDate, 
		HV1400.ArmyEndDate, 
		HV1400.ArmyLevel, 
		HV1400.Hobby, 
		HV1400.HospitalID, 
		HV1400.Height, 
		HV1400.Weight, 
		HV1400.BloodGroup, 
		HV1400.SalaryCoefficient, 
		HV1400.DutyCoefficient, 
		HV1400.TimeCoefficient, 
		HV1400.DepartmentID, 
		HV1400.DepartmentName, 
		HV1400.DutyID, 
		HV1400.DutyName, 
		HV1400.TaxObjectID, 
		HV1400.EmployeeStatus, 
		HV1400.Experience, 
		HV1400.SuggestSalary, 
		HV1400.RecruitDate, 
		HV1400.RecruitPlace, 
		HV1400.WorkDate, 
		HV1400.LeaveDate, 
		HV1400.C01, 
		HV1400.C02, 
		HV1400.C03, 
		HV1400.C04, 
		HV1400.C05, 
		HV1400.C06, 
		HV1400.C07, 
		HV1400.C08, 
		HV1400.C09, 
		HV1400.C10, 
		HV1400.BaseSalary, 
		HV1400.InsuranceSalary, 
		HV1400.Salary01, 
		HV1400.Salary02, 
		HV1400.Salary03, 
		HV1400.Target01ID, 
		HV1400.Target02ID, 
		HV1400.Target03ID, 
		HV1400.Target04ID, 
		HV1400.Target05ID, 
		HV1400.Target06ID, 
		HV1400.Target07ID, 
		HV1400.Target08ID, 
		HV1400.Target09ID, 
		HV1400.Target10ID, 
		HV1400.TargetAmount01, 
		HV1400.TargetAmount02, 
		HV1400.TargetAmount03, 
		HV1400.TargetAmount04, 
		HV1400.TargetAmount05, 
		HV1400.TargetAmount06, 
		HV1400.TargetAmount07, 
		HV1400.TargetAmount08, 
		HV1400.TargetAmount09, 
		HV1400.TargetAmount10, 
		HV1400.LoaCondID, 
		HV1400.ApplyDate, 
		HV1400.BeginProbationDate, 
		HV1400.EndProbationDate, 
		HV1400.ProbationNote, 
		HV1400.FileID,
		HV1400.AssociationID,
		HT1302.TeamID, 
		HT1101.TeamName,
		HT1302.FromDate,
		HT1302.ToDate

From HT1444 HV1400
 inner join HT1302 on HV1400.EmployeeID=HT1302.EmployeeID
 inner join HT1101 on HT1302.TeamID=HT1101.TeamID

Where HV1400.DivisionID = ''' + @DivisionID + ''' and 
	(HV1400.DepartmentID between ''' + @FromDepartmentID + ''' and ''' + 	@ToDepartmentID + ''' or
	 HV1400.DepartmentID between ''' + @ToDepartmentID + ''' and ''' + 	@FromDepartmentID + ''') and 
	isnull(HT1302.TeamID,'''') like ''' + isnull(@TeamID, '') + ''' and 
	HV1400.EmployeeStatus = ' + cast(@EmployeeStatus as nvarchar(50)) 
*/
--print @sSQL
IF @EmployeeStatus <> '3' and @EmployeeStatus <> '9'
BEGIN
	Set @sSQL = ' 
		SELECT	HV1400.* ,
				HT1403_1.C26, HT1403_1.C27, HT1403_1.C28, HT1403_1.C29, HT1403_1.C30, HT1403_1.C31, HT1403_1.C32, 
				HT1403_1.C33, HT1403_1.C34, HT1403_1.C35, HT1403_1.C36, HT1403_1.C37, HT1403_1.C38, HT1403_1.C39, 
				HT1403_1.C40, HT1403_1.C41, HT1403_1.C42, HT1403_1.C43, HT1403_1.C44, HT1403_1.C45, HT1403_1.C46, 
				HT1403_1.C47, HT1403_1.C48, HT1403_1.C49, HT1403_1.C50, HT1403_1.C51, HT1403_1.C52, HT1403_1.C53, 
				HT1403_1.C54, HT1403_1.C55, HT1403_1.C56, HT1403_1.C57, HT1403_1.C58, HT1403_1.C59, HT1403_1.C60, 
				HT1403_1.C61, HT1403_1.C62, HT1403_1.C63, HT1403_1.C64, HT1403_1.C65, HT1403_1.C66, HT1403_1.C67, 
				HT1403_1.C68, HT1403_1.C69, HT1403_1.C70, HT1403_1.C71, HT1403_1.C72, HT1403_1.C73, HT1403_1.C74, 
				HT1403_1.C75, HT1403_1.C76, HT1403_1.C77, HT1403_1.C78, HT1403_1.C79, HT1403_1.C80, HT1403_1.C81, 
				HT1403_1.C82, HT1403_1.C83, HT1403_1.C84, HT1403_1.C85, HT1403_1.C86, HT1403_1.C87, HT1403_1.C88, 
				HT1403_1.C89, HT1403_1.C90, HT1403_1.C91, HT1403_1.C92, HT1403_1.C93, HT1403_1.C94, HT1403_1.C95, 
				HT1403_1.C96, HT1403_1.C97, HT1403_1.C98, HT1403_1.C99, HT1403_1.C100, HT1403_1.C101, HT1403_1.C102, HT1403_1.C103, HT1403_1.C104, 
				HT1403_1.C105, HT1403_1.C106, HT1403_1.C107, HT1403_1.C108, HT1403_1.C109, HT1403_1.C110, HT1403_1.C111, HT1403_1.C112, HT1403_1.C113, 
				HT1403_1.C114, HT1403_1.C115, HT1403_1.C116, HT1403_1.C117, HT1403_1.C118, HT1403_1.C119, HT1403_1.C120, HT1403_1.C121, HT1403_1.C122, 
				HT1403_1.C123, HT1403_1.C124, HT1403_1.C125, HT1403_1.C126, HT1403_1.C127, HT1403_1.C128, HT1403_1.C129, HT1403_1.C130, HT1403_1.C131, HT1403_1.C132, 
				HT1403_1.C133, HT1403_1.C134, HT1403_1.C135, HT1403_1.C136, HT1403_1.C137, HT1403_1.C138, HT1403_1.C139, HT1403_1.C140, HT1403_1.C141, HT1403_1.C142, 
				HT1403_1.C143, HT1403_1.C144, HT1403_1.C145, HT1403_1.C146, HT1403_1.C147, HT1403_1.C148, HT1403_1.C149, HT1403_1.C150
		FROM	HV1400
		LEFT JOIN HT1403_1 ON HV1400.EmployeeID = HT1403_1.EmployeeID AND HV1400.DivisionID = HT1403_1.DivisionID
		WHERE	HV1400.DivisionID '+@StrDivisionID_New+' and 
				(HV1400.DepartmentID between ''' + @FromDepartmentID + ''' and ''' + 	@ToDepartmentID + ''' or
		 		HV1400.DepartmentID between ''' + @ToDepartmentID + ''' and ''' + 	@FromDepartmentID + ''') and 
				isnull(HV1400.TeamID,'''') like ''' + isnull(@TeamID, '') + ''' and 
				HV1400.EmployeeStatus like ''' + isnull(@EmployeeStatus,'') + ''''
/*
	IF EXISTS(SELECT TOP 1 1 FROM SYSOBJECTS WHERE XTYPE = 'V' AND NAME = 'HV1402')
		DROP VIEW HV1402

	EXEC('CREATE VIEW HV1402   ---tao boi HP1402
			AS ' + @sSQL)
*/
END
ELSE	--- Trả ra view in danh sách nghỉ việc và tạm nghỉ
BEGIN
	Set @sSQL = ' 
	SELECT	HT80.EmployeeID, HT80.DecidingNo, HT80.DecidingDate, HT80.WorkDate, HT80.LeaveDate, HT80.Notes,
			HV1400.FullName, HT1107.QuitJobName, V14.FullName as DecidingPerson
	FROM	HT1380 HT80
	INNER JOIN HV1400 On HT80.DivisionID = HV1400.DivisionID And HT80.EmployeeID = HV1400.EmployeeID
	INNER JOIN HV1400 V14 On HT80.DivisionID = V14.DivisionID And HT80.DecidingPerson = V14.EmployeeID
	INNER JOIN HT1107 On HT80.DivisionID = HT1107.DivisionID And HT80.QuitJobID = HT1107.QuitJobID
	WHERE	HT80.DivisionID '+@StrDivisionID_New+' and 
			(HV1400.DepartmentID between ''' + @FromDepartmentID + ''' and ''' + 	@ToDepartmentID + ''') and 
			isnull(HV1400.TeamID,'''') like ''' + isnull(@TeamID, '') + ''' and
			(convert(nvarchar(20),HT80.LeaveDate,101) between ''' + convert(nvarchar(20),@FromDate,101) + ''' and ''' + convert(nvarchar(20),@ToDate,101) + ''') 
	'
	IF @EmployeeStatus = '9' --- nghỉ việc
		Set @sSQL = @sSQL + ' AND Isnull(HT80.IsBreaking,0) = 0'
	ELSE --- tạm nghỉ
		Set @sSQL = @sSQL + ' AND Isnull(HT80.IsBreaking,0) = 1'
	/*	
	IF EXISTS(SELECT TOP 1 1 FROM SYSOBJECTS WHERE XTYPE = 'V' AND NAME = 'HV1412')
		DROP VIEW HV1412

	EXEC('CREATE VIEW HV1412   ---tao boi HP1402
			AS ' + @sSQL)
	*/
END
--PRINT(@sSQL)
EXEC(@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
