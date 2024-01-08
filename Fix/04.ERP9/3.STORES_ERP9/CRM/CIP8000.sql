IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP8000]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP8000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Kiểm tra Sửa/Xóa danh mục hợp đồng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Trà Giang on 29/10/2018
----Modified on 13/12/2019 by Học Huy: Sửa lỗi hiện thông báo không xoá được nhưng vẫn xoá dữ liệu.
-- Modify by Anh Tuấn, Date 4/1/2022: Thay đổi giá trị DeleteFlg = 1 khi xóa
/*-- <Example>
	
	exec CIP8000 @DivisionID=N'BS',@APK=N'D54AAB34-9C6E-41E4-BEA2-25637A017F22',@APKList=N'D54AAB34-9C6E-41E4-BEA2-25637A017F22',@FormID=N'CIF1360', @Mode=1

	EXEC POP2017 @DivisionID, @UserID, @TranMonth, @TranYear, @APK, @APKList, @Mode
----*/


CREATE PROCEDURE CIP8000
( 
  @DivisionID VARCHAR(50),
  @APK VARCHAR(50),
  @APKList VARCHAR(MAX),
  @FormID nvarchar(50),			 --Truyên vào mã form cần kiểm tra
  @Mode TINYINT --0: Edit, 1: Delete
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)	
IF @FormID IN ('CIF1360', 'CIF1362')
BEGIN
IF @Mode = 0 ---Sửa
	BEGIN
		SET @sSQL = '
		DECLARE @Status TINYINT,
				@MessageID NVARCHAR(1000),
				@DelDivisionID VARCHAR(50),
				@DelVoucherNo VARCHAR(50), 
				@DelTranMonth INT, 
				@DelTranYear INT, 
				@Params VARCHAR(MAX) = ''''

		SELECT @DelDivisionID = DivisionID, @DelVoucherNo = ContractNo
		FROM AT1020 WITH (NOLOCK)
		WHERE APK = '''+@APK+'''

		IF @DelDivisionID <> '''+@DivisionID+''' -- Kiểm tra khác đơn vị
			BEGIN
				SET @Params = @DelVoucherNo
				SET @MessageID = ''00ML000050''
				Goto EndMess
			END

		--Kiêm tra đã được sử dụng
		--ELSE 
		--IF EXISTS (SELECT TOP 1 1 FROM POT2010 WITH (NOLOCK) WHERE DivisionID = '''+@DivisionID+''' AND InheritAPK = '''+@APK+''') 
		--BEGIN
		--	SET @Params = @DelVoucherNo
		--	SET @MessageID = ''00ML000052''
		--	Goto EndMess
		--END

		EndMess:
		SELECT 2 AS Status, @MessageID AS MessageID, LEFT(@Params, LEN(@Params) -1) AS Params
		WHERE ISNULL(@Params, '''') <> ''''
		'
	END
ELSE
IF @Mode = 1 ---Xóa
	BEGIN
		SET @sSQL = N'
	
		CREATE TABLE #AP1020_Errors (ContractNo Varchar(50), APK Varchar(50), MessageID Varchar(50))		

		SELECT APK, DivisionID, ContractNo, ContractID
		INTO #AP1020_AT1020
		FROM AT1020 WITH (NOLOCK) WHERE APK IN ('''+@APKList+''')
	
		IF EXISTS 
			(
				SELECT TOP 1 1 
				FROM #AP1020_AT1020
				WHERE DivisionID <> '''+@DivisionID+'''
			)
			BEGIN 
				INSERT INTO #AP1020_Errors (ContractNo, APK, MessageID)
				SELECT ContractNo, APK, ''00ML000050''
				FROM #AP1020_AT1020
				WHERE DivisionID <> '''+@DivisionID+'''
			END
		
		IF EXISTS 
			(
				SELECT TOP 1 1 
				FROM AT9000 WITH(NOLOCK)
					INNER JOIN #AP1020_AT1020 ON AT9000.DivisionID = #AP1020_AT1020.DivisionID AND AT9000.Ana05ID = #AP1020_AT1020.ContractNo
			)
			BEGIN
				INSERT INTO #AP1020_Errors (ContractNo, APK, MessageID)
				SELECT ContractNo, #AP1020_AT1020.APK, ''00ML000052''
				FROM AT9000 WITH(NOLOCK) 
					INNER JOIN #AP1020_AT1020 ON AT9000.DivisionID = #AP1020_AT1020.DivisionID AND AT9000.Ana05ID = #AP1020_AT1020.ContractNo								
			END

		-- Thay đổi biến DeleteFlg
				Update AT1020 set DeleteFlg = 1 FROM AT1020 T1 INNER JOIN #AP1020_AT1020 T2 ON T1.ContractID = T2.ContractID AND T1.APK = T2.APK	

		--DELETE T1
		--FROM AT1020 T1 INNER JOIN #AP1020_AT1020 T2 ON T1.ContractID = T2.ContractID AND T1.APK = T2.APK	
		--WHERE NOT EXISTS 
		--	(
		--		SELECT TOP 1 1 
		--		FROM #AP1020_Errors T3 WITH (NOLOCK) 
		--		WHERE T1.APK = T3.APK
		--	)

		--DELETE T1
		--FROM AT1021 T1 INNER JOIN #AP1020_AT1020 T2 ON T1.ContractID = T2.ContractID		
		--WHERE NOT EXISTS 
		--	(
		--		SELECT TOP 1 1 
		--		FROM #AP1020_Errors T3 WITH(NOLOCK) 
		--		WHERE T2.APK = T3.APK
		--	)

		--DELETE T1
		--FROM AT1031 T1 INNER JOIN #AP1020_AT1020 T2 ON T1.ContractID = T2.ContractID		
		--WHERE NOT EXISTS 
		--	(
		--		SELECT TOP 1 1 
		--		FROM #AP1020_Errors T3 WITH(NOLOCK) 
		--		WHERE T2.APK = T3.APK
		--	)

							
		SELECT 	DISTINCT 2 AS Status, MessageID, STUFF (
			(	
				SELECT '', '' + ContractNo 
				FROM #AP1020_Errors T2 WITH(NOLOCK) 
				WHERE  T1.APK = T2.APK
				FOR XML PATH ('''')), 1, 1, ''''
			) AS Params
		FROM #AP1020_Errors T1
		ORDER BY MessageID
		'
	END
END

--PRINT @sSQL
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
