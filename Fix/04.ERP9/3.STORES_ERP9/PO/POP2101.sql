IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2101]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2101]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO













-- <Summary>
---- Delete master và detail tiến độ giao hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 09/08/2019 by Đình Ly

CREATE PROCEDURE [dbo].[POP2101] 
(
	@DivisionID VARCHAR(50), 	
	@APK VARCHAR(50), 			
	@APKList NVARCHAR(MAX), 	
	@TableID NVARCHAR(50), 		
	@Mode TINYINT, 				
	@IsDisable TINYINT, 		
	@UserID VARCHAR(50)
) 
AS 
BEGIN
	DECLARE @sSQL NVARCHAR(MAX)
	IF @Mode = 1 -- Kiểm tra và xóa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT, 
						@Message NVARCHAR(1000), 
						@Cur CURSOR, 
						@DelDivisionID VARCHAR(50),
						@DelAPK VARCHAR(50), 
						@DelVoucherNo NVARCHAR(250),
						@DelPOrderID NVARCHAR(250)

				DECLARE @OT3003 TABLE (
						Status TINYINT, 
						MessageID VARCHAR(100), 
						Params NVARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''

				INSERT INTO @OT3003 (Status, MessageID, Params) 
				SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
					union all
				SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
				
				SET @Cur = CURSOR SCROLL KEYSET FOR

				SELECT APK, DivisionID, VoucherNo, POrderID FROM OT3003 WITH (NOLOCK)
				WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')
				
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelVoucherNo, @DelPOrderID
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC OOP9000 ''' + @DivisionID + ''', NULL, ''' + @TableID + ''', @DelAPK, @DelVoucherNo, NULL, NULL, @Status OUTPUT
					IF (@DelDivisionID != ''' + @DivisionID + ''')
							UPDATE @OT3003 SET Params = ISNULL(Params, '''') + @DelVoucherNo + '', '' WHERE MessageID = ''00ML000050''
					ELSE IF (SELECT @Status) = 1
							UPDATE @OT3003 SET Params = ISNULL(Params, '''') + @DelVoucherNo + '', '' WHERE MessageID = ''00ML000052''
					ELSE 
						BEGIN
							-- Xóa master tiến độ nhận hàng OT3003
							DELETE FROM OT3003 WHERE CAST(APK AS VARCHAR(50)) = @DelAPK

							-- Update lại detail tiến độ nhận hàng OT3002
							UPDATE OT3002 SET 
								Quantity01 = 0, Quantity02 = 0, Quantity03 = 0, Quantity04 = 0, Quantity05 = 0,
								Quantity06 = 0, Quantity07 = 0, Quantity08 = 0, Quantity09 = 0, Quantity10 = 0,
								Quantity11 = 0, Quantity12 = 0, Quantity13 = 0, Quantity14 = 0, Quantity15 = 0,
								Quantity16 = 0, Quantity17 = 0, Quantity18 = 0, Quantity19 = 0, Quantity20 = 0, 
								Quantity21 = 0, Quantity22 = 0, Quantity23 = 0, Quantity24 = 0, Quantity25 = 0,
								Quantity26 = 0, Quantity27 = 0, Quantity28 = 0, Quantity29 = 0, Quantity30 = 0
							WHERE  POrderID = @DelPOrderID

							-- Xóa thông tin tiến độ giao hàng OT3003_MT
							DELETE FROM OT3003_MT WHERE POrderID = @DelPOrderID
						END					
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelVoucherNo, @DelPOrderID
					SET @Status = 0
				END

				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params FROM @OT3003 WHERE Params IS NOT NULL'

			EXEC (@sSQL)
			PRINT (@sSQL)
	END
END




















GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
