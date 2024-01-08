IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CMNP0011]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CMNP0011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO











-- <Summary>
---- Màn hình thiết lập dữ liệu mặc định màn hình
---- Insert or Update 2 bảng CMNT0010, CMNT0011
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 17/10/2019 by Đình Ly
-- <Example>

CREATE PROCEDURE [dbo].[CMNP0011]
(	-- Master 
	@ScreenID NVARCHAR(250),
	@Analysis NVARCHAR(250),
	-- Detail
	@APK NVARCHAR(250),
	@APKMaster NVARCHAR(250),
	@ColumnID NVARCHAR(250),
	@Value NVARCHAR(250),
	-- Dùng chung
	@NewAPK NVARCHAR(250),
	@NewAPKMaster NVARCHAR(250),
	@DivisionID NVARCHAR(250),
	@UserID NVARCHAR(250),
	@CreateDate DATETIME,
	@CreateUserID NVARCHAR(250),
	@LastModifyDate DATETIME,
	@LastModifyUserID NVARCHAR(250)
)
AS
BEGIN
	DECLARE @APKCMNT0010 NVARCHAR(250) 

	-- Update lại bảng master nếu dữ liệu master đã tồn tại
	IF EXISTS (SELECT TOP 1 * FROM CMNT0010 C1 WITH (NOLOCK)
	WHERE C1.ScreenID = @ScreenID AND C1.Analysis = @Analysis)
		BEGIN		
			-- Update lại bảng detail nếu dữ liệu detail đã tồn tại
			IF EXISTS (SELECT TOP 1 * FROM CMNT0011 C2 WITH (NOLOCK)
			INNER JOIN CMNT0010 C1 ON C1.APK = C2.APKMASTER
			WHERE C1.ScreenID = @ScreenID AND C1.Analysis = @Analysis AND C2.APK = @APK)
				BEGIN
					UPDATE CMNT0011
					SET Value = @Value, ColumnID = @ColumnID, CreateDate = @CreateDate, CreateUserID = @CreateUserID,
						LastModifyDate = @LastModifyDate, LastModifyUserID = @LastModifyUserID
					WHERE APK = @APK
				END
			-- Insert bảng detail nếu dữ liệu detail chưa tồn tại
			ELSE
				BEGIN
					-- Get APK của master để cập nhật APKMaster cho detail 
					SELECT @APKCMNT0010 = C1.APK 
					FROM CMNT0010 C1 WITH (NOLOCK)
					WHERE C1.ScreenID = @ScreenID AND C1.Analysis = @Analysis
					-- Insert bảng detail
					INSERT INTO CMNT0011
					VALUES (@NewAPK, @APKCMNT0010, @DivisionID, @Value, @ColumnID, @CreateUserID, @LastModifyDate, @LastModifyUserID, @CreateDate)
				END
		END
	-- Insert bảng master và bảng detail
	-- Trường hợp master chưa tồn tại đồng nghĩ detail của master đó cũng chưa tồn tại
	ELSE
		BEGIN
			-- Insert bảng master
			INSERT INTO CMNT0010
			VALUES (@NewAPK, @DivisionID, @Analysis, @ScreenID, @CreateDate, @CreateUserID, @LastModifyDate, @LastModifyUserID)
			-- Insert bảng detail
			INSERT INTO CMNT0011
			VALUES (@NewAPK, @NewAPKMaster, @DivisionID, @Value, @ColumnID, @CreateUserID, @LastModifyDate, @LastModifyUserID, @CreateDate)
		END
END











GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
