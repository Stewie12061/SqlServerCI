IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[EDMP2013]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[EDMP2013]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- In, Xuất Excel Hồ sơ học sinh
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Văn Tình, Date: 09/10/2018
----Modified by Khánh Đoan  on 24/12/2018 : Bổ sung 3  trường AdmissionDate, BeginTrialDate,EndTrialDate
-- <Example>
---- 
/*-- <Example>
	EDMP2013 @DivisionID = 'VF', @UserID = '', @LanguageID = '', @XML = 'A565A93E-588A-48DD-AF4D-38F966C70F68'

----*/
CREATE PROCEDURE EDMP2013
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @LanguageID VARCHAR(50),
	 @XML XML
)
AS 
SET NOCOUNT ON

DECLARE @cLan VARCHAR(1)
DECLARE @sSQL NVARCHAR(MAX) = N''

IF @LanguageID = 'vi-VN' SET @cLan = '' ELSE SET @cLan = 'E'

CREATE TABLE #EDMP2013 (APK VARCHAR(50))
INSERT INTO #EDMP2013 (APK)
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK
FROM @XML.nodes('//Data') AS X (Data)


SET @sSQL = @sSQL + N'
SELECT A.DivisionID, A.APK, A.StudentID, A.StudentName, A.StatusID, E.StatusName, A.DateOfBirth, A.PlaceOfBirth,
	CASE WHEN SexID = 0 THEN N''Nam'' ELSE N''Nữ'' END AS SexName, A.Image AS StudentImage, A.FatherMobiphone AS StudentPhone,
	A.GradeID, C.GradeName, A.ClassID, D.ClassName,
	A.Address, CASE WHEN ISNULL(A.FatherPhone,'''') != '''' THEN A.FatherPhone ELSE A.MotherPhone END AS Phone, 
	A.NationalityID, AT1.CountryName AS NationalityName, A.NationID, AT7.EthnicName AS NationName,
	O1.ObjectName AS FatherName, 
	A.FatherDateOfBirth, A.FatherPlaceOfBirth, A.FatherNationalityID, A.FatherNationID, AT2.CountryName AS FatherNationalityName, 
	A.FatherJob, A.FatherOffice, A.FatherPhone, A.FatherMobiphone, A.FatherEmail, A.FatherImage, 
	O2.ObjectName AS MotherName, 
	A.MotherID, A.MotherDateOfBirth, A.MotherPlaceOfBirth, A.MotherNationalityID, A.MotherNationID, AT3.CountryName AS MotherNationalityName, 
	A.MotherJob, A.MotherOffice, 
	A.MotherPhone, A.MotherMobiphone, A.MotherEmail, A.MotherImage, 
	[Picker1Name], [Picker1RelateTo], [Picker1HomePhone], [Picker1MobiPhone], [Picker1OfficePhone], [Picker1Image], 
	[Picker2PickerName], [Picker2RelateTo], [Picker2HomePhone], [Picker2MobiPhone], [Picker2OfficePhone], [Picker2Image],
	AT4.Description AS ComfirmStatusName,A.RegistrationDate,AT5.FullName AS Receiver, A.StatusID, AT6.Description AS StatusName,
	A.AdmissionDate, A.BeginTrialDate, A.EndTrialDate
FROM EDMT2010 A WITH(NOLOCK) INNER JOIN #EDMP2013 ON A.APK = #EDMP2013.APK
	LEFT JOIN (SELECT GradeID, GradeName FROM EDMT1000 WITH(NOLOCK) WHERE DivisionID IN (''' + @DivisionID + ''', ''@@@'') AND [Disabled] = 0) AS C ON A.GradeID = C.GradeID
	LEFT JOIN (SELECT ClassID, ClassName FROM EDMT1020 WITH(NOLOCK) WHERE DivisionID IN (''' + @DivisionID + ''', ''@@@'') AND [Disabled] = 0) AS D ON D.ClassID = A.ClassID
	LEFT JOIN (SELECT ID AS StatusID, Description' + @cLan + ' AS StatusName FROM EDMT0099 WITH(NOLOCK) WHERE CodeMaster = ''StudentStatus'' AND [Disabled] = 0) AS E ON E.StatusID = A.StatusID
	LEFT JOIN AT1202 O1 WITH(NOLOCK) ON A.FatherID = O1.ObjectID
	LEFT JOIN AT1202 O2 WITH(NOLOCK) ON A.MotherID = O2.ObjectID
	LEFT JOIN AT1001 AT1 WITH(NOLOCK) ON AT1.CountryID = A.NationalityID
	LEFT JOIN AT1001 AT2 WITH(NOLOCK) ON AT2.CountryID = A.FatherNationalityID
	LEFT JOIN AT1001 AT3 WITH(NOLOCK) ON AT3.CountryID = A.MotherNationalityID
	LEFT JOIN EDMT0099 AT4 WITH(NOLOCK) ON AT4.ID = A.ComfirmID AND AT4.CodeMaster = ''ComfirmStatus''
	LEFT JOIN AT1103 AT5 WITH(NOLOCK) ON AT5.DivisionID IN (''' + @DivisionID + ''', ''@@@'') AND AT5.EmployeeID = A.Receiver 
	LEFT JOIN EDMT0099 AT6 WITH(NOLOCK) ON AT6.ID = A.StatusID AND AT6.CodeMaster = ''StudentStatus''
	LEFT JOIN HT1001 AT7 WITH(NOLOCK) ON AT7.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND A.NationID = AT7.EthnicID
'

--PRINT @sSQL
EXEC (@sSQL)

-- LEFT JOIN HT1001 HT1 WITH(NOLOCK) ON HT1.EthnicID = A.NationID


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

