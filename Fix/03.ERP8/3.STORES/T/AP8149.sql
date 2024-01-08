IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP8149]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP8149]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Xử lý Import thời gian đứng máy thực tế
---- Created by Bảo Thy on 21/11/2017
---- Modified on 05/03/2019 by Kim Thư: Tạo khóa chính cho table #Data có nối với @@SPID để tránh trùng khóa chính khi nhiều user sử dụng
---- Modified on 01/09/2020 by Huỳnh Thử: Merge Code: MEKIO và MTE: Tách Store

CREATE PROCEDURE [DBO].[AP8149]
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@ImportTemplateID AS NVARCHAR(50),
	@XML AS XML
) 
AS
DECLARE @cCURSOR AS CURSOR,
		@sSQL AS VARCHAR(1000)
		
DECLARE @ColID AS NVARCHAR(50), 
		@ColSQLDataType AS NVARCHAR(50),
		@CustomerName INT


SELECT @CustomerName = CustomerName FROM dbo.CustomerIndex
IF(@CustomerName = 50 OR @CustomerName	= 115) -- Mekio or Mte
BEGIN
	EXEC AP8149_MK	@DivisionID = @DivisionID,
					@UserID = @UserID,	
					@ImportTemplateID = @ImportTemplateID,
					@XML = @XML
END
ELSE
BEGIN
	CREATE TABLE #Data
	(
		APK UNIQUEIDENTIFIER DEFAULT(NEWID()),
		Row INT NOT NULL,
		Orders INT,
		ImportMessage NVARCHAR(500) DEFAULT ('')--,
		--CONSTRAINT [PK_#Data] PRIMARY KEY CLUSTERED 
		--(
		--	Row ASC
		--) ON [PRIMARY]	
	)

	-- Tạo khóa chính cho table #Data
	DECLARE @Data_PK VARCHAR(50),
			@SQL1 NVARCHAR(MAX);
	SET @Data_PK='PK_#Data_' + LTRIM(@@SPID);

	--add constraint 
	SET @SQL1 = 'ALTER TABLE #Data ADD CONSTRAINT ' + @Data_PK+ ' PRIMARY KEY(Row)'

	EXEC(@SQL1)


	SET @cCURSOR = CURSOR STATIC FOR
		SELECT		TLD.ColID,
					BTL.ColSQLDataType
		FROM		A01065 TL
		INNER JOIN	A01066 TLD
				ON	TL.ImportTemplateID = TLD.ImportTemplateID
		INNER JOIN	A00065 BTL
				ON	BTL.ImportTransTypeID = TL.ImportTransTypeID AND BTL.ColID = TLD.ColID
		WHERE		TL.ImportTemplateID = @ImportTemplateID
		ORDER BY	TLD.OrderNum

	OPEN @cCURSOR									
	-- Tạo cấu trúc bảng tạm
	FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @sSQL = 'ALTER TABLE #Data ADD ' + @ColID + ' ' + @ColSQLDataType + CASE WHEN @ColSQLDataType LIKE '%char%' THEN ' COLLATE SQL_Latin1_General_CP1_CI_AS' ELSE '' END + ' NULL'
	--	PRINT @sSQL
		EXEC (@sSQL)
		FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
	END

	SELECT	X.Data.query('Row').value('.', 'INT') AS Row,
			X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
			X.Data.query('Period').value('.', 'VARCHAR(10)') AS Period,
			X.Data.query('EmployeeID').value('.', 'VARCHAR(50)') AS EmployeeID,
			X.Data.query('MachineID').value('.', 'VARCHAR(50)') AS MachineID,
			X.Data.query('Date').value('.', 'DATETIME') AS Date,
			X.Data.query('ActFromTime').value('.', 'NVARCHAR(50)') AS ActFromTime,
			X.Data.query('ActToTime').value('.', 'NVARCHAR(50)') AS ActToTime
	INTO	#AP8149		
	FROM	@XML.nodes('//Data') AS X (Data)

	INSERT INTO #Data (Row,DivisionID,Period,EmployeeID,MachineID,Date,ActFromTime,ActToTime)
	SELECT Row,DivisionID,Period,EmployeeID,MachineID,Date,ActFromTime,ActToTime FROM #AP8149

	DECLARE @TranMonth INT,
			@TranYear INT,
			@DataCol VARCHAR(50)

	SELECT @DataCol = DataCol
	FROM	A01066 WITH (NOLOCK)
	WHERE	ImportTemplateID = @ImportTemplateID AND ColID = 'Date'

	SET @TranMonth = (SELECT TOP 1 LEFT(Period, 2) FROM #Data)
	SET @TranYear = (SELECT TOP 1 RIGHT(Period, 4) FROM #Data)

	---- Kiểm tra check code mặc định
	EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID

	---- Kiểm tra NV trong file import bị trùng
	UPDATE T1
	SET	ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + 'HFML000578 {0}='''+@DataCol+''''
	FROM #Data T1
	INNER JOIN 
	(
		SELECT EmployeeID, MachineID, Date FROM #Data
		GROUP BY EmployeeID, MachineID, Date
		HAVING COUNT(1) > 1
	) T2 ON T1.EmployeeID = T2.EmployeeID AND T1.MachineID = T2.MachineID AND T1.Date = T2.Date

	---- Kiểm tra nhân viên cập nhật thời gian thực tế đúng ngày phân công đứng máy không
	UPDATE T1
	SET	ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + 'HFML000577 {0}='''+@DataCol+''''
	FROM #Data T1
	WHERE NOT EXISTS (SELECT TOP 1 1 FROM HT1113 T2 WITH (NOLOCK)
					  WHERE T1.DivisionID = T2.DivisionID AND @TranMonth+@TranYear*100 = T2.TranMonth+T2.TranYear*100
					  AND T1.EmployeeID = T2.EmployeeID AND T1.MachineID = T2.MachineID AND T1.[Date] = T2.[Date])

	--drop constraint 
	SET @SQL1 = 'IF EXISTS (SELECT TOP 1 1 FROM tempdb.sys.sysobjects WHERE [name] = ''#Data'' AND xtype = ''U'')
				BEGIN
					IF EXISTS (SELECT TOP 1 1 FROM tempdb.sys.sysobjects WHERE [name] = '''+@Data_PK+''' AND xtype = ''PK'')
						ALTER TABLE #Keys DROP CONSTRAINT ' + @Data_PK +'
				END
				'
	EXEC(@SQL1)


	-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
	IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
		GOTO LB_RESULT

	--Lưu hiệu chỉnh thời gian đứng máy thực tế
	UPDATE T1
	SET T1.ActFromTime = T2.ActFromTime,
		T1.ActToTime = T2.ActToTime,
		T1.LastModifyUserID = @UserID,
		T1.LastModifyDate = GETDATE()
	FROM HT1113 T1 WITH (NOLOCK)
	INNER JOIN #Data T2 ON T1.EmployeeID = T2.EmployeeID AND T1.MachineID = T2.MachineID AND T1.[Date] = T2.[Date]
	WHERE T1.DivisionID = @DivisionID
	AND T1.TranMonth+T1.TranYear*100 = @TranMonth+@TranYear*100

	LB_RESULT:
	SELECT * FROM #Data
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
