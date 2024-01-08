IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2050]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
	DROP PROCEDURE [DBO].[SOP2050]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Thông báo nhân viên vượt hạn mức quota
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
-- <Example>
-- SOP2050 'DTI', 'HUULOI'
-- </Example>
----Created by BẢO TOÀN on 06/09/2019
CREATE PROC SOP2050
@DivisionID varchar(50),
@UserID varchar(50)
as
BEGIN TRY
	--Khai báo
	DECLARE @isNotification bit = 0
	--Gọi store SOP20504 kiểm tra có nhân viên vượt hạn mức hay không?
	EXEC SOP20504 @DivisionID,@UserID,1,1, @isNotification output
	--Nếu có tồn nhân viên vượt hạn mức thì thông báo chuông
	IF @isNotification = 1
	BEGIN
		--OOT9002 : Dữ liệu Thông báo - Cảnh báo
		--OOT9003 : Dữ liệu Thông báo - Cảnh báo theo User
		--SELECT TOP 1 *  FROM OOT9002 WHERE apk = 'F70A5B2F-2523-4406-890B-FFEA23951AD3' ORDER BY CreateDate DESC
		--SELECT TOP 1 *  FROM OOT9003 WHERE APKMaster = 'F70A5B2F-2523-4406-890B-FFEA23951AD3' UserID = 'HUULOI' ORDER BY CreateDate DESC
		DECLARE @APK_OOT9002 UNIQUEIDENTIFIER = NEWID(),
				@Description NVARCHAR(MAX)= N'Danh sách nhân viên sale vượt hạn mức',
				@ModuleID VARCHAR(50) = 'SO',
				@ScreenID VARCHAR(50) = 'SOF2053',
				@UrlCustom NVARCHAR(500) = '/PopupSelectData/Index/SO/SOF2053',
				@CurrentDate Datetime = GETDATE(),
				@CurrentDateString Datetime = FORMAT(GETDATE(),'yyyyMMdd'),
				@ExpiryDate Datetime = DATEADD(MONTH,1,GETDATE()),
				@ShowType int = 2
		--Hiệu lực cảnh báo 1 ngày
		IF NOT EXISTS (SELECT 1 
					FROM OOT9002 T2 WITH (NOLOCK) 
					INNER JOIN OOT9003 T3 WITH (NOLOCK) ON T2.APK = T3.APKMaster
					WHERE  T2.ScreenID = @ScreenID 
					AND FORMAT(T2.CreateDate,'yyyyMMdd') = @CurrentDateString
					AND T3.UserID = @UserID
					)
		BEGIN
			INSERT INTO OOT9002(APK, APKMaster, [Description], ModuleID, UrlCustom, CreateDate, EffectDate, ExpiryDate, Title,ShowType,ScreenID)
			VALUES(@APK_OOT9002,@APK_OOT9002,@Description,@ModuleID,@UrlCustom,@CurrentDate,@CurrentDate,@ExpiryDate,@Description,@ShowType,@ScreenID)

			INSERT INTO OOT9003(APKMaster,UserID, DivisionID)
			VALUES(@APK_OOT9002,@UserID,@DivisionID)
		END
	END
	--OK
END TRY
BEGIN CATCH
	PRINT ERROR_MESSAGE()
END CATCH
