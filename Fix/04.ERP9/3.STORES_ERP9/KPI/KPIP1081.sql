IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[KPIP1081]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[KPIP1081]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
-- Ki?m tra tru?c khi xóa/s?a danh sách bu?c
-- N?u mã lo?i hình chua du?c s? d?ng thì cho phép xóa (Xóa ng?m) ngu?c l?i thì báo message ID dã s? d?ng không du?c phép xóa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Cao Th? Phu?ng, Date: 04/10/2017
-- <Example> EXEC OOP1031 'AS', '', '', 'OOT1030', 1, 0, NULL

CREATE PROCEDURE [dbo].[KPIP1081] ( 
	@DivisionID VARCHAR(50),-- Tru?ng h?p @DivisionID dúng v?i DivisionID dang nh?p thì cho xóa
	@APK VARCHAR(50),		-- Tru?ng h?p s?a
	@APKList NVARCHAR(MAX),	-- Tru?ng h?p xóa ho?c x? lý enable/disable
	@TableID NVARCHAR(50),	-- "OOT1030"	
	@Mode TINYINT,			-- 0: S?a, 1: Xóa; 2: S?a (Disable/Enable)
	@IsDisable TINYINT,	-- 1: Disable; 0: Enable
	@UserID VARCHAR(50)
	) 
AS 
BEGIN
	DECLARE @sSQL NVARCHAR(MAX)
	IF @Mode = 1 -- Ki?m tra và xóa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000),
						@Cur CURSOR,
						@DelDivisionID VARCHAR(50),
						@DelAPKID VARCHAR(50),
						@DelTableName NVARCHAR(250)
				DECLARE @KPIT1080Temp TABLE (
						Status TINYINT,
						MessageID VARCHAR(100),
						Params NVARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @KPIT1080Temp (	Status, MessageID, Params) 
											SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
											UNION ALL
											SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, TableName FROM KPIT1080 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPKID, @DelDivisionID, @DelTableName
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC KPIP90000 ''' + @DivisionID + ''', ''' + @TableID + ''', @DelTableName, @Status OUTPUT
					IF (@DelDivisionID NOT IN (''@@@'', ''' + @DivisionID + '''))
						UPDATE @KPIT1080Temp SET Params = ISNULL(Params,'''') + @DelTableName + '','' WHERE MessageID = ''00ML000050''
					ELSE IF (SELECT @Status) = 1
						UPDATE @KPIT1080Temp SET Params = ISNULL(Params,'''') + @DelTableName + '','' WHERE MessageID = ''00ML000052''
					ELSE 
						BEGIN
							DELETE FROM KPIT1080 WHERE CAST(APK AS VARCHAR(50)) = @DelAPKID
							DELETE FROM KPIT1081 WHERE CAST(APKMaster AS VARCHAR(50)) = @DelAPKID
						END					
					FETCH NEXT FROM @Cur INTO @DelAPKID, @DelDivisionID, @DelTableName
					SET @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params FROM @KPIT1080Temp WHERE Params IS NOT NULL'
			EXEC (@sSQL)
			-- PRINT (@sSQL)
	END
END




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
