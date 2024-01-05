IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP9000]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP9000]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Kiểm tra xóa/sửa module EDM
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo, Date: 23/08/2018
----Modified by on  
----Modify by [Đình Hoà] [22/06/2020] Danh mục điều tra tâm lý : convert APK 
----Modify by [Đình Hoà] [23/06/2020] Nghiệp vụ thay đổi mức đóng : convert APK 
-- <Example>
---- 
/*-- <Example>
	EDMP9000 @DivisionID, @APK, @APKList, @FormID, @Mode, @IsDisable, @UserID
----*/

CREATE PROCEDURE EDMP9000
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

/*********Danh mục Khối *************/   
IF @FormID IN ('EDMF1000', 'EDMF1002')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #EDMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, GradeID, IsCommon
	INTO #EDMP9000
	FROM EDMT1000 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'EDMF1000' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''' AND IsCommon <> 1)	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, GradeID AS Params, ''00ML000050''AS MessageID, APK
		FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'
		IF EXISTS (SELECT TOP 1 1 FROM EDMT1020 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Danh mục lớp 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT1090 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Danh mục biểu phí 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2010 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ hồ sơ học sinh 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2020 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ xếp lớp
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2030 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ phân công giáo viên 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2040 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ điểm danh 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2050 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ kết quả học tập 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2060 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ dự giờ 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2100 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ lịch học cơ sở 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2120 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ chương trình học theo tháng
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2131 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ đăng ký dịch vụ 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2140 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeIDTo ---- Nghiệp vụ điều chuyển học sinh 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2150 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ bảo lưu 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2160 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ dự thu học phí 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2170 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ quản lý tin tức 
				   )
		BEGIN
			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
			
			SELECT 2 AS Status, T1.GradeID AS Params, ''00ML000165''AS MessageID, T1.APK 
			FROM #EDMP9000 T1 WITH (NOLOCK) 
			WHERE EXISTS (
			       SELECT TOP 1 1 FROM EDMT1020 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Danh mục lớp 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT1090 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Danh mục biểu phí 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2010 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ hồ sơ học sinh 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2020 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ xếp lớp
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2030 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ phân công giáo viên 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2040 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ điểm danh 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2050 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ kết quả học tập 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2060 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ dự giờ 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2100 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ lịch học cơ sở 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2120 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ chương trình học theo tháng
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2131 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ đăng ký dịch vụ 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2140 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeIDTo ---- Nghiệp vụ điều chuyển học sinh 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2150 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ bảo lưu 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2160 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ dự thu học phí 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2170 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ quản lý tin tức 
				   )
		END

		DELETE T1 FROM EDMT1000 T1 INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK 
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END
	ELSE IF @Mode = 2 
	BEGIN 
		SET @sSQL = @sSQL + N'
		UPDATE T1 SET T1.Disabled = '+CAST(@IsDisable AS VARCHAR(1))+' FROM EDMT1000 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END 

	
	ELSE IF @Mode = 3 
	BEGIN 
	SET @sSQL = @sSQL + N'
		IF EXISTS (SELECT TOP 1 1 FROM EDMT1020 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Danh mục lớp 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT1090 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Danh mục biểu phí 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2010 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ hồ sơ học sinh 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2020 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ xếp lớp
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2030 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ phân công giáo viên 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2040 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ điểm danh 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2050 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ kết quả học tập 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2060 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ dự giờ 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2100 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ lịch học cơ sở 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2120 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ chương trình học theo tháng
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2131 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ đăng ký dịch vụ 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2140 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeIDTo ---- Nghiệp vụ điều chuyển học sinh 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2150 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ bảo lưu 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2160 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ dự thu học phí 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2170 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ quản lý tin tức 
				   )   
		BEGIN
			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
			SELECT 2 AS Status, NULL AS Params, NULL AS MessageID, APK
			FROM #EDMP9000
			WHERE EXISTS (
				   SELECT TOP 1 1 FROM EDMT1020 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Danh mục lớp 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT1090 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Danh mục biểu phí 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2010 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ hồ sơ học sinh 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2020 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ xếp lớp
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2030 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ phân công giáo viên 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2040 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ điểm danh 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2050 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ kết quả học tập 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2060 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ dự giờ 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2100 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ lịch học cơ sở 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2120 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ chương trình học theo tháng
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2131 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ đăng ký dịch vụ 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2140 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeIDTo ---- Nghiệp vụ điều chuyển học sinh 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2150 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ bảo lưu 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2160 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ dự thu học phí 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2170 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.GradeID = T1.GradeID ---- Nghiệp vụ quản lý tin tức 
				   )
		END '
	END



	SET  @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #EDMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #EDMP9000_Errors T1 ORDER BY MessageID'
END 



/*********Danh mục định mức *************/
IF @FormID IN ('EDMF1010', 'EDMF1012')
BEGIN
	SET @sSQL = N'CREATE TABLE #EDMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	    SELECT APK, DivisionID, QuotaID, IsCommon
		INTO #EDMP9000
		FROM EDMT1010 WITH(NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'EDMF1010' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''' AND IsCommon <> 1)	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, QuotaID AS Params, ''00ML000050''AS MessageID, APK
		FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END
	'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'
		ELSE IF EXISTS (SELECT TOP 1 1 FROM EDMT1020 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON  T2.QuotaID = T1.QuotaID ---- Danh mục lớp
				   )
		BEGIN
			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
			SELECT 2 AS Status, T1.QuotaID AS Params, ''00ML000165''AS MessageID, T1.APK 
			FROM #EDMP9000 T1 WITH (NOLOCK) 
			WHERE EXISTS (
						SELECT TOP 1 1 FROM EDMT1020 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.QuotaID = T1.QuotaID ---- Danh mục lớp
						 )
		END

		-- delete detail
		DELETE T1 FROM EDMT1011 T1 INNER JOIN #EDMP9000 T2 ON T1.APKMaster = T2.APK
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APKMaster = T3.APK)

		-- delete master
		DELETE T1 FROM EDMT1010 T1 INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK 
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)

		'
	END
	ELSE IF @Mode = 2 
	BEGIN 
		SET @sSQL = @sSQL + N'
		UPDATE T1 SET T1.Disabled = '+CAST(@IsDisable AS VARCHAR(1))+' FROM EDMT1010 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)'


	END 

	SET  @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #EDMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #EDMP9000_Errors T1 ORDER BY MessageID'
END


/*********Danh mục Lớp *************/
IF @FormID IN ('EDMF1020', 'EDMF1022')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #EDMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))


	SELECT APK, DivisionID, ClassID, IsCommon
	INTO #EDMP9000
	FROM EDMT1020 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'EDMF1020' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''' AND IsCommon <> 1)	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, ClassID AS Params, ''00ML000050''AS MessageID, APK
		FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'
				IF EXISTS (
				   SELECT TOP 1 1 FROM EDMT2010 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID AND T1.DeleteFlg = 0-----Hồ sơ học sinh  
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2020 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID AND T1.DeleteFlg = 0---- Nghiệp vụ xếp lớp 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2030 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID AND T1.DeleteFlg = 0---- Nghiệp vụ phân công giáo viên 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2040 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID AND T1.DeleteFlg = 0---- Nghiệp vụ điểm danh 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2050 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID AND T1.DeleteFlg = 0---- Nghiệp vụ kết quả học tập 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2060 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID AND T1.DeleteFlg = 0---- Nghiệp vụ dự giờ 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2131 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID AND T1.DeleteFlg = 0---- Nghiệp vụ đăng ký dịch vụ 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2140 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassIDTo AND T1.DeleteFlg = 0---- Nghiệp vụ điều chuyển học sinh 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2150 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID AND T1.DeleteFlg = 0---- Nghiệp vụ bảo lưu 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2160 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID AND T1.DeleteFlg = 0---- Nghiệp vụ dự thu học phí 
				   )
		BEGIN
			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
			
			SELECT 2 AS Status, T1.ClassID AS Params, ''00ML000165''AS MessageID, T1.APK 
			FROM #EDMP9000 T1 WITH (NOLOCK) 
			WHERE EXISTS (
			       SELECT TOP 1 1 FROM EDMT2010 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID AND T1.DeleteFlg = 0 -----Hồ sơ học sinh  
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2020 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID AND T1.DeleteFlg = 0---- Nghiệp vụ xếp lớp 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2030 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID AND T1.DeleteFlg = 0---- Nghiệp vụ phân công giáo viên 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2040 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID AND T1.DeleteFlg = 0---- Nghiệp vụ điểm danh 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2050 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID AND T1.DeleteFlg = 0---- Nghiệp vụ kết quả học tập 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2060 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID AND T1.DeleteFlg = 0---- Nghiệp vụ dự giờ 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2131 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID AND T1.DeleteFlg = 0---- Nghiệp vụ đăng ký dịch vụ 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2140 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassIDTo AND T1.DeleteFlg = 0---- Nghiệp vụ điều chuyển học sinh 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2150 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID AND T1.DeleteFlg = 0---- Nghiệp vụ bảo lưu 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2160 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID AND T1.DeleteFlg = 0---- Nghiệp vụ dự thu học phí 
				   )
		END


		DELETE T1 FROM EDMT1020 T1 INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK 
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END
	ELSE IF @Mode = 2 
	BEGIN 
		SET @sSQL = @sSQL + N'
		UPDATE T1 SET T1.Disabled = '+CAST(@IsDisable AS VARCHAR(1))+' FROM EDMT1020 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END 

	ELSE IF @Mode = 3
	BEGIN 
		SET @sSQL = @sSQL + N'
			IF EXISTS (
				   SELECT TOP 1 1 FROM EDMT2010 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID -----Hồ sơ học sinh  
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2020 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID ---- Nghiệp vụ xếp lớp 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2030 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID ---- Nghiệp vụ phân công giáo viên 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2040 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID ---- Nghiệp vụ điểm danh 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2050 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID ---- Nghiệp vụ kết quả học tập 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2060 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID ---- Nghiệp vụ dự giờ 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2131 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID ---- Nghiệp vụ đăng ký dịch vụ 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2140 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassIDTo ---- Nghiệp vụ điều chuyển học sinh 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2150 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID ---- Nghiệp vụ bảo lưu 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2160 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID ---- Nghiệp vụ dự thu học phí 
				   )
		BEGIN
			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
			
			SELECT 2 AS Status, T1.ClassID AS Params, ''00ML000165''AS MessageID, T1.APK 
			FROM #EDMP9000 T1 WITH (NOLOCK) 
			WHERE EXISTS (
			       SELECT TOP 1 1 FROM EDMT2010 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID -----Hồ sơ học sinh  
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2020 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID ---- Nghiệp vụ xếp lớp 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2030 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID ---- Nghiệp vụ phân công giáo viên 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2040 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID ---- Nghiệp vụ điểm danh 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2050 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID ---- Nghiệp vụ kết quả học tập 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2060 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID ---- Nghiệp vụ dự giờ 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2131 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID ---- Nghiệp vụ đăng ký dịch vụ 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2140 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassIDTo ---- Nghiệp vụ điều chuyển học sinh 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2150 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID ---- Nghiệp vụ bảo lưu 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2160 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T1.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T2.ClassID = T1.ClassID ---- Nghiệp vụ dự thu học phí 
				   )
		END
		'
	END 



	SET  @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #EDMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #EDMP9000_Errors T1 ORDER BY MessageID'
END 


/*********Danh mục Môn học *************/
IF @FormID IN ('EDMF1030', 'EDMF1032')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #EDMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, SubjectID, IsCommon
	INTO #EDMP9000
	FROM EDMT1030 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'EDMF1030' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''' AND IsCommon <> 1)	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, SubjectID AS Params, ''00ML000050''AS MessageID, APK
		FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'
		IF EXISTS (SELECT TOP 1 1 FROM EDMT2121 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.SubjectID = T1.SubjectID ---- Nghiệp vụ chương trình học theo tháng 
				   )
		BEGIN

			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
			SELECT 2 AS Status, T1.SubjectID AS Params, ''00ML000165''AS MessageID, T1.APK 
			FROM #EDMP9000 T1 WITH (NOLOCK) 
			WHERE EXISTS (
						SELECT TOP 1 1 FROM EDMT2121 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.SubjectID = T1.SubjectID ---- Nghiệp vụ chương trình học theo tháng 
						 )
		END
		DELETE T1 FROM EDMT1030 T1 INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK 
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END
	ELSE IF @Mode = 2 
	BEGIN 
		SET @sSQL = @sSQL + N'
		UPDATE T1 SET T1.Disabled = '+CAST(@IsDisable AS VARCHAR(1))+' FROM EDMT1030 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END 
	ELSE IF @Mode = 3
	BEGIN 
		SET @sSQL = @sSQL + N'
		IF EXISTS (SELECT TOP 1 1 FROM EDMT2121 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SubjectID = T1.SubjectID ---- Nghiệp vụ chương trình học theo tháng 
				   )
		BEGIN

			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
			SELECT 2 AS Status, NULL AS Params, NULL AS MessageID, T1.APK 
			FROM #EDMP9000 T1 WITH (NOLOCK) 
			WHERE EXISTS (
						SELECT TOP 1 1 FROM EDMT2121 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SubjectID = T1.SubjectID ---- Nghiệp vụ chương trình học theo tháng 
						 )
		END
		'
	END 


	SET  @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #EDMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #EDMP9000_Errors T1 ORDER BY MessageID'
END 



/*********Danh mục Năm học *************/
IF @FormID IN ('EDMF1040', 'EDMF1042')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #EDMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, SchoolYearID, IsCommon
	INTO #EDMP9000
	FROM EDMT1040 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'EDMF1040' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''' AND IsCommon <> 1)	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, SchoolYearID AS Params, ''00ML000050''AS MessageID, APK
		FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'
			IF EXISTS ( 
		           SELECT TOP 1 1 FROM EDMT2020 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.SchoolYearID ---- Nghiệp vụ xếp lớp 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2030 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.SchoolYearID ---- Nghiệp vụ phân công giáo viên 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2040 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.SchoolYearID ---- Nghiệp vụ điểm danh 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2050 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.SchoolYearID ---- Nghiệp vụ kết quả học tập 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2060 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.SchoolYearID ---- Nghiệp vụ dự giờ 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2090 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.TermID ---- Nghiệp vụ lịch học năm 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2100 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.TermID ---- Nghiệp vụ lịch học cơ sở
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2110 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.TermID ---- Nghiệp vụ tổng khung chương trình 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2120 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.TermID ---- Nghiệp vụ chương trình học theo tháng 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2130 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.SchoolYearID ---- Nghiệp vụ đăng ký dịch vụ 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2150 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.SchoolYearID ---- Nghiệp vụ bảo lưu 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2160 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.SchoolYearID ---- Nghiệp vụ dự thu học phí 
				   )
		BEGIN
			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
			
			SELECT 2 AS Status, T1.SchoolYearID AS Params, ''00ML000165''AS MessageID, T1.APK 
			FROM #EDMP9000 T1 WITH (NOLOCK) 
			WHERE EXISTS (
			       SELECT TOP 1 1 FROM EDMT2020 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.SchoolYearID ---- Nghiệp vụ xếp lớp 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2030 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.SchoolYearID ---- Nghiệp vụ phân công giáo viên 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2040 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.SchoolYearID ---- Nghiệp vụ điểm danh 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2050 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.SchoolYearID ---- Nghiệp vụ kết quả học tập 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2060 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.SchoolYearID ---- Nghiệp vụ dự giờ 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2090 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.TermID ---- Nghiệp vụ lịch học năm 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2100 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.TermID ---- Nghiệp vụ lịch học cơ sở
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2110 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.TermID ---- Nghiệp vụ tổng khung chương trình 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2120 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.TermID ---- Nghiệp vụ chương trình học theo tháng 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2130 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.SchoolYearID ---- Nghiệp vụ đăng ký dịch vụ 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2150 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.SchoolYearID ---- Nghiệp vụ bảo lưu 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2160 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.SchoolYearID = T1.SchoolYearID ---- Nghiệp vụ dự thu học phí 
				   )
		END

		DELETE T1 FROM EDMT1040 T1 INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK 
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END
	ELSE IF @Mode = 2 
	BEGIN 
		SET @sSQL = @sSQL + N'
		UPDATE T1 SET T1.Disabled = '+CAST(@IsDisable AS VARCHAR(1))+' FROM EDMT1040 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END 
	ELSE IF @Mode = 3
	BEGIN 
		SET @sSQL = @sSQL + N'
		IF EXISTS ( 
		           SELECT TOP 1 1 FROM EDMT2020 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.SchoolYearID ---- Nghiệp vụ xếp lớp 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2030 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.SchoolYearID ---- Nghiệp vụ phân công giáo viên 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2040 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.SchoolYearID ---- Nghiệp vụ điểm danh 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2050 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.SchoolYearID ---- Nghiệp vụ kết quả học tập 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2060 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.SchoolYearID ---- Nghiệp vụ dự giờ 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2090 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.TermID ---- Nghiệp vụ lịch học năm 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2100 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.TermID ---- Nghiệp vụ lịch học cơ sở
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2110 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.TermID ---- Nghiệp vụ tổng khung chương trình 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2120 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.TermID ---- Nghiệp vụ chương trình học theo tháng 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2130 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.SchoolYearID ---- Nghiệp vụ đăng ký dịch vụ 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2150 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.SchoolYearID ---- Nghiệp vụ bảo lưu 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2160 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.SchoolYearID ---- Nghiệp vụ dự thu học phí 
				   )
		BEGIN
			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
			SELECT 2 AS Status, NULL AS Params, NULL AS MessageID, T1.APK 
			FROM #EDMP9000 T1 WITH (NOLOCK) 
			WHERE EXISTS (
			       SELECT TOP 1 1 FROM EDMT2020 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.SchoolYearID ---- Nghiệp vụ xếp lớp 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2030 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.SchoolYearID ---- Nghiệp vụ phân công giáo viên 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2040 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.SchoolYearID ---- Nghiệp vụ điểm danh 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2050 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.SchoolYearID ---- Nghiệp vụ kết quả học tập 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2060 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.SchoolYearID ---- Nghiệp vụ dự giờ 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2090 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.TermID ---- Nghiệp vụ lịch học năm 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2100 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.TermID ---- Nghiệp vụ lịch học cơ sở
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2110 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.TermID ---- Nghiệp vụ tổng khung chương trình 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2120 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.TermID ---- Nghiệp vụ chương trình học theo tháng 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2130 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.SchoolYearID ---- Nghiệp vụ đăng ký dịch vụ 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2150 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.SchoolYearID = T1.SchoolYearID ---- Nghiệp vụ bảo lưu 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2160 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.SchoolYearID = T1.SchoolYearID ---- Nghiệp vụ dự thu học phí 
				   )
		END'
	END 


	SET  @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #EDMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #EDMP9000_Errors T1 ORDER BY MessageID'
END 



/*********Danh mục loại hình thu*************/
IF @FormID IN ('EDMF1050', 'EDMF1052')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #EDMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, ReceiptTypeID, IsCommon
	INTO #EDMP9000
	FROM EDMT1050 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'EDMF1050' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''' AND IsCommon <> 1)	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, ReceiptTypeID AS Params, ''00ML000050''AS MessageID, APK
		FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''' AND IsCommon <> 1
	END'

	IF @Mode = 1 ---Xóa 
	BEGIN 
		SET @sSQL = @sSQL + N'
		IF EXISTS (SELECT TOP 1 1 FROM EDMT1091 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.ReceiptTypeID = T1.ReceiptTypeID ---- Danh mục biểu phí
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2130 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.ReceiptTypeID = T1.ReceiptTypeID ---- Nghiệp vụ đăng ký dịch vụ
				   )
		BEGIN
			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
			
			SELECT 2 AS Status, T1.ReceiptTypeID AS Params, ''00ML000165''AS MessageID, T1.APK 
			FROM #EDMP9000 T1 WITH (NOLOCK) 
			WHERE EXISTS (
			       SELECT TOP 1 1 FROM EDMT1091 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.ReceiptTypeID = T1.ReceiptTypeID ---- Danh mục biểu phí
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2130 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.ReceiptTypeID = T1.ReceiptTypeID ---- Nghiệp vụ đăng ký dịch vụ
				   )
		END


		DELETE T1 FROM EDMT1050 T1 INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK 
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END
	ELSE IF @Mode = 2 
	BEGIN 
		SET @sSQL = @sSQL + N'
		UPDATE T1 SET T1.Disabled = '+CAST(@IsDisable AS VARCHAR(1))+' FROM EDMT1050 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END 
	ELSE IF @Mode = 3
	BEGIN 
		SET @sSQL = @sSQL + N'
		IF EXISTS (SELECT TOP 1 1 FROM EDMT1091 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON  T2.ReceiptTypeID = T1.ReceiptTypeID ---- Danh mục biểu phí
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2130 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON  T2.ReceiptTypeID = T1.ReceiptTypeID ---- Nghiệp vụ đăng ký dịch vụ
				   )
		BEGIN
			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
			SELECT 2 AS Status, NULL AS Params, NULL AS MessageID, APK 
			FROM #EDMP9000 T1 WITH (NOLOCK) 
			WHERE EXISTS (
						  SELECT TOP 1 1 FROM EDMT1091 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.ReceiptTypeID = T1.ReceiptTypeID ---- Danh mục biểu phí
					      UNION ALL 
					      SELECT TOP 1 1 FROM EDMT2130 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.ReceiptTypeID = T1.ReceiptTypeID ---- Nghiệp vụ đăng ký dịch vụ
						 )
		END'
	END 



	SET  @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #EDMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #EDMP9000_Errors T1 ORDER BY MessageID'
END 
   



/*********Danh mục loại hoạt động*************/
IF @FormID IN ('EDMF1060', 'EDMF1062')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #EDMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, ActivityTypeID, IsCommon
	INTO #EDMP9000
	FROM EDMT1060 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'EDMF1060' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''' AND IsCommon <> 1)	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, ActivityTypeID AS Params, ''00ML000050''AS MessageID, APK
		FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''' AND IsCommon <> 1
	END'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'
		IF EXISTS (SELECT TOP 1 1 FROM EDMT2091 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.ActivityTypeID = T1.ActivityTypeID ---- Lịch học năm 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2112 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON  T2.ActivityTypeID = T1.ActivityTypeID ---- Tổng khung chương trình
				   )
		BEGIN
			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
			
			SELECT 2 AS Status, T1.ActivityTypeID AS Params, ''00ML000165''AS MessageID, T1.APK 
			FROM #EDMP9000 T1 WITH (NOLOCK) 
			WHERE EXISTS (
						  SELECT TOP 1 1 FROM EDMT2091 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.ActivityTypeID = T1.ActivityTypeID ---- Lịch học năm 
						  UNION ALL 
						  SELECT TOP 1 1 FROM EDMT2112 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON  T2.ActivityTypeID = T1.ActivityTypeID ---- Tổng khung chương trình
						 )
		END
		


		DELETE T1 FROM EDMT1061 T1 INNER JOIN #EDMP9000 T2 ON T1.APKMaster = T2.APK 
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APKMaster = T3.APK) ---- Delate detail 

		DELETE T1 FROM EDMT1060 T1 INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK 
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK) ---- Delete master'
	END
	ELSE IF @Mode = 2 
	BEGIN 
		SET @sSQL = @sSQL + N'
		UPDATE T1 SET T1.Disabled = '+CAST(@IsDisable AS VARCHAR(1))+' FROM EDMT1060 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END 
	ELSE IF @Mode = 3 
	BEGIN 
		SET @sSQL = @sSQL + N'
		IF EXISTS (SELECT TOP 1 1 FROM EDMT2091 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.ActivityTypeID = T1.ActivityTypeID ---- Lịch học năm 
				   UNION ALL 
		           SELECT TOP 1 1 FROM EDMT2112 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON  T2.ActivityTypeID = T1.ActivityTypeID ---- Tổng khung chương trình
				   )
		BEGIN
			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
			SELECT 2 AS Status, NULL AS Params, NULL AS MessageID, APK
			FROM #EDMP9000 T1 WITH (NOLOCK) 
			WHERE EXISTS (
						  SELECT TOP 1 1 FROM EDMT2091 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.ActivityTypeID = T1.ActivityTypeID ---- Lịch học năm 
						  UNION ALL 
						  SELECT TOP 1 1 FROM EDMT2112 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON  T2.ActivityTypeID = T1.ActivityTypeID ---- Tổng khung chương trình
						 )
		END'
	END 


	SET  @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #EDMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #EDMP9000_Errors T1 ORDER BY MessageID'
END 




/*********Danh mục điều tra tâm lý *************/
IF @FormID IN ('EDMF1070', 'EDMF1072')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #EDMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, PsychologizeID, IsCommon
	INTO #EDMP9000
	FROM EDMT1070 WITH (NOLOCK) WHERE CONVERT(VARCHAR(50),APK) IN ('''+CASE WHEN @FormID = 'EDMF1070' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''' AND IsCommon <> 1)	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, PsychologizeID AS Params, ''00ML000050''AS MessageID, APK
		FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''' AND IsCommon <> 1
	END'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'
		IF EXISTS (SELECT TOP 1 1 FROM EDMT2011 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.PsychologizeID = T1.PsychologizeID ---- Hồ sơ học sinh 
				   )
		BEGIN
			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
			
			SELECT 2 AS Status, T1.PsychologizeID AS Params, ''00ML000165''AS MessageID, T1.APK 
			FROM #EDMP9000 T1 WITH (NOLOCK) 
			WHERE EXISTS ( SELECT TOP 1 1 FROM EDMT2011 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.PsychologizeID = T1.PsychologizeID ---- Hồ sơ học sinh 
						 )
		END

		DELETE T1 FROM EDMT1070 T1 INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK 
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END
	ELSE IF @Mode = 2 
	BEGIN 
		SET @sSQL = @sSQL + N'
		UPDATE T1 SET T1.Disabled = '+CAST(@IsDisable AS VARCHAR(1))+' FROM EDMT1070 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)'

	END 
	ELSE IF @Mode = 3 
	BEGIN 
		SET @sSQL = @sSQL + N'
		IF EXISTS (SELECT TOP 1 1 FROM EDMT2011 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.DivisionID = T1.DivisionID AND T2.PsychologizeID = T1.PsychologizeID ---- Hồ sơ học sinh 
				   )
		BEGIN
			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
			SELECT 2 AS Status,NULL AS Params, NULL AS MessageID, APK
			FROM #EDMP9000 T1 WITH (NOLOCK) 
			WHERE EXISTS ( SELECT TOP 1 1 FROM EDMT2011 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.PsychologizeID = T1.PsychologizeID ---- Hồ sơ học sinh 
						 )
		END'
	END 


	SET  @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #EDMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #EDMP9000_Errors T1 ORDER BY MessageID'
END 




/*********Danh mục Feeling *************/
IF @FormID IN ('EDMF1080', 'EDMF1082')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #EDMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, FeelingID, IsCommon
	INTO #EDMP9000
	FROM EDMT1080 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'EDMF1080' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''' AND IsCommon <> 1)	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, FeelingID AS Params, ''00ML000050''AS MessageID, APK
		FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''' AND IsCommon <> 1
	END'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'
		IF EXISTS (SELECT TOP 1 1 FROM EDMT2050 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.FeelingID = T1.FeelingID ---- Kết quả học tập 
				   )
		BEGIN
			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
			
			SELECT 2 AS Status, T1.FeelingID AS Params, ''00ML000165''AS MessageID, T1.APK 
			FROM #EDMP9000 T1 WITH (NOLOCK) 
			WHERE EXISTS ( SELECT TOP 1 1 FROM EDMT2050 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.FeelingID = T1.FeelingID ---- Kết quả học tập  
						 )
		END

		DELETE T1 FROM EDMT1080 T1 INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK 
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END
	ELSE IF @Mode = 2 
	BEGIN 
		SET @sSQL = @sSQL + N'
		UPDATE T1 SET T1.Disabled = '+CAST(@IsDisable AS VARCHAR(1))+' FROM EDMT1080 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END 
	ELSE IF @Mode = 3 
	BEGIN 
		SET @sSQL = @sSQL + N'
		IF EXISTS (SELECT TOP 1 1 FROM EDMT2050 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.FeelingID = T1.FeelingID ---- Kết quả học tập 
				   )
		BEGIN
			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
			
			SELECT 2 AS Status, NULL AS Params, NULL AS MessageID, APK
			FROM #EDMP9000 T1 WITH (NOLOCK) 
			WHERE EXISTS ( SELECT TOP 1 1 FROM EDMT2050 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.FeelingID = T1.FeelingID ---- Kết quả học tập  
						 )
		END'
	END


	SET  @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #EDMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #EDMP9000_Errors T1 ORDER BY MessageID'
END 




/*********Danh mục biểu phí*************/
IF @FormID IN ('EDMF1090', 'EDMF1092')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #EDMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, FeeID, IsCommon
	INTO #EDMP9000
	FROM EDMT1090 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'EDMF1090' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''' AND IsCommon <> 1)	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, FeeID AS Params, ''00ML000050''AS MessageID, APK
		FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''' AND IsCommon <> 1
	END'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'
		IF EXISTS (SELECT TOP 1 1 FROM EDMT2160 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.FeeID = T1.FeeID ---- Dự thu học phí
				   )
		BEGIN
			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
			
			SELECT 2 AS Status, T1.FeeID AS Params, ''00ML000165''AS MessageID, T1.APK 
			FROM #EDMP9000 T1 WITH (NOLOCK) 
			WHERE EXISTS ( SELECT TOP 1 1 FROM EDMT2160 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.FeeID = T1.FeeID ---- Dự thu học phí 
						 )
		END


		DELETE T1 FROM EDMT1091 T1 INNER JOIN #EDMP9000 T2 ON T1.APKMaster = T2.APK 
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APKMaster = T3.APK) ---- Delate detail 

		DELETE T1 FROM EDMT1090 T1 INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK 
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK) ---- Delete master'
	END
	ELSE IF @Mode = 2 
	BEGIN 
		SET @sSQL = @sSQL + N'
		UPDATE T1 SET T1.Disabled = '+CAST(@IsDisable AS VARCHAR(1))+' FROM EDMT1090 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END 
	ELSE IF @Mode = 3
	BEGIN 
		SET @sSQL = @sSQL + N'
		IF EXISTS (SELECT TOP 1 1 FROM EDMT2160 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.FeeID = T1.FeeID ---- Dự thu học phí
		WHERE T1.DeleteFlg = 0 
				   )
		BEGIN
			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
			
			SELECT 2 AS Status, NULL AS Params, NULL AS MessageID, APK
			FROM #EDMP9000 T1 WITH (NOLOCK) 
			WHERE EXISTS ( SELECT TOP 1 1 FROM EDMT2160 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.FeeID = T1.FeeID ---- Dự thu học phí 
					WHERE T1.DeleteFlg = 0 

						 )
		END'
	END 

	SET  @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #EDMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #EDMP9000_Errors T1 ORDER BY MessageID'
END 






/*********Nghiệp vụ Phiếu thông tin tư vấn  *************/
IF @FormID IN ('EDMF2000', 'EDMF2002')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #EDMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, VoucherNo,StudentID,ParentID
	INTO #EDMP9000
	FROM EDMT2000 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'EDMF2000' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''')	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, VoucherNo AS Params, ''00ML000050''AS MessageID, APK
		FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END
	
	'

	
	IF @Mode = 0
	BEGIN 
		SET @sSQL = @sSQL + N'
			IF EXISTS (
				SELECT TOP 1 1 FROM #EDMP9000 A INNER JOIN EDMT2021 B WITH(NOLOCK) ON A.DivisionID = B.DivisionID AND A.StudentID = B.StudentID AND B.DeleteFlg = 0    ------XẾP LỚP 
				UNION ALL 
				SELECT TOP 1 1 FROM #EDMP9000 A INNER JOIN AT9000 B WITH(NOLOCK) ON A.DivisionID = B.DivisionID AND CONVERT(VARCHAR(50),A.APK)  = B.InheritVoucherID -----PHÁT SINH DỮ LIỆU DƯỚI 8 

		)
		BEGIN
			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
			
			SELECT 2 AS Status, T1.VoucherNo AS Params, ''00ML000165''AS MessageID, T1.APK 
			FROM #EDMP9000 T1 WITH (NOLOCK) 	
		END
		'
	END 

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'
	IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 A INNER JOIN EDMT2021 B WITH(NOLOCK) ON A.DivisionID = B.DivisionID AND A.StudentID = B.StudentID AND B.DeleteFlg = 0    ------XẾP LỚP 
				UNION ALL 
				SELECT TOP 1 1 FROM #EDMP9000 A INNER JOIN AT9000 B WITH(NOLOCK) ON A.DivisionID = B.DivisionID AND A.StudentID = B.ObjectID -----PHÁT SINH DỮ LIỆU DƯỚI 8 			
				) 
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, VoucherNo AS Params, ''00ML000052''AS MessageID, A.APK
		FROM #EDMP9000 A 
		WHERE EXISTS (SELECT TOP 1 1 FROM #EDMP9000 A INNER JOIN EDMT2021 B WITH(NOLOCK) ON A.DivisionID = B.DivisionID AND A.StudentID = B.StudentID AND B.DeleteFlg = 0    ------XẾP LỚP 
					  UNION ALL 
					  SELECT TOP 1 1 FROM #EDMP9000 A INNER JOIN AT9000 B WITH(NOLOCK) ON A.DivisionID = B.DivisionID AND A.StudentID = B.ObjectID  ----PHÁT SINH DỮ LIỆU DƯỚI 8 
					   )
		
	END


	 ----Xóa danh mục đối tượng phụ huynh 

   DELETE T1 FROM AT1202 T1 WITH (NOLOCK)
   INNER JOIN #EDMP9000 T2 WITH (NOLOCK) ON T1.ObjectID = T2.ParentID
   WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T2.APK = T3.APK)
   AND NOT EXISTS (SELECT ParentID
					FROM EDMT2000 WITH (NOLOCK)
					WHERE T1.ObjectID = EDMT2000.ParentID AND EDMT2000.DeleteFlg = 0
					GROUP BY ParentID
					HAVING COUNT (ParentID) > 1 )


	----Xóa danh mục khách hàng (CRM)  
	      DELETE T1 FROM POST0011 T1 WITH (NOLOCK) 
		  INNER JOIN #EDMP9000 T2 WITH (NOLOCK) ON T1.MemberID = T2.ParentID
		 WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T2.APK = T3.APK)
		 AND NOT EXISTS (SELECT ParentID
					FROM EDMT2000 WITH (NOLOCK)
					WHERE T1.MemberID = EDMT2000.ParentID AND EDMT2000.DeleteFlg = 0
					GROUP BY ParentID
					HAVING COUNT (ParentID) > 1 )

	----Xóa danh mục đầu mối 
	      DELETE T1 FROM CRMT20301  T1 WITH (NOLOCK) 
		  INNER JOIN #EDMP9000 T2 WITH (NOLOCK) ON T1.InheritConsultantID = T2.APK
		 WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T2.APK = T3.APK)
		 AND NOT EXISTS (SELECT ParentID
					FROM EDMT2000 WITH (NOLOCK)
					WHERE T1.InheritConsultantID = EDMT2000.APK AND EDMT2000.DeleteFlg = 0
					GROUP BY EDMT2000.ParentID
					HAVING COUNT (EDMT2000.ParentID) > 1 )

		

		 ---Cập nhật trạng thái phiếu thông tin tư vấn
		 
		UPDATE T1  ---Xóa detail 
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2001 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APKMaster = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APKMaster = T3.APK)

		 
		 ----MASTER 
        UPDATE T1
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2000 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)


	----Cập nhật trạng thái hồ sơ học sinh 
	    UPDATE T1
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2010 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.StudentID = T2.StudentID
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T2.APK = T3.APK)



   ------Xóa danh mục đối tượng học sinh 

   DELETE T1 FROM AT1202 T1 WITH (NOLOCK) 
   INNER JOIN #EDMP9000 T2 WITH (NOLOCK) ON T1.ObjectID = T2.StudentID
   WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T2.APK = T3.APK)



   -----Xóa bảng thay đổi mức đóng phí 

		UPDATE T4  ---Xóa detail 
		SET T4.DeleteFlg = 1
		, T4.LastModifyUserID = '''+@UserID+'''
		, T4.LastModifyDate = GETDATE()
		FROM EDMT2200 T1 WITH (NOLOCK)
		INNER JOIN #EDMP9000 T2 ON T1.StudentID = T2.StudentID AND ISNULL(T1.VoucherNo,'''') = '''' 
		INNER JOIN EDMT2201 T4 WITH (NOLOCK) ON T1.APK = T4.APKMaster 
	    WHERE T1.DeleteFlg = 0 AND NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T2.APK = T3.APK)



		----Xóa master 
		UPDATE T1  
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2200 T1 WITH (NOLOCK)
		INNER JOIN #EDMP9000 T2 ON T1.StudentID = T2.StudentID AND ISNULL(T1.VoucherNo,'''') = '''' 
	    WHERE T1.DeleteFlg = 0 AND NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T2.APK = T3.APK)



   ---Xóa bảng theo dõi mức phí đầu năm 

  		UPDATE T4  ---Xóa detail 
		SET T4.DeleteFlg = 1
		, T4.LastModifyUserID = '''+@UserID+'''
		, T4.LastModifyDate = GETDATE()
		FROM EDMT2013 T1 WITH (NOLOCK)
		INNER JOIN #EDMP9000 T2 ON T1.StudentID = T2.StudentID 
		INNER JOIN EDMT2014 T4 WITH (NOLOCK) ON T1.APK = T4.APKMaster 
	    WHERE T1.DeleteFlg = 0 AND NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T2.APK = T3.APK)



		----Xóa master 
		UPDATE T1  
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2013 T1 WITH (NOLOCK)
		INNER JOIN #EDMP9000 T2 ON T1.StudentID = T2.StudentID 
	    WHERE T1.DeleteFlg = 0 AND NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T2.APK = T3.APK)
 
'

	
	END


 

	SET @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #EDMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #EDMP9000_Errors T1 ORDER BY MessageID'
END 

/*********Nghiệp vụ hồ sơ học sinh  *************/
IF @FormID IN ('EDMF2010', 'EDMF2012')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #EDMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, StudentID,APKConsultant
	INTO #EDMP9000
	FROM EDMT2010 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'EDMF2010' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''')	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, StudentID AS Params, ''00ML000050''AS MessageID, APK
		FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'
		IF EXISTS (SELECT TOP 1 1 FROM EDMT2000 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.APKConsultant = T1.APK ---Phiếu thông tin tư vấn 
				   UNION ALL 
				   SELECT TOP 1 1 FROM EDMT2021 T1 WITH (NOLOCK)
				   INNER JOIN #EDMP9000 T2 WITH (NOLOCK) ON T2.DivisionID = T1.DivisionID AND T2.StudentID = T1.StudentID AND T1.DeleteFlg = 0 ---kết  hoc tập 
				   )
		BEGIN
			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
			
			SELECT 2 AS Status, T1.StudentID AS Params, ''00ML000165''AS MessageID, T1.APK 
			FROM #EDMP9000 T1 WITH (NOLOCK) 
			WHERE EXISTS ( SELECT TOP 1 1 FROM EDMT2000 T1 WITH (NOLOCK) INNER JOIN #EDMP9000 T2 ON T2.APKConsultant = T1.APK  ---- Phiếu thông tin tư vấn
						  UNION ALL 
						  SELECT TOP 1 1 FROM EDMT2021 T1 WITH (NOLOCK)
				          INNER JOIN #EDMP9000 T2 WITH (NOLOCK) ON T2.DivisionID = T1.DivisionID AND T2.StudentID = T1.StudentID AND T1.DeleteFlg = 0 ---kết  hoc tập
						 )
		END


		UPDATE T1
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2010 T1 WITH(NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END


	SET @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #EDMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #EDMP9000_Errors T1 ORDER BY MessageID'
END 


/*********Nghiệp vụ Xếp lớp  *************/
IF @FormID IN ('EDMF2020', 'EDMF2022')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #EDMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, ArrangeClassID,SchoolYearID,GradeID,ClassID
	INTO #EDMP9000
	FROM EDMT2020 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'EDMF2020' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''')	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, ArrangeClassID AS Params, ''00ML000050''AS MessageID, APK
		FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'
		IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 T1 WITH (NOLOCK)
					INNER JOIN EDMT2040 T2 WITH (NOLOCK) ON T2.DivisionID = T1.DivisionID AND T2.SchoolYearID = T1.SchoolYearID AND T2.GradeID = T1.GradeID AND T1.ClassID = T2.ClassID AND T2.DeleteFlg = 0  --NV điểm danh 
					UNION ALL 
					SELECT TOP 1 1 FROM #EDMP9000 T1 WITH (NOLOCK)
					INNER JOIN EDMT2050 T2 WITH (NOLOCK) ON T2.DivisionID = T1.DivisionID AND T2.SchoolYearID = T1.SchoolYearID AND T2.GradeID = T1.GradeID AND T1.ClassID = T2.ClassID AND T2.DeleteFlg = 0 ---kết  hoc tập 
					--UNION ALL 
					--SELECT TOP 1 1 FROM #EDMP9000 T1 WITH (NOLOCK)
					--INNER JOIN EDMT2140 T2 WITH (NOLOCK) ON T2.DivisionID = T1.DivisionID AND T2.ArrangeClassIDFrom = T1.ArrangeClassID AND AND T2.DeleteFlg = 0 ---Điều chuyển học sinh 
					UNION ALL 
					SELECT TOP 1 1 FROM #EDMP9000 T1 WITH (NOLOCK)
					INNER JOIN EDMT2150 T2 WITH (NOLOCK) ON T2.DivisionID = T1.DivisionID AND T2.SchoolYearID = T1.SchoolYearID AND T2.GradeID = T1.GradeID AND T1.ClassID = T2.ClassID AND T2.DeleteFlg = 0 ---Bảo lưu  
					UNION ALL 
					SELECT TOP 1 1 FROM #EDMP9000 T1 WITH (NOLOCK)
					INNER JOIN EDMT2160 T2 WITH (NOLOCK) ON T2.DivisionID = T1.DivisionID AND T2.SchoolYearID = T1.SchoolYearID AND T2.GradeID = T1.GradeID AND T1.ClassID = T2.ClassID AND T2.DeleteFlg = 0 ---Dự thu học phí 
				   )
		BEGIN
			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
			
			SELECT 2 AS Status, T1.ArrangeClassID AS Params, ''00ML000165''AS MessageID, T1.APK 
			FROM #EDMP9000 T1 WITH (NOLOCK) 
			WHERE EXISTS ( SELECT TOP 1 1 FROM #EDMP9000 T1 WITH (NOLOCK)
						   INNER JOIN EDMT2040 T2 WITH (NOLOCK) ON T2.SchoolYearID = T1.SchoolYearID AND T2.GradeID = T1.GradeID AND T1.ClassID = T2.ClassID AND T2.DeleteFlg = 0
						   UNION ALL 
						   SELECT TOP 1 1 FROM #EDMP9000 T1 WITH (NOLOCK)
						   INNER JOIN EDMT2050 T2 WITH (NOLOCK) ON T2.SchoolYearID = T1.SchoolYearID AND T2.GradeID = T1.GradeID AND T1.ClassID = T2.ClassID AND T2.DeleteFlg = 0 ---kết  hoc tập 
						   --UNION ALL 
						   --SELECT TOP 1 1 FROM #EDMP9000 T1 WITH (NOLOCK)
						   --INNER JOIN EDMT2140 T2 WITH (NOLOCK) ON T2.DivisionID = T1.DivisionID AND T2.ArrangeClassIDFrom = T1.ArrangeClassID AND AND T2.DeleteFlg = 0 ---Điều chuyển hoc sinh 
						   UNION ALL 
						   SELECT TOP 1 1 FROM #EDMP9000 T1 WITH (NOLOCK)
					       INNER JOIN EDMT2150 T2 WITH (NOLOCK) ON T2.DivisionID = T1.DivisionID AND T2.SchoolYearID = T1.SchoolYearID AND T2.GradeID = T1.GradeID AND T1.ClassID = T2.ClassID AND T2.DeleteFlg = 0 ---Bảo lưu 
						   UNION ALL 
						   SELECT TOP 1 1 FROM #EDMP9000 T1 WITH (NOLOCK)
						   INNER JOIN EDMT2160 T2 WITH (NOLOCK) ON T2.DivisionID = T1.DivisionID AND T2.SchoolYearID = T1.SchoolYearID AND T2.GradeID = T1.GradeID AND T1.ClassID = T2.ClassID AND T2.DeleteFlg = 0 ---Dự thu học phí 
						 )
		END



		UPDATE T1  ---Xóa detail 
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2021 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APKMaster = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APKMaster = T3.APK)


		---XÓA MASTER 
		UPDATE T1
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2020 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END


	SET @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #EDMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #EDMP9000_Errors T1 ORDER BY MessageID'
END 

/*********Nghiệp vụ Phân công giáo viên  *************/
IF @FormID IN ('EDMF2030', 'EDMF2032')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #EDMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, VoucherNo,SchoolYearID,GradeID,ClassID
	INTO #EDMP9000
	FROM EDMT2030 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'EDMF2030' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''')	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, VoucherNo AS Params, ''00ML000050''AS MessageID, APK
		FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'
		IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 T1 
					INNER JOIN EDMT2031 T2 ON T1.APK = T2.APKMaster 
					INNER JOIN EDMT2060 T3 ON T3.DivisionID = T1.DivisionID AND T3.SchoolYearID = T1.SchoolYearID AND T1.GradeID = T3.GradeID AND T1.ClassID = T3.ClassID AND T2.TeacherID = T3.TeacherID
					UNION ALL 
					SELECT TOP 1 1 FROM #EDMP9000 T1 WITH (NOLOCK)
					INNER JOIN EDMT2071 T2 WITH (NOLOCK) ON T2.DivisionID = T1.DivisionID AND T2.GradeIDFrom = T1.GradeID AND T1.ClassID = T2.ClassIDFrom AND T2.DeleteFlg = 0 -----Điều chuyển giáo viên 

				   )
		BEGIN
			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
			
			SELECT 2 AS Status, T1.VoucherNo AS Params, ''00ML000165''AS MessageID, T1.APK 
			FROM #EDMP9000 T1 WITH (NOLOCK) 
			WHERE EXISTS (SELECT TOP 1 1 FROM #EDMP9000 T1 
					INNER JOIN EDMT2031 T2 ON T1.APK = T2.APKMaster 
					INNER JOIN EDMT2060 T3 ON T3.DivisionID = T1.DivisionID AND T3.SchoolYearID = T1.SchoolYearID AND T1.GradeID = T3.GradeID AND T1.ClassID = T3.ClassID AND T2.TeacherID = T3.TeacherID
					UNION ALL 
					SELECT TOP 1 1 FROM #EDMP9000 T1 WITH (NOLOCK)
					INNER JOIN EDMT2071 T2 WITH (NOLOCK) ON T2.DivisionID = T1.DivisionID AND T2.GradeIDFrom = T1.GradeID AND T1.ClassID = T2.ClassIDFrom AND T2.DeleteFlg = 0 -----Điều chuyển giáo viên 

						 )
		END

		UPDATE T1  ---Xóa detail 
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2031 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APKMaster = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APKMaster = T3.APK)

		UPDATE T1  ---Xóa detail 
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2032 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APKMaster = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APKMaster = T3.APK)


		----Xóa master 
		UPDATE T1
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2030 T1 WITH(NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END


	SET @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #EDMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #EDMP9000_Errors T1 ORDER BY MessageID'
END 

/*********Nghiệp vụ điểm danh  *************/
IF @FormID IN ('EDMF2040', 'EDMF2042')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #EDMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, VoucherNo,AttendanceDate,SchoolYearID,GradeID,ClassID
	INTO #EDMP9000
	FROM EDMT2040 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'EDMF2040' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''')	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, VoucherNo AS Params, ''00ML000050''AS MessageID, APK
		FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'
		IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 T1 WITH (NOLOCK) 
		INNER JOIN EDMT2160 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T2.DeleteFlg = 0 
		AND T1.GradeID = T2.GradeID AND T1.ClassID = T2.ClassID  AND T2.TranMonth = MONTH(DATEADD(MONTH, 1, T1.AttendanceDate))  
		AND T2.TranYear = Year(DATEADD(MONTH, 1, T1.AttendanceDate)) -----Đã dự thu học phí 
				   )
		BEGIN
			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
			
			SELECT 2 AS Status, T1.VoucherNo AS Params, ''00ML000165''AS MessageID, T1.APK 
			FROM #EDMP9000 T1 WITH (NOLOCK) 
			WHERE EXISTS ( SELECT TOP 1 1 FROM #EDMP9000 T1 WITH (NOLOCK) 
						   INNER JOIN EDMT2160 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T2.DeleteFlg = 0 
						   AND T1.GradeID = T2.GradeID AND T1.ClassID = T2.ClassID  AND T2.TranMonth = MONTH(DATEADD(MONTH, 1, T1.AttendanceDate))  
						  AND T2.TranYear = Year(DATEADD(MONTH, 1, T1.AttendanceDate)) -----Đã dự thu học phí 
						 )
		END

		-----Xóa đơn xin phép trên app 

		DELETE T1
		FROM APT0008 T1 WITH (NOLOCK) 
		INNER JOIN EDMT2041 T2 ON T2.DeleteFlg = T1.DeleteFlg AND ISNULL(T2.InheritAPKAbsence,'''') = CONVERT(VARCHAR(50),T1.APK) AND T2.IsException = 1 
		INNER JOIN #EDMP9000 T3 ON T2.APKMaster = T3.APK
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T4 WHERE T3.APK = T4.APK)
		AND T1.DeleteFlg = 0
		
	

		-----Xóa detail 
		UPDATE T1  ---Xóa detail 
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2041 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APKMaster = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APKMaster = T3.APK)


		----XÓA MASTER 
		UPDATE T1
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2040 T1 WITH(NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)
		


		'


		






	END


	SET @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #EDMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #EDMP9000_Errors T1 ORDER BY MessageID'
END 

/*********Nghiệp vụ Kết quả học tập  *************/
IF @FormID IN ('EDMF2050', 'EDMF2052')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #EDMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, VoucherResult
	INTO #EDMP9000
	FROM EDMT2050 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'EDMF2050' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''')	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, VoucherResult AS Params, ''00ML000050''AS MessageID, APK
		FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'

		UPDATE T1
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2050 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END


	SET @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #EDMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #EDMP9000_Errors T1 ORDER BY MessageID'
END 


/*********Nghiệp vụ Kết quả dự giờ  *************/
IF @FormID IN ('EDMF2060', 'EDMF2062')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #EDMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, EvaluetionID
	INTO #EDMP9000
	FROM EDMT2060 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'EDMF2060' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''')	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, EvaluetionID AS Params, ''00ML000050''AS MessageID, APK
		FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'

		---Xóa detail 
		UPDATE T1   
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2061 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APKMaster = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APKMaster = T3.APK)

		
		---Xóa master 
		UPDATE T1
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2060 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END


	SET @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #EDMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #EDMP9000_Errors T1 ORDER BY MessageID'
END 

/*********Nghiệp vụ điều chuyển giáo viên  *************/
IF @FormID IN ('EDMF2070', 'EDMF2072')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #EDMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, VoucherNo,DecisionDate
	INTO #EDMP9000
	FROM EDMT2070 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'EDMF2070' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''')	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, VoucherNo AS Params, ''00ML000050''AS MessageID, APK
		FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'

		IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 T1 WHERE CONVERT(VARCHAR(10), CONVERT(DATE, T1.DecisionDate,120), 126)  <= '''+CONVERT(VARCHAR(10),GETDATE(),126)+''' -----Đã cập nhật trạng thái nghỉ học 
				   )
		BEGIN
			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
			
			SELECT 2 AS Status, T1.VoucherNo AS Params, ''00ML000165''AS MessageID, T1.APK 
			FROM #EDMP9000 T1 WITH (NOLOCK) 
			WHERE EXISTS ( SELECT TOP 1 1 FROM #EDMP9000 T1 WHERE CONVERT(VARCHAR(10), CONVERT(DATE, T1.DecisionDate,120), 126)  <= '''+CONVERT(VARCHAR(10),GETDATE(),126)+'''  ----Đã cập nhật trạng thái nghỉ học 
						 )
		END
		

		----Xóa detail
		UPDATE T1   
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2071 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APKMaster = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APKMaster = T3.APK)

		
		---Xóa master 
		UPDATE T1
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2070 T1 WITH(NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END


	SET @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #EDMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #EDMP9000_Errors T1 ORDER BY MessageID'
END 


/*********Nghiệp vụ Quyết định nghỉ học  *************/
IF @FormID IN ('EDMF2080', 'EDMF2082')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #EDMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, VoucherLeaveSchool,LeaveDate
	INTO #EDMP9000
	FROM EDMT2080 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'EDMF2080' THEN @APKList ELSE @APK END+''') OR APKVoucher IN ('''+CASE WHEN @FormID = 'EDMF2080' THEN @APKList ELSE @APK END+''')
	
	---- Kiểm tra khác đơn vị
	IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''')	
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, VoucherLeaveSchool AS Params, ''00ML000050''AS MessageID, APK
		FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END
	
	-- Kiểm tra Người dùng thuộc Nhóm ADMIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM AT1402 WHERE DivisionID = ''' + @DivisionID + ''' AND UserID = ''' + @UserID + ''' AND GroupID = ''ADMIN'' )
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, ''' + @UserID + ''' AS Params, ''AFML000119''AS MessageID, APK
		FROM #EDMP9000 
	END
	'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'
																	print 123123213123

		IF EXISTS (
			SELECT TOP 1 1 FROM #EDMP9000 T1 
			---	Quyết toán
			INNER JOIN EDMT2081 T2 WITH (NOLOCK) ON CONVERT(VARCHAR(50),T1.APK) = CONVERT(VARCHAR(50),T2.APKMaster) AND T1.DivisionID = T2.DivisionID AND T2.DeleteFlg = 0 
			
			UNION ALL
			 
			SELECT TOP 1 1 FROM #EDMP9000 T0 
			---	Quyết định nghỉ học
			INNER JOIN EDMT2080 T1 WITH (NOLOCK) ON T1.APK = T0.APK 
			--- Bảng tạm chứa dữ liệu Học lại
			INNER JOIN EDMT2012 T2 WITH (NOLOCK) ON T2.StudentID = T1.StudentID 
			WHERE T2.DivisionID = ''' + @DivisionID + ''' AND T2.DateStudy >= T1.CreateDate

				   )
		BEGIN
			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)

			SELECT 2 AS Status, T1.VoucherLeaveSchool AS Params, ''00ML000165''AS MessageID, T1.APK 
			FROM #EDMP9000 T1 WITH (NOLOCK) 
		END
		ELSE BEGIN 


		UPDATE T1
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2080 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON CONVERT(VARCHAR(50), T1.APK) = CONVERT(VARCHAR(50), T2.APK)
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE CONVERT(VARCHAR(50), T1.APK) = CONVERT(VARCHAR(50), T3.APK))
		
		END


		'
	END





	SET @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #EDMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #EDMP9000_Errors T1 ORDER BY MessageID'
END 

/*********Nghiệp vụ lịch học năm *************/
IF @FormID IN ('EDMF2090', 'EDMF2092')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #EDMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, YearlyScheduleID
	INTO #EDMP9000
	FROM EDMT2090 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'EDMF2090' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''')	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, YearlyScheduleID AS Params, ''00ML000050''AS MessageID, APK
		FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'

		----Xóa detail
		UPDATE T1   
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2091 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APKMaster = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APKMaster = T3.APK)

		UPDATE T1
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2090 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END


	SET @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #EDMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #EDMP9000_Errors T1 ORDER BY MessageID'
END 




/*********Nghiệp vụ lịch học cơ sở *************/
IF @FormID IN ('EDMF2100', 'EDMF2102')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #EDMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, DailyScheduleID
	INTO #EDMP9000
	FROM EDMT2100 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'EDMF2100' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''')	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, DailyScheduleID AS Params, ''00ML000050''AS MessageID, APK
		FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'

		UPDATE T1  ---Xóa detail 
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2101 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APKMaster = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APKMaster = T3.APK)


		UPDATE T1   ----Xóa master
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2100 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END


	SET @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #EDMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #EDMP9000_Errors T1 ORDER BY MessageID'
END 






/*********Nghiệp vụ tổng khung chương trình  *************/
IF @FormID IN ('EDMF2110', 'EDMF2112')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #EDMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, ProgramID
	INTO #EDMP9000
	FROM EDMT2110 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'EDMF2110' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''')	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, ProgramID AS Params, ''00ML000050''AS MessageID, APK
		FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'

		UPDATE T1  ---Xóa detail 
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2111 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APKMaster = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APKMaster = T3.APK)

		UPDATE T1  ---Xóa detail 
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2112 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APKMaster = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APKMaster = T3.APK)

		UPDATE T1
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2110 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END


	SET @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #EDMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #EDMP9000_Errors T1 ORDER BY MessageID'
END 


/*********Nghiệp vụ chương trình theo tháng*************/
IF @FormID IN ('EDMF2120', 'EDMF2122')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #EDMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, ProgramMonthID
	INTO #EDMP9000
	FROM EDMT2120 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'EDMF2120' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''')	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, ProgramMonthID AS Params, ''00ML000050''AS MessageID, APK
		FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'

		UPDATE T1  ---Xóa detail 
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2121 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APKMaster = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APKMaster = T3.APK)


		UPDATE T1 ---Xóa master 
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2120 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END


	SET @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #EDMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #EDMP9000_Errors T1 ORDER BY MessageID'
END 

/*********Nghiệp vụ Đăng ký dịch vụ*************/
IF @FormID IN ('EDMF2130', 'EDMF2132')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #EDMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, VoucherNo
	INTO #EDMP9000
	FROM EDMT2130 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'EDMF2130' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''')	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, VoucherNo AS Params, ''00ML000050''AS MessageID, APK
		FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'

		IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 T1 INNER JOIN AT9000 T2 WITH (NOLOCK) ON T1.APK = T2.InheritVoucherID AND T1.DivisionID = T2.DivisionID AND T2.InheritTableID = ''EDMT2130''
				   )
		BEGIN
			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
			
			SELECT 2 AS Status, T1.VoucherNo AS Params, ''00ML000165''AS MessageID, T1.APK 
			FROM #EDMP9000 T1 WITH (NOLOCK) 
			WHERE EXISTS (SELECT TOP 1 1 FROM #EDMP9000 T1 INNER JOIN AT9000 T2 WITH (NOLOCK) ON T1.APK = T2.InheritVoucherID AND T1.DivisionID = T2.DivisionID AND T2.InheritTableID = ''EDMT2130''
						 )
		END


		UPDATE T1  ---Xóa detail 
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2131 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APKMaster = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APKMaster = T3.APK)

		UPDATE T1  ---Xóa detail 
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2132 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APKMaster = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APKMaster = T3.APK)

		UPDATE T1  ---Xóa detail 
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2133 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APKMaster = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APKMaster = T3.APK)
		
		
		UPDATE T1 ---Xóa master 
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2130 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END


	SET @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #EDMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #EDMP9000_Errors T1 ORDER BY MessageID'
END 

/*********Nghiệp vụ điều chuyển học sinh*************/

IF @FormID IN ('EDMF2140', 'EDMF2142')
BEGIN
	SET @sSQL = N'
	
	CREATE TABLE #EDMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, TranferStudentNo,FromEffectiveDate
	INTO #EDMP9000
	FROM EDMT2140 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'EDMF2140' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''')	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, TranferStudentNo AS Params, ''00ML000050''AS MessageID, APK
		FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END

	-- Kiểm tra Người dùng thuộc Nhóm ADMIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM AT1402 WHERE DivisionID = ''' + @DivisionID + ''' AND UserID = ''' + @UserID + ''' AND GroupID = ''ADMIN'' )
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, ''' + @UserID + ''' AS Params, ''AFML000119''AS MessageID, APK
		FROM #EDMP9000 
	END
	'

	

	IF @Mode = 1 
	BEGIN 
	SET @sSQL = @sSQL + N'
	IF EXISTS ( 
				
			---	Chuyển trường đã bị kế thừa
			SELECT TOP 1 1 FROM #EDMP9000 T0 
			INNER JOIN EDMT2140 T1 WITH (NOLOCK) ON T0.APK = T1.APK AND T1.DivisionID <> T1.SchoolIDTo
			INNER JOIN EDMT2000 T3 WITH (NOLOCK) ON T3.APKTransfer = T1.APK AND T3.DeleteFlg = 0			

			UNION ALL

			---	Ở lớp mới đã được phát sinh nghiệp vụ liên quan tới Trạng thái Xếp lớp
			SELECT TOP 1 1 FROM #EDMP9000 T0 
			INNER JOIN EDMT2140 T1 WITH (NOLOCK) ON T0.APK = T1.APK AND T1.DivisionID = T1.SchoolIDTo
			INNER JOIN EDMT2020 T2 WITH (NOLOCK) ON T2.ArrangeClassID = T1.ArrangeClassIDTo
			INNER JOIN EDMT2021 T3 WITH (NOLOCK) ON T3.APKMaster = T2.APK AND T3.StudentID = T1.StudentID  
			WHERE CONVERT(DATE, T3.LastModifyDate) > CONVERT(DATE, T1.FromEffectiveDate)

			UNION ALL

			---	Ở lớp mới đã được phát sinh Điểm danh
			SELECT TOP 1 1 FROM #EDMP9000 T0 
			INNER JOIN EDMT2140 T1 WITH (NOLOCK) ON T0.APK = T1.APK AND T1.DivisionID = T1.SchoolIDTo
			INNER JOIN EDMT2020 T2 WITH (NOLOCK) ON T2.ArrangeClassID = T1.ArrangeClassIDTo
			INNER JOIN EDMT2040 T3 WITH (NOLOCK) ON T3.SchoolYearID = T2.SchoolYearID AND T3.GradeID = T2.GradeID AND T3.ClassID = T2.ClassID 
			INNER JOIN EDMT2041 T4 WITH (NOLOCK) ON T4.APKMaster = T3.APK AND T4.StudentID = T1.StudentID
			WHERE T3.DeleteFlg = 0 AND T4.DeleteFlg = 0 
				AND CONVERT(DATE, T3.CreateDate) >= CONVERT(DATE, T1.FromEffectiveDate)

			UNION ALL
				
			---	Ở lớp mới đã được phát sinh Dự thu
			SELECT TOP 1 1 FROM #EDMP9000 T0 
			INNER JOIN EDMT2140 T1 WITH (NOLOCK) ON T0.APK = T1.APK AND T1.DivisionID = T1.SchoolIDTo
			INNER JOIN EDMT2020 T2 WITH (NOLOCK) ON T2.ArrangeClassID = T1.ArrangeClassIDTo
			INNER JOIN EDMT2160 T3 WITH (NOLOCK) ON T3.SchoolYearID = T2.SchoolYearID AND T3.GradeID = T2.GradeID AND T3.ClassID = T2.ClassID 
			INNER JOIN EDMT2161 T4 WITH (NOLOCK) ON T4.APKMaster = T3.APK AND T4.StudentID = T1.StudentID
			WHERE T3.DeleteFlg = 0 AND T4.DeleteFlg = 0 
				AND CONVERT(DATE, T3.CreateDate) >= CONVERT(DATE, T1.FromEffectiveDate)

			UNION ALL
				
			---	Ở lớp mới đã được phát sinh Đơn xin phép trên App
			SELECT TOP 1 1 FROM #EDMP9000 T0 
			INNER JOIN EDMT2140 T1 WITH (NOLOCK) ON T0.APK = T1.APK AND T1.DivisionID = T1.SchoolIDTo
			INNER JOIN EDMT2020 T2 WITH (NOLOCK) ON T2.ArrangeClassID = T1.ArrangeClassIDTo
			INNER JOIN APT0008 T3 WITH (NOLOCK) ON T3.ArrangeClassID = T2.ArrangeClassID 
			WHERE  T3.StudentID = T1.StudentID AND T3.DeleteFlg = 0 
				AND CONVERT(DATE, T3.CreateDate) >= CONVERT(DATE, T1.FromEffectiveDate)

			UNION ALL
				
			---	Ở lớp mới đã được phát sinh Bảo lưu
			SELECT TOP 1 1 FROM #EDMP9000 T0 
			INNER JOIN EDMT2140 T1 WITH (NOLOCK) ON T0.APK = T1.APK AND T1.DivisionID = T1.SchoolIDTo
			INNER JOIN EDMT2020 T2 WITH (NOLOCK) ON T2.ArrangeClassID = T1.ArrangeClassIDTo
			INNER JOIN EDMT2150 T3 WITH (NOLOCK) ON T3.SchoolYearID = T2.SchoolYearID AND T3.GradeID = T2.GradeID AND T3.ClassID = T2.ClassID 
			WHERE  T3.StudentID = T1.StudentID AND T3.DeleteFlg = 0 
				AND CONVERT(DATE, T3.CreateDate) >= CONVERT(DATE, T1.FromEffectiveDate)

			UNION ALL
				
			---	Ở lớp mới đã được phát sinh Điều chuyển
			SELECT TOP 1 1 FROM #EDMP9000 T0 
			INNER JOIN EDMT2140 T1 WITH (NOLOCK) ON T0.APK = T1.APK AND T1.DivisionID = T1.SchoolIDTo
			INNER JOIN EDMT2140 T2 WITH (NOLOCK) ON T2.ArrangeClassIDFrom = T1.ArrangeClassIDTo AND T2.StudentID = T1.StudentID
			WHERE    T2.DeleteFlg = 0 
				AND CONVERT(DATE, T2.CreateDate) >= CONVERT(DATE, T1.FromEffectiveDate)

			UNION ALL
				
			---	Ở lớp mới đã được phát sinh Nghỉ học
			SELECT TOP 1 1 FROM #EDMP9000 T0 
			INNER JOIN EDMT2140 T1 WITH (NOLOCK) ON T0.APK = T1.APK AND T1.DivisionID = T1.SchoolIDTo
			INNER JOIN EDMT2080 T2 WITH (NOLOCK) ON T2.ArrangeClassID = T1.ArrangeClassIDTo AND T2.StudentID = T1.StudentID
			WHERE    T2.DeleteFlg = 0 
				AND CONVERT(DATE, T2.CreateDate) >= CONVERT(DATE, T1.FromEffectiveDate)


	)

		BEGIN
			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
			
			SELECT 2 AS Status, T1.TranferStudentNo AS Params, ''00ML000165''AS MessageID, T1.APK 
			FROM #EDMP9000 T1 WITH (NOLOCK) 
			WHERE EXISTS (
						---	Chuyển trường đã bị kế thừa
			SELECT TOP 1 1 FROM #EDMP9000 T0 
			INNER JOIN EDMT2140 T1 WITH (NOLOCK) ON T0.APK = T1.APK AND T1.DivisionID <> T1.SchoolIDTo
			INNER JOIN EDMT2000 T3 WITH (NOLOCK) ON T3.APKTransfer = T1.APK AND T3.DeleteFlg = 0			

			UNION ALL

			---	Ở lớp mới đã được phát sinh nghiệp vụ liên quan tới Trạng thái Xếp lớp
			SELECT TOP 1 1 FROM #EDMP9000 T0 
			INNER JOIN EDMT2140 T1 WITH (NOLOCK) ON T0.APK = T1.APK AND T1.DivisionID = T1.SchoolIDTo
			INNER JOIN EDMT2020 T2 WITH (NOLOCK) ON T2.ArrangeClassID = T1.ArrangeClassIDTo
			INNER JOIN EDMT2021 T3 WITH (NOLOCK) ON T3.APKMaster = T2.APK AND T3.StudentID = T1.StudentID  
			WHERE CONVERT(DATE, T3.LastModifyDate) > CONVERT(DATE, T1.FromEffectiveDate)

			UNION ALL

			---	Ở lớp mới đã được phát sinh Điểm danh
			SELECT TOP 1 1 FROM #EDMP9000 T0 
			INNER JOIN EDMT2140 T1 WITH (NOLOCK) ON T0.APK = T1.APK AND T1.DivisionID = T1.SchoolIDTo
			INNER JOIN EDMT2020 T2 WITH (NOLOCK) ON T2.ArrangeClassID = T1.ArrangeClassIDTo
			INNER JOIN EDMT2040 T3 WITH (NOLOCK) ON T3.SchoolYearID = T2.SchoolYearID AND T3.GradeID = T2.GradeID AND T3.ClassID = T2.ClassID 
			INNER JOIN EDMT2041 T4 WITH (NOLOCK) ON T4.APKMaster = T3.APK AND T4.StudentID = T1.StudentID
			WHERE T3.DeleteFlg = 0 AND T4.DeleteFlg = 0 
				AND CONVERT(DATE, T3.CreateDate) >= CONVERT(DATE, T1.FromEffectiveDate)

			UNION ALL
				
			---	Ở lớp mới đã được phát sinh Dự thu
			SELECT TOP 1 1 FROM #EDMP9000 T0 
			INNER JOIN EDMT2140 T1 WITH (NOLOCK) ON T0.APK = T1.APK AND T1.DivisionID = T1.SchoolIDTo
			INNER JOIN EDMT2020 T2 WITH (NOLOCK) ON T2.ArrangeClassID = T1.ArrangeClassIDTo
			INNER JOIN EDMT2160 T3 WITH (NOLOCK) ON T3.SchoolYearID = T2.SchoolYearID AND T3.GradeID = T2.GradeID AND T3.ClassID = T2.ClassID 
			INNER JOIN EDMT2161 T4 WITH (NOLOCK) ON T4.APKMaster = T3.APK AND T4.StudentID = T1.StudentID
			WHERE T3.DeleteFlg = 0 AND T4.DeleteFlg = 0 
				AND CONVERT(DATE, T3.CreateDate) >= CONVERT(DATE, T1.FromEffectiveDate)

			UNION ALL
				
			---	Ở lớp mới đã được phát sinh Đơn xin phép trên App
			SELECT TOP 1 1 FROM #EDMP9000 T0 
			INNER JOIN EDMT2140 T1 WITH (NOLOCK) ON T0.APK = T1.APK AND T1.DivisionID = T1.SchoolIDTo
			INNER JOIN EDMT2020 T2 WITH (NOLOCK) ON T2.ArrangeClassID = T1.ArrangeClassIDTo
			INNER JOIN APT0008 T3 WITH (NOLOCK) ON T3.ArrangeClassID = T2.ArrangeClassID 
			WHERE  T3.StudentID = T1.StudentID AND T3.DeleteFlg = 0 
				AND CONVERT(DATE, T3.CreateDate) >= CONVERT(DATE, T1.FromEffectiveDate)

			UNION ALL
				
			---	Ở lớp mới đã được phát sinh Bảo lưu
			SELECT TOP 1 1 FROM #EDMP9000 T0 
			INNER JOIN EDMT2140 T1 WITH (NOLOCK) ON T0.APK = T1.APK AND T1.DivisionID = T1.SchoolIDTo
			INNER JOIN EDMT2020 T2 WITH (NOLOCK) ON T2.ArrangeClassID = T1.ArrangeClassIDTo
			INNER JOIN EDMT2150 T3 WITH (NOLOCK) ON T3.SchoolYearID = T2.SchoolYearID AND T3.GradeID = T2.GradeID AND T3.ClassID = T2.ClassID 
			WHERE  T3.StudentID = T1.StudentID AND T3.DeleteFlg = 0 
				AND CONVERT(DATE, T3.CreateDate) >= CONVERT(DATE, T1.FromEffectiveDate)

			UNION ALL
				
			---	Ở lớp mới đã được phát sinh Điều chuyển
			SELECT TOP 1 1 FROM #EDMP9000 T0 
			INNER JOIN EDMT2140 T1 WITH (NOLOCK) ON T0.APK = T1.APK AND T1.DivisionID = T1.SchoolIDTo
			INNER JOIN EDMT2140 T2 WITH (NOLOCK) ON T2.ArrangeClassIDFrom = T1.ArrangeClassIDTo AND T2.StudentID = T1.StudentID
			WHERE    T2.DeleteFlg = 0 
				AND CONVERT(DATE, T2.CreateDate) >= CONVERT(DATE, T1.FromEffectiveDate)

			UNION ALL
				
			---	Ở lớp mới đã được phát sinh Nghỉ học
			SELECT TOP 1 1 FROM #EDMP9000 T0 
			INNER JOIN EDMT2140 T1 WITH (NOLOCK) ON T0.APK = T1.APK AND T1.DivisionID = T1.SchoolIDTo
			INNER JOIN EDMT2080 T2 WITH (NOLOCK) ON T2.ArrangeClassID = T1.ArrangeClassIDTo AND T2.StudentID = T1.StudentID
			WHERE    T2.DeleteFlg = 0 
				AND CONVERT(DATE, T2.CreateDate) >= CONVERT(DATE, T1.FromEffectiveDate)
				
					)
		END


		UPDATE T1  
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2140 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END


	SET @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #EDMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #EDMP9000_Errors T1 ORDER BY MessageID'
END



/*********Nghiệp vụ bảo lưu*************/
IF @FormID IN ('EDMF2150', 'EDMF2152')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #EDMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, ReserveID,FromDate
	INTO #EDMP9000
	FROM EDMT2150 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'EDMF2150' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''')	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, ReserveID AS Params, ''00ML000050''AS MessageID, APK
		FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END
	
	-- Kiểm tra Người dùng thuộc Nhóm ADMIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM AT1402 WHERE DivisionID = ''' + @DivisionID + ''' AND UserID = ''' + @UserID + ''' AND GroupID = ''ADMIN'' )
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, ''' + @UserID + ''' AS Params, ''AFML000119''AS MessageID, APK
		FROM #EDMP9000 
	END
	'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'
		IF EXISTS ( 

			SELECT TOP 1 1 FROM #EDMP9000 T0 
			---	đã được tạo phiếu Nghỉ học
			INNER JOIN EDMT2150 T1 WITH (NOLOCK) ON T0.APK = T1.APK
			INNER JOIN EDMT2080 T2 WITH (NOLOCK) ON T2.StudentID = T1.StudentID AND T2.DeleteFlg=0
			
			WHERE T1.DivisionID = ''' + @DivisionID + ''' AND T2.CreateDate >= T1.FromDate

			UNION ALL

			SELECT TOP 1 1 FROM #EDMP9000 T0 
			---	Học lại
			INNER JOIN EDMT2150 T1 WITH (NOLOCK) ON T0.APK = T1.APK
			INNER JOIN EDMT2012 T2 WITH (NOLOCK) ON T2.StudentID = T1.StudentID 
			
			WHERE T1.DivisionID = ''' + @DivisionID + ''' AND T2.DateStudy >= T1.CreateDate

				   )

		BEGIN
			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
			
			SELECT 2 AS Status, T1.ReserveID AS Params, ''00ML000165''AS MessageID, T1.APK 
			FROM #EDMP9000 T1 WITH (NOLOCK) 
			WHERE EXISTS (

					SELECT TOP 1 1 FROM #EDMP9000 T0 
					---	Nghỉ học
					INNER JOIN EDMT2150 T1 WITH (NOLOCK) ON T0.APK = T1.APK
					INNER JOIN EDMT2080 T2 WITH (NOLOCK) ON T2.StudentID = T1.StudentID AND T2.DeleteFlg=0
					
					WHERE T1.DivisionID = ''' + @DivisionID + ''' AND T2.CreateDate >= T1.FromDate

					UNION ALL

					SELECT TOP 1 1 FROM #EDMP9000 T0 
					---	Học lại
					INNER JOIN EDMT2150 T1 WITH (NOLOCK) ON T0.APK = T1.APK
					INNER JOIN EDMT2012 T2 WITH (NOLOCK) ON T2.StudentID = T1.StudentID  
					
					WHERE T1.DivisionID = ''' + @DivisionID + ''' AND T2.DateStudy >= T1.CreateDate


						 )
		END

		UPDATE T1  
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2150 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK) 
		
		
		'


	END


	SET @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #EDMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #EDMP9000_Errors T1 ORDER BY MessageID'
END


/*********Nghiệp vụ phiếu dự thu học phí*************/
IF @FormID IN ('EDMF2160', 'EDMF2162')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #EDMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, EstimateID
	INTO #EDMP9000
	FROM EDMT2160 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'EDMF2160' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''')	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, EstimateID AS Params, ''00ML000050''AS MessageID, APK
		FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END'


IF @Mode = 0
	BEGIN 
		SET @sSQL = @sSQL + N'
		IF EXISTS (
			SELECT TOP 1 1 FROM #EDMP9000 T1 INNER JOIN AT9000 T2 WITH (NOLOCK) ON T1.APK = T2.InheritVoucherID AND T1.DivisionID = T2.DivisionID AND T2.InheritTableID = ''EDMT2160''
				   
				   UNION ALL

			SELECT TOP 1 1 FROM #EDMP9000 T1 
			INNER JOIN EDMT2200 T2 WITH (NOLOCK) ON T2.Used = ''EDMT2160'' AND T2.InheritVoucherID = T1.APK
			WHERE EXISTS (SELECT TOP 1 1 FROM EDMT2200 T3 WITH (NOLOCK) WHERE T3.StudentID = T2.StudentID AND T3.DeleteFlg = 0 AND T3.CreateDate> T2.CreateDate)	

	)
		BEGIN
			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
			
			SELECT 2 AS Status, T1.EstimateID AS Params, ''00ML000165''AS MessageID, T1.APK 
			FROM #EDMP9000 T1 WITH (NOLOCK) 
			
		END
		'
	END 

IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'

		IF EXISTS (
			SELECT TOP 1 1 FROM #EDMP9000 T1 INNER JOIN AT9000 T2 WITH (NOLOCK) ON T1.APK = T2.InheritVoucherID AND T1.DivisionID = T2.DivisionID AND T2.InheritTableID = ''EDMT2160''
						   UNION ALL

			SELECT TOP 1 1 FROM #EDMP9000 T1 
			INNER JOIN EDMT2200 T2 WITH (NOLOCK) ON T2.Used = ''EDMT2160'' AND T2.InheritVoucherID = T1.APK
			WHERE EXISTS (SELECT TOP 1 1 FROM EDMT2200 T3 WITH (NOLOCK) WHERE T3.StudentID = T2.StudentID AND T3.DeleteFlg = 0 AND T3.CreateDate> T2.CreateDate)	

				   )
		BEGIN
			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
			
			SELECT 2 AS Status, T1.EstimateID AS Params, ''00ML000165''AS MessageID, T1.APK 
			FROM #EDMP9000 T1 WITH (NOLOCK) 
			WHERE EXISTS (
			SELECT TOP 1 1 FROM #EDMP9000 T1 INNER JOIN AT9000 T2 WITH (NOLOCK) ON T1.APK = T2.InheritVoucherID AND T1.DivisionID = T2.DivisionID AND T2.InheritTableID = ''EDMT2160''
						   UNION ALL

			SELECT TOP 1 1 FROM #EDMP9000 T1 
			INNER JOIN EDMT2200 T2 WITH (NOLOCK) ON T2.Used = ''EDMT2160'' AND T2.InheritVoucherID = T1.APK
			WHERE EXISTS (SELECT TOP 1 1 FROM EDMT2200 T3 WITH (NOLOCK) WHERE T3.StudentID = T2.StudentID AND T3.CreateDate> T2.CreateDate)	

			 )
		END
		ELSE
		BEGIN 

		--- Xóa EDMT2201 - Bảng phí ngầm Detail
		DELETE EDMT2201
        WHERE APKMaster = (SELECT T1.APK FROM EDMT2200 T1 WITH (NOLOCK)
				INNER JOIN #EDMP9000 T2 ON T1.InheritVoucherID = CONVERT(VARCHAR(50), T2.APK)

                WHERE T1.Used = ''EDMT2160'' 
				AND NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T2.APK = T3.APK)
        )		

		--- Xóa EDMT2200 - Bảng phí ngầm Master
		DELETE T1 FROM EDMT2200 T1
		INNER JOIN #EDMP9000 T2 ON T1.InheritVoucherID = CONVERT(VARCHAR(50),T2.APK)
        WHERE T1.Used = ''EDMT2160'' 
		AND NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T2.APK = T3.APK)

		---Xóa detail
		DELETE T1 FROM EDMT2162 T1
		INNER JOIN EDMT2161 T2 WITH (NOLOCK) ON T1.APKMaster = CONVERT(VARCHAR(50),T2.APK)
		INNER JOIN #EDMP9000 T3 WITH (NOLOCK) ON T3.APK = T2.APKMaster 
		WHERE T2.APKMaster = T3.APK 
		AND NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T2.APK = T3.APK)

		---Xóa detail 
		UPDATE T1   
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2161 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APKMaster = CONVERT(VARCHAR(50),T2.APK)
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APKMaster = T3.APK)
	 
		
		----Xóa master 
		UPDATE T1  
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2160 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON CONVERT(VARCHAR(50),T1.APK) = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE CONVERT(VARCHAR(50),T1.APK) = T3.APK)
		
		DECLARE @StudentID VARCHAR(50)

		DECLARE cursorStudentID CURSOR FOR

		SELECT T2.StudentID 
		FROM #EDMP9000 T1
		INNER JOIN EDMT2161 T2 WITH(NOLOCK) ON T2.APKMaster = T1.APK AND T2.DeleteFlg =0
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)

		OPEN cursorStudentID                -- Mở con trỏ

		FETCH NEXT FROM cursorStudentID     -- Đọc dòng đầu tiên
		      INTO @StudentID
		
		WHILE @@FETCH_STATUS = 0          --vòng lặp WHILE khi đọc Cursor thành công
		BEGIN
		

			EXEC dbo.EDMP2056 @DivisionID = '''+ @DivisionID+  ''', -- varchar(50)
                  @UserID = '''+@UserID+''',     -- varchar(50)
                  @StudentID = @StudentID  -- varchar(50)

				  	
			FETCH NEXT FROM cursorStudentID     -- Đọc dòng tiếp theo
			      INTO @StudentID
		END
		
		CLOSE cursorStudentID              -- Đóng Cursor
		DEALLOCATE cursorStudentID         -- Giải phóng tài nguyên
		
		END
		'
	END


	SET @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #EDMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #EDMP9000_Errors T1 ORDER BY MessageID'
END


/*********Nghiệp vụ quản lý tin tức*************/
IF @FormID IN ('EDMF2170', 'EDMF2172')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #EDMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, NewsID
	INTO #EDMP9000
	FROM EDMT2170 WITH (NOLOCK) WHERE APK IN ('''+CASE WHEN @FormID = 'EDMF2170' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''')	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, NewsID AS Params, ''00ML000050''AS MessageID, APK
		FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END'

	IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'

		UPDATE T1  
		SET T1.DeleteFlg = 1
		, T1.LastModifyUserID = '''+@UserID+'''
		, T1.LastModifyDate = GETDATE()
		FROM EDMT2170 T1 WITH (NOLOCK) 
		INNER JOIN #EDMP9000 T2 ON T1.APK = T2.APK
	    WHERE NOT EXISTS (SELECT TOP 1 1 FROM #EDMP9000_Errors T3 WHERE T1.APK = T3.APK)'
	END


	SET @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #EDMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #EDMP9000_Errors T1 ORDER BY MessageID'
END


/*********Nghiệp vụ Thay đổi mức đóng*************/
--Convert APK [23/06/2020]
IF @FormID IN ('EDMF2200', 'EDMF2202')
BEGIN
	SET @sSQL = N'
	CREATE TABLE #EDMP9000_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

	SELECT APK, DivisionID, VoucherNo
	INTO #EDMP9000
	FROM EDMT2200 WITH (NOLOCK) WHERE CONVERT(VARCHAR(50),APK) IN ('''+CASE WHEN @FormID = 'EDMF2200' THEN @APKList ELSE @APK END+''')
	
	IF EXISTS (SELECT TOP 1 1 FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+''')	---- Kiểm tra khác đơn vị
	BEGIN
		INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
		SELECT 2 AS Status, VoucherNo AS Params, ''00ML000050''AS MessageID, APK
		FROM #EDMP9000 WHERE DivisionID <> '''+@DivisionID+'''
	END'

---Convert APK [23/06/2020]
IF @Mode = 0
	BEGIN 
		SET @sSQL = @sSQL + N'
		IF EXISTS (
			SELECT TOP 1 1 FROM #EDMP9000 T1 
			INNER JOIN EDMT2200 T2 WITH (NOLOCK) ON T2.APK = T1.APK
			WHERE EXISTS (SELECT TOP 1 1 FROM EDMT2200 T3 WITH (NOLOCK) WHERE T3.StudentID = T2.StudentID AND T3.CreateDate > T2.CreateDate AND T3.DeleteFlg = 0)
			
			UNION ALL 
			SELECT TOP 1 1 FROM #EDMP9000 A 
			INNER JOIN AT9000 B WITH(NOLOCK) ON A.DivisionID = B.DivisionID AND B.InheritVoucherID = CONVERT(VARCHAR(50),A.APK) -----PHÁT SINH DỮ LIỆU DƯỚI 8 

	
		)
		BEGIN
			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
			
			SELECT 2 AS Status, T1.VoucherNo AS Params, ''00ML000165''AS MessageID, T1.APK 
			FROM #EDMP9000 T1 WITH (NOLOCK) 

		END
		'
	END 

IF @Mode = 1 
	BEGIN 
		SET @sSQL = @sSQL + N'

		IF EXISTS (
			SELECT TOP 1 1 FROM #EDMP9000 T1 
			INNER JOIN EDMT2200 T2 WITH (NOLOCK) ON T2.APK = T1.APK
			WHERE EXISTS (SELECT TOP 1 1 FROM EDMT2200 T3 WITH (NOLOCK) WHERE T3.StudentID = T2.StudentID AND T3.CreateDate > T2.CreateDate AND T3.DeleteFlg = 0)	
		)
		BEGIN
		--Error
			INSERT INTO #EDMP9000_Errors (Status, Params, MessageID, APK)
			
			SELECT 2 AS Status, T1.VoucherNo AS Params, ''00ML000165''AS MessageID, T1.APK 
			FROM #EDMP9000 T1 WITH (NOLOCK) 
			
		END
		ELSE
		BEGIN 

			--- Update DeleteFlg cho bảng Master EDMT2200 - Bảng phí ngầm Master
			UPDATE EDMT2200
			SET DeleteFlg = 1
			,LastModifyUserID = '''+@UserID+'''
			, LastModifyDate = GETDATE()
			WHERE APK = (SELECT TOP 1 APK FROM #EDMP9000)			

			DECLARE @StudentID VARCHAR(50)

			DECLARE cursorStudentID CURSOR FOR
			SELECT T2.StudentID 
			FROM #EDMP9000 T1
			INNER JOIN EDMT2200 T2 WITH(NOLOCK) ON T2.APK = T1.APK

			OPEN cursorStudentID                -- Mở con trỏ

			FETCH NEXT FROM cursorStudentID     -- Đọc dòng đầu tiên
			      INTO @StudentID
			
			WHILE @@FETCH_STATUS = 0          --vòng lặp WHILE khi đọc Cursor thành công
			BEGIN
			

				EXEC dbo.EDMP2056 @DivisionID = '''+ @DivisionID+  ''', -- varchar(50)
			          @UserID = '''+@UserID+''',     -- varchar(50)
			          @StudentID = @StudentID  -- varchar(50)

					  	
				FETCH NEXT FROM cursorStudentID     -- Đọc dòng tiếp theo
				      INTO @StudentID
			END
			
			CLOSE cursorStudentID              -- Đóng Cursor
			DEALLOCATE cursorStudentID         -- Giải phóng tài nguyên
			
		END
		'
	END


	SET @sSQL = @sSQL + N'
	SELECT 	DISTINCT 2 AS Status, MessageID, STUFF ((	
	SELECT '', '' + Params FROM #EDMP9000_Errors T2 WHERE  T1.MessageID = T2.MessageID FOR XML PATH ('''')), 1, 1, '''') AS Params 
	FROM #EDMP9000_Errors T1 ORDER BY MessageID'
END

PRINT(@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
