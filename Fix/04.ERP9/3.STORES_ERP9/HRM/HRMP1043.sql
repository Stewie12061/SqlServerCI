IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP1043]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP1043]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load đổ nguồn màn hình xem thông tin lĩnh vực đào tạo
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Hải Long on 08/09/2017
---- <Example>
---- Exec HRMP1043 @DivisionID='CTY',@UserID='ASOFTADMIN',@TrainingFieldID=''
---- 

CREATE PROCEDURE [dbo].[HRMP1043]
( 
  @DivisionID NVARCHAR(50),
  @UserID NVARCHAR(50),
  @APK NVARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)

SET @sSQL = N' 		
SELECT HRMT1040.APK, HRMT1040.DivisionID, HRMT1040.TrainingFieldID, HRMT1040.TrainingFieldName, HRMT1040.Description, HRMT1040.Disabled, HRMT1040.IsCommon, 
CASE WHEN HRMT1040.Disabled = 1 THEN N''Có'' ELSE N''Không'' END DisabledName,
CASE WHEN HRMT1040.IsCommon = 1 THEN N''Có'' ELSE N''Không'' END IsCoName,
HRMT1040.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT1040.CreateUserID) CreateUserID, HRMT1040.CreateDate, 
HRMT1040.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT1040.LastModifyUserID) LastModifyUserID, HRMT1040.LastModifyDate
FROM HRMT1040 WITH (NOLOCK)
WHERE HRMT1040.APK = ''' + @APK + ''''

--PRINT(@sSQL)
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
