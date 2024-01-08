IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1063]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1063]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load from thông tin danh mục loại hoạt động  
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
	EDMP1063 @DivisionID = 'VF', @UserID = 'ASOFTADMIN', @APK = ''

	EDMP1063 @DivisionID, @UserID, @APK
----*/

CREATE PROCEDURE EDMP1063
( 
	 @DivisionID VARCHAR(50), 
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N''
     
SET @sSQL = @sSQL + N'
	SELECT EDMT1060.APK, EDMT1060.DivisionID, EDMT1060.ActivityTypeID, EDMT1060.ActivityTypeName, EDMT1060.IsCommon, 
	EDMT1060.Disabled, EDMT1060.CreateUserID, EDMT1060.CreateDate, EDMT1060.LastModifyUserID, EDMT1060.LastModifyDate
	FROM EDMT1060 WITH (NOLOCK)
	WHERE EDMT1060.APK = '''+@APK+''''
EXEC (@sSQL)
--PRINT(@sSQL)

   
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
