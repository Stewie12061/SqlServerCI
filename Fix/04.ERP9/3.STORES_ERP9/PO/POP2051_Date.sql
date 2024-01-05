IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2051_DATE]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2051_DATE]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
---- Thông báo đơn hàng sắp đến ngày nhận theo qui cách sản phẩm
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
-- <Example>
-- POP2051_Date 'DTI', 'HUULOI'
-- </Example>
----Created by Trọng Kiên on 11/12/2020
----Updated by Trọng Kiên on 23/02/2021: Bổ sung điều kiện kiểm tra số chứng từ, UserID để tạo thông báo

CREATE PROC POP2051_Date
@DivisionID varchar(50),
@RecieveDayDate INT,
@UserID varchar(50)
as
BEGIN TRY
	--Khai báo
	DECLARE @isNotification bit = 0
	--Gọi store POP0019_Date kiểm tra có đơn hàng sắp đến ngày nhận theo qui cách sản phẩm hay không?
	CREATE TABLE #temp (SOrderID Nvarchar(50) ,Date Datetime);
	INSERT INTO #temp
	EXEC POP0019_Date @DivisionID, '', @RecieveDayDate, @UserID

	DECLARE @Count INT = 0
	select @Count = count(*) from #temp

	IF EXISTS (select top 1 1 from #temp)
	SET @isNotification = 1;

	--Nếu có đơn hàng sắp đến ngày nhận thì thông báo chuông
	IF @isNotification = 1
	BEGIN
		--OOT9002 : Master chuông
		--OOT9003 : Detail chuông	
		DECLARE @APK_OOT9002 UNIQUEIDENTIFIER = NEWID(),
				@Description NVARCHAR(MAX)= concat(N'Có ',@Count,N' đơn hàng sắp đến ngày nhận hàng!'), 
				@ModuleID VARCHAR(50) = 'SO',
				@ScreenID VARCHAR(50) = 'POF2055',
				@UrlCustom NVARCHAR(500) = '/PopupSelectData/Index/PO/POF2055',
				@CurrentDate Datetime = GETDATE(),
				@CurrentDateString Datetime = FORMAT(GETDATE(),'yyyyMMdd'),
				@ExpiryDate Datetime = DATEADD(MONTH,1,GETDATE()),
				@ShowType int = 2
		--Hiệu lực cảnh báo 1 ngày
		IF NOT EXISTS (SELECT 1 FROM OOT9002 WITH (NOLOCK) LEFT JOIN OOT9003 WITH (NOLOCK) ON OOT9002.APK = OOT9003.APKMaster 
		               WHERE  OOT9002.ScreenID = @ScreenID AND FORMAT(OOT9002.CreateDate,'yyyyMMdd') = @CurrentDateString AND OOT9003.UserID = @UserID AND OOT9002.[Parameters] LIKE '' + @Count + '')
		BEGIN
			INSERT INTO OOT9002(APK, APKMaster, [Description], ModuleID, UrlCustom, [Parameters], CreateDate, EffectDate, ExpiryDate, Title,ShowType,ScreenID)
			VALUES(@APK_OOT9002,@APK_OOT9002,@Description,@ModuleID,@UrlCustom,@Count,@CurrentDate,@CurrentDate,@ExpiryDate,@Description,@ShowType,@ScreenID)

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
