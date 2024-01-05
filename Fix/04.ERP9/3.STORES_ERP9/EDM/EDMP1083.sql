IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1083]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1083]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load from thông tin danh mục Feeling (EDMF1082)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Hồng Thảo, Date: 25/08/2018
----Modified by on
-- <Example>
---- 
/*-- <Example>
	EDMP1083 @DivisionID = 'VF', @UserID = 'ASOFTADMIN', @APK = ''

	EDMP1083 @DivisionID, @UserID, @APK
----*/

CREATE PROCEDURE EDMP1083
( 
	 @DivisionID VARCHAR(50), 
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N''
     
SET @sSQL = @sSQL + N'
	SELECT EDMT1080.APK, EDMT1080.DivisionID, EDMT1080.FeelingID, EDMT1080.FeelingName, EDMT1080.IsCommon, 
	EDMT1080.Disabled, EDMT1080.CreateUserID, EDMT1080.CreateDate, EDMT1080.LastModifyUserID, EDMT1080.LastModifyDate
	FROM EDMT1080 WITH (NOLOCK) 
	WHERE EDMT1080.APK = '''+@APK+''''
EXEC (@sSQL)
--PRINT(@sSQL)

   
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
