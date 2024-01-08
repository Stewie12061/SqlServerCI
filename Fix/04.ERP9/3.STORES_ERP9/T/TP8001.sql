IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[TP8001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[TP8001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Kiểm tra cảnh báo công nợ phải trả đến hạn, quá hạn
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Lê Hoàng, Date: 16/06/2021
----Modified by ... on ... 
-- <Example>
---- 
/*-- <Example>
	EXEC TP8001 @DivisionID, @APK, @APKList, @FormID, @Mode, @UserID
----*/

CREATE PROCEDURE TP8001
( 
	@DivisionID VARCHAR(50),
	@Date DATETIME,
	@UserID NVARCHAR(50)
) 
AS 
BEGIN TRY
	DECLARE @sSQL NVARCHAR(MAX)
	--Khai báo
	DECLARE @isNotification BIT = 0
	--Gọi store OP0019_Date kiểm tra có đơn hàng sắp đến ngày giao theo qui cách sản phẩm hay không?
	CREATE TABLE #temp (Params INT, TypeID INT);
	INSERT INTO #temp
	EXEC AP1032 @DivisionID, @Date

	DECLARE @CountDue INT = 0,
			@CountOver INT = 0
	SELECT TOP 1 @CountDue = Params FROM #temp WHERE TypeID = 0 -- đến hạn
	SELECT TOP 1 @CountOver = Params FROM #temp WHERE TypeID = 1 -- quá hạn

	IF EXISTS (SELECT TOP 1 1 FROM #temp)
	SET @isNotification = 1;

	--Nếu có đơn hàng sắp đến ngày giao thì thông báo chuông
	IF @isNotification = 1
	BEGIN
		--OOT9002 : Master chuông
		--OOT9003 : Detail chuông	
		DECLARE @APK_OOT9002 UNIQUEIDENTIFIER = NEWID(),
				@Description NVARCHAR(MAX) = '', 
				@ModuleID VARCHAR(50) = 'S',
				@ScreenID VARCHAR(50) = NULL,
				@UrlCustom NVARCHAR(500) = '/',
				@CurrentDate Datetime = GETDATE(),
				@CurrentDateString Datetime = FORMAT(GETDATE(),'yyyyMMdd'),
				@ExpiryDate Datetime = DATEADD(MONTH,1,GETDATE()),
				@ShowType int = 1
		IF(@CountDue > 0)
		BEGIN
			SET @Description = CONCAT(@Description,N' Có ',@CountDue,N' nhà cung cấp có công nợ đến hạn!')
		END

		IF(@CountOver > 0)
		BEGIN
			SET @Description = CONCAT(@Description,N' Có ',@CountOver,N' nhà cung cấp có công nợ quá hạn!')
		END

		--Hiệu lực cảnh báo 1 ngày
		IF NOT EXISTS (SELECT 1 FROM OOT9002 WITH (NOLOCK) LEFT JOIN OOT9003 WITH (NOLOCK) ON OOT9002.APK = OOT9003.APKMaster 
		               WHERE ISNULL(OOT9002.ScreenID,'') = ISNULL(@ScreenID,'') AND FORMAT(OOT9002.CreateDate,'yyyyMMdd') = @CurrentDateString AND OOT9003.UserID = @UserID AND OOT9002.[Parameters] LIKE '' + @CountDue+@CountOver + '') AND
			   EXISTS (SELECT TOP 1 1 FROM AT0011 WITH(NOLOCK)
					  LEFT JOIN AT1103 WITH(NOLOCK) ON AT1103.DivisionID IN (AT0011.DivisionID,'@@@') AND AT1103.GroupID = AT0011.GroupID
					  WHERE AT0011.DivisionID = @DivisionID AND AT0011.WarningID = 11 AND AT1103.EmployeeID = @UserID)
		BEGIN
			INSERT INTO OOT9002(APK, APKMaster, [Description], ModuleID, UrlCustom, [Parameters], CreateDate, EffectDate, ExpiryDate, Title,ShowType,ScreenID)
			VALUES(@APK_OOT9002,@APK_OOT9002,@Description,@ModuleID,@UrlCustom,@CountDue+@CountOver,@CurrentDate,@CurrentDate,@ExpiryDate,@Description,@ShowType,@ScreenID)

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
