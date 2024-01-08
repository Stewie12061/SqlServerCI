IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP1092]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP1092]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Đổ nguồn màn hình cập nhật chấm công ngày/tháng (HRMF1091,HRMF1093)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Phương Thảo, Date: 14/12/2023
-- <Example>
---- 
/*-- <Example>
	exec HRMP1092 @DivisionID=N'BBA-SI',@UserID=N'ADMIN',@APK=N'83e2ee2e-ca59-48be-99ee-21640a47fa60'
----*/

CREATE PROCEDURE [HRMP1092] 
( 
	@DivisionID NVARCHAR(50),
	@UserID NVARCHAR(50),
	@APK NVARCHAR(50)
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)

SET @sSQL = '
		SELECT HT13.APK
     		, HT13.DivisionID
	     	, HT13.AbsentTypeID
	     	, HT13.Caption
            , HT13.AbsentName
	     	, HT13.UnitID
	     	, HT13.TypeID
	     	, HT13.ProbationaryTypeID
	     	, HT13.Disabled
	     	, HT13.Orders
	     	, HT13.ConvertUnit
	     	, HT13.MaxValue
	     	, HT13.IsCondition
	     	, HT13.ConditionCode
	     	, HT13.IsTransfer
	     	, HT13.IsAnnualLeave --- công phép thường niên (HRMF1093)
	     	, HT13.ParentID
	     	, HT13.IsMonth
	     	, HT13.CreateUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HT13.CreateUserID) CreateUserID
	     	, HT13.CreateDate
	     	, HT13.LastModifyUserID +'' - ''+ (SELECT TOP 1 UserName FROM AT1405 WHERE UserID = HT13.LastModifyUserID) LastModifyUserID
	     	, HT13.LastModifyDate
    FROM HT1013 HT13 WITH (NOLOCK)
    WHERE HT13.DivisionID = '''+@DivisionID+'''
    AND HT13.APK = '''+@APK+''''

PRINT @sSQL			
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
