IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SHMP9000]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SHMP9000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Kiểm tra xóa/sửa 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Create on 08/09/2018 by Xuân Minh
----Modified by Hoàng Vũ - 12/06/2019: Fixbug lỗi khi xóa loại cổ phần
----Modified by Hoàng Vũ - 12/06/2019: Fixbug lỗi khi xóa Nhóm cổ đông
----Modified by Hoàng Vũ - 04/07/2019: Fixbug lỗi khi xóa Sổ cổ đông
-- <Example>
---- 
/*-- <Example>
	EXEC SHMP9000 @DivisionID='BS', @APK='', @APKList='', @FormID='SHMF2010', @Mode='0', @IsDisable='0', @UserID=''
	SHMP9000 @DivisionID, @APK, @APKList, @FormID=, @Mode, @IsDisable, @UserID
----*/

CREATE PROCEDURE SHMP9000
( 
	@DivisionID VARCHAR(50),
	@APK VARCHAR(50), --Trường hợp sửa
	@APKList NVARCHAR(MAX), --Trường hợp xóa hoặc xử lý enable/disable
	@FormID VARCHAR(50),
	@Mode TINYINT, --0: Sửa, 1: Xóa; 2: Sửa (Disable/Enable), 3: Sửa: kiểm tra đã sử dụng để check dùng chung 
	@IsDisable TINYINT, --1: Disable; 0: Enable
	@UserID NVARCHAR(50)  
) 
AS 
DECLARE @sSQL NVARCHAR(MAX)

/*********Danh mục nhóm cổ đông*************/
IF @FormID IN ('SHMF1000', 'SHMF1002')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #SHMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, ShareHolderCategoryID, IsCommon
	INTO #SHMP9000
	FROM SHMT1000 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'SHMF1000' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #SHMP9000 WHERE DivisionID <> '''+@DivisionID+''' AND IsCommon <> 1)	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #SHMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, ShareHolderCategoryID AS Params, ''00ML000050''AS MessageID, APK
		FROM #SHMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END '

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'
		ELSE IF EXISTS (
					SELECT TOP 1 1 FROM SHMT2010 T1 WITH (NOLOCK) INNER JOIN #SHMP9000 T2 ON T1.ShareHolderCategoryID = T2.ShareHolderCategoryID ---- NGhiệp vụ sổ cổ đông 
					UNION ALL
					SELECT TOP 1 1 FROM SHMT2020 T1 WITH (NOLOCK) INNER JOIN #SHMP9000 T2 ON T1.ShareHolderCategoryID = T2.ShareHolderCategoryID ---- Nghiệp vụ đăng ký mua cổ phần
					) 
		BEGIN
			INSERT INTO #SHMP9000_Errors (Status, Params, MessageID, APK)
			SELECT 2 AS Status, ShareHolderCategoryID AS Params, ''00ML000052''AS MessageID, APK
			FROM #SHMP9000 T2 WHERE EXISTS (SELECT TOP 1 1 FROM SHMT2010 T1 WITH (NOLOCK) WHERE T1.ShareHolderCategoryID = T2.ShareHolderCategoryID ---- NGhiệp vụ sổ cổ đông 
											 UNION ALL
											 SELECT TOP 1 1 FROM SHMT2020 T1 WITH (NOLOCK) WHERE T1.ShareHolderCategoryID = T2.ShareHolderCategoryID ---- Nghiệp vụ đăng ký mua cổ phần
											) 
		END 
		DELETE T1 FROM SHMT1000 T1 INNER JOIN #SHMP9000 T2 ON T1.APK = T2.APK 
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #SHMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END
	ELSE IF @Mode = 2 
	BEGIN 
		SET @sSQL = @sSQL + N'
		UPDATE T1 SET T1.Disabled = '+CAST(@IsDisable AS VARCHAR(1))+' FROM SHMT1000 T1 WITH (NOLOCK) 
		INNER JOIN #SHMP9000 T2 ON T1.APK = T2.APK WHERE NOT EXISTS (SELECT TOP 1 1 FROM #SHMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END 
	ELSE IF @Mode = 3 
	BEGIN 
	SET @sSQL = @sSQL + N'
		IF EXISTS (SELECT TOP 1 1 FROM SHMT2010 T1 WITH (NOLOCK) INNER JOIN #SHMP9000 T2 ON T1.ShareHolderCategoryID = T2.ShareHolderCategoryID ---- NGhiệp vụ sổ cổ đông 
			       UNION ALL
			       SELECT TOP 1 1 FROM SHMT2020 T1 WITH (NOLOCK) INNER JOIN #SHMP9000 T2 ON T1.ShareHolderCategoryID = T2.ShareHolderCategoryID ---- Nghiệp vụ đăng ký mua cổ phần
				   ) 
		BEGIN
			INSERT INTO #SHMP9000_Errors (Status, Params, MessageID, APK)
			SELECT 2 AS Status, ShareHolderCategoryID AS Params, ''00ML000052''AS MessageID, APK
			FROM #SHMP9000 T2 WHERE EXISTS (SELECT TOP 1 1 FROM SHMT2010 T1 WITH (NOLOCK) WHERE T1.ShareHolderCategoryID = T2.ShareHolderCategoryID ---- NGhiệp vụ sổ cổ đông 
											UNION ALL
											SELECT TOP 1 1 FROM SHMT2020 T1 WITH (NOLOCK) WHERE T1.ShareHolderCategoryID = T2.ShareHolderCategoryID ---- Nghiệp vụ đăng ký mua cổ phần
											) 
		END '
	END
	SET  @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #SHMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #SHMP9000_Errors T1 ORDER BY MessageID'
END



/*********Danh mục loại cổ phần *************/
IF @FormID IN ('SHMF1010', 'SHMF1012')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #SHMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, ShareTypeID, IsCommon
	INTO #SHMP9000
	FROM SHMT1010 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'SHMF1010' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #SHMP9000 WHERE DivisionID <> '''+@DivisionID+''' AND IsCommon <> 1)	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #SHMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, ShareTypeID AS Params, ''00ML000050''AS MessageID, APK
		FROM #SHMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'
		ELSE IF EXISTS (SELECT TOP 1 1 FROM SHMT1021 T1 WITH (NOLOCK) INNER JOIN #SHMP9000 T2 ON T1.ShareTypeID = T2.ShareTypeID ---- Danh mục đợt phát hành
			       UNION ALL
				   SELECT TOP 1 1 FROM SHMT2011 T1 WITH (NOLOCK) INNER JOIN #SHMP9000 T2 ON T1.ShareTypeID = T2.ShareTypeID ---- Nghiệp vụ sổ cổ đông
			       UNION ALL
			       SELECT TOP 1 1 FROM SHMT2021 T1 WITH (NOLOCK) INNER JOIN #SHMP9000 T2 ON T1.ShareTypeID = T2.ShareTypeID ---- Nghiệp vụ đăng ký mua cổ phần
				   UNION ALL
				   SELECT TOP 1 1 FROM SHMT2031 T1 WITH (NOLOCK) INNER JOIN #SHMP9000 T2 ON T1.ShareTypeID = T2.ShareTypeID ---- Nghiệp vụ chuyển nhượng cổ phần
				   ) 
		BEGIN
			INSERT INTO #SHMP9000_Errors (Status, Params, MessageID, APK)
			SELECT 2 AS Status, ShareTypeID AS Params, ''00ML000052''AS MessageID, APK
			FROM #SHMP9000 T2 WHERE EXISTS (SELECT TOP 1 1 FROM SHMT1021 T1 WITH (NOLOCK) WHERE T1.ShareTypeID = T2.ShareTypeID ---- Danh mục đợt phát hành
										   UNION ALL
										   SELECT TOP 1 1 FROM SHMT2011 T1 WITH (NOLOCK) WHERE T1.ShareTypeID = T2.ShareTypeID ---- Nghiệp vụ sổ cổ đông
										   UNION ALL
										   SELECT TOP 1 1 FROM SHMT2021 T1 WITH (NOLOCK) WHERE T1.ShareTypeID = T2.ShareTypeID ---- Nghiệp vụ đăng ký mua cổ phần
										   UNION ALL
										   SELECT TOP 1 1 FROM SHMT2031 T1 WITH (NOLOCK) WHERE T1.ShareTypeID = T2.ShareTypeID ---- Nghiệp vụ chuyển nhượng cổ phần
									   )  
		END 
		DELETE T1 FROM SHMT1010 T1 INNER JOIN #SHMP9000 T2 ON T1.APK = T2.APK 
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #SHMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END
	ELSE IF @Mode = 2 
	BEGIN 
		SET @sSQL = @sSQL + N'
		UPDATE T1 SET T1.Disabled = '+CAST(@IsDisable AS VARCHAR(1))+' FROM SHMT1010 T1 WITH (NOLOCK) 
		INNER JOIN #SHMP9000 T2 ON T1.APK = T2.APK WHERE NOT EXISTS (SELECT TOP 1 1 FROM #SHMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END 
	ELSE IF @Mode = 3 
	BEGIN 
	SET @sSQL = @sSQL + N'
		IF EXISTS (SELECT TOP 1 1 FROM SHMT1021 T1 WITH (NOLOCK) INNER JOIN #SHMP9000 T2 ON T1.ShareTypeID = T2.ShareTypeID ---- Danh mục đợt phát hành
			       UNION ALL
				   SELECT TOP 1 1 FROM SHMT2011 T1 WITH (NOLOCK) INNER JOIN #SHMP9000 T2 ON T1.ShareTypeID = T2.ShareTypeID ---- Nghiệp vụ sổ cổ đông
			       UNION ALL
			       SELECT TOP 1 1 FROM SHMT2021 T1 WITH (NOLOCK) INNER JOIN #SHMP9000 T2 ON T1.ShareTypeID = T2.ShareTypeID ---- Nghiệp vụ đăng ký mua cổ phần
				   UNION ALL
				   SELECT TOP 1 1 FROM SHMT2031 T1 WITH (NOLOCK) INNER JOIN #SHMP9000 T2 ON T1.ShareTypeID = T2.ShareTypeID ---- Nghiệp vụ chuyển nhượng cổ phần
				   )
		BEGIN
			INSERT INTO #SHMP9000_Errors (Status, Params, MessageID, APK)
			SELECT 2 AS Status, NULL AS Params, NULL AS MessageID, APK
			FROM #SHMP9000 T2 WHERE EXISTS (SELECT TOP 1 1 FROM SHMT1021 T1 WITH (NOLOCK) WHERE T1.ShareTypeID = T2.ShareTypeID ---- Danh mục đợt phát hành
										   UNION ALL
										   SELECT TOP 1 1 FROM SHMT2011 T1 WITH (NOLOCK) WHERE T1.ShareTypeID = T2.ShareTypeID ---- Nghiệp vụ sổ cổ đông
										   UNION ALL
										   SELECT TOP 1 1 FROM SHMT2021 T1 WITH (NOLOCK) WHERE T1.ShareTypeID = T2.ShareTypeID ---- Nghiệp vụ đăng ký mua cổ phần
										   UNION ALL
										   SELECT TOP 1 1 FROM SHMT2031 T1 WITH (NOLOCK) WHERE T1.ShareTypeID = T2.ShareTypeID ---- Nghiệp vụ chuyển nhượng cổ phần
									   )  
		END '
	END
	SET  @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #SHMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #SHMP9000_Errors T1 ORDER BY MessageID'
END 

/*********Danh mục đợt phát hành *************/
IF @FormID IN ('SHMF1020', 'SHMF1021', 'SHMF1022')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #SHMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID,SHPublishPeriodID , IsCommon
	INTO #SHMP9000
	FROM SHMT1020 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'SHMF1020' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #SHMP9000 WHERE DivisionID <> '''+@DivisionID+''' AND IsCommon <> 1)	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #SHMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, SHPublishPeriodID AS Params, ''00ML000050''AS MessageID, APK
		FROM #SHMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END' 
	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'
		ELSE IF EXISTS (SELECT TOP 1 1 FROM SHMT2020 T1 WITH (NOLOCK) INNER JOIN #SHMP9000 T2 ON T1.SHPublishPeriodID = T2.SHPublishPeriodID WHERE T2.DivisionID = '''+@DivisionID+''' and T1.DeleteFlg = 0) ---- Nghiệp vụ đăng ký mua cổ phần
		BEGIN
			INSERT INTO #SHMP9000_Errors (Status, Params, MessageID, APK)
			SELECT 2 AS Status, SHPublishPeriodID AS Params, ''00ML000052''AS MessageID, APK
			FROM #SHMP9000 T2 WHERE EXISTS (SELECT TOP 1 1 FROM SHMT2020 T1 WITH (NOLOCK) WHERE T1.SHPublishPeriodID = T2.SHPublishPeriodID and T1.DivisionID = '''+@DivisionID+''' and T1.DeleteFlg = 0)
		END 

		DELETE T1 FROM SHMT1020 T1 INNER JOIN #SHMP9000 T2 ON T1.APK = T2.APK 
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #SHMP9000_Errors T3 WHERE T1.APK = T3.APK) ---delete Master

		DELETE T1 FROM SHMT1021 T1 INNER JOIN #SHMP9000 T2 ON T1.APK = T2.APK 
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #SHMP9000_Errors T3 WHERE T1.APKMaster = T3.APK) ---delete Detail'


	END
	ELSE IF @Mode = 2 
	BEGIN 
		SET @sSQL = @sSQL + N'
		UPDATE T1 SET T1.Disabled = '+CAST(@IsDisable AS VARCHAR(1))+' FROM SHMT1020 T1 WITH (NOLOCK) 
		INNER JOIN #SHMP9000 T2 ON T1.APK = T2.APK WHERE NOT EXISTS (SELECT TOP 1 1 FROM #SHMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END 
	ELSE IF @Mode = 3 
	BEGIN 
	SET @sSQL = @sSQL + N'
		IF EXISTS (SELECT TOP 1 1 FROM SHMT2020 T1 WITH (NOLOCK) INNER JOIN #SHMP9000 T2 ON T1.SHPublishPeriodID = T2.SHPublishPeriodID WHERE T2.DivisionID = '''+@DivisionID+''' and T1.DeleteFlg = 0) ---- Nghiệp vụ đăng ký mua cổ phần
		BEGIN
			INSERT INTO #SHMP9000_Errors (Status, Params, MessageID, APK)
			SELECT 2 AS Status, NULL AS Params, NULL AS MessageID, APK
			FROM #SHMP9000 T2 WHERE EXISTS (SELECT TOP 1 1 FROM SHMT2020 T1 WITH (NOLOCK) WHERE T1.SHPublishPeriodID = T2.SHPublishPeriodID  and T1.DivisionID = '''+@DivisionID+''' and T1.DeleteFlg = 0)
		END '
	END

	SET  @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #SHMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #SHMP9000_Errors T1 ORDER BY MessageID'
END 
/*********Nghiệp vụ sổ cổ đông *************/
IF @FormID IN ('SHMF2010', 'SHMF2012')
BEGIN
		SET @sSQL = N'
		CREATE TABLE #SHMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

		SELECT APK, DivisionID, ObjectID
		INTO #SHMP9000
		FROM SHMT2010 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'SHMF2010' THEN @APKList ELSE @APK END+''')
	
		--Kiểm tra khác đơn vị
		IF EXISTS (SELECT TOP 1 1 FROM #SHMP9000 WHERE DivisionID != '''+@DivisionID+''')	
		BEGIN
			INSERT INTO #SHMP9000_Errors (Status, Params, MessageID, APK)
			SELECT 2 AS Status, ObjectID AS Params, ''00ML000050''AS MessageID, APK
			FROM #SHMP9000 WHERE DivisionID != '''+@DivisionID+'''
		END
		'
		IF @Mode = 1 
		BEGIN 
			SET @sSQL = @sSQL + N'
			--Kiểm tra đã bị sử dụng
			IF EXISTS (SELECT TOP 1 1 FROM SHMT2011 T1 WITH (NOLOCK) INNER JOIN #SHMP9000 T2 ON T1.APKMaster = T2.APK 
					   WHERE T1.DivisionID = '''+@DivisionID+''' and T1.APKMInherited is not null and T1.DeleteFlg = 0
					   Union all
					   SELECT TOP 1 1 FROM SHMT2041 T1 WITH (NOLOCK) INNER JOIN #SHMP9000 T2 ON T1.ObjectID = T2.ObjectID 
					   WHERE T1.DivisionID = '''+@DivisionID+''' and T1.DeleteFlg = 0
					   )
			BEGIN
				INSERT INTO #SHMP9000_Errors (Status, Params, MessageID, APK)
				SELECT 2 AS Status, ObjectID AS Params, ''00ML000052''AS MessageID, APK
				FROM #SHMP9000 T2
				WHERE EXISTS (SELECT TOP 1 1 FROM SHMT2011 T1 WITH (NOLOCK) WHERE T1.APKMaster = T2.APK AND T1.APKMInherited is not null and T1.DeleteFlg = 0) and T2.DivisionID = '''+@DivisionID+'''
			END
			--Xóa master sổ cổ đông
			UPDATE T1 SET T1.DeleteFlg = 1, T1.LastModifyUserID = '''+@UserID+''', T1.LastModifyDate = Getdate()
			FROM SHMT2010 T1 WITH (NOLOCK) INNER JOIN #SHMP9000 T2 ON T1.APK = T2.APK
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM #SHMP9000_Errors T3 WHERE T2.APK = T3.APK) and T2.DivisionID = '''+@DivisionID+'''
			--Xóa detail sổ cổ đông
			UPDATE T1 SET T1.DeleteFlg = 1, T1.LastModifyUserID = '''+@UserID+''', T1.LastModifyDate = Getdate()
			FROM SHMT2011 T1 WITH (NOLOCK) INNER JOIN #SHMP9000 T2 ON T1.APKMaster = T2.APK
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM #SHMP9000_Errors T3 WHERE T2.APK = T3.APK) and T2.DivisionID = '''+@DivisionID+''''
		END
		SET @sSQL = @sSQL + N'
		SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
		SELECT '', '' + Params FROM #SHMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
		FROM #SHMP9000_Errors T1 ORDER BY MessageID'
END 

/*********Nghiệp vụ đăng ký mua cổ phần *************/
IF @FormID IN ('SHMF2020', 'SHMF2022')
BEGIN
		SET @sSQL = N'
		CREATE TABLE #SHMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50), VoucherDate Datetime)

		SELECT APK, DivisionID, VoucherNo, VoucherDate
		INTO #SHMP9000
		FROM SHMT2020 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'SHMF2020' THEN @APKList ELSE @APK END+''')
	
		--Kiểm tra khác đơn vị
		IF EXISTS (SELECT TOP 1 1 FROM #SHMP9000 WHERE DivisionID != '''+@DivisionID+''')	
		BEGIN
			INSERT INTO #SHMP9000_Errors (Status, Params, MessageID, APK, VoucherDate)
			SELECT 2 AS Status, VoucherNo AS Params, ''00ML000050''AS MessageID, APK, VoucherDate
			FROM #SHMP9000 WHERE DivisionID != '''+@DivisionID+N'''
		END
		--Kiểm tra đã bị sử dụng
		IF EXISTS (SELECT TOP 1 1 FROM AT9000 T1 WITH (NOLOCK) INNER JOIN #SHMP9000 T2 ON T1.DivisionID = T2.DivisionID and T1.InheritVoucherID = CONVERT(VARCHAR(50),T2.APK) WHERE T2.DivisionID = '''+@DivisionID+''')
		BEGIN
			INSERT INTO #SHMP9000_Errors (Status, Params, MessageID, APK)
			SELECT 2 AS Status, T2.VoucherNo AS Params, ''00ML000052''AS MessageID, T2.APK
			FROM #SHMP9000 T2
			WHERE EXISTS (SELECT TOP 1 1 FROM AT9000 T1 WITH (NOLOCK) WHERE T1.DivisionID = T2.DivisionID and T1.InheritVoucherID = CONVERT(VARCHAR(50),T2.APK)) and T2.DivisionID = '''+@DivisionID+N'''
		END
		--Kiểm tra Ngày chứng từ nhỏ hơn đã chốt sổ?
		IF EXISTS (SELECT TOP 1 1 FROM SHMT2020 T1 WITH (NOLOCK) INNER JOIN #SHMP9000 T2 ON T1.DivisionID = T2.DivisionID and T1.APK = T2.APK 
					WHERE T2.DivisionID = '''+@DivisionID+N''' and T2.VoucherDate <= (Select Max(LockDate) as LockDate From SHMT2040 WITH (NOLOCK) Where DivisionID =  '''+@DivisionID+N''' and DeleteFlg = 0))
		BEGIN
			INSERT INTO #SHMP9000_Errors (Status, Params, MessageID, APK)
			SELECT 2 AS Status, T2.VoucherNo AS Params, ''SHMFML000008''AS MessageID, T2.APK
			FROM #SHMP9000 T2
			WHERE EXISTS (SELECT TOP 1 1 FROM AT9000 T1 WITH (NOLOCK) WHERE T1.DivisionID = T2.DivisionID and T1.InheritVoucherID = CONVERT(VARCHAR(50),T2.APK) ) and T2.DivisionID = '''+@DivisionID+'''
					and T2.VoucherDate <= (Select Max(LockDate) as LockDate From SHMT2040 WITH (NOLOCK) Where DivisionID =  '''+@DivisionID+N''' and DeleteFlg = 0)
		END '
		IF @Mode = 1 --Xóa
		BEGIN 
			SET @sSQL = @sSQL + N'
			--Xóa master đăng ký mua cổ phần
			UPDATE T1 SET T1.DeleteFlg = 1, T1.LastModifyUserID = '''+@UserID+''', T1.LastModifyDate = Getdate()
			FROM SHMT2020 T1 WITH (NOLOCK) INNER JOIN #SHMP9000 T2 ON T1.APK = T2.APK
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM #SHMP9000_Errors T3 WHERE T2.APK = T3.APK) and T2.DivisionID = '''+@DivisionID+'''
			--Xóa detail đăng ký mua cổ phần
			UPDATE T1 SET T1.DeleteFlg = 1, T1.LastModifyUserID = '''+@UserID+''', T1.LastModifyDate = Getdate()
			FROM SHMT2021 T1 WITH (NOLOCK) INNER JOIN #SHMP9000 T2 ON T1.APKMaster = T2.APK
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM #SHMP9000_Errors T3 WHERE T2.APK = T3.APK) and T2.DivisionID = '''+@DivisionID+'''
			--Xóa detail sổ cổ đông
			DELETE T1 FROM SHMT2011 T1 INNER JOIN #SHMP9000 T2 ON T1.APKMInherited = T2.APK 
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM #SHMP9000_Errors T3 WHERE T1.APKMInherited = T3.APK)  and TransactionTypeID = 1 and T2.DivisionID = '''+@DivisionID+''''
		END
		SET @sSQL = @sSQL + N'
		SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((SELECT '', '' + Params FROM #SHMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
		FROM #SHMP9000_Errors T1 ORDER BY MessageID'
END 


/*********Nghiệp vụ chuyển nhượng *************/
IF @FormID IN ('SHMF2030', 'SHMF2032')
BEGIN
		SET @sSQL = N'
		CREATE TABLE #SHMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50), VoucherDate Datetime)

		SELECT APK, DivisionID, VoucherNo, VoucherDate
		INTO #SHMP9000
		FROM SHMT2030 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'SHMF2030' THEN @APKList ELSE @APK END+''')
	
		--Kiểm tra khác đơn vị
		IF EXISTS (SELECT TOP 1 1 FROM #SHMP9000 WHERE DivisionID != '''+@DivisionID+''')	
		BEGIN
			INSERT INTO #SHMP9000_Errors (Status, Params, MessageID, APK)
			SELECT 2 AS Status, VoucherNo AS Params, ''00ML000050''AS MessageID, APK
			FROM #SHMP9000 WHERE DivisionID != '''+@DivisionID+N'''
		END
		--Kiểm tra Ngày chứng từ nhỏ hơn đã chốt sổ (Chia cổ tức)?
		IF EXISTS (SELECT TOP 1 1 FROM SHMT2030 T1 WITH (NOLOCK) INNER JOIN #SHMP9000 T2 ON T1.DivisionID = T2.DivisionID and T1.APK = T2.APK 
					WHERE T2.DivisionID = '''+@DivisionID+N''' and T2.VoucherDate <= (Select Max(LockDate) as LockDate From SHMT2040 WITH (NOLOCK) Where DivisionID =  '''+@DivisionID+N''' and DeleteFlg = 0))
		BEGIN
			INSERT INTO #SHMP9000_Errors (Status, Params, MessageID, APK)
			SELECT 2 AS Status, T2.VoucherNo AS Params, ''SHMFML000008''AS MessageID, T2.APK
			FROM #SHMP9000 T2
			WHERE EXISTS (SELECT TOP 1 1 FROM AT9000 T1 WITH (NOLOCK) WHERE T1.DivisionID = T2.DivisionID and T1.InheritVoucherID = CONVERT(VARCHAR(50),T2.APK) ) and T2.DivisionID = '''+@DivisionID+'''
					and T2.VoucherDate <= (Select Max(LockDate) as LockDate From SHMT2040 WITH (NOLOCK) Where DivisionID =  '''+@DivisionID+N''' and DeleteFlg = 0)
		END '
		IF @Mode = 1 --Xóa
		BEGIN 
			SET @sSQL = @sSQL + N'
			--Xóa master chia cổ tức
			UPDATE T1 SET T1.DeleteFlg = 1, T1.LastModifyUserID = '''+@UserID+N''', T1.LastModifyDate = Getdate()
			FROM SHMT2030 T1 WITH (NOLOCK) INNER JOIN #SHMP9000 T2 ON T1.APK = T2.APK
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM #SHMP9000_Errors T3 WHERE T2.APK = T3.APK) and T2.DivisionID = '''+@DivisionID+N'''
			--Xóa detail chia cổ tức
			UPDATE T1 SET T1.DeleteFlg = 1, T1.LastModifyUserID = '''+@UserID+N''', T1.LastModifyDate = Getdate()
			FROM SHMT2031 T1 WITH (NOLOCK) INNER JOIN #SHMP9000 T2 ON T1.APKMaster = T2.APK
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM #SHMP9000_Errors T3 WHERE T2.APK = T3.APK) and T2.DivisionID = '''+@DivisionID+N'''
			--Xóa detail sổ cổ đông
			DELETE T1 FROM SHMT2011 T1 INNER JOIN #SHMP9000 T2 ON T1.APKMInherited = T2.APK 
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM #SHMP9000_Errors T3 WHERE T1.APKMInherited = T3.APK)  and TransactionTypeID = 2 and T2.DivisionID = '''+@DivisionID+''''
		END
		SET @sSQL = @sSQL + N'
		SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((SELECT '', '' + Params FROM #SHMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
		FROM #SHMP9000_Errors T1 ORDER BY MessageID'
END 


/*********Nghiệp vụ Chia cổ tức *************/
IF @FormID IN ('SHMF2040', 'SHMF2042')
BEGIN
		SET @sSQL = N'
		CREATE TABLE #SHMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

		SELECT APK, DivisionID, VoucherNo
		INTO #SHMP9000
		FROM SHMT2040 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'SHMF2040' THEN @APKList ELSE @APK END+N''')
	
		--Kiểm tra khác đơn vị
		IF EXISTS (SELECT TOP 1 1 FROM #SHMP9000 WHERE DivisionID != '''+@DivisionID+''')	
		BEGIN
			INSERT INTO #SHMP9000_Errors (Status, Params, MessageID, APK)
			SELECT 2 AS Status, VoucherNo AS Params, ''00ML000050''AS MessageID, APK
			FROM #SHMP9000 WHERE DivisionID != '''+@DivisionID+N'''
		END
		--Kiểm tra đã bị sử dụng
		IF EXISTS (SELECT TOP 1 1 FROM AT9000 T1 WITH (NOLOCK) INNER JOIN #SHMP9000 T2 ON T1.DivisionID = T2.DivisionID and T1.InheritVoucherID =  CONVERT(VARCHAR(50),T2.APK) WHERE T2.DivisionID = '''+@DivisionID+''')
		BEGIN
			INSERT INTO #SHMP9000_Errors (Status, Params, MessageID, APK)
			SELECT 2 AS Status, T2.VoucherNo AS Params, ''00ML000052''AS MessageID, T2.APK
			FROM #SHMP9000 T2
			WHERE EXISTS (SELECT TOP 1 1 FROM AT9000 T1 WITH (NOLOCK) WHERE T1.DivisionID = T2.DivisionID and T1.InheritVoucherID =  CONVERT(VARCHAR(50),T2.APK) ) and T2.DivisionID = '''+@DivisionID+'''
		END'
		IF @Mode = 1 --Xóa
		BEGIN 
			SET @sSQL = @sSQL + N'
			--Xóa master chia cổ tức
			UPDATE T1 SET T1.DeleteFlg = 1, T1.LastModifyUserID = '''+@UserID+''', T1.LastModifyDate = Getdate()
			FROM SHMT2040 T1 WITH (NOLOCK) INNER JOIN #SHMP9000 T2 ON T1.APK = T2.APK
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM #SHMP9000_Errors T3 WHERE T2.APK = T3.APK) and T2.DivisionID = '''+@DivisionID+'''
			--Xóa detail chia cổ tức
			UPDATE T1 SET T1.DeleteFlg = 1, T1.LastModifyUserID = '''+@UserID+''', T1.LastModifyDate = Getdate()
			FROM SHMT2041 T1 WITH (NOLOCK) INNER JOIN #SHMP9000 T2 ON T1.APKMaster = T2.APK
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM #SHMP9000_Errors T3 WHERE T2.APK = T3.APK) and T2.DivisionID = '''+@DivisionID+'''
			'
		END
		SET @sSQL = @sSQL + N'
		SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((SELECT '', '' + Params FROM #SHMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
		FROM #SHMP9000_Errors T1 ORDER BY MessageID'
END 


EXEC (@sSQL)
Print (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
