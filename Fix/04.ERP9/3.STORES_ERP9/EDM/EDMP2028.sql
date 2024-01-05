IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2028]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2028]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Xuất excel hồ sơ học sinh  
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo, Date: 20/9/2019
-- <Example>
---- 
/*-- <Example>
	EDMP2028 @DivisionID = 'BE', @UserID = 'ASOFTADMIN',@XML = '<Data><APK>2ADD7E6A-118F-466B-9CCA-A428CDEE12FE</APK></Data>',@Mode = 0,@StudentID = ''
	EDMP2028 @DivisionID = 'BE', @UserID = 'ASOFTADMIN',
	@XML = '<Data><APK>2ADD7E6A-118F-466B-9CCA-A428CDEE12FE</APK></Data>'

----*/
CREATE PROCEDURE EDMP2028
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50), 
	 @XML XML,
	 @LanguageID VARCHAR(50)
)
AS 

DECLARE @sSQL NVARCHAR(MAX) 


	 

CREATE TABLE #EDMP2028 (APK VARCHAR(50))
INSERT INTO #EDMP2028 (APK)
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK
FROM @XML.nodes('//Data') AS X (Data)

 

 
SELECT 
	A.DivisionID, A.APK, A.StudentID, A.StudentName, A.DateOfBirth, A.PlaceOfBirth
	,A.SexID, CASE WHEN ISNULL(@LanguageID, '') = 'vi-VN' THEN G.[Description] ELSE G.DescriptionE END AS SexName
	, A.StatusID, CASE WHEN ISNULL(@LanguageID, '') = 'vi-VN' THEN E.[Description] ELSE E.DescriptionE END AS StatusName
	, A.NationalityID,O3.CountryName AS NationalityName, A.NationID, O6.EthnicName AS NationName, A.Address, A.Description
	, A.FatherID, O1.ObjectName AS FatherName, A.FatherDateOfBirth, A.FatherPlaceOfBirth, A.FatherNationalityID,O4.CountryName AS FatherNationalityName
	, A.FatherNationID,O7.EthnicName AS FatherNationName, A.FatherJob, A.FatherOffice, A.FatherPhone, A.FatherMobiphone, A.FatherEmail
	, A.MotherID, O2.ObjectName AS MotherName, A.MotherDateOfBirth, A.MotherPlaceOfBirth, A.MotherNationalityID,O5.CountryName AS MotherNationalityName
	, A.MotherNationID,O8.EthnicName AS MotherNationName,A.MotherJob, A.MotherOffice, A.MotherPhone, A.MotherMobiphone, A.MotherEmail
	
FROM EDMT2010 A WITH(NOLOCK) 
	LEFT JOIN EDMT0099 E WITH(NOLOCK) ON  E.CodeMaster = 'StudentStatus' AND E.ID = A.StatusID
	LEFT JOIN EDMT0099 G WITH(NOLOCK) ON G.CodeMaster = 'Sex' AND  G.ID = A.SexID
	LEFT JOIN AT1202 O1 WITH(NOLOCK) ON  A.FatherID = O1.ObjectID AND O1.DivisionID IN (A.DivisionID, '@@@')
	LEFT JOIN AT1202 O2 WITH(NOLOCK) ON  A.MotherID = O2.ObjectID AND O2.DivisionID IN (A.DivisionID, '@@@') 
	LEFT JOIN AT1001 O3 WITH(NOLOCK) ON  A.NationalityID = O3.CountryID AND  O3.DivisionID IN (A.DivisionID, '@@@')
	LEFT JOIN AT1001 O4 WITH(NOLOCK) ON  A.FatherNationalityID = O4.CountryID AND O4.DivisionID IN (A.DivisionID, '@@@') 
	LEFT JOIN AT1001 O5 WITH(NOLOCK) ON  A.MotherNationalityID = O5.CountryID AND O5.DivisionID IN (A.DivisionID, '@@@')
	LEFT JOIN HT1001 O6 WITH(NOLOCK) ON  A.NationID = O6.EthnicID AND O6.DivisionID IN (A.DivisionID, '@@@') 
	LEFT JOIN HT1001 O7 WITH(NOLOCK) ON  A.FatherNationID = O7.EthnicID AND O7.DivisionID IN (A.DivisionID, '@@@') 
	LEFT JOIN HT1001 O8 WITH(NOLOCK) ON  A.MotherNationID = O8.EthnicID AND O8.DivisionID IN (A.DivisionID, '@@@')
	INNER JOIN #EDMP2028 O9 WITH(NOLOCK) ON A.APK = O9.APK 
 




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
