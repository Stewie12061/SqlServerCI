IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP20530]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].EDMP20530
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Thông báo sắp đến Ngày dự thu
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
-- <Example>
-- SOP2053 'BE', 'ASOFTADMIN'
-- </Example>
----Created by ĐÌNH HÒA on 05/06/2020
CREATE PROC EDMP20530
@DivisionID varchar(50),
@UserID varchar(50)
as
BEGIN TRY
	--Khai báo
	DECLARE @isNotification bit = 0
	DECLARE @notifyID varchar(50)
	--Gọi store EDMP20531 kiểm tra có phiếu dự thu sắp đến ngày đóng phí hay không?
	EXEC EDMP20531 @DivisionID,@UserID,1,1,'', @isNotification output
	--Nếu có thì thông báo chuông
	IF @isNotification = 1
	BEGIN
		--OOT9002 : Master chuông
		--OOT9003 : Detail chuông	
		--SELECT TOP 1 *  FROM OOT9002 WHERE apk = 'F70A5B2F-2523-4406-890B-FFEA23951AD3' ORDER BY CreateDate DESC
		--SELECT TOP 1 *  FROM OOT9003 WHERE APKMaster = 'F70A5B2F-2523-4406-890B-FFEA23951AD3' UserID = 'HUULOI' ORDER BY CreateDate DESC
		DECLARE @APK_OOT9002 UNIQUEIDENTIFIER = NEWID(),
				@Description NVARCHAR(MAX)= N'Danh sách phiếu dự thu sắp đến ngày đóng phí',
				@ModuleID VARCHAR(50) = 'EDM',
				@ScreenID VARCHAR(50) = 'EDMF2053',
				@UrlCustom NVARCHAR(500) = '/PopupSelectData/Index/EDM/EDMF2053',
				@CurrentDate Datetime = GETDATE(),
				@CurrentDateString Datetime = FORMAT(GETDATE(),'yyyyMMdd'),
				@ExpiryDate Datetime = DATEADD(MONTH,1,GETDATE()),
				@ShowType int = 2,
				@CreateUserId VARCHAR(50) = @UserID
		--Hiệu lực cảnh báo 1 ngày
		--Kiếm tra đã thông báo trong ngày hôm đó hay chưa và có phải của UserID login hay không?
	    IF NOT EXISTS (SELECT 1 FROM OOT9002 WITH (NOLOCK) WHERE  ScreenID = @ScreenID AND FORMAT(CreateDate,'yyyyMMdd') = @CurrentDateString AND CreateUserID = @UserID)
		   BEGIN
			    INSERT INTO OOT9002(APK, APKMaster, [Description], ModuleID, UrlCustom, CreateDate, EffectDate, ExpiryDate, Title,ShowType,ScreenID, CreateUserID)
				VALUES(@APK_OOT9002,@APK_OOT9002,@Description,@ModuleID,@UrlCustom,@CurrentDate,@CurrentDate,@ExpiryDate,@Description,@ShowType,@ScreenID,@CreateUserId)

				INSERT INTO OOT9003(APKMaster,UserID, DivisionID)
				VALUES(@APK_OOT9002,@UserID,@DivisionID)
		   END
		
	END
	--OK
END TRY
BEGIN CATCH
	PRINT ERROR_MESSAGE()
END CATCH

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

--EXECUTE SOP2053 'BE','AS0098'
