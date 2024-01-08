IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[EDMP2017]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[EDMP2017]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- In, Xuất Excel bảng điều tra tâm lý trẻ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Văn Tình, Date: 09/11/2018
-- <Example>
---- 
/*-- <Example>

	EDMP2017 @DivisionID = 'BE', @UserID = '', @LanguageID = 'vi-VN', @XML = '0CEEAE4E-8C00-4C37-83F0-2BD44B37B49E'

----*/
CREATE PROCEDURE EDMP2017
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

CREATE TABLE #EDMP2017 (APK VARCHAR(50))
INSERT INTO #EDMP2017 (APK)
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK
FROM @XML.nodes('//Data') AS X (Data)

	SELECT APK, APKMaster, PsychologizeID, Answer
	INTO #EDMT2011
	FROM EDMT2011 WITH(NOLOCK) 
	WHERE EXISTS (SELECT TOP 1 1 FROM #EDMP2017 WHERE #EDMP2017.APK = EDMT2011.APKMaster)

SELECT TOP 0 A.PsychologizeType, CAST('' AS NVARCHAR(250)) AS PsychologizeTypeName, A.PsychologizeID, A.PsychologizeName, ISNULL(A.PsychologizeGroup, '') AS PsychologizeGroup, A.Orders
	INTO #EDMT1070
	FROM EDMT1070 A WITH(NOLOCK)

SET @sSQL = '
INSERT INTO #EDMT1070
SELECT A.PsychologizeType, B.Description AS PsychologizeTypeName, A.PsychologizeID, A.PsychologizeName, ISNULL(A.PsychologizeGroup, '''') AS PsychologizeGroup, A.Orders
FROM EDMT1070 A WITH(NOLOCK) LEFT JOIN (
		SELECT ID, Description' + @cLan + ' AS Description
			FROM EDMT0099 WITH(NOLOCK) 
			WHERE CodeMaster = ''PsychologizeType'' AND [Disabled]=0
	) AS B ON A.PsychologizeType = B.ID
WHERE A.Disabled = 0
'
--PRINT @sSQL
EXEC (@sSQL)

-- Stt: Xử lý cột stt hiển thị theo cấp 
SELECT A.PsychologizeType, A.PsychologizeGroup, A.Orders, A.PsychologizeID
	, ROW_NUMBER() OVER(PARTITION BY A.PsychologizeType, A.PsychologizeGroup ORDER BY A.Orders) AS STT, CAST(0 AS INT) AS STT_GROUP
INTO #STT
FROM #EDMT1070 A

--select * from #STT

;WITH temp(PsychologizeType, PsychologizeID, PsychologizeGroup, level, Orders, cSTT)
AS (
        SELECT PsychologizeType, PsychologizeID, PsychologizeGroup, 0 as aLevel, Orders, CONVERT(varchar(100), LTRIM(STR(STT))) AS cSTT
        FROM #STT
        WHERE PsychologizeGroup = ''
        UNION ALL
        SELECT B.PsychologizeType, b.PsychologizeID, b.PsychologizeGroup, a.level + 1, B.Orders, CONVERT(varchar(100), a.cSTT + '.' + CONVERT(varchar(100), LTRIM(STR(B.STT)))) AS Z
        FROM temp AS a INNER JOIN #STT AS b ON a.PsychologizeID = b.PsychologizeGroup
)
SELECT *
	INTO #STT2
	FROM temp
--ORDER BY PsychologizeType, Orders

UPDATE #STT2 SET cSTT = SPACE(level * 3) + cSTT

-- END Stt

SELECT A.PsychologizeType, A.PsychologizeTypeName, A.PsychologizeID AS PsychologizeIDQuestion, A.PsychologizeGroup, A.Orders
	, CONCAT(B.cSTT, ' ' , A.PsychologizeName) AS PsychologizeName
	, C.APK, C.APKMaster, C.PsychologizeID, C.Answer
FROM #EDMT1070 A INNER JOIN #STT2 AS B ON A.PsychologizeID = B.PsychologizeID AND A.PsychologizeType = B.PsychologizeType
LEFT JOIN #EDMT2011 AS C ON C.PsychologizeID = A.PsychologizeID
ORDER BY A.PsychologizeType, A.Orders

DROP TABLE #STT
DROP TABLE #EDMT1070



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

