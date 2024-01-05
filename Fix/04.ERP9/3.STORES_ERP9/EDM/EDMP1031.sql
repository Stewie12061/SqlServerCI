IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1031]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[EDMP1031]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load thông tin chi tiết môn học EDMF1032
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Minh Hòa, Date: 12/09/2018
--- Modify by ...: Bổ sung ...
-- <Example>

/*-- <Example>
	EDMP1031 @DivisionID='MK',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@IsSearch=1,
	@LevelName=NULL,@SubjectID=NULL,@SubjectName NULL,@Notes=NULL, @Disabled=0

	exec EDMP1031 'MK','NV04','E80FA704-6CBD-4168-A7D3-2580ABDA2D64'
----*/

CREATE PROCEDURE EDMP1031
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@APK VARCHAR(50),
	@LanguageID VARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX),
		@sSQLLanguage VARCHAR(100)=''

SET @sSQL = '
	SELECT EDMT1030.DivisionID, EDMT1030.APK, EDMT1030.SubjectID, EDMT1030.SubjectName, EDMT1030.Notes, EDMT1030.Disabled , EDMT1030.IsCommon,  
	EDMT1030.CreateUserID, EDMT1030.CreateDate, EDMT1030.LastModifyUserID, EDMT1030.LastModifyDate
	FROM EDMT1030 WITH (NOLOCK)
   	WHERE  EDMT1030.APK ='''+ @APK +'''

'

EXEC (@sSQL)
--PRINT(@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

