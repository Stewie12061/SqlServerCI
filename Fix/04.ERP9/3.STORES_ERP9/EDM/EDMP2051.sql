IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2051]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2051]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load  kết quả học tập
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Minh Hòa on 25/11/2018
-- <Example>
---- 
/*-- <Example>
	EDMP2051 @DivisionID = 'BE', @UserID = 'ASOFTADMIN', @APK = '2df8217a-7df8-4205-aea8-12decb1efbe0', @LanguageID ='vi-VN'

	EDMP2051 @DivisionID, @UserID, @APK, @LanguageID
----*/
CREATE PROCEDURE EDMP2051
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50),
	 @LanguageID VARCHAR(50)
)

AS 

DECLARE @sSQL NVARCHAR(MAX)=''



SET @sSQL =  @sSQL +  N'
	SELECT  T1.APK , T1.VoucherResult, T1.ResultDate, 
	T1.GradeID, T1.ClassID, 
	T1.StudentID, T5.StudentName, T1.FeelingID,	T1.Content, 
	T1.HoursFrom, T1.HoursTo, 
    T1.EnglishVocabulary,
    T1.TeacherNotes,
    T1.ParentNotes,
	T1.SchoolYearID
	FROM EDMT2050 T1 WITH (NOLOCK)
	LEFT JOIN EDMT2010 T5 WITH (NOLOCK) ON T1.StudentID = T5.StudentID AND T5.DeleteFlg=0
	WHERE T1.APK = '''+@APK+'''

'

--PRINT @sSQL
 EXEC (@sSQL)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
