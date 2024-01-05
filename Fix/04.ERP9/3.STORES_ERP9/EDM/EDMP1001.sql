﻿IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[EDMP1001]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[EDMP1001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load thông tin chi tiết khối EDMF1002
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Minh Hòa, Date: 28/08/2018
--- Modify by ...: Bổ sung ...
-- <Example>

/*-- <Example>
	EDMP1001 @DivisionID='VS',@UserID='ASOFTADMIN',@APK ='DAF414E6-68E3-42D2-8B69-D27DD6D9C603', @LanguageID ='vi-VN'

	----*/

CREATE PROCEDURE EDMP1001
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@APK VARCHAR(50),
	@LanguageID VARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR (MAX),
        @sWhere NVARCHAR(MAX)


SET @sSQL = '
	SELECT EDMT1000.DivisionID, EDMT1000.APK, '+ CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'EDMT0099.Description' ELSE 'EDMT0099.DescriptionE' END +' as LevelName, EDMT1000.GradeID, EDMT1000.GradeName, EDMT1000.Disabled , EDMT1000.IsCommon,  
	EDMT1000.CreateUserID, EDMT1000.CreateDate, EDMT1000.LastModifyUserID, EDMT1000.LastModifyDate, EDMT1000.Notes
	FROM EDMT1000 WITH (NOLOCK)
    LEFT JOIN EDMT0099 WITH (NOLOCK) ON EDMT1000.LevelID = EDMT0099.ID AND EDMT0099.Disabled = 0 AND EDMT0099.CodeMaster = ''Level''
	WHERE  EDMT1000.APK ='''+ @APK +'''
'

--PRINT(@sSQL)
EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

