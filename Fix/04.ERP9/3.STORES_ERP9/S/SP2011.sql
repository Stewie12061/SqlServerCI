IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SP2011]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SP2011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Store xóa PipeLine
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Tấn Thành, Date 06/10/2020

CREATE PROCEDURE [dbo].[SP2011] (
	@DivisionID VARCHAR(50), 	-- Tr??ng h?p @DivisionID ?úng v?i DivisionID ??ng nh?p thì cho xóa
	@APK VARCHAR(50), 			-- Tr??ng h?p s?a
	@APKList NVARCHAR(MAX), 	-- Tr??ng h?p xóa ho?c x? lí enable/disable
	@TableID NVARCHAR(50), 		-- "BEMT2010"	
	@Mode TINYINT, 				-- 0: S?a, 1: Xóa; 2: S?a (Disable/Enable)
	@IsDisable TINYINT, 		-- 1: Disable; 0: Enable
	@UserID VARCHAR(50)
	) 
AS 
BEGIN
	DECLARE @sSQL NVARCHAR(MAX)
	IF @Mode = 1 -- Kiểm tra và xóa.
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT, 
						@Cur CURSOR, 
						@DelDivisionID VARCHAR(50), 
						@DelAPK VARCHAR(50)
				BEGIN TRY
					BEGIN TRANSACTION;
					BEGIN 
						SET @Cur = CURSOR SCROLL KEYSET FOR
						SELECT S1.APK FROM ST2010 S1 WITH (NOLOCK) 
						WHERE CAST(S1.APK AS VARCHAR(50)) IN (''' + @APKList + ''') AND ISNULL(S1.IsSystem,0) = 0
						OPEN @Cur
						FETCH NEXT FROM @Cur INTO @DelAPK
						WHILE @@FETCH_STATUS = 0
						BEGIN
							DELETE FROM ST2013 WHERE CAST(APKMaster_Action AS VARCHAR(50)) IN (SELECT APK FROM ST2011 WHERE CAST(APKMaster AS VARCHAR(50)) = @DelAPK)
							DELETE FROM ST2011 WHERE CAST(APKMaster AS VARCHAR(50)) = @DelAPK
							DELETE FROM ST2012 WHERE CAST(APKMaster AS VARCHAR(50)) = @DelAPK
							DELETE FROM ST2010 WHERE CAST(APK AS VARCHAR(50)) = @DelAPK
							FETCH NEXT FROM @Cur INTO @DelAPK
							SET @Status = 0
						END
						CLOSE @Cur
					END
					COMMIT TRANSACTION;
				END TRY
				BEGIN CATCH
					SELECT   
						ERROR_NUMBER() AS ErrorNumber  
						,ERROR_SEVERITY() AS ErrorSeverity  
						,ERROR_STATE() AS ErrorState  
						,ERROR_LINE () AS ErrorLine  
						,ERROR_PROCEDURE() AS ErrorProcedure  
						,ERROR_MESSAGE() AS ErrorMessage;  
					ROLLBACK TRANSACTION;  
				END CATCH'
			EXEC (@sSQL)
			PRINT (@sSQL)
	END
END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
