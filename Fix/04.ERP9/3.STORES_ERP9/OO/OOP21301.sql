IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP21301]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP21301]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
--- Tạo các chuỗi xử lý lấy dữ liệu Thiết lập công việc theo bảng Đánh giá công việc
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by Vĩnh Tâm on 09/09/2019
-- <Example>
/*
	DECLARE @ListGroup NVARCHAR(MAX) = '', @ListFieldId NVARCHAR(MAX), @ListFieldName NVARCHAR(MAX), @ListColumn NVARCHAR(MAX), @JoinString NVARCHAR(MAX)
	EXEC OOP21301 'DTI', 'f5d0be79-c485-45c1-996b-33dfde7f2848', 'O10', 'VINHTAM', 0, 'CV'
		, @ListGroup OUTPUT, @ListFieldId OUTPUT, @ListFieldName OUTPUT, @ListColumn OUTPUT, @JoinString OUTPUT
	PRINT(@ListGroup)
	PRINT(@ListFieldId)
	PRINT(@ListFieldName)
	PRINT(@ListColumn)
	PRINT(@JoinString)
*/

CREATE PROCEDURE [dbo].[OOP21301]
(
	@DivisionID NVARCHAR(250),
	@APK NVARCHAR(250) = NULL,
	@TableName NVARCHAR(250),
	@UserID NVARCHAR(250),
	@ObjectID NVARCHAR(250) = 'CV', -- DA hoặc CV
	@Mode INT = 0,
	@ListGroup NVARCHAR(MAX) OUTPUT,
	@ListFieldId NVARCHAR(MAX) OUTPUT,
	@ListFieldName NVARCHAR(MAX) OUTPUT,
	@ListColumn NVARCHAR(MAX) OUTPUT,
	@JoinString NVARCHAR(MAX) OUTPUT
)
AS
BEGIN
	DECLARE @TargetsGroupID VARCHAR(50),
			@TempTable NVARCHAR(50) = '',
			@TempColumn NVARCHAR(50) = '',
			@ListTempColumn NVARCHAR(MAX) = '',
			@Index INT = 0,
			@Cur CURSOR
	DECLARE @OOP21301Temp TABLE (
		TargetsGroupID VARCHAR(50)
	)

	SET @ListGroup = ''
	SET @ListFieldId = ''
	SET @ListFieldName = ''
	SET @ListColumn = ''
	SET @JoinString = ''

	-- Lấy dữ liệu Đánh giá công việc cho một công việc cụ thể theo APKMaster
	IF @Mode = 0
	BEGIN
		INSERT INTO @OOP21301Temp
		SELECT REPLACE(REPLACE(O1.TargetsGroupID, '.', ''), '-', '') AS TargetsGroupID
		FROM OOT2130 O1 WITH (NOLOCK) WHERE APKMaster = @APK
	END
	-- Lấy dữ liệu Thiết lập đánh giá công việc theo DivisionID
	ELSE
	BEGIN
		INSERT INTO @OOP21301Temp
		SELECT REPLACE(REPLACE(O2.TargetsGroupID, '.', ''), '-', '') AS TargetsGroupID
		FROM OOT0051 O1 WITH (NOLOCK)
			INNER JOIN OOT0050 O2 WITH (NOLOCK) ON O1.APK = O2.APKMaster
			INNER JOIN KPIT10101 K1 WITH (NOLOCK) ON O2.TargetsGroupID = K1.TargetsGroupID AND ISNULL(K1.Disabled, 0) = 0
		WHERE ISNULL(O1.ObjectID, '') = @ObjectID AND O2.DivisionID = @DivisionID AND ISNULL(O2.NoDisplay, 1) = 0
	END

	SET @Cur = CURSOR SCROLL KEYSET FOR
		SELECT * FROM @OOP21301Temp
	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @TargetsGroupID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @Index = @Index + 1
		-- Loại bỏ các dấu chấm ra khỏi tên Nhóm chỉ tiêu
		SET @TargetsGroupID = REPLACE(@TargetsGroupID, '.', '')
		-- Danh sách tên nhóm dùng trong PIVOT để chuyển dòng thành cột
		SET @ListGroup = @ListGroup + ',[' + @TargetsGroupID + ']'

		-- Tên cột khi SELECT sau khi thực hiện PIVOT
		SET @TempColumn = @TableName + '.[' + @TargetsGroupID + ']'
		-- ALIAS các tên cột thành các tên cột AssessUserID sử dụng trên màn hình
		SET @ListFieldId = @ListFieldId + ', ' + @TempColumn + ' AS [AssessUserID' + @TargetsGroupID + ']'

		-- ALIAS cho bảng AT1103 để LEFT JOIN lấy tên theo các AssessUserID
		SET @TempTable = 'ATemp' + CAST(@Index AS VARCHAR(3))
		-- Tạo điều kiện LEFT JOIN cho các bảng AT1103 với bảng PIVOT
		SET @JoinString = @JoinString + ' LEFT JOIN AT1103 ' + @TempTable + ' WITH (NOLOCK) ON ' + @TempTable + '.EmployeeID = ' + @TempColumn
		-- Lấy các cột AssessUserID
		SET @ListFieldName = @ListFieldName + ',' + @TempTable + '.FullName AS [AssessUserName' + @TargetsGroupID + ']'

		-- Tạo danh sách các cột được hiển thị trên kết quả SELECT
		SET @ListColumn = @ListColumn + ', [AssessUserID' + @TargetsGroupID + ']'
		SET @ListTempColumn = @ListTempColumn + ', [AssessUserName' + @TargetsGroupID + ']'

		FETCH NEXT FROM @Cur INTO @TargetsGroupID
	END
	CLOSE @Cur
	
	SET @ListColumn = @ListColumn + @ListTempColumn

	SET @ListGroup = SUBSTRING(@ListGroup, 2, LEN(@ListGroup))
	SET @ListColumn = SUBSTRING(@ListColumn, 2, LEN(@ListColumn))
	SET @ListFieldId = SUBSTRING(@ListFieldId, 2, LEN(@ListFieldId))
	SET @ListFieldName = SUBSTRING(@ListFieldName, 2, LEN(@ListFieldName))

	--PRINT(@ListGroup)
	--PRINT(@ListFieldId)
	--PRINT(@ListFieldName)
	--PRINT(@ListColumn)
	--PRINT(@JoinString)
END






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
