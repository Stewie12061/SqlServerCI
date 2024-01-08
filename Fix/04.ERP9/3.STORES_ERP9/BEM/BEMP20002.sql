IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BEMP20002]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BEMP20002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---		Kiểm tra danh sách APK9000 nhận vào có dữ liệu cần Duyệt theo cấp kế toán hay không
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by Vĩnh Tâm ON 19/11/2020
-- <Example>
/*
	EXEC BEMP20002 'MK', '2C444DE2-8AAF-47BD-BE3F-E6F9ABCF207A'
*/

CREATE PROCEDURE [dbo].[BEMP20002]
(
	@DivisionID NVARCHAR(250),
	@ListAPK9000 NVARCHAR(MAX)
)
AS
BEGIN
	DECLARE @Result TINYINT = 0,		-- 0: Duyệt thường; 1: Duyệt kế toán
			@CurrentStatus TINYINT = 1,	-- 1: Trạng thái đã duyệt
			@LevelApprove TINYINT

	-- Chuyển chuỗi danh sách APK9000 thành dạng bảng để truy vấn
	SELECT Value AS APK9000 INTO #TableAPK9000 FROM StringSplit(@ListAPK9000, ',')

	SELECT @LevelApprove = Levels FROM ST0010 WITH (NOLOCK) WHERE TypeID = 'PDN'
	-- 1. Trường hợp lấy không được cấp duyệt hoặc số lượng cấp duyệt bằng 0 thì kết thúc => Duyệt thường
	IF ISNULL(@LevelApprove, 0) = 0 GOTO EndStore

	-- 2. Trường hợp chỉ có một cấp duyệt thì hiển thị form Duyệt kế toán
	IF @LevelApprove = 1
	BEGIN
		SET @Result = 1
		GOTO EndStore
	END

	-- 3. Nếu có 1 trường hợp cấp duyệt gần nhất là cấp duyệt lớn nhất thì đánh dấu là Kế toán duyệt và kết thúc
	IF EXISTS(	SELECT TOP 1 1
				FROM OOT9001 O1 WITH (NOLOCK)
				WHERE O1.APKMaster IN (SELECT APK9000 FROM #TableAPK9000) AND O1.Status != @CurrentStatus
				GROUP BY O1.APKMaster
				HAVING MIN(O1.Level) = @LevelApprove)
	BEGIN
		--PRINT(N'Có cấp lớn nhất')
		SET @Result = 1
		GOTO EndStore
	END

	-- Dữ liệu xét duyệt của cấp lớn nhất chưa được duyệt
	SELECT O1.*
	INTO #TableMax
	FROM OOT9001 O1 WITH (NOLOCK)
		INNER JOIN (
			SELECT O1.APKMaster, MAX(O1.Level) AS MaxNotApprove
			FROM OOT9001 O1 WITH (NOLOCK)
			WHERE O1.APKMaster IN (SELECT APK9000 FROM #TableAPK9000) AND O1.Status != @CurrentStatus
			GROUP BY O1.APKMaster
			) T1 ON O1.APKMaster = T1.APKMaster AND O1.Level = T1.MaxNotApprove
			
	-- Dữ liệu xét duyệt của cấp nhỏ nhất chưa được duyệt
	SELECT O1.*
	INTO #TableMin
	FROM OOT9001 O1 WITH (NOLOCK)
		INNER JOIN (
			SELECT O1.APKMaster, MIN(O1.Level) AS MinNotApprove
			FROM OOT9001 O1 WITH (NOLOCK)
			WHERE O1.APKMaster IN (SELECT APK9000 FROM #TableAPK9000) AND O1.Status != @CurrentStatus
			GROUP BY O1.APKMaster
			) T1 ON O1.APKMaster = T1.APKMaster AND O1.Level = T1.MinNotApprove

	-- 4. Nếu cấp lớn nhất và nhỏ nhất là của cùng một người duyệt thì người duyệt đó là duyệt nhiều cấp và duyệt cấp kế toán
	IF EXISTS(	SELECT TOP 1 1
				FROM #TableMax T1, #TableMin T2
				WHERE T1.APKMaster = T2.APKMaster AND T1.ApprovePersonID = T2.ApprovePersonID AND T1.Level != T2.Level)
	BEGIN
		--PRINT(N'Người duyệt nhiều cấp')
		SET @Result = 1
		GOTO EndStore
	END

	EndStore:

	IF OBJECT_ID('tempdb..#TableAPK9000') IS NOT NULL DROP TABLE #TableAPK9000
	IF OBJECT_ID('tempdb..#TableMax') IS NOT NULL DROP TABLE #TableMax
	IF OBJECT_ID('tempdb..#TableMin') IS NOT NULL DROP TABLE #TableMin

	SELECT @Result AS Result

END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
