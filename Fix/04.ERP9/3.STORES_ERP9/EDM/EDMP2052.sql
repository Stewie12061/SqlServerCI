IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2052]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2052]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Load xem thông tin kết quả học tập
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
	EDMP2052 @DivisionID = 'BE', @UserID = 'ASOFTADMIN', @APK = '2df8217a-7df8-4205-aea8-12decb1efbe0', @LanguageID ='vi-VN'
	
	EDMP2052 @DivisionID, @UserID, @APK, @LanguageID
----*/
CREATE PROCEDURE EDMP2052
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50),
	 @LanguageID VARCHAR(50)
)

AS 

DECLARE @sSQL NVARCHAR(MAX)

SET @sSQL =  N'
	SELECT T1.DivisionID,T7.DivisionName,T1.APK , T1.VoucherResult, T1.ResultDate, 
	T1.GradeID, T1.ClassID, 
	T3.GradeName, T4.ClassName, 
	T1.StudentID, T5.StudentName,
	 T1.FeelingID,	T6.FeelingName,
    T1.Content, 
	HoursFrom, HoursTo, 
    EnglishVocabulary,
    TeacherNotes,
    ParentNotes,
	T1.CreateUserID, T1.CreateDate, T1.LastModifyUserID, T1.LastModifyDate
	FROM EDMT2050 T1 WITH (NOLOCK)
	LEFT JOIN EDMT1000 T3 WITH (NOLOCK) ON T1.GradeID = T3.GradeID 
	LEFT JOIN EDMT1020 T4 WITH (NOLOCK) ON T1.ClassID = T4.ClassID
	LEFT JOIN EDMT2010 T5 WITH (NOLOCK) ON T1.StudentID = T5.StudentID AND T5.DeleteFlg = 0
	LEFT JOIN EDMT1080 T6 WITH (NOLOCK) ON T1.FeelingID = T6.FeelingID
	LEFT JOIN AT1101   T7 WITH (NOLOCK) ON T1.DivisionID = T7.DivisionID


	WHERE T1.APK = '''+@APK+'''

	'

--PRINT @sSQL
 EXEC (@sSQL)
 


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
