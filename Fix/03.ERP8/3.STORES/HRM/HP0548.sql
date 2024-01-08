IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0548]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0548]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Import hệ số tính lương theo công đoạn (MAITHU)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Lê Hoàng, Date: 15/03/2021
----Modified by Lê Hoàng, Date: 01/06/2021 : Update dữ liệu cũ, insert dữ liệu mới
/*-- <Example>

----*/

CREATE PROCEDURE HP0548
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@ImportTemplateID AS NVARCHAR(50),
	@XML AS XML
)

AS

DECLARE @cCURSOR AS CURSOR,
		@sSQL AS VARCHAR(1000),
		@FieldName1 AS NVARCHAR(4000) = '',
		@FieldName2 AS NVARCHAR(4000) = ''
		
DECLARE @ColID AS NVARCHAR(50), 
		@ColSQLDataType AS NVARCHAR(50)
		
CREATE TABLE #Data
(
	APK UNIQUEIDENTIFIER DEFAULT(NEWID()),
	Row INT,
	Orders INT,
	EmpFileID NVARCHAR(50) NULL,
	ImportMessage NVARCHAR(500) DEFAULT (''),
	CONSTRAINT [PK_#Data] PRIMARY KEY CLUSTERED 
	(
		Row ASC
	) ON [PRIMARY]	
)

CREATE TABLE #Keys
(
	Row INT,
	Orders INT,
	EmpFileID NVARCHAR(50),
	CONSTRAINT [PK_#Keys] PRIMARY KEY CLUSTERED 
	(
		Row ASC
	) ON [PRIMARY]	
)

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
		X.Data.query('PhaseID').value('.', 'NVARCHAR(50)') AS PhaseID,
		X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,
		(CASE WHEN X.Data.query('InventoryID').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('InventoryID').value('.', 'NVARCHAR(50)') END) AS InventoryID,	
		(CASE WHEN X.Data.query('Coefficient').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Coefficient').value('.', 'DECIMAL(28,8)') END) AS Coefficient,
		(CASE WHEN X.Data.query('Notes').value('.', 'NVARCHAR(250)') = '' THEN NULL ELSE X.Data.query('Notes').value('.', 'NVARCHAR(250)') END) AS Notes
INTO	#HP0548
FROM	@XML.nodes('//Data') AS X (Data)

INSERT INTO #Data (		
		Row,
		DivisionID,		
		PhaseID,
		EmployeeID,
		InventoryID,
		Coefficient,
		Notes)
SELECT Row, DivisionID, PhaseID, EmployeeID, InventoryID, Coefficient, Notes
FROM #HP0548 H548

---- Kiểm tra check code mặc định
EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID

---- Kiểm tra trùng bộ [PhaseID, EmployeeID, InventoryID]
SELECT DivisionID, PhaseID, EmployeeID, InventoryID, Count(*) CountD INTO #GroupDistinct
FROM #Data 
GROUP BY DivisionID, PhaseID, EmployeeID, InventoryID
HAVING Count(*) > 1

--SELECT * FROM HT0541
--SELECT * FROM #Data
--SELECT * FROM #GroupDistinct

IF EXISTS (SELECT TOP 1 1 #GroupDistinct)
BEGIN
	PRINT N'error'
	UPDATE R01 SET ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + 'CFML000196 {0}=''A'' {1}=''B'' {2}=''C'''
	FROM #Data R01
	INNER JOIN #GroupDistinct R02 ON R01.PhaseID = R02.PhaseID AND R01.EmployeeID = R02.EmployeeID AND ISNULL(R01.InventoryID,'') = ISNULL(R02.InventoryID,'')
END

-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT	

--- Xử lý làm tròn dữ liệu vì nhập trên Excel có thể sai
UPDATE		DT
SET			Coefficient = ROUND(DT.Coefficient,A.CoefficientDecimals)
FROM		#Data DT
LEFT JOIN	HT0000 A ON A.DivisionID = DT.DivisionID

--- Update IsUsed = 1 cho dữ liệu cũ trùng DivisionID, PhaseID, EmployeeID, InventoryID
SELECT DivisionID, PhaseID, EmployeeID, InventoryID, Coefficient, Notes, Count(*) CountD INTO #GroupUpdate
FROM #Data 
GROUP BY DivisionID, PhaseID, EmployeeID, InventoryID
HAVING Count(*) = 1

--update dữ liệu cho hệ số đã tồn tại
UPDATE R01 SET R01.LastModifyUserID = @UserID, R01.LastModifyDate = GETDATE(), R01.Coefficient = R02.Coefficient, R01.Notes = R02.Notes
FROM HT0541 R01
INNER JOIN #GroupUpdate R02 ON R01.PhaseID = R02.PhaseID AND R01.EmployeeID = R02.EmployeeID AND ISNULL(R01.InventoryID,'') = ISNULL(R02.InventoryID,'')

--- Insert dữ liệu mới từ import (cho hệ số chưa tồn tại)
INSERT INTO [dbo].[HT0541]
           ([DivisionID],[PhaseID],[EmployeeID],[InventoryID],[Coefficient],[Notes]
           ,[IsUsed],[Disabled],[IsCommon]
           ,[CreateUserID],[CreateDate],[LastModifyUserID],[LastModifyDate])
SELECT @DivisionID, R01.PhaseID, R01.EmployeeID, R01.InventoryID, R01.Coefficient, R01.Notes,
		1, 0, 0, @UserID, GETDATE(), @UserID, GETDATE()
FROM #Data R01
LEFT JOIN HT0541 R02 ON R01.PhaseID = R02.PhaseID AND R01.EmployeeID = R02.EmployeeID AND ISNULL(R01.InventoryID,'') = ISNULL(R02.InventoryID,'')
WHERE R02.APK IS NULL

-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT		

LB_RESULT:
SELECT * FROM #Data WHERE ImportMessage <> ''

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
