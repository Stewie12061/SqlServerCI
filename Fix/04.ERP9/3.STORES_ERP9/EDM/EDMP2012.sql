IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2012]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2012]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Tab thông tin EDMF2012: Hồ sơ học sinh
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Văn Tình, Date: 28/09/2018
----Modified by  Khánh Đoan : Bổ sung 3 trường :AdmissionDate,BeginTrialDate,EndTrialDate
-- <Example>
---- 
--	EDMP2012 @DivisionID='BE', @UserID='ASOFTADMIN', @LanguageID = 'vi-VN', @APK=N'12698E39-09A6-464A-A7C1-0B3B9DCC946B'

CREATE PROCEDURE [dbo].[EDMP2012]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @LanguageID VARCHAR(50),
	 @APK VARCHAR(50)
)
AS 
SET NOCOUNT ON

DECLARE @cLan VARCHAR(1)
DECLARE @sSQL NVARCHAR (MAX) = '', @sWhere NVARCHAR(4000)
                
IF @LanguageID = 'vi-VN' SET @cLan = '' ELSE SET @cLan = 'E'

--SET @sSQL = ''

SET @sSQL = @sSQL + '
SELECT TOP 1 
	A.DivisionID, A.APK, A.StudentID, A.StudentName, A.DateOfBirth, A.PlaceOfBirth,A.SexID
	, G.SexName, A.GradeID, C.GradeName, A.ClassID, D.ClassName
	, A.StatusID, E.StatusName, A.ComfirmID, F.ComfirmName
	, A.CreateUserID, O10.UserName AS CreateUserName, A.CreateDate
	, A.LastModifyUserID, O11.UserName AS LastModifyUserName, A.LastModifyDate
	, A.NationalityID,O3.CountryName AS NationalityName, A.NationID, O6.EthnicName AS NationName, A.Address, A.Description, A.RegistrationDate, A.Receiver, O9.FullName AS ReceiverName
	, A.FatherID, O1.ObjectName AS FatherName, A.FatherDateOfBirth, A.FatherPlaceOfBirth, A.FatherNationalityID,O4.CountryName AS FatherNationalityName
	, A.FatherNationID,O7.EthnicName AS FatherNationName, A.FatherJob, A.FatherOffice, A.FatherPhone, A.FatherMobiphone, A.FatherEmail
	, A.MotherID, O2.ObjectName AS MotherName, A.MotherDateOfBirth, A.MotherPlaceOfBirth, A.MotherNationalityID,O5.CountryName AS MotherNationalityName
	, A.MotherNationID,O8.EthnicName AS MotherNationName,A.MotherJob, A.MotherOffice, A.MotherPhone, A.MotherMobiphone, A.MotherEmail
	, A.Picker1Name, A.Picker1RelateTo, A.Picker1HomePhone, A.Picker1MobiPhone, A.Picker1OfficePhone
	, A.Picker2PickerName, A.Picker2RelateTo, A.Picker2HomePhone, A.Picker2MobiPhone, A.Picker2OfficePhone
	, A.PickerNotes, A.[Image], A.FatherImage, A.MotherImage, A.Picker1Image, A.Picker2Image, A.IsInheritConsultant, A.APKConsultant,A.SType01IDS,A.SType02IDS,A.SType03IDS
	, O12.AdmissionDate, O12.DateFrom AS BeginTrialDate, O12.DateTo AS EndTrialDate
	, O13.FeeID, O14.FeeName
FROM EDMT2010 A WITH(NOLOCK) 
	LEFT JOIN (SELECT GradeID, GradeName FROM EDMT1000 WITH(NOLOCK) WHERE  [Disabled] = 0) AS C ON A.GradeID = C.GradeID
	LEFT JOIN (SELECT ClassID, ClassName FROM EDMT1020 WITH(NOLOCK) WHERE  [Disabled] = 0) AS D ON D.ClassID = A.ClassID
	LEFT JOIN (SELECT ID AS StatusID, Description' + @cLan + ' AS StatusName FROM EDMT0099 WITH(NOLOCK) WHERE CodeMaster = ''StudentStatus'' AND [Disabled] = 0) AS E ON E.StatusID = A.StatusID
	LEFT JOIN (SELECT ID AS StatusID, Description' + @cLan + ' AS ComfirmName FROM EDMT0099 WITH(NOLOCK) WHERE CodeMaster = ''ComfirmStatus'' AND [Disabled] = 0) AS F ON F.StatusID = A.ComfirmID
	LEFT JOIN (SELECT ID AS SexID, Description' + @cLan + ' AS SexName FROM EDMT0099 WITH(NOLOCK) WHERE CodeMaster = ''Sex'' AND [Disabled] = 0) AS G ON G.SexID = A.SexID
	LEFT JOIN AT1202 O1 WITH(NOLOCK) ON  A.FatherID = O1.ObjectID AND O1.DivisionID IN (A.DivisionID, ''@@@'')
	LEFT JOIN AT1202 O2 WITH(NOLOCK) ON  A.MotherID = O2.ObjectID AND O2.DivisionID IN (A.DivisionID, ''@@@'') 
	LEFT JOIN AT1001 O3 WITH(NOLOCK) ON  A.NationalityID = O3.CountryID AND  O3.DivisionID IN (A.DivisionID, ''@@@'')
	LEFT JOIN AT1001 O4 WITH(NOLOCK) ON  A.FatherNationalityID = O4.CountryID AND O4.DivisionID IN (A.DivisionID, ''@@@'') 
	LEFT JOIN AT1001 O5 WITH(NOLOCK) ON  A.MotherNationalityID = O5.CountryID AND O5.DivisionID IN (A.DivisionID, ''@@@'')
	LEFT JOIN HT1001 O6 WITH(NOLOCK) ON  A.NationID = O6.EthnicID AND O6.DivisionID IN (A.DivisionID, ''@@@'') 
	LEFT JOIN HT1001 O7 WITH(NOLOCK) ON  A.FatherNationID = O7.EthnicID AND O7.DivisionID IN (A.DivisionID, ''@@@'') 
	LEFT JOIN HT1001 O8 WITH(NOLOCK) ON  A.MotherNationID = O8.EthnicID AND O8.DivisionID IN (A.DivisionID, ''@@@'')
	LEFT JOIN AT1103 O9 WITH(NOLOCK) ON  O9.EmployeeID = A.Receiver AND O9.DivisionID IN (A.DivisionID, ''@@@'')
	LEFT JOIN AT1405 O10 WITH(NOLOCK) ON  A.CreateUserID = O10.UserID
	LEFT JOIN AT1405 O11 WITH(NOLOCK) ON  A.LastModifyUserID = O11.UserID
	LEFT JOIN EDMT2000 O12 WITH(NOLOCK) ON O12.StudentID = A.StudentID AND O12.DeleteFlg = 0 
	LEFT JOIN EDMT2013 O13 WITH(NOLOCK) ON O13.StudentID = A.StudentID 
	LEFT JOIN EDMT1090 O14 WITH(NOLOCK) ON O14.FeeID = O13.FeeID 

WHERE a.APK = ''' + @APK + ''' 
ORDER BY O13.CreateDate DESC



'


PRINT @sSQL
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO



