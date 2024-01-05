IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP0031]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP0031]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
-- 
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Bùi Đức Nhân, Date: 03/05/2019
-- Modified by Khâu Vĩnh Tâm, Date 06/08/2019 Thay đổi điều kiện xóa
-- <Example> EXEC OOP0031 'DTI', NULL, NULL, 'OOT0030', 1, 0, 'VINHTAM'

CREATE PROCEDURE [dbo].[OOP0031] ( 
	@DivisionID VARCHAR(50),	-- Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@APK NVARCHAR(MAX),
	@APKList NVARCHAR(MAX),
	@TableID NVARCHAR(MAX), 	-- OOT0030
	@Mode TINYINT,				-- 0: Sửa, 1: Xóa
	@IsDisable TINYINT,
	@UserID VARCHAR(50) --Biến môi trường
) 
AS 
BEGIN
	DECLARE @sSQL NVARCHAR(MAX)

	IF (@Mode = 1)
	BEGIN
		SET @sSQL = '
					DECLARE @Status TINYINT,
							@Message NVARCHAR(1000),
							@Cur CURSOR,
							@DelAPKYearID VARCHAR(50),
							@DelYearID VARCHAR(50)
					DECLARE @OOT0030temp TABLE (
							Status TINYINT,
							MessageID VARCHAR(100),
							Params VARCHAR(4000))
					SET @Status = 0
					SET @Message = ''''
					INSERT INTO @OOT0030temp (	Status, MessageID, Params) 
												SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
												UNION ALL
												SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
					SET @Cur = CURSOR SCROLL KEYSET FOR
					SELECT APK , YearID FROM OOT0030 WITH (NOLOCK) WHERE APK IN (''' + @APKList + ''')
					OPEN @Cur
					FETCH NEXT FROM @Cur INTO @DelAPKYearID, @DelYearID
					WHILE @@FETCH_STATUS = 0
					BEGIN
						EXEC OOP9000 ''' + @DivisionID + ''', NULL, ''' + @TableID + ''', NULL, @DelYearID, NULL, NULL, @Status OUTPUT
						IF EXISTS (SELECT TOP 1 1 FROM OOT0030 WHERE DivisionID != ''' + @DivisionID + ''')
							UPDATE @OOT0030temp SET Params = ISNULL(Params, '''') + @DelYearID + '','' WHERE MessageID = ''00ML000050''
						ELSE IF (SELECT @Status) = 1
							UPDATE @OOT0030temp SET Params = ISNULL(Params, '''') + @DelYearID + '','' WHERE MessageID = ''00ML000052''
						ELSE 
							BEGIN
								DELETE FROM OOT0030 WHERE APK = @DelAPKYearID
							END
						FETCH NEXT FROM @Cur INTO @DelAPKYearID, @DelYearID
					SET @Status = 0
					END
					CLOSE @Cur
					SELECT Status, MessageID, LEFT(Params,LEN(Params) - 1) AS Params FROM @OOT0030temp WHERE Params IS NOT NULL'
		EXEC (@sSQL)
		--PRINT (@sSQL)
	END
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
