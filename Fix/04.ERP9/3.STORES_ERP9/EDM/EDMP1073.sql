IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1073]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1073]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load form xem thông tin danh mục điều tra tâm lý    
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- ASOFT - EDM \ Danh mục \ Danh mục điều tra tâm lý \ Xem thông tin điều tra tâm lý 
-- <History>
----Created by: Hồng Thảo, Date: 25/08/2018
-- <Example>
---- 
/*-- <Example>
	EDMP1073 @DivisionID = 'VS', @UserID = 'ASOFTADMIN', @APK = '431AFE34-9E6E-45B6-9C8E-241532857FBE'
	
	EDMP1073 @DivisionID, @UserID, @APK
----*/

CREATE PROCEDURE EDMP1073
( 
	 @DivisionID VARCHAR(50), 
	 @UserID VARCHAR(50), 
	 @APK VARCHAR(50),
	 @LanguageID NVARCHAR (50)
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N''

     
SET @sSQL = @sSQL + N'
	SELECT EDMT1070.APK, EDMT1070.DivisionID, EDMT1070.PsychologizeType, '+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'E03.Description' ELSE 'E03.DescriptionE' END+' AS PsychologizeTypeName,
    EDMT1070.PsychologizeID,EDMT1070.PsychologizeName,EDMT1070.PsychologizeGroup, EDMT1070.IsCommon, EDMT1070.[Disabled], EDMT1070.Orders, EDMT1070.CreateUserID, EDMT1070.CreateDate, EDMT1070.LastModifyUserID, EDMT1070.LastModifyDate
	FROM EDMT1070 WITH (NOLOCK)
	LEFT JOIN EDMT0099 E01 WITH (NOLOCK) ON EDMT1070.PsychologizeType = E01.ID AND E01.CodeMaster = ''Disabled''
	LEFT JOIN EDMT0099 E02 WITH (NOLOCK) ON EDMT1070.PsychologizeType = E02.ID AND E02.CodeMaster = ''Disabled''
	LEFT JOIN EDMT0099 E03 WITH (NOLOCK) ON EDMT1070.PsychologizeType = E03.ID AND E03.CodeMaster = ''PsychologizeType''
	WHERE EDMT1070.APK = '''+@APK+''' 
'
EXEC (@sSQL)
--PRINT(@sSQL)

   
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
