IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP8128]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP8128]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Xử lý Import dữ liệu bộ hệ số theo đối tượng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 02/06/2021 by Lê Hoàng
---- Modified on ... by ...: ...
-- <Example>
---- 
CREATE PROCEDURE [DBO].[MP8128]
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@ImportTemplateID AS NVARCHAR(50),
	@XML AS XML
) 
AS
DECLARE @cCURSOR AS CURSOR,
		@sSQL AS VARCHAR(1000),
		@sAPKMaster AS NVARCHAR(50) = CONVERT(NVARCHAR(50),NEWID())
		
DECLARE @ColID AS NVARCHAR(50), 
		@ColSQLDataType AS NVARCHAR(50)
		
CREATE TABLE #Data
(
	APK UNIQUEIDENTIFIER DEFAULT(NEWID()),
	Row INT NOT NULL,
	APKMaster NVARCHAR(50),
	ImportMessage NVARCHAR(500) DEFAULT ('')
	--CONSTRAINT [PK_#Data] PRIMARY KEY CLUSTERED 
	--(
	--	Row ASC
	--) ON [PRIMARY]	
)

CREATE TABLE #Keys
(
	Row INT NOT NULL,
	APK NVARCHAR(50)--,	
	--CONSTRAINT [PK_#Keys] PRIMARY KEY CLUSTERED 
	--(
	--	Row ASC
	--) ON [PRIMARY]	
)

-- Tạo khóa chính cho table #Data và #Keys
DECLARE @Keys_PK VARCHAR(50), @Data_PK VARCHAR(50),
		@SQL NVARCHAR(MAX);
SET @Data_PK='PK_#Data_' + LTRIM(@@SPID);
SET @Keys_PK='PK_#Keys_' + LTRIM(@@SPID);

--add constraint 
SET @SQL = 'ALTER TABLE #Data ADD CONSTRAINT ' + @Data_PK+ ' PRIMARY KEY(Row)
			ALTER TABLE #Keys ADD CONSTRAINT ' + @Keys_PK+ ' PRIMARY KEY(Row)'

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
	PRINT @sSQL
	EXEC (@sSQL)
	FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
END

	
SELECT	X.Data.query('Row').value('.', 'INT') AS Row,
		X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
		X.Data.query('CoefficientID').value('.', 'NVARCHAR(50)') AS CoefficientID,
		X.Data.query('CoefficientName').value('.', 'NVARCHAR(250)') AS CoefficientName,
		X.Data.query('CoType').value('.', 'INT') AS CoType,
		X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,
		X.Data.query('PeriodID').value('.', 'NVARCHAR(50)') AS PeriodID,
		X.Data.query('CoValue').value('.', 'DECIMAL(28,8)') AS CoValue,
		X.Data.query('Notes').value('.', 'NVARCHAR(250)') AS Notes
INTO	#MP8128		
FROM	@XML.nodes('//Data') AS X (Data)

INSERT INTO #Data (
		APKMaster, Row,			DivisionID,			CoefficientID,
		CoefficientName,			CoType,	
		EmployeeID, PeriodID,CoValue,Notes
)	
SELECT @sAPKMaster, * FROM #MP8128		 

---- Kiểm tra check code mặc định
EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID

-- Kiểm tra trùng mã
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckDuplicateInTable', @ColID = 'CoefficientID', @Param1 = 'MT1606', @Param2 = 'CoefficientID'

-- Kiểm tra dữ liệu đồng nhất
EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @ColID = 'CoefficientID', @Param1 = 'CoefficientID,CoefficientName,CoType,EmployeeID'

-- Kiểm tra 

-- Nếu có lỗi thì không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT

--- Xử lý làm tròn dữ liệu vì nhập trên Excel có thể sai
UPDATE		DT
SET			CoValue = ROUND(CoValue, CUR.PercentDecimal)
FROM		#Data DT
INNER JOIN	MT0000 CUR ON CUR.DivisionID IN (DT.DivisionID,'@@@')

--- Cập nhật thông tin hóa đơn và tài khoản	

--drop constraint 
--SET @SQL = 'IF EXISTS (SELECT TOP 1 1 FROM tempdb.sys.sysobjects WHERE [name] = ''#Keys'' AND xtype = ''U'')
--			BEGIN
--				IF EXISTS (SELECT TOP 1 1 FROM tempdb.sys.sysobjects WHERE [name] = '''+@Keys_PK+''' AND xtype = ''PK'')
--					ALTER TABLE #Keys DROP CONSTRAINT ' + @Keys_PK +'
--			END
--			IF EXISTS (SELECT TOP 1 1 FROM tempdb.sys.sysobjects WHERE [name] = ''#Data'' AND xtype = ''U'')
--			BEGIN
--				IF EXISTS (SELECT TOP 1 1 FROM tempdb.sys.sysobjects WHERE [name] = '''+@Data_PK+''' AND xtype = ''PK'')
--					ALTER TABLE #Keys DROP CONSTRAINT ' + @Data_PK +'
--			END
--			'
--EXEC(@SQL)

-- Đẩy dữ liệu vào bảng
INSERT INTO MT1606
(
APK, DivisionID, CoefficientID, CoefficientName,	
EmployeeID, CoType, CreateUserID, CreateDate, LastModifyUserID,	
LastModifyDate,	Disabled
)
SELECT DISTINCT APKMaster, DivisionID, CoefficientID, CoefficientName,	
EmployeeID, CoType, @UserID, GETDATE(), @UserID, GETDATE(), 0
FROM #Data

--- MT1607
INSERT INTO MT1607
(
DivisionID, DeCoefficientID, CoefficientID, PeriodID, CoValue, Notes
)
SELECT DivisionID, APKDetail, CoefficientID, PeriodID, CoValue, Notes
FROM #Data

LB_RESULT:
SELECT * FROM #Data

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
