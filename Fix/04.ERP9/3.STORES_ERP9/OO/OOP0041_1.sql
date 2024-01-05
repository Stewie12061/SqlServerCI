IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP0041_1]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP0041_1]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Insert và update dữ liệu của bảng oot0042 và oot0043
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 19/08/2015 by Truong Lam
-- <Example>

CREATE PROCEDURE [dbo].[OOP0041_1]
(
	@APK NVARCHAR(250),
	@DivisionID NVARCHAR(250),
	@APKMaster NVARCHAR(250),
	@EventID NVARCHAR(250),
	@UserID NVARCHAR(250),
	@SendNotification NVARCHAR(250),
	@SendEmail NVARCHAR(250),
	@RemindAfterDay NVARCHAR(250),

	@ModuleID NVARCHAR(250),
	@GroupID NVARCHAR(250),
	@EventName NVARCHAR(250),

	@EmailTemplateID NVARCHAR(250),
	@CreateDate DATETIME,

	@CreateUserID NVARCHAR(250),
	@LastModifyDate DATETIME,
	@LastModifyUserID NVARCHAR(250),

	@Warning NVARCHAR(250),
	@WarningTypeID NVARCHAR(250)

)
AS
BEGIN
---
	IF EXISTS (SELECT TOP 1 * FROM OOT0042 A1 WITH (NOLOCK)
		WHERE A1.EventID = @EventID AND A1.ModuleID = @ModuleID)
		BEGIN
			UPDATE OOT0042
			SET ModuleID = @ModuleID, EventID= @EventID, EventName = @EventName, EmailTemplateID = @EmailTemplateID
			, CreateDate = @CreateDate, CreateUserID = @CreateUserID, LastModifyDate = @LastModifyDate, LastModifyUserID = @LastModifyUserID, WarningTypeID = @WarningTypeID
			WHERE EventID = @EventID AND ModuleID = @ModuleID

			IF EXISTS (SELECT 1 FROM OOT0043 A2 WITH (NOLOCK)
			WHERE A2.EventID = @EventID AND A2.ModuleID = @ModuleID AND A2.GroupID = @GroupID)
				BEGIN
					UPDATE OOT0043
					SET UserID = @UserID, SendNotification = @SendNotification, SendEmail = @SendEmail
					, RemindAfterDay = @RemindAfterDay, CreateDate = @CreateDate, CreateUserID = @CreateUserID, LastModifyDate = @LastModifyDate, LastModifyUserID = @LastModifyUserID, Warning = @Warning
					WHERE EventID = @EventID AND ModuleID = @ModuleID AND GroupID = @GroupID
				END
			ELSE
				BEGIN
					--- set @APKMaster với giá trị mới
					SELECT @APKMaster = A2.APK FROM OOT0042 A2 WITH (NOLOCK)
					WHERE A2.EventID = @EventID AND A2.ModuleID = @ModuleID

					INSERT INTO OOT0043(APK, DivisionID, APKMaster, ModuleID, GroupID, UserID, EventID, SendNotification, SendEmail, RemindAfterDay, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, Warning) 
					VALUES (@APK, @DivisionID, @APKMaster, @ModuleID, @GroupID, @UserID, @EventID, @SendNotification, @SendEmail, @RemindAfterDay, @CreateDate, @CreateUserID, @LastModifyDate, @LastModifyUserID, @Warning)
				END
		END
	ELSE
		BEGIN
			INSERT INTO OOT0042(APK, DivisionID, ModuleID, EventID, EventName, EmailTemplateID, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, WarningTypeID) 
			VALUES (@APK, @DivisionID, @ModuleID, @EventID, @EventName, @EmailTemplateID, @CreateDate, @CreateUserID, @LastModifyDate, @LastModifyUserID, @WarningTypeID)

			INSERT INTO OOT0043(APK, DivisionID, APKMaster, ModuleID, GroupID, UserID, EventID, SendNotification, SendEmail, RemindAfterDay, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID, Warning) 
			VALUES (@APK, @DivisionID, @APKMaster, @ModuleID, @GroupID, @UserID, @EventID, @SendNotification, @SendEmail, @RemindAfterDay, @CreateDate, @CreateUserID, @LastModifyDate, @LastModifyUserID, @Warning)
		END
END






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
