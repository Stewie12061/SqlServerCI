IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2171]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[EDMP2171]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load thông tin quản lý tin tức EDMF2172
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo , Date: 26/10/2018
--- Modify by ...: Bổ sung ...
-- <Example>

/*-- <Example>
	EDMP2171 @DivisionID='BS',@APK = 'B7DC9C78-D9BE-4D4C-9BA0-0DE834B2A7DF', @LanguageID = 'vi-VN' 
	SELECT * FROM  EDMT2170
	EDMP2171 @DivisionID,@APK,@LanguageID
----*/

CREATE PROCEDURE EDMP2171
( 
	@DivisionID VARCHAR(50),
	@APK VARCHAR(50),
	@LanguageID VARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX)

SET @sSQL = '
	SELECT T1.APK,T1.DivisionID, T1.NewsID, T1.TitleName, T1.PublicDate,T1.Image,T1.Summary,T1.Content,T1.DeleteFlg,
	T1.CreateDate,T1.CreateUserID,T3.FullName AS CreateUserName,T1.LastModifyUserID,T4.FullName AS LastModifyUserName, T1.LastModifyDate,
	T1.NewTypeID , '+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T5.Description' ELSE 'T5.DescriptionE' END+' AS NewTypeName,
	T1.GradeID,T6.GradeName, T1.ClassID,T7.ClassName
	FROM EDMT2170 T1 WITH (NOLOCK)
	LEFT JOIN AT1103 T3 WITH (NOLOCK) ON T3.DivisionID IN (T1.DivisionID,''@@@'') AND T3.EmployeeID = T1.CreateUserID
	LEFT JOIN AT1103 T4 WITH (NOLOCK) ON T4.DivisionID IN (T1.DivisionID,''@@@'') AND T4.EmployeeID = T1.LastModifyUserID
	LEFT JOIN EDMT0099 T5 WITH (NOLOCK) ON T5.ID = T1.NewTypeID AND T5.CodeMaster = ''NewType''
	LEFT JOIN EDMT1000 T6 WITH (NOLOCK) ON T6.DivisionID IN (T1.DivisionID,''@@@'') AND T6.GradeID = T1.GradeID
	LEFT JOIN EDMT1020 T7 WITH (NOLOCK) ON T6.DivisionID IN (T1.DivisionID,''@@@'') AND T7.ClassID = T1.ClassID
   	WHERE T1.APK ='''+@APK +'''
'

EXEC (@sSQL)
--PRINT(@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

