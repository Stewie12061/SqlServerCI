IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0080]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0080]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Do nguon danh sach nhan vien
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- 
---- Create On 09/08/2013 by Le Thu Thu Hien
---- 
---- Modified On 09/08/2013 by Thanh Son : 
---- Modified On 27/12/2014 by Le Thi Thu Hien : Bo sung 10 cot ghi chu, chuc danh 
---- Modified On 24/02/2016	by Kim Vũ: Bổ sung lấy hết các trường trong màn hình cập nhật lên 
---- Modified by Phương Thảo on 18/05/2017: Sửa danh mục dùng chung
---- Modified by Phương Thảo on 14/08/2017: Chỉnh sửa cách lấy tên (bỏ khoảng trắng)
---- Modified by Bảo Anh on 23/01/2018: Bổ sung biến @ConditionDE truyền từ code (trước đây lấy giá trị trả ra từ AP1409)
---- Modified by Phương Thảo on 27/04/2018: Bổ sung 150 hệ số
---- Modified by Kim Thư on 30/05/2019: Không hiển thị giờ ở các cột ngày
---- Modified by Kiều Nga on 15/12/2023: [2023/12/IS/0163] Xử lý lấy thêm cột BankID
---- Modified by Hồng Thắm on 18/12/2023: Customize lọc hồ sơ nhân sự (Customize Gree)
---- Modified by Xuân Nguyên on 20/12/2023: Fix lỗi tràn chuỗi 
-- <Example>
---- EXEC HP0080 'AS', '', 4, 2013, 9 , 'BKS', 'SX', '%',  'ASOFTADMIN'

CREATE PROCEDURE HP0080
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),
	@TranMonth AS INT,
	@TranYear AS INT,
	@Status AS NVARCHAR(2),
	@FromDepartment AS NVARCHAR(50),
	@ToDepartment AS NVARCHAR(50),
	@TeamID AS NVARCHAR(50),
	@GroupID AS NVARCHAR(50),
	@ConditionDE NVARCHAR(4000)
) 
AS 

DECLARE @sSQL AS NVARCHAR(MAX),@sSQLA AS NVARCHAR(MAX)
DECLARE @sSQL1 AS NVARCHAR(MAX),
		--@Condition NVARCHAR(4000),
		@sSQL2 as NVARCHAR(MAX),
		@sSQL3 AS NVARCHAR(MAX),
		@sSQLWhere AS NVARCHAR(4000),
		@CustomerIndex AS NVARCHAR(250) = (Select CustomerName from CustomerIndex)
SET NOCOUNT OFF
--If @UserID<>''
--EXEC AP1409 @DivisionID,'ASOFTHRM','DE','DE',@UserID,@GroupID,0,@Condition OUTPUT , 1
   
SET NOCOUNT ON
SET @sSQL = N'      
SELECT YEAR(Birthday) AS Year,
		CONVERT(VARCHAR(10),Birthday,121) as Birthday,
		DATEDIFF(YEAR, HT03.WorkDate, GETDATE()) AS YearTime ,
		HT00.DivisionID, HT00.EmployeeID, 
		HT00.Orders,HT00.S1,HT00.S2,HT00.S3,		
		LTRIM(RTRIM(REPLACE(LTRIM(RTRIM(ISNULL(HT00.LastName,'''')))+ '' '' + LTRIM(RTRIM(ISNULL(HT00.MiddleName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HT00.FirstName,''''))),''  '','' ''))) AS FullName, 
		HT00.LastName, HT00.MiddleName, HT00.FirstName,
		HT00.ShortName, HT00.Alias, HT00.BornPlace,
		HT1001.EthnicName,
		HT1002.ReligionName,
		HT01.EducationLevelID,HT01.PoliticsID,
		HT02.BankAccountNo, A.AssociationID,
        HT02.PersonalTaxID,HT02.SoInsuranceNo,
		HT00.IsMale,HT03.CompanyDate,
		(Case When HT00.IsMale=1 then N''Nam'' else N''Nữ'' End) as IsMaleName, 

		HT00.NativeCountry, HT00.PassportNo, HT00.PassportDate, 
		HT00.PassportEnd, HT00.IdentifyCardNo, CONVERT(VARCHAR(10),HT00.IdentifyDate,121) AS IdentifyDate, HT00.IdentifyPlace, 

		HT00.IsSingle,
		(Case When HT00.IsSingle=1 then N''Độc thân'' else N''Đã lập gia đình'' End) as IsSingleName, 
		(Case HT00.EmployeeStatus
				when 0 then N''Tuyển dụng''
				when 1 then N''Đang làm''
				when 2 then N''Thử việc''
				when 3 then N''Tạm nghỉ''
				else N''Nghỉ việc'' end) as StatusName,
	
		HT00.CountryID, AT01.CountryName, 
		LTrim(RTrim(Isnull(HT00.PermanentAddress,''''))) + '' '' + LTrim(RTrim(Isnull(HT00.DistrictID,''''))) + '' '' +
		(Case when isnull(HT00.CityID,'''') <> '''' then  LTrim(RTrim(isnull(AT02.CityName,'''')))  else  ''''  End  ) AS FullAddress,
		--LTrim(RTrim(isnull(HT00.CityID,'''')))  AS FullAddress, 
		HT00.CityID, AT02.CityName, HT00.DistrictID, HT00.PermanentAddress, HT00.TemporaryAddress,
		HT00.Notes, HT00.HealthStatus, HT00.HomePhone, 
		HT00.HomeFax, HT00.MobiPhone, HT00.Email,
		HT00.CreateDate, HT00.CreateUserID, HT00.LastModifyDate, HT00.LastModifyUserID, HT03.IsOtherDayPerMonth,
		HT00.IsForeigner,HT00.RecruitTimeID,

		-- Thong tin ve he so chi tieu
		HT03.SalaryCoefficient, HT03.DutyCoefficient, HT03.TimeCoefficient, 
		Case  '+@CustomerIndex+' when 162 then HT03.SectionID
								else HT00.DepartmentID end  as DepartmentID, 
		Case '+@CustomerIndex+'  
				when 162 then (select AnaName from AT1011 where AnaID = HT03.SectionID) 
				else A03.DepartmentName end  AS DepartmentName,
		ISNULL(HT00.TeamID,'''') AS TEAMID,
		Case '+@CustomerIndex+'  
			when 162 then (select AnaName from AT1011 where AnaID = HT00.TeamID) 
			else T01.TeamName end  AS TeamName, 
		HT03.DutyID, DutyName, HT03.TitleID, HT1106.TitleName, HT1106.TitleNameE,
		HT03.TaxObjectID, HT00.EmployeeStatus, HT03.Experience,
		HT03.SuggestSalary, HT03.RecruitDate, HT03.RecruitPlace, CONVERT(VARCHAR(10),HT03.WorkDate,121) AS WorkDate, CONVERT(VARCHAR(10),HT03.LeaveDate,121) AS LeaveDate, 
		HT07.QuitJobID, HT07.QuitJobName,
		HT03.C01, HT03.C02, HT03.C03, HT03.C04, HT03.C05, HT03.C06, HT03.C07,
		HT03.C08, HT03.C09, HT03.C10, HT03.C11, HT03.C12, HT03.C13, 
		HT03.C14, HT03.C15, HT03.C16, HT03.C17, HT03.C18, HT03.C19, HT03.C20, HT03.C21, HT03.C22, HT03.C23, HT03.C24, HT03.C25,
		HT04.C26, HT04.C27, HT04.C28, HT04.C29, HT04.C30, HT04.C31, HT04.C32, HT04.C33, HT04.C34, HT04.C35, HT04.C36, HT04.C37,
		HT04.C38, HT04.C39, HT04.C40, HT04.C41, HT04.C42, HT04.C43, HT04.C44, HT04.C45, HT04.C46, HT04.C47, HT04.C48, HT04.C49,
		HT04.C50, HT04.C51, HT04.C52, HT04.C53, HT04.C54, HT04.C55, HT04.C56, HT04.C57, HT04.C58, HT04.C59, HT04.C60, HT04.C61,
		HT04.C62, HT04.C63, HT04.C64, HT04.C65, HT04.C66, HT04.C67, HT04.C68, HT04.C69, HT04.C70, HT04.C71, HT04.C72, HT04.C73,
		HT04.C74, HT04.C75, HT04.C76, HT04.C77, HT04.C78, HT04.C79, HT04.C80, HT04.C81, HT04.C82, HT04.C83, HT04.C84, HT04.C85,
		HT04.C86, HT04.C87, HT04.C88, HT04.C89, HT04.C90, HT04.C91, HT04.C92, HT04.C93, HT04.C94, HT04.C95, HT04.C96, HT04.C97,'
		SET @sSQLA = N' 
		HT04.C98, HT04.C99, HT04.C100,HT04.C101, HT04.C102, HT04.C103, HT04.C104, HT04.C105, HT04.C106, 
		HT04.C107, HT04.C108, HT04.C109, HT04.C110, HT04.C111, HT04.C112, HT04.C113, HT04.C114, 
		HT04.C115, HT04.C116, HT04.C117, HT04.C118, HT04.C119, HT04.C120, 
		HT04.C121, HT04.C122, HT04.C123, HT04.C124, HT04.C125, HT04.C126, 
		HT04.C127, HT04.C128, HT04.C129, HT04.C130, HT04.C131, HT04.C132, 
		HT04.C133, HT04.C134, HT04.C135, HT04.C136, HT04.C137, HT04.C138, 
		HT04.C139, HT04.C140, HT04.C141, HT04.C142, HT04.C143, HT04.C144, 
		HT04.C145, HT04.C146, HT04.C147, HT04.C148, HT04.C149, HT04.C150,
		HT03.BaseSalary, HT03.InsuranceSalary,
		HT03.Salary01, HT03.Salary02, HT03.Salary03, HT03.Target01ID, HT03.Target02ID,
		HT03.Target03ID, HT03.Target04ID, HT03.Target05ID, HT03.Target06ID, HT03.Target07ID,
		HT03.Target08ID, HT03.Target09ID, HT03.Target10ID, HT03.TargetAmount01, 
		HT03.TargetAmount02, HT03.TargetAmount03, HT03.TargetAmount04, HT03.TargetAmount05,
		HT03.TargetAmount06, HT03.TargetAmount07, HT03.TargetAmount08, HT03.TargetAmount09, HT03.TargetAmount10, HT03.LoaCondID, HT06.LoaCondName, 
		CONVERT(VARCHAR(10),HT03.ApplyDate,121) AS ApplyDate, CONVERT(VARCHAR(10),HT03.BeginProbationDate,121) AS BeginProbationDate, 
		CONVERT(VARCHAR(10),HT03.EndProbationDate,121) AS EndProbationDate, HT03.ProbationNote, HT03. FileID, HT03.ExpenseAccountID,HT03.PayableAccountID, HT03.PerInTaxID,
		HT00.EthnicID,HT00.ReligionID,
		HT1413.N01,HT1413.N02,HT1413.N03,HT1413.N04,HT1413.N05,
		HT1413.N06,HT1413.N07,HT1413.N08,HT1413.N09,HT1413.N10,
		HT00.Ana01ID, HT00.Ana02ID, HT00.Ana03ID, HT00.Ana04ID,HT00.Ana05ID,
		HT00.Ana06ID, HT00.Ana07ID, HT00.Ana08ID, HT00.Ana09ID,HT00.Ana10ID, A13.AnaName SubsectionName,A14.AnaName ProcessName
'
SET @sSQL1 = N'
FROM HT1400 AS HT00 
LEFT JOIN HT1401 AS HT01 ON HT00.EmployeeID = HT01.EmployeeID AND  HT00.DivisionID = HT01.DivisionID
LEFT JOIN HT1402 AS HT02 ON HT00.EmployeeID = HT02.EmployeeID AND  HT00.DivisionID = HT02.DivisionID
LEFT JOIN HT1403 AS HT03 ON HT00.EmployeeID = HT03.EmployeeID AND  HT00.DivisionID = HT03.DivisionID
LEFT JOIN HT1403_1 AS HT04 ON HT00.EmployeeID = HT04.EmployeeID AND  HT00.DivisionID = HT04.DivisionID
LEFT JOIN HT1413 AS HT1413 ON HT1413.DivisionID = HT00.DivisionID AND HT1413.EmployeeID = HT00.EmployeeID
LEFT JOIN (SELECT DivisionID,EmployeeID, MAX(AssociationID)AS AssociationID  FROM HT1405 GROUP BY DivisionID,EmployeeID)A ON A.DivisionID=HT00.DivisionID AND A.EmployeeID = HT00.EmployeeID
--LEFT JOIN HT1405 AS T05 ON HT00.EmployeeID = T05.EmployeeID AND HT00.DivisionID = T05.DivisionID 
LEFT JOIN HT1101 AS T01 ON HT00.TeamID = T01.TeamID AND HT00.DepartmentID =T01.DepartmentID AND  HT00.DivisionID = T01.DivisionID
LEFT JOIN HT1107 HT07 ON HT03.QuitJobID = HT07.QuitJobID AND  HT03.DivisionID = HT07.DivisionID
LEFT JOIN HT1001  ON HT00.EthnicID = HT1001.EthnicID  AND  HT00.DivisionID = HT1001.DivisionID
LEFT JOIN HT1002  ON HT00.ReligionID = HT1002.ReligionID AND  HT00.DivisionID = HT1002.DivisionID
LEFT JOIN HT1102 ON HT03.DutyID = HT1102.DutyID  AND  HT03.DivisionID = HT1102.DivisionID
LEFT JOIN HT1005 HT05 ON HT05.EducationLevelID = HT01.EducationLevelID AND  HT05.DivisionID = HT01.DivisionID
--		LEFT JOIN HT1007 HT07 ON HT07.LanguageLevelID = HT01.LanguageLevel1ID
LEFT JOIN AT1001 AT01 ON HT00.CountryID = AT01.CountryID
LEFT JOIN AT1002 AT02 ON isnull(HT00.CityID,'''') = isnull(AT02.CityID,'''')
LEFT JOIN AT1102 A03 ON A03.DepartmentID = HT00.DepartmentID 
LEFT JOIN HT2806 HT06 ON  HT03.LoaCondID = HT06.LoaCondID  AND  HT03.DivisionID = HT06.DivisionID
LEFT JOIN HT1106 AS HT1106 ON HT1106.DivisionID = HT00.DivisionID AND HT1106.TitleID = HT03.TitleID
LEFT JOIN AT1011 A13 ON A13.AnaID=HT00.Ana04ID AND A13.AnaTypeID=''A04''
LEFT JOIN AT1011 A14 ON A14.AnaID=HT00.Ana05ID AND A14.AnaTypeID=''A05''
'
IF (@CustomerIndex = 162)
BEGIN
	SET @sSQLWhere = '
	WHERE HT03.SectionID between '''+@FromDepartment+''' and '''+@ToDepartment+'''
	ORDER BY EmployeeID     
	      '
END
ELSE
BEGIN
SET @sSQLWhere = '
WHERE	HT00.DivisionID = '''+@DivisionID+'''
		And HT00.DepartmentID between '''+@FromDepartment+''' And '''+@ToDepartment+'''
		'+ CASE WHEN @UserID<>'' AND ISNULL (@ConditionDE, '')  <> ''Then ' AND ISNULL(HT00.DepartmentID,''#'') In ' + @ConditionDE Else '' END +'
		AND ISNULL(HT00.TeamID, '''') LIKE '''+@TeamID+'''
		AND HT00.EmployeeStatus LIKE '''+@Status+'''

ORDER BY EmployeeID     
      '
END

SET @sSQL2 ='
		,HT061.LanguageName as Language1Name,HT062.LanguageName as Language2Name,HT063.LanguageName as Language3Name,
		HT071.LanguageLevelName as LanguageLevel1Name,
		HT072.LanguageLevelName as LanguageLevel2Name,
		HT073.LanguageLevelName as LanguageLevel3Name, 
		--HT001.FullName as MidEmployeeName,
		HT11.TaxObjectName,HV0100.Description as SalaryLevelName, CONVERT(VARCHAR(10),HT03.SalaryLevelDate,121) as SalaryLevelDate,
		HT02.HeInsuranceNo, CONVERT(VARCHAR(10),HT02.HFromDate,121) AS HFromDate, CONVERT(VARCHAR(10),HT02.HToDate,121) AS HToDate, HT02.Height, HT02.Weight, HT02.BloodGroup, HT02.Hobby,
		CONVERT(VARCHAR(10),HT02.ArmyJoinDate,121) as ArmyJoinDate, CONVERT(VARCHAR(10),HT02.ArmyEndDate,121) as ArmyEndDate, HT02.ArmyLevel, HT01.FatherName, HT01.FatherYear,
		HT01.FatherAddress, HT01.FatherJob, HT01.FatherNote, HT01.MotherName, HT01.MotherYear,
		HT01.MotherAddress, HT01.MotherJob, HT01.MotherNote, HT01.SpouseName, HT01.SpouseYear,
		HT01.SpouseAddress, HT01.SpouseJob, HT01.SpouseNote, HT1009.HospitalName,HT02.BankID
'
SET @sSQL3 ='
LEFT JOIN HT1007 HT071 ON HT071.LanguageLevelID = HT01.LanguageLevel1ID AND HT071.DivisionID = HT01.DivisionID
LEFT JOIN HT1007 HT072 ON HT072.LanguageLevelID = HT01.LanguageLevel2ID AND HT072.DivisionID = HT01.DivisionID
LEFT JOIN HT1007 HT073 ON HT073.LanguageLevelID = HT01.LanguageLevel3ID AND HT073.DivisionID = HT01.DivisionID
LEFT JOIN HT1006 HT061 ON HT061.LanguageID = HT01.Language1ID AND HT061.DivisionID = HT01.DivisionID
LEFT JOIN HT1006 HT062 ON HT062.LanguageID = HT01.Language2ID AND HT062.DivisionID = HT01.DivisionID
LEFT JOIN HT1006 HT063 ON HT063.LanguageID = HT01.Language3ID AND HT063.DivisionID = HT01.DivisionID
--LEFT Join ( Select HT1400.DivisionID, MidEmployeeID, Ltrim(RTrim(isnull(HT1400.LastName,'''')))+ '' '' + LTrim(RTrim(isnull(HT1400.MiddleName,''''))) + '' '' + LTrim(RTrim(Isnull(HT1400.FirstName,''''))) AS FullName
--			 from HT1403 left join HT1400 on HT1400.DivisionID = HT1403.DivisionID AND HT1400.EmployeeID = HT1403.EmployeeID
--			 ) HT001 on HT001.DivisionID = HT03.DivisionID AND HT001.MidEmployeeID = HT03.MidEmployeeID
Left join HT1011 HT11 on HT11.TaxObjectID = HT03.TaxObjectID and HT11.DivisionID = HT03.DivisionID
LEFT JOIN HV0100 ON HT03.SalaryLevel = HV0100.CodeID
LEFT JOIN HT1009 ON HT1009.DivisionID = HT02.DivisionID AND HT1009.HospitalID = HT02.HospitalID
'
EXEC (@sSQL + @sSQLA + @sSQL2 +@sSQL1 + @sSQL3 + @sSQLWhere)
---print (@sSQL + @sSQL2 +@sSQL1 + @sSQL3 + @sSQLWhere)

--PRINT(@sSQL)
--PRINT(@sSQL2)
--PRINT(@sSQL1)
--PRINT(@sSQL3)
--PRINT(@sSQLWhere)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
