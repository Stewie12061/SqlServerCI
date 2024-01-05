IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BEMP1001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BEMP1001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Store xóa BEMT2000
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---
-- <Example>
--- EXEC BEMP1001 @DivisionID=N'MK',@TableID=N'BEMT1000',@APK=NULL,@APKList=N'c6303aae-4d00-45bb-8270-526c119ca799',@Mode=1,@IsDisable=0,@UserID=N'ASOFTADMIN'
---- Created by: Tấn Thành, Date 16/06/2020

CREATE PROCEDURE [dbo].[BEMP1001](
	@DivisionID VARCHAR(50), 	-- Tr??ng h?p @DivisionID ?úng v?i DivisionID ??ng nh?p thì cho xóa
	@APK VARCHAR(50), 			-- Tr??ng h?p s?a
	@APKList NVARCHAR(MAX), 	-- Tr??ng h?p xóa ho?c x? lí enable/disable
	@TableID NVARCHAR(50), 		-- "BEMT2000"	
	@Mode TINYINT, 				-- 0: S?a, 1: Xóa; 2: S?a (Disable/Enable)
	@IsDisable TINYINT, 		-- 1: Disable; 0: Enable
	@UserID VARCHAR(50)
)
AS
BEGIN
	DECLARE @sSQL NVARCHAR(MAX)
	IF @Mode = 1
		BEGIN
			SET @sSQL = '
				DECLARE @Status TINYINT,
						@Message NVARCHAR(1000), 
						@Cur CURSOR,
						@DelAPK VARCHAR(50),
						@DelFeeID VARCHAR(50),
						@DelFeeName NVARCHAR(500)

				DECLARE @TempTB TABLE (
						Status TINYINT, 
						MessageID VARCHAR(100), 
						Params NVARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @TempTB (Status, MessageID, Params) 
				SELECT 2 AS Status, ''00ML000165'' AS MessageID, NULL AS Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT B1.APK, B1.FeeID, B1.FeeName
				FROM BEMT1000 B1 WITH (NOLOCK)
				WHERE CAST(B1.APK AS VARCHAR(100)) IN (''' + @APKList + ''') 
				OPEN @CUR
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelFeeID, @DelFeeName
				WHILE @@FETCH_STATUS = 0
				BEGIN
					EXEC BEMP9000 ''' + @DivisionID + ''', NULL, ''' + @TableID + ''', @DelAPK, NULL, NULL, NULL, @Status OUTPUT
					IF @Status = 1
						UPDATE @TempTB SET Params = ISNULL(Params, '''') + @DelFeeName + '', '' WHERE MessageID = ''00ML000165''
					ELSE 
					BEGIN
						DELETE FROM BEMT1000 WHERE APK = @DelAPK
					END					
					FETCH NEXT FROM @Cur INTO @DelAPK, @DelFeeID, @DelFeeName
					SET @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params FROM @TempTB WHERE Params IS NOT NULL
			'
			EXEC (@sSQL)
			PRINT (@sSQL)
		END
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
