IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[EDMP2002]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[EDMP2002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- In, Xuất Excel Phiếu thông tin tư vấn
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Minh Hòa, Date: 09/10/2018
-- <Example>
---- 
/*-- <Example>
	EDMP2002 @DivisionID = 'BE', @UserID = '', @LanguageID = '', @XML = '8DFC813D-37E9-4F24-8CC4-003400C58D69'
	
	EDMP2002 @DivisionID, @UserID, @LanguageID, @XML
----*/
CREATE PROCEDURE EDMP2002
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @LanguageID VARCHAR(50),
	 @XML XML
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N''

CREATE TABLE #EDMP2002 (APK VARCHAR(50))
INSERT INTO #EDMP2002 (APK)
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK
FROM @XML.nodes('//Data') AS X (Data)


SET @sSQL = @sSQL + N'
SELECT T1.DivisionID,T5.DivisionName AS SchoolName, T1.VoucherNo, T1.VoucherDate, T1.IsInheritClue, T1.ParentID, T1.ParentName,T1.ParentDateBirth, T1.Telephone,
T1.Address, T1.Email, T1.StudentID,T1.StudentName, T1.StudentDateBirth, T1.Sex, 
T1.ResultID, '+ CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T3.Description' ELSE 'T3.DescriptionE' END +' as ResultName, 
T1.DateFrom, T1.DateTo,
T1.Status as StatusID, 
'+ CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T4.Description' ELSE 'T4.DescriptionE' END +' as StatusName, 
T1.Amount, T1.Information,
T1.CreateUserID,T1.CreateDate,T1.LastModifyUserID,T1.LastModifyDate
FROM EDMT2000 T1  WITH (NOLOCK)
INNER JOIN #EDMP2002 ON T1.APK = #EDMP2002.APK
LEFT JOIN EDMT0099  T3 WITH (NOLOCK) ON T1.ResultID = T3.ID AND T3.Disabled = 0 AND T3.CodeMaster=''ConsultancyResult''
LEFT JOIN EDMT0099  T4 WITH (NOLOCK) ON T1.Status = T4.ID AND T4.Disabled = 0 AND T4.CodeMaster=''PaymentStatus''
LEFT JOIN AT1101 T5 WITH (NOLOCK) ON T5.DivisionID = T1.DivisionID
Where T1.DivisionID = '''+ @DivisionID+ '''
'

--PRINT @sSQL
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

