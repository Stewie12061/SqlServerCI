IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP9000]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[NMP9000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Kiểm tra xóa/sửa module NM
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Trà Giang, Date: 23/08/2018
----Modified by on  
-- <Example>
---- 
/*-- <Example>
	NMP9000 @DivisionID, @APK, @APKList, @FormID, @Mode, @IsDisable, @UserID
----*/

CREATE PROCEDURE NMP9000
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
	
/*********Danh mục Nhóm thực phẩm*************/
IF @FormID IN ('NMF1000', 'NMF1002')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #NMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, MaterialsTypeID, IsCommon
	INTO #NMP9000
	FROM NMT1000 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'NMF1000' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #NMP9000 WHERE DivisionID <> '''+@DivisionID+''' AND IsCommon <> 1)	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #NMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, MaterialsTypeID AS Params, ''00ML000050''AS MessageID, APK
		FROM #NMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'
		 IF EXISTS (SELECT TOP 1 1 FROM NMT1010 T1 WITH (NOLOCK) INNER JOIN #NMP9000 T2 ON  T2.MaterialsTypeID = T1.MaterialsTypeID ---- Danh mục nhóm thực phẩm
				   )
		BEGIN
			INSERT INTO #NMP9000_Errors (Status, Params, MessageID, APK)
			SELECT 2 AS Status, T1.MaterialsTypeID AS Params, ''00ML000165''AS MessageID, T1.APK 
			FROM #NMP9000 T1 WITH (NOLOCK) 
			WHERE EXISTS (
			SELECT TOP 1 1 FROM NMT1010 T1 WITH (NOLOCK) INNER JOIN #NMP9000 T2 ON  T2.MaterialsTypeID = T1.MaterialsTypeID ---- Danh mục nhóm thực phẩm
						 )
		END

		DELETE T1 FROM NMT1000 T1 INNER JOIN #NMP9000 T2 ON T1.APK = T2.APK 
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #NMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END
	ELSE IF @Mode = 2 
	BEGIN 
		SET @sSQL = @sSQL + N'
		UPDATE T1 SET T1.Disabled = '+CAST(@IsDisable AS VARCHAR(1))+' FROM NMT1000 T1 WITH (NOLOCK) 
		INNER JOIN #NMP9000 T2 ON T1.APK = T2.APK WHERE NOT EXISTS (SELECT TOP 1 1 FROM #NMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END 

	SET  @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #NMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #NMP9000_Errors T1 ORDER BY MessageID'
END 
--print @sSQL
/*********Danh mục thực phẩm*************/
IF @FormID IN ('NMF1010', 'NMF1012')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #NMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, MaterialsID
	INTO #NMP9000
	FROM NMT1010 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'NMF1010' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #NMP9000 WHERE DivisionID <> '''+@DivisionID+''' )	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #NMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, MaterialsID AS Params, ''00ML000050''AS MessageID, APK
		FROM #NMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'
			IF EXISTS (SELECT TOP 1 1 FROM NMT1051 T1 WITH (NOLOCK) INNER JOIN #NMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.MaterialsID = T1.MaterialsID ---- Danh mục món ăn 
				   UNION ALL 
		           SELECT TOP 1 1 FROM NMT2013 T1 WITH (NOLOCK) INNER JOIN #NMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.MaterialsID = T1.MaterialsID ---- Nghiệp vụ TD ngày 
								)
		BEGIN
			INSERT INTO #NMP9000_Errors (Status, Params, MessageID, APK)
			
			SELECT 2 AS Status, T1.MaterialsID AS Params, ''00ML000165''AS MessageID, T1.APK 
			FROM #NMP9000 T1 WITH (NOLOCK) 
			WHERE EXISTS (
			      SELECT TOP 1 1 FROM NMT1051 T1 WITH (NOLOCK) INNER JOIN #NMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.MaterialsID = T1.MaterialsID ---- Danh mục món ăn 
				   UNION ALL 
		           SELECT TOP 1 1 FROM NMT2013 T1 WITH (NOLOCK) INNER JOIN #NMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.MaterialsID = T1.MaterialsID ---- Nghiệp vụ TD ngày 
				 )
		END
		DELETE T1 FROM NMT1010 T1 INNER JOIN #NMP9000 T2 ON T1.APK = T2.APK 
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #NMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END
	ELSE IF @Mode = 2 
	BEGIN 
		SET @sSQL = @sSQL + N'
		UPDATE T1 SET T1.Disabled = '+CAST(@IsDisable AS VARCHAR(1))+' FROM NMT1010 T1 WITH (NOLOCK) 
		INNER JOIN #NMP9000 T2 ON T1.APK = T2.APK WHERE NOT EXISTS (SELECT TOP 1 1 FROM #NMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END 
	--ELSE IF @Mode = 3 
	--BEGIN 
	--SET @sSQL = @sSQL + N'
	--IF EXISTS (
	--				SELECT TOP 1 1 FROM NMT1051 T1 WITH (NOLOCK) INNER JOIN #NMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.MaterialsID = T1.MaterialsID ---- Danh mục món ăn 
	--			   UNION ALL 
	--	           SELECT TOP 1 1 FROM NMT2013 T1 WITH (NOLOCK) INNER JOIN #NMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.MaterialsID = T1.MaterialsID ---- Nghiệp vụ TD ngày 
	--				)
	--	BEGIN
	--		INSERT INTO #NMP9000_Errors (Status, Params, MessageID, APK)
	--		SELECT 2 AS Status, NULL AS Params, NULL AS MessageID, APK
	--		FROM #NMP9000
	--		WHERE EXISTS (
	--				SELECT TOP 1 1 FROM NMT1051 T1 WITH (NOLOCK) INNER JOIN #NMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.MaterialsID = T1.MaterialsID ---- Danh mục món ăn 
	--			   UNION ALL 
	--	           SELECT TOP 1 1 FROM NMT2013 T1 WITH (NOLOCK) INNER JOIN #NMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.MaterialsID = T1.MaterialsID ---- Nghiệp vụ TD ngày 
	--				)
	--	END '
	SET  @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #NMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #NMP9000_Errors T1 ORDER BY MessageID'
END 
/*********Danh mục nhóm thực đơn*************/
 IF @FormID IN ('NMF1020', 'NMF1022')
BEGIN
	SET @sSQL = N'CREATE TABLE #NMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, MenuTypeID, IsCommon
		INTO #NMP9000
		FROM NMT1020 WITH(NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'NMF1020' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #NMP9000 WHERE DivisionID <> '''+@DivisionID+''' AND IsCommon <> 1)	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #NMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, MenuTypeID AS Params, ''00ML000050''AS MessageID, APK
		FROM #NMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END

	'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'
		 IF EXISTS (SELECT TOP 1 1 FROM NMT1030 T1 WITH (NOLOCK) INNER JOIN #NMP9000 T2 ON  T2.MenuTypeID = T1.MenuTypeID ---- Danh mục định mức
				   )
		BEGIN
			INSERT INTO #NMP9000_Errors (Status, Params, MessageID, APK)
			SELECT 2 AS Status, T1.MenuTypeID AS Params, ''00ML000165''AS MessageID, T1.APK 
			FROM #NMP9000 T1 WITH (NOLOCK) 
			WHERE EXISTS (
			SELECT TOP 1 1 FROM NMT1030 T1 WITH (NOLOCK) INNER JOIN #NMP9000 T2 ON  T2.MenuTypeID = T1.MenuTypeID ---- Danh mục định mức
						 )
		END
				
		DELETE T1 FROM NMT1022 T1 INNER JOIN #NMP9000 T2 ON T1.APKMaster = T2.APK 
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #NMP9000_Errors T3 WHERE T1.APKMaster = T3.APK) ---- Delate detail 

		DELETE T1 FROM NMT1020 T1 INNER JOIN #NMP9000 T2 ON T1.APK = T2.APK 
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #NMP9000_Errors T3 WHERE T1.APK = T3.APK) ---- Delete master '
	END
	ELSE IF @Mode = 2 
	BEGIN 
		SET @sSQL = @sSQL + N'
		UPDATE T1 SET T1.Disabled = '+CAST(@IsDisable AS VARCHAR(1))+' FROM NMT1020 T1 WITH(NOLOCK) 
		INNER JOIN #NMP9000 T2 ON T1.APK = T2.APK'
	END 

	SET  @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #NMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #NMP9000_Errors T1 ORDER BY MessageID'
END

/*********Danh mục loại món ăn *************/
IF @FormID IN ('NMF1040', 'NMF1042')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #NMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, DishTypeID
	INTO #NMP9000
	FROM NMT1040 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'NMF1040' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #NMP9000 WHERE DivisionID <> '''+@DivisionID+''' )	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #NMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, DishTypeID AS Params, ''00ML000050''AS MessageID, APK
		FROM #NMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'
		DELETE T1 FROM NMT1040 T1 INNER JOIN #NMP9000 T2 ON T1.APK = T2.APK 
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #NMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END
	ELSE IF @Mode = 2 
	BEGIN 
		SET @sSQL = @sSQL + N'
		UPDATE T1 SET T1.Disabled = '+CAST(@IsDisable AS VARCHAR(1))+' FROM NMT1040 T1 WITH (NOLOCK) 
		INNER JOIN #NMP9000 T2 ON T1.APK = T2.APK WHERE NOT EXISTS (SELECT TOP 1 1 FROM #NMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END 

	SET  @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #NMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #NMP9000_Errors T1 ORDER BY MessageID'
END 


/*********Danh mục món ăn *************/
IF @FormID IN ('NMF1050', 'NMF1052')
BEGIN
	SET @sSQL = N'CREATE TABLE #NMT1050_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, DishID, IsCommon
		INTO #NMT1050
		FROM NMT1050 WITH(NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'NMF1050' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #NMT1050 WHERE DivisionID <> '''+@DivisionID+''' AND IsCommon <> 1)	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #NMT1050_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, DishID AS Params, ''00ML000050''AS MessageID, APK
		FROM #NMT1050 WHERE DivisionID <> '''+@DivisionID+'''
	END
	-- delete cac ban ghi bi loi trong bang tam #NMT1050_Errors
	DELETE T2 FROM #NMT1050 T2 INNER JOIN #NMT1050_Errors T3 ON T2.APK = T3.APK
	'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'
		-- delete detail
		DELETE T1 FROM NMT1051 T1 INNER JOIN #NMT1050 T2 ON T1.APKMaster = T2.APK
		-- delete master
		DELETE T1 FROM NMT1050 T1 INNER JOIN #NMT1050 T2 ON T1.APK = T2.APK '
	END
	ELSE IF @Mode = 2 
	BEGIN 
		SET @sSQL = @sSQL + N'
		UPDATE T1 SET T1.Disabled = '+CAST(@IsDisable AS VARCHAR(1))+' FROM NMT1050 T1 WITH(NOLOCK) 
		INNER JOIN #NMT1050 T2 ON T1.APK = T2.APK'
	END 

	SET  @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #NMT1050_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #NMT1050_Errors T1 ORDER BY MessageID'
END
print @sSQL

/*********Danh mục định mức dinh dưỡng *************/
IF @FormID IN ('NMF1030', 'NMF1032')
BEGIN
	SET @sSQL = N'CREATE TABLE #NMT1030_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, MenuTypeID, IsCommon
		INTO #NMT1030
		FROM NMT1030 WITH(NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'NMF1030' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #NMT1030 WHERE DivisionID <> '''+@DivisionID+''' AND IsCommon <> 1)	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #NMT1030_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, MenuTypeID AS Params, ''00ML000050''AS MessageID, APK
		FROM #NMT1030 WHERE DivisionID <> '''+@DivisionID+'''
	END
	-- delete cac ban ghi bi loi trong bang tam #NMP9000_Errors
	DELETE T2 FROM #NMT1030 T2 INNER JOIN #NMT1030_Errors T3 ON T2.APK = T3.APK
	'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'
		-- delete detail
		DELETE T1 FROM NMT1031 T1 INNER JOIN #NMT1030 T2 ON T1.APKMaster = T2.APK
		-- delete master
		DELETE T1 FROM NMT1030 T1 INNER JOIN #NMT1030 T2 ON T1.APK = T2.APK '
	END
	ELSE IF @Mode = 2 
	BEGIN 
		SET @sSQL = @sSQL + N'
		UPDATE T1 SET T1.Disabled = '+CAST(@IsDisable AS VARCHAR(1))+' FROM NMT1030 T1 WITH(NOLOCK) 
		INNER JOIN #NMT1030 T2 ON T1.APK = T2.APK'
	END 

	SET  @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #NMT1030_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #NMT1030_Errors T1 ORDER BY MessageID'
END


/*********Danh mục bữa ăn *************/
IF @FormID IN ('NMF1060', 'NMF1062')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #NMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, MealID
	INTO #NMP9000
	FROM NMT1060 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'NMF1060' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #NMP9000 WHERE DivisionID <> '''+@DivisionID+''' )	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #NMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, MealID AS Params, ''00ML000050''AS MessageID, APK
		FROM #NMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'
		DELETE T1 FROM NMT1060 T1 INNER JOIN #NMP9000 T2 ON T1.APK = T2.APK 
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #NMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END
	ELSE IF @Mode = 2 
	BEGIN 
		SET @sSQL = @sSQL + N'
		UPDATE T1 SET T1.Disabled = '+CAST(@IsDisable AS VARCHAR(1))+' FROM NMT1060 T1 WITH (NOLOCK) 
		INNER JOIN #NMP9000 T2 ON T1.APK = T2.APK WHERE NOT EXISTS (SELECT TOP 1 1 FROM #NMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END 

	SET  @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #NMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #NMP9000_Errors T1 ORDER BY MessageID'
END 
/*********Nghiệp vụ thực đơn tổng *************/
IF @FormID IN ('NMF2000', 'NMF2002')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #NMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, VoucherNo
	INTO #NMP9000
	FROM NMT2000 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'NMF2000' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #NMP9000 WHERE DivisionID <> '''+@DivisionID+''')	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #NMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, VoucherNo AS Params, ''00ML000050''AS MessageID, APK
		FROM #NMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'

		UPDATE T1
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM NMT2000 T1 WITH (NOLOCK) 
		INNER JOIN #NMP9000 T2 ON T1.APK = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #NMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END


	SET @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #NMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #NMP9000_Errors T1 ORDER BY MessageID'
END  

/*********Nghiệp vụ thực đơn ngày *************/
IF @FormID IN ('NMF2010', 'NMF2012')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #NMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, FromDate, ToDate
	INTO #NMP9000
	FROM NMT2010 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'NMF2010' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #NMP9000 WHERE DivisionID <> '''+@DivisionID+''')	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #NMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, APK AS Params, ''00ML000050''AS MessageID, APK
		FROM #NMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END

		--DECLARE @FromDate DATETIME,
		--@ToDate DATETIME

		--SET @FromDate = ( SELECT FromDate FROM #NMP9000 )

		--SET @ToDate = ( SELECT ToDate FROM #NMP9000 )


	---- Kiểm tra đã được sử dụng ở Kết Quả Học Tập EDMF2050
	IF EXISTS (	
		SELECT 1
		FROM #NMP9000, EDMT2050 E1
		WHERE E1.DivisionID = '''+@DivisionID+''' AND E1.DeleteFlg = 0
		AND E1.ResultDate BETWEEN #NMP9000.FromDate AND #NMP9000.ToDate		
		)
	BEGIN
		INSERT INTO #NMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, ''Thông tin'' AS Params, ''00ML000052''AS MessageID, APK
		FROM #NMP9000 WHERE DivisionID = '''+@DivisionID+'''
	END
	
	'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'

		
		---Xóa detail 
		UPDATE T1   
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM NMT2011 T1 WITH (NOLOCK) 
		INNER JOIN #NMP9000 T2 ON T1.APKMaster = CONVERT(VARCHAR(50),T2.APK)
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #NMP9000_Errors T3 WHERE T1.APKMaster = T3.APK)



		---XÓA MASTER 
		UPDATE T1
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM NMT2010 T1 WITH (NOLOCK) 
		INNER JOIN #NMP9000 T2 ON T1.APK = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #NMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END


	SET @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #NMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #NMP9000_Errors T1 ORDER BY MessageID'
END  

/*********Nghiệp vụ hồ sơ sức khỏe  *************/
IF @FormID IN ('NMF2060', 'NMF2062')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #NMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, VoucherNo
	INTO #NMP9000
	FROM NMT2060 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'NMF2060' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #NMP9000 WHERE DivisionID <> '''+@DivisionID+''')	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #NMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, VoucherNo AS Params, ''00ML000050''AS MessageID, APK
		FROM #NMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'
		UPDATE T1
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM NMT2060 T1 WITH(NOLOCK) 
		INNER JOIN #NMP9000 T2 ON T1.APK = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #NMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END


	SET @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #NMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #NMP9000_Errors T1 ORDER BY MessageID'
END 
PRINT(@sSQL)
EXEC (@sSQL)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
