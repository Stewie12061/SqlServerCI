IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0527]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0527]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Lưu thông tin NV kế thừa từ ứng viên trúng tuyển (HF0502)
-- <History>
---- Created by Bảo Thy on 27/07/2017
---- Modified by on
-- <Example>
/* 
 EXEC HP0527 @DivisionID = 'CH', @UserID = 'ASOFTADMIN', @CandidateList = NULL
 */
 
CREATE PROCEDURE HP0527
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@CandidateList AS XML

) 
AS
CREATE TABLE #CandidateList (RecDecisionID VARCHAR(50), CandidateID VARCHAR(50), EmployeeID VARCHAR(50))
INSERT INTO #CandidateList (RecDecisionID, CandidateID, EmployeeID)
SELECT  X.Data.query('RecDecisionID').value('.', 'NVARCHAR(50)') AS RecDecisionID,
		X.Data.query('CandidateID').value('.', 'NVARCHAR(50)') AS CandidateID,
		X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID
FROM	@CandidateList.nodes('//Data') AS X (Data)


select * from #CandidateList
---- Thêm dữ liệu vào HT1400 - Thông tin nhân viên
INSERT INTO HT1400 (DivisionID, EmployeeID, S1, S2, S3, LastName, MiddleName, FirstName, Birthday, 
BornPlace, NativeCountry, CountryID, ReligionID, EthnicID, IsMale, IsSingle, HealthStatus, PermanentAddress, 
TemporaryAddress, HomePhone, HomeFax, MobiPhone, Email, IdentifyCardNo, IdentifyDate, IdentifyPlace, IdentifyCityID, 
PassportNo, PassportDate, PassportEnd, Notes, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate,EmployeeStatus,DepartmentID, 
Ana01ID, Ana02ID, Ana03ID, Ana04ID, Ana05ID, Ana06ID, Ana07ID, Ana08ID, Ana09ID, Ana10ID, RecDecisionID, CandidateID)
SELECT HRMT1030.DivisionID, T1.EmployeeID, NULL, NULL, NULL, LastName, MiddleName, FirstName, Birthday, BornPlace, 
NativeCountry, NationalityID, ReligionID, EthnicID, Gender, IsSingle, HealthStatus, PermanentAddress, 
TemporaryAddress, NULL, Fax, PhoneNumber, Email, IdentifyCardNo, IdentifyDate, IdentifyPlace, IdentifyCityID,
PassportNo, PassportDate, PassportEnd, Note, @UserID, GETDATE(), @UserID, GETDATE(), 1 , T2.DepartmentID, 
NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, T1.RecDecisionID, T1.CandidateID
FROM HRMT1030 WITH (NOLOCK)
INNER JOIN #CandidateList T1 ON HRMT1030.CandidateID = T1.CandidateID
INNER JOIN HRMT1031 T2 ON HRMT1030.CandidateID = T2.CandidateID
WHERE HRMT1030.DivisionID = @DivisionID

---- INSERT HT1403 - Thông tin nghề nghiệp
DECLARE @IsTranEntrySalary TINYINT
SELECT @IsTranEntrySalary = IsTranEntrySalary FROM HT0000 

INSERT INTO HT1403 (DivisionID, EmployeeID, EmployeeStatus, DepartmentID, DutyID, PayableAccountID, ExpenseAccountID, PerInTaxID, WorkDate)
SELECT DivisionID, T1.EmployeeID, 0 , DepartmentID, DutyID,
CASE WHEN @IsTranEntrySalary = 1 THEN '3341' ELSE NULL END PayableAccountID,
CASE WHEN @IsTranEntrySalary = 1 THEN '621' ELSE NULL END ExpenseAccountID,
CASE WHEN @IsTranEntrySalary = 1 THEN '3335' ELSE NULL END PerInTaxID, StartDate
FROM HRMT1031 WITH (NOLOCK)
INNER JOIN #CandidateList T1 ON HRMT1031.CandidateID = T1.CandidateID
WHERE HRMT1031.DivisionID = @DivisionID

---- Trình độ học vấn - HT1401
INSERT INTO HT1401 (DivisionID, EmployeeID, EducationLevelID, PoliticsID, Language1ID, LanguageLevel1ID, Language2ID, LanguageLevel2ID, Language3ID, LanguageLevel3ID)
SELECT DivisionID, EmployeeID, EducationLevelID, PoliticsID, Language1ID, LanguageLevel1ID, Language2ID, LanguageLevel2ID, Language3ID, LanguageLevel3ID
FROM HRMT1032 WITH (NOLOCK)
INNER JOIN #CandidateList T1 ON HRMT1032.CandidateID = T1.CandidateID
WHERE HRMT1032.DivisionID = @DivisionID

---- Thông tin bảo hiểm xã hội, tài khoản cá nhân, thông tin nhập ngũ
INSERT INTO HT1402 (DivisionID, EmployeeID, SoInsuranceNo, SoInsurBeginDate, HeInsuranceNo, HFromDate, HToDate, HospitalID, 
Height, [Weight], BloodGroup, Hobby, BankID, BankAccountNo, PersonalTaxID, ArmyEndDate, ArmyJoinDate, ArmyLevel)
SELECT HRMT1030.DivisionID, T1.EmployeeID, NULL, NULL, NULL, NULL, NULL, NULL,
	   HRMT1030.Height, HRMT1030.[Weight], NULL, HRMT1031.Hobby, NULL, NULL, NULL, NULL, NULL, NULL
FROM HRMT1030 WITH (NOLOCK)
LEFT JOIN HRMT1031 WITH (NOLOCK) ON HRMT1031.DivisionID = HRMT1030.DivisionID AND HRMT1031.CandidateID = HRMT1030.CandidateID
INNER JOIN #CandidateList T1 ON HRMT1030.CandidateID = T1.CandidateID
WHERE HRMT1030.DivisionID = @DivisionID

---- Quá trình học tập - HT1301
INSERT INTO HT1301 (DivisionID, HistoryID, EmployeeID, SchoolID, MajorID, TypeID, FromMonth, FromYear, ToMonth, 
ToYear, [Description], Notes, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT DivisionID, NEWID(), T1.EmployeeID, EducationCenter, EducationMajor, EducationTypeID, MONTH(EducationFromDate), YEAR(EducationFromDate),
MONTH(EducationToDate), YEAR(EducationToDate),[Description], Note, @UserID, GETDATE(), @UserID, GETDATE()
FROM HRMT1034 WITH (NOLOCK)
INNER JOIN #CandidateList T1 ON HRMT1034.CandidateID = T1.CandidateID
WHERE HRMT1034.DivisionID = @DivisionID

---Cập nhật trạng thái cập nhật HSNV
UPDATE HRMT2051
SET IsTransferedHRM = 1
FROM HRMT2051
INNER JOIN #CandidateList T1 ON HRMT2051.CandidateID = T1.CandidateID
WHERE HRMT2051.DivisionID = @DivisionID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
