IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2062]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2062]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Created by Văn Tài
---- Created Date 31/12/2019
---- Purpose: Kiểm tra trước khi xóa
---- Modified on 15/03/2019 by Như Hàn: Bổ sung kiểm tra trước khi xóa, sửa yêu cầu báo cáo nhà cung cấp
/*
	POP2036 'AS','482131B8-DF4C-4AD7-AF28-6586B6B6B520','<Data><APK>482131B8-DF4C-4AD7-AF28-6586B6B6B520</APK></Data>',1,''
*/

CREATE PROCEDURE [dbo].[POP2062]
				@DivisionID VARCHAR(50),
				@APK VARCHAR(50), --Trường hợp sửa
				@APKList XML, --Trường hợp xóa
				@Mode TINYINT, --0: Sửa, 1: Xóa
				@FormID VARCHAR(50)
AS
BEGIN
	CREATE TABLE #POT2061 (APK VARCHAR(50))
	INSERT INTO #POT2061 (APK)
	SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK
	FROM @APKList.nodes('//Data') AS X (Data)

	CREATE TABLE #Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	IF @Mode = 1
		BEGIN 
			WHILE(EXISTS(SELECT * FROM #POT2061))
			BEGIN

			DECLARE @APKDel VARCHAR(50)
			SELECT TOP 1 @APKDel = APK FROM #POT2061

			PRINT(@APKDel)

			UPDATE T1 SET DeleteFlag = 1
			FROM POT2061 T1 
			WHERE T1.APK = @APKDel
			AND NOT EXISTS (SELECT * FROM #Errors T3 WHERE T1.APK = T3.APK) 

			DELETE #POT2061 WHERE APK = @APKDel
			END

		END

	IF @Mode = 0
		BEGIN
			-- TODO Kiểm tra quyền xóa, sửa.
			SELECT 1 WHERE 1 <> 1
		END

	-- Trả về danh sách thông báo
	SELECT * FROM #Errors

END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

