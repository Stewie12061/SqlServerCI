IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP1053]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP1053]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load đổ nguồn màn hình xem thông tin khóa đào tạo
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Hải Long on 08/09/2017
----Updated by Võ Dương on 22/08/2023
---- <Example>
---- Exec HRMP1053 @DivisionID='AS',@UserID='ASOFTADMIN',@TrainingCourseID='DT1'
---- 

CREATE PROCEDURE [dbo].[HRMP1053]
( 
  @DivisionID NVARCHAR(50),
  @UserID NVARCHAR(50),
  @APK NVARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)

SET @sSQL = ' 		
SELECT
HRMT1050.APK,
CASE WHEN HRMT1050.DivisionID = ''@@@'' THEN NULL ELSE HRMT1050.DivisionID END AS DivisionID,
TrainingCourseID,
HRMT1050.TrainingFieldID,
HRMT1040.TrainingFieldName,
TrainingType,
HT0099.Description AS TrainingTypeName,
HRMT1050.ObjectID,
CASE
        WHEN TrainingType = 1 THEN AT1202.ObjectName
        ELSE (SELECT TOP(1) UserName FROM AT1405 where HRMT1050.ObjectID = AT1405.UserID)
    END AS ObjectName
,
HRMT1050.Address,
HRMT1050.Description,
HRMT1050.Disabled,
HRMT1050.IsCommon,
CASE WHEN HRMT1040.Disabled = 1 THEN N''Có'' ELSE N''Không'' END DisabledName,
CASE WHEN HRMT1050.IsCommon = 1 THEN N''Có'' ELSE N''Không'' END IsCoName,
HRMT1050.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT1050.CreateUserID) CreateUserID,
HRMT1050.CreateDate, 
HRMT1050.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HRMT1050.LastModifyUserID) LastModifyUserID,
HRMT1050.LastModifyDate
FROM HRMT1050 WITH (NOLOCK)
LEFT JOIN HRMT1040 WITH (NOLOCK) ON HRMT1040.TrainingFieldID = HRMT1050.TrainingFieldID
LEFT JOIN HT0099 WITH (NOLOCK) ON HT0099.ID = HRMT1050.TrainingType AND CodeMaster = ''TrainingType''
LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.ObjectID = HRMT1050.ObjectID

WHERE HRMT1050.DivisionID IN (''' + @DivisionID + ''', ''@@@'')
AND CONVERT(NVARCHAR(50), HRMT1050.APK) = ''' + @APK + ''''

--PRINT(@sSQL)
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
