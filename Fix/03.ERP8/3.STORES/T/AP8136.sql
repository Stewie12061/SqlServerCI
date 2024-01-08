IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP8136]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP8136]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Import chấm công công trình theo ca
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 22/09/2014 by Lê Thị Thu Hiền
---- Modified by Bảo Thy on 11/08/2016: sửa AbsentTime TINYINT -> DECIAML(28,8)
---- Modified on 22/09/2014 by 
---- Modified on 05/03/2019 by Kim Thư: Tạo khóa chính cho table #Data và #Keys có nối với @@SPID để tránh trùng khóa chính khi nhiều user sử dụng
---- Modified on 12/08/2019 by Văn Tài: [VÂN KHÁNH] Điều chỉnh [Quét dữ liệu chấm công công trình theo ca] - Chuyễn mã thẻ [AbsentCardNo] => Mã nhân viên [EmployeeID]: khách hàng duy nhất sử dụng chức năng import này
---- Modified on 15/01/2020 by Văn Tài: [VÂN KHÁNH] Điều chỉnh [Quét dữ liệu chấm công công trình theo ca] - Bổ sung cột [AbsentCardNo] để phù hợp cho cách xử lý hiện tại.
-- <Example>
---- 
CREATE PROCEDURE [DBO].[AP8136]
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
		@ColSQLDataType AS NVARCHAR(50)
		
CREATE TABLE #Data
(
	APK UNIQUEIDENTIFIER DEFAULT(NEWID()),
	Row INT NOT NULL,
	Orders INT,
	AbsentCardNo NVARCHAR(500),
	ImportMessage NVARCHAR(500) DEFAULT ('')--,
	--CONSTRAINT [PK_#Data] PRIMARY KEY CLUSTERED 
	--(
	--	Row ASC
	--) ON [PRIMARY]	
)

-- Tạo khóa chính cho table #Data và #Keys
DECLARE @Data_PK VARCHAR(50),
		@SQL NVARCHAR(MAX);
SET @Data_PK='PK_#Data_' + LTRIM(@@SPID);

--add constraint 
SET @SQL = 'ALTER TABLE #Data ADD CONSTRAINT ' + @Data_PK+ ' PRIMARY KEY(Row)'

EXEC(@SQL)

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
---	PRINT @sSQL
	EXEC (@sSQL)
	FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
END

SELECT	X.Data.query('Row').value('.', 'INT') AS Row,
		X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
		X.Data.query('Period').value('.', 'VARCHAR(10)') AS Period, -- Kỳ kế toán
		X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,
		X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS AbsentCardNo,
		X.Data.query('ProjectID').value('.', 'NVARCHAR(50)') AS ProjectID,	
		X.Data.query('AbsentDate').value('.', 'DATETIME') AS AbsentDate,
		X.Data.query('ShiftCode').value('.', 'NVARCHAR(50)') AS ShiftCode,
		X.Data.query('AbsentTime').value('.', 'DECIMAL(28,8)') AS AbsentTime,
		X.Data.query('PeriodID').value('.', 'VARCHAR(50)') AS PeriodID, -- Kỳ lương
		X.Data.query('Notes').value('.', 'NVARCHAR(250)') AS Notes		
		
INTO	#AP8136	
FROM	@XML.nodes('//Data') AS X (Data)

INSERT INTO #Data (Row, DivisionID, Period, EmployeeID, AbsentCardNo, ProjectID, AbsentDate, ShiftCode, AbsentTime, PeriodID, Notes)
SELECT Row, DivisionID, Period, EmployeeID, AbsentCardNo, ProjectID, AbsentDate, ShiftCode, AbsentTime, PeriodID, Notes
FROM #AP8136

---- Kiểm tra check code mặc định
EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID

---- Kiểm tra dữ liệu không đồng nhất tại phần master
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @Module = 'ASOFT-HRM', @ColID = 'AbsentDate', @Param1 = 'AbsentDate'

-- Xử lý làm tròn dữ liệu vì nhập trên Excel có thể sai
--UPDATE		DT
--SET			AbsentAmount = ROUND(AbsentAmount, 0)
--FROM		#Data DT

			
--drop constraint 
SET @SQL = 'IF EXISTS (SELECT TOP 1 1 FROM tempdb.sys.sysobjects WHERE [name] = ''#Data'' AND xtype = ''U'')
			BEGIN
				IF EXISTS (SELECT TOP 1 1 FROM tempdb.sys.sysobjects WHERE [name] = '''+@Data_PK+''' AND xtype = ''PK'')
					ALTER TABLE #Keys DROP CONSTRAINT ' + @Data_PK +'
			END
			'
EXEC(@SQL)

 -- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT

-- Nếu có lỗi thì không đẩy dữ liệu vào
--IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
--	GOTO LB_RESULT

-- Đẩy dữ liệu vào bảng HT2406

DECLARE @Cur AS CURSOR,
		@TranMonth INT,
		@TranYear INT,
		@AbsentCardNo NVARCHAR(50),
		@EmployeeID NVARCHAR(50),
		@ProjectID NVARCHAR(50),
		@AbsentDate DATETIME,
		@ShiftCode NVARCHAR(50),
		@AbsentTime DECIMAL(28,8),
		@PeriodID NVARCHAR(50),
		@Notes NVARCHAR(250),
		@Row INT
		
SET @TranMonth = (SELECT TOP 1 LEFT(Period, 2) FROM #Data)
SET @TranYear = (SELECT TOP 1 RIGHT(Period, 4) FROM #Data)

SET @Cur = CURSOR FOR
	SELECT	D.Row, D.AbsentCardNo, A.EmployeeID, D.ProjectID, D.AbsentDate, D.ShiftCode, D.AbsentTime, D.PeriodID, D.Notes
	FROM	#Data D
	LEFT JOIN  
	(
		SELECT DISTINCT HT1400.DivisionID, HT1407.AbsentCardNo, HT1400.EmployeeID
		FROM HT1400 HT1400
		LEFT JOIN HT1407 ON HT1400.DivisionID = HT1407.DivisionID AND HT1400.EmployeeID = HT1407.EmployeeID
	) A ON A.DivisionID = D.DivisionID AND A.EmployeeID = D.EmployeeID
	
	
OPEN @Cur
FETCH NEXT FROM @Cur INTO @Row, @AbsentCardNo, @EmployeeID, @ProjectID, @AbsentDate, @ShiftCode, @AbsentTime, @PeriodID, @Notes
WHILE @@FETCH_STATUS = 0
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM HT2416 
	               WHERE	DivisionID = @DivisionID 
							AND EmployeeID = @EmployeeID
							AND AbsentDate = @AbsentDate 
							AND ShiftCode = @ShiftCode
				)
	INSERT INTO HT2416 (DivisionID, TranMonth, Tranyear, AbsentCardNo, EmployeeID, ProjectID, AbsentDate, ShiftCode, AbsentTime, PeriodID, Notes )
	VALUES (@DivisionID, @TranMonth, @Tranyear,@AbsentCardNo, @EmployeeID, @ProjectID, @AbsentDate, @ShiftCode, @AbsentTime, @PeriodID, @Notes)
	
	FETCH NEXT FROM @Cur INTO @Row, @AbsentCardNo, @EmployeeID, @ProjectID, @AbsentDate, @ShiftCode, @AbsentTime, @PeriodID, @Notes
	
END	
CLOSE @Cur

LB_RESULT:
SELECT * FROM #Data



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
