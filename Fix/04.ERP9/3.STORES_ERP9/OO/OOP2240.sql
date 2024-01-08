IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2240]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2240]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
-- Kiểm tra trước khi xóa/sửa và xóa thành công dữ liệu của quản lí thiết bị
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Đình Hoà, Date: 10/10/2020


CREATE PROCEDURE [dbo].[OOP2240] ( 
	@DivisionID VARCHAR(50),	-- Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@APK NVARCHAR(MAX),
	@APKList NVARCHAR(MAX),
	@TableID NVARCHAR(MAX), 	-- OOT2240
	@Mode TINYINT,				
	@IsDisable TINYINT,
	@UserID VARCHAR(50) --Biến môi trường
) 
AS 
BEGIN
	DECLARE @sSQL NVARCHAR(MAX)

		SET @sSQL = '
					DECLARE @Status TINYINT,
							@Message NVARCHAR(1000),
							@Cur CURSOR,
							@DelAPK VARCHAR(50)
					DECLARE @OOT2240temp TABLE (
							Status TINYINT,
							MessageID VARCHAR(100),
							Params VARCHAR(4000))
					SET @Status = 0
					SET @Message = ''''
					INSERT INTO @OOT2240temp (	Status, MessageID, Params) 
												SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
												UNION ALL
												SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
					SET @Cur = CURSOR SCROLL KEYSET FOR
					SELECT APK FROM OOT2240 WITH (NOLOCK) WHERE APK IN (''' + @APKList + ''')
					OPEN @Cur
					FETCH NEXT FROM @Cur INTO @DelAPK
					WHILE @@FETCH_STATUS = 0
					BEGIN
						EXEC OOP9000 ''' + @DivisionID + ''', NULL, ''' + @TableID + ''', @DelAPK,NULL, NULL, NULL, @Status OUTPUT
						
						IF (SELECT @Status) = 1
							BEGIN			
								DECLARE @BookingID VARCHAR(50)
								SELECT @BookingID = BookingID FROM OOT2240 WHERE APK = @DelAPK		
											
								UPDATE @OOT2240temp SET Params = ISNULL(Params, '''') + @BookingID + '','' WHERE MessageID = ''00ML000052''
							END		
						ELSE
							BEGIN
								DECLARE @APKSettingTime VARCHAR(50)

								SET @APKSettingTime = (SELECT APKSettingTime FROM OOT2240 WHERE APK = @DelAPK)

								IF @APKSettingTime != ''''
								BEGIN
									--DELETE FROM OOT0033 WHERE APK = @APKSettingTime
									DELETE FROM ST0033 WHERE APK = @APKSettingTime

									UPDATE OOT2240 SET DeleteFlg = 1 WHERE APKSettingTime = @APKSettingTime AND GETDATE() < PlanStartDate
								END
								ELSE
								BEGIN
									UPDATE OOT2240 SET DeleteFlg = 1 WHERE APK = @DelAPK
								END
							END
						FETCH NEXT FROM @Cur INTO @DelAPK
					SET @Status = 0
					END
					CLOSE @Cur
					SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params FROM @OOT2240temp WHERE Params IS NOT NULL'
		PRINT (@sSQL)
		EXEC (@sSQL)
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
