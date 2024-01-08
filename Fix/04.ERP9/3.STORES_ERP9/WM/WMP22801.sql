IF EXISTS(SELECT TOP 1  1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DBO].[WMP22801]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
    DROP PROCEDURE [dbo].[WMP22801];
GO
SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_NULLS ON;
GO



-- <Summary>
----    Thực hiện đẩy dữ liệu import số serial cho phiếu nhập kho ERP 9
-- <Param>
---- 
-- <Return>
---- 
---- 
-- <History>
---- Created  on 25/12/2023 by Nhật Thanh
-- <Example>
CREATE PROCEDURE WMP22801
(
     @DivisionID VARCHAR(50),
     @UserID VARCHAR(50),
     @TranMonth INT,
     @TranYear INT,   
     @Mode TINYINT, --0 chưa hết dữ liệu, 1: hết dữ liệu
     @ImportTransTypeID NVARCHAR(250),
     @TransactionKey NVARCHAR(50),
     @XML XML
)
AS
DECLARE @cCURSOR AS CURSOR,
        @sSQL AS VARCHAR(1000);

DECLARE @ColID AS NVARCHAR(50),
        @ColSQLDataType AS NVARCHAR(50),
		@VoucherNo AS NVARCHAR(50),
		@InventoryID AS NVARCHAR(50),
		@SerialNo AS NVARCHAR(50)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[#Data]') AND TYPE IN (N'U'))
BEGIN
	CREATE TABLE #Data
	(
		APK UNIQUEIDENTIFIER DEFAULT (NEWID()),
		Row INT,
		DivisionID VARCHAR(50),
		Period VARCHAR(50),
		VoucherNo NVARCHAR(100),
		InventoryID VARCHAR(50),
		SerialNo VARCHAR(50),
		TransactionID NVARCHAR(50),
		ImportMessage NVARCHAR(500) DEFAULT (''),
		ErrorMessage NVARCHAR(MAX)  DEFAULT (''),
		ErrorColumn NVARCHAR(MAX) DEFAULT (''),
		CONSTRAINT [PK_#Data]
    		PRIMARY KEY CLUSTERED (Row ASC) ON [PRIMARY]
	);
END
--SET @cCURSOR = CURSOR STATIC FOR
--SELECT TLD.ColID,
--       BTL.ColSQLDataType
--FROM A01065 TL
--    INNER JOIN A01066 TLD ON TL.ImportTemplateID = TLD.ImportTemplateID
--    INNER JOIN A00065 BTL ON BTL.ImportTransTypeID = TL.ImportTransTypeID AND BTL.ColID = TLD.ColID
--WHERE TL.ImportTemplateID = @ImportTransTypeID
--ORDER BY TLD.OrderNum;

--OPEN @cCURSOR;
---- Tạo cấu trúc bảng tạm
--FETCH NEXT FROM @cCURSOR
--INTO @ColID,
--     @ColSQLDataType;
--WHILE @@FETCH_STATUS = 0
--BEGIN
--    SET @sSQL = 'ALTER TABLE #Data ADD ' + @ColID + ' ' + @ColSQLDataType + ' NULL';
--    --PRINT @sSQL
--    IF 'OrderDate' = @ColID
--        PRINT @ColSQLDataType;
--    EXEC (@sSQL);
--    FETCH NEXT FROM @cCURSOR
--    INTO @ColID,
--         @ColSQLDataType;
--END;

--CLOSE @cCURSOR;

---Lấy dữ liệu từ XML:
SELECT X.Data.query('Row').value('.', 'INT') AS Row,
	   X.Data.query('OrderNo').value('.', 'INT') AS OrderNo, -- OrderNo XML trên 9
    X.Data.query('Period').value('.', 'NVARCHAR(50)') AS Period,
       X.Data.query('VoucherNo').value('.', 'NVARCHAR(50)') AS VoucherNo,
       X.Data.query('InventoryID').value('.', 'NVARCHAR(50)') AS InventoryID,
       X.Data.query('SerialNo').value('.', 'NVARCHAR(50)') AS SerialNo,
	   @DivisionID AS DivisionID
INTO #WMP22801
FROM @XML.nodes('//Data') AS X(Data);

-- Insert dữ liệu vào bảng tạm
INSERT INTO #Data(Row, DivisionID, Period, VoucherNo, InventoryID, SerialNo, ErrorColumn, ErrorMessage)
SELECT Case when Isnull(Row,0) =0 Then OrderNo else Row END Row, DivisionID, Period, VoucherNo, InventoryID, SerialNo, '', ''
FROM #WMP22801;

---- Kiểm tra check code mặc định(Thiết lập trong dữ liệu ngầm)
EXEC AP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID;

-- Kiểm tra trước khi update
UPDATE #Data 
SET	ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + 'WFML000289 {0}='''+VoucherNo+'''', 
					ErrorMessage = CONCAT(ErrorMessage,(SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'VoucherNo'),CONVERT(VARCHAR,Row),'-WFML000289,'), ErrorColumn = ErrorColumn + 'VoucherNo,'
WHERE VoucherNo IN (
SELECT DT.VoucherNo FROM (select COUNT(*) RowsCount,VoucherNo, InventoryID FROM #WMP22801 Group by VoucherNo, InventoryID) Dt	
LEFT JOIN  (select COUNT(*) RowsCount,VoucherNo, InventoryID FROM BT1002 WHERE Isnull(SeriNo,'')=''  Group by VoucherNo, InventoryID) B02 ON B02.VoucherNo = Dt.VoucherNo AND B02.InventoryID = Dt.InventoryID
WHERE ISNULL(Dt.RowsCount,0) != ISNULL(B02.RowsCount,0)
)

-- Kiểm tra serial tồn tại trong BT1002
UPDATE T1
SET	ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + '00ML000162 {0}='''+SeriNo+'''', 
					ErrorMessage = CONCAT(ErrorMessage,(SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'SeriNo'),CONVERT(VARCHAR,Row),'-00ML000162,'), ErrorColumn = ErrorColumn + 'SeriNo,'
FROM #Data T1
INNER JOIN BT1002 ON T1.SerialNo = BT1002.SeriNo

---- Kiểm tra ghi nhận trùng serial
UPDATE T1
SET	ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + 'ASML000088 {0}=''SerialNo''', 
					ErrorMessage = CONCAT(ErrorMessage,(SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'SerialNo'),CONVERT(VARCHAR,Row),'-ASML000088,'), ErrorColumn = ErrorColumn + 'SeriNo,'
FROM #Data T1
INNER JOIN 
(
	SELECT SerialNo
	FROM #Data
	GROUP BY SerialNo
	HAVING COUNT(1) > 1
) T2 ON T1.SerialNo = T2.SerialNo


-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS (SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
    GOTO LB_RESULT;

IF @Mode = 1 -- nếu dữ liệu truyền xuống đã hết
BEGIN
	WHILE EXISTS (SELECT TOP 1 1 FROM #Data)
	BEGIN 

		SELECT TOP 1 @VoucherNo = VoucherNo,
					@InventoryID = InventoryID,
					@SerialNo = SerialNo
					From #Data

		---- Test dữ liệu
		--SELECT * FROM #Data
		--select * from bt1002 where voucherno = @VoucherNo order by orders
		--print (@VoucherNo)
		--print (@InventoryID)
		--print (@SerialNo)

		Update BT1002 SET SeriNo = @SerialNo 
		WHERE APK IN (SELECT TOP 1 APK FROM BT1002 WHERE DivisionID = @DivisionID and VoucherNo = @VoucherNo and InventoryID = @InventoryID AND ISNULL(SeriNo,'')='' ORDER BY Orders)
		Delete #Data where VoucherNo = @VoucherNo and InventoryID = @InventoryID and SerialNo = @SerialNo
	END
END

LB_RESULT:
SELECT *
FROM #Data;

IF @Mode = 1
BEGIN 
	DROP Table #Data
END 

GO
SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO