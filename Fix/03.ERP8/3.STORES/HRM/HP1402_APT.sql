IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP1402_APT]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP1402_APT]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Trả dữ liệu xuất excel cho mẫu HR1407_APT của APT
-- <Param>
----  
-- <Return>
---- 
-- <Reference> HRM/ Nghiệp vụ
---- Kết quả thử việc
-- <History>
---- Create on 11/01/2019 by Bảo Anh 
---- Modified on
---- Modified on 01/12/2033 Xuân Nguyên : Bỏ join các cột C26-C150 do trong HV1400 đã có rồi và bổ sung các cột dữ liệu
---- Modified on 19/12/2033 Xuân Nguyên : Bổ sung order by DepartmentID
---- EXEC [HP1402_APT] 'MK', '2016-10-01', '2016-10-31', 'A000000', 'C000000', NULL, 1, 'MK'

CREATE PROCEDURE [dbo].[HP1402_APT] 
		@DivisionID nvarchar(50),
		@FromDate datetime,
		@ToDate datetime,
		@FromDepartmentID nvarchar(50),
		@ToDepartmentID nvarchar(50),
		@TeamID nvarchar(50),
		@EmployeeStatus NVARCHAR(50),
		@StrDivisionID AS NVARCHAR(4000) = ''
 AS
DECLARE @sSQL nvarchar(max),
		@sSQL1 varchar(max)

DECLARE @StrDivisionID_New AS NVARCHAR(4000),
		@CustomerIndex INT

SELECT @CustomerIndex = CustomerName From CustomerIndex

SET @StrDivisionID_New = ''		
SET @sSQL = ''
SET @sSQL1 = ''

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
		WITH TEMP
		AS
		(
		SELECT	HV1400.* ,
				(SELECT TOP 1 ContractNo FROM HT1360 WITH (NOLOCK) WHERE DivisionID = HV1400.DivisionID AND EmployeeID = HV1400.EmployeeID Order by SignDate DESC) AS LastContractNo,
				(SELECT TOP 1 ContractNo FROM HT1360 WITH (NOLOCK) WHERE DivisionID = HV1400.DivisionID AND EmployeeID = HV1400.EmployeeID Order by SignDate) AS BeginContractNo,
				
				(SELECT TOP 1 ContractNo FROM HT1360 WITH (NOLOCK) WHERE DivisionID = HV1400.DivisionID AND EmployeeID = HV1400.EmployeeID
					AND SignDate > (SELECT TOP 1 SignDate FROM HT1360 WITH (NOLOCK) WHERE DivisionID = HV1400.DivisionID AND EmployeeID = HV1400.EmployeeID Order by SignDate)
					ORDER BY SignDate
				) AS SecondContractNo,HT1106.TitleNameE
		FROM	HV1400
		LEFT JOIN HT1403_1 ON HV1400.EmployeeID = HT1403_1.EmployeeID AND HV1400.DivisionID = HT1403_1.DivisionID
		LEFT JOIN HT1106 ON HT1106.TitleID = HV1400.TitleID AND HV1400.DivisionID = HT1106.DivisionID
		WHERE	HV1400.DivisionID '+@StrDivisionID_New+' and 
				(HV1400.DepartmentID between ''' + @FromDepartmentID + ''' and ''' + 	@ToDepartmentID + ''' or
		 		HV1400.DepartmentID between ''' + @ToDepartmentID + ''' and ''' + 	@FromDepartmentID + ''') and 
				isnull(HV1400.TeamID,'''') like ''' + isnull(@TeamID, '') + ''' and 
				HV1400.EmployeeStatus like ''' + isnull(@EmployeeStatus,'') + '''
		)'

	Set @sSQL1 = '
		SELECT	T1.*, T2.WorkAddress, HT1105.ContractTypeName, ISNULL(T2.WorkDate,T1.WorkDate) AS WorkDate,
			DATEADD(m,HT11051.Months,T3.SignDate) AS BeginLimitDate,
			DATEADD(m,HT11052.Months,T4.SignDate) AS SecondLimitDate,
			CASE WHEN T1.LastContractNo = T1.BeginContractNo OR T1.LastContractNo = T1.SecondContractNo THEN NULL ELSE DATEADD(m,HT1105.Months,T2.SignDate) END AS ThirdLimitDate,
			CASE WHEN T1.LastContractNo = T1.BeginContractNo OR T1.LastContractNo = T1.SecondContractNo THEN NULL ELSE T1.LastContractNo END AS ThirdContractNo,
			DATEDIFF(yy,CONVERT(VARCHAR(10),T1.Birthday,112),''' + CONVERT(VARCHAR(10),@ToDate,112) + ''') AS Ages,
			DATEDIFF(yy,CONVERT(VARCHAR(10),T3.SignDate,112),''' + CONVERT(VARCHAR(10),@ToDate,112) + ''') AS SeniorityYears,
			(SELECT COUNT(TransactionID) FROM HT0334 WITH (NOLOCK) WHERE DivisionID = T1.DivisionID AND EmployeeID = T1.EmployeeID AND Status = 0) AS DependPersons,
			T13.SchoolID,H03.SchoolName, H04.MajorName
	FROM TEMP T1
	LEFT JOIN HT1360 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.LastContractNo = T2.ContractNo
	LEFT JOIN HT1360 T3 WITH (NOLOCK) ON T1.DivisionID = T3.DivisionID AND T1.EmployeeID = T3.EmployeeID AND T1.BeginContractNo = T3.ContractNo
	LEFT JOIN HT1360 T4 WITH (NOLOCK) ON T1.DivisionID = T4.DivisionID AND T1.EmployeeID = T4.EmployeeID AND T1.SecondContractNo = T4.ContractNo
	LEFT JOIN HT1105 WITH (NOLOCK) ON T2.DivisionID = HT1105.DivisionID AND T2.ContractTypeID = HT1105.ContractTypeID
	LEFT JOIN HT1105 HT11051 WITH (NOLOCK) ON T3.DivisionID = HT11051.DivisionID AND T3.ContractTypeID = HT11051.ContractTypeID
	LEFT JOIN HT1105 HT11052 WITH (NOLOCK) ON T4.DivisionID = HT11052.DivisionID AND T4.ContractTypeID = HT11052.ContractTypeID
	left outer join HT1301 T13 on T13.EmployeeID = T1.EmployeeID
	left join HT1003 H03 on T13.SchoolID = H03.SchoolID
	left join HT1004 H04 on T13.MajorID = H04.MajorID
	order by T1.DepartmentID,T1.EmployeeID
	'
/*
	IF EXISTS(SELECT TOP 1 1 FROM SYSOBJECTS WHERE XTYPE = 'V' AND NAME = 'HV1402')
		DROP VIEW HV1402

	EXEC('CREATE VIEW HV1402   ---tao boi HP1402_APT
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

	EXEC('CREATE VIEW HV1412   ---tao boi HP1402_APT
			AS ' + @sSQL)
	*/
END
--PRINT(@sSQL)
EXEC(@sSQL+@sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
