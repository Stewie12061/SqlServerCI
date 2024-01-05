IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP0041]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP0041]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
-- Kiểm tra trước khi xóa/sửa và xóa thành công đối tượng Sự kiện phát sinh
-- Nếu EventID của sự kiện phát sinh đã được sử dụng thì không cho phép xóa/sửa
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Khâu Vĩnh Tâm, Date: 09/03/2019
-- Modified by: Bùi Đức Nhân, Date: 19/03/2019
-- <Example> EXEC OOP0041 'AS', 'aa', 'OOT0030', NULL

CREATE PROCEDURE [dbo].[OOP0041] (
	@DivisionID VARCHAR(50),
	@APKList NVARCHAR(MAX),
	@APK VARCHAR(50),
	@TableID NVARCHAR(50),
	@Mode TINYINT,
	@UserID VARCHAR(50)
)
AS 
BEGIN
	DECLARE @sSQL NVARCHAR(MAX)
	SET @sSQL = '
			DECLARE @Status TINYINT,
					@Message NVARCHAR(1000),
					@Cur CURSOR,
					@DelAPK VARCHAR(50),
					@DelEventID VARCHAR(50)
			Declare @OOT0030Temp TABLE (
					Status TINYINT,
					MessageID VARCHAR(100),
					Params VARCHAR(4000))
			SET @Status = 0
			SET @Message = ''''
			INSERT INTO @OOT0030Temp (	Status, MessageID, Params) 
										SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
										UNION ALL
										SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
			SET @Cur = CURSOR SCROLL KEYSET FOR
			SELECT APK, EventID FROM OOT0042 WHERE APK IN (''' + @APKList + ''')
			OPEN @Cur
			FETCH NEXT FROM @Cur INTO @DelAPK, @DelEventID
			WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC OOP9000 ''' + @DivisionID + ''', NULL, ''' + @TableID + ''', NULL, @DelAPK, NULL, NULL, @Status OUTPUT
					IF (SELECT @Status) = 1
						UPDATE @OOT0030Temp SET Params = ISNULL(Params, '''') + @DelEventID + '','' WHERE MessageID = ''00ML000052''
					ELSE
						BEGIN
							DELETE FROM OOT0042 WHERE APK = @DelAPK
							DELETE FROM OOT0043 WHERE APKMaster = @DelAPK
						END
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelEventID
				END
			CLOSE @Cur

			SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params
			FROM @OOT0030Temp
			WHERE Params IS NOT NULL'

	--PRINT @sSQL
	EXEC (@sSQL)
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
