IF EXISTS(SELECT TOP 1  1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DBO].[WMP22901]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
    DROP PROCEDURE [dbo].[WMP22901];
GO
SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_NULLS ON;
GO



-- <Summary>
----    Thực hiện đẩy dữ liệu import số serial cho phiếu xuất kho ERP 9
-- <Param>
---- 
-- <Return>
---- 
---- 
-- <History>
---- Created  on 05/01/2024 by Thanh Lượng
-- <Example>
CREATE PROCEDURE WMP22901
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
	VoucherID NVARCHAR(100) DEFAULT (NEWID()),	
	DivisionID NVARCHAR(50),
	Period VARCHAR(100),
	ObjectID VARCHAR(50),
	VoucherTypeID NVARCHAR(50),
	VoucherNo NVARCHAR(50),
	VoucherDate DATETIME,
	WareHouseID NVARCHAR(50),
	RDAddress NVARCHAR(50),
	Description NVARCHAR(50),
	SerialNo NVARCHAR(50),
	InventoryID	NVARCHAR(50),	
	Quantity INT,
	Notes NVARCHAR(MAX),		
    Row INT,
    TransactionID NVARCHAR(50),
    ImportMessage NVARCHAR(500) DEFAULT (''),
    ErrorMessage NVARCHAR(MAX)  DEFAULT (''),
    ErrorColumn NVARCHAR(MAX) DEFAULT (''),
    CONSTRAINT [PK_#Data]
        PRIMARY KEY CLUSTERED (Row ASC) ON [PRIMARY]
);
END

---Lấy dữ liệu từ XML:
SELECT X.Data.query('Row').value('.', 'INT') AS Row,       
	   X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
       X.Data.query('OrderNo').value('.', 'INT') AS OrderNo, -- OrderNo XML trên 9
       X.Data.query('Period').value('.', 'NVARCHAR(50)') AS Period,
	   X.Data.query('VoucherTypeID').value('.', 'NVARCHAR(50)') AS VoucherTypeID,
       X.Data.query('VoucherNo').value('.', 'NVARCHAR(50)') AS VoucherNo,
	   -- Do data type xml 8.3.7 và 9.9 khác nhau nên dùng OrderNo để phân biệt
	  (SELECT CASE WHEN X.Data.query('OrderNo').value('.', 'INT') = 0 THEN X.Data.query('VoucherDate').value('.', 'DATETIME')
	   ELSE CONVERT(DateTime, X.Data.query('VoucherDate').value('.','NVARCHAR(50)'), 103) END) AS VoucherDate,
	   X.Data.query('ObjectID').value('.', 'NVARCHAR(50)') AS ObjectID,
	   X.Data.query('WareHouseID').value('.', 'NVARCHAR(50)') AS WareHouseID,
	   X.Data.query('RDAddress').value('.', 'NVARCHAR(250)') AS RDAddress,
	   X.Data.query('Description').value('.', 'NVARCHAR(250)') AS Description,		
	   X.Data.query('SerialNo').value('.', 'NVARCHAR(50)') AS SerialNo,
	   X.Data.query('InventoryID').value('.', 'NVARCHAR(50)') AS InventoryID,
       X.Data.query('Quantity').value('.', 'INT') AS Quantity,
       X.Data.query('Notes').value('.', 'NVARCHAR(250)') AS Notes
INTO #WMP22901
FROM @XML.nodes('//Data') AS X(Data);

-- Insert dữ liệu vào bảng tạm
INSERT INTO #Data(Row, DivisionID, Period,VoucherTypeID, VoucherNo, VoucherDate, ObjectID, WareHouseID, RDAddress, Description, SerialNo, InventoryID, Quantity, Notes, ErrorColumn, ErrorMessage )
SELECT Case when Isnull(Row,0) =0 Then OrderNo else Row END Row,  DivisionID, Period, VoucherTypeID, VoucherNo, VoucherDate, ObjectID,WareHouseID, RDAddress, Description, SerialNo, InventoryID, Quantity, Notes, '', ''
FROM #WMP22901;

---- Kiểm tra check code mặc định(Thiết lập trong dữ liệu ngầm)
EXEC AP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID;

-- Kiểm tra trước khi update
UPDATE #Data 
SET	ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + 'WFML000292 {0}='''+VoucherNo+'''',
	ErrorMessage = CONCAT(ErrorMessage,(SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'VoucherNo'),CONVERT(VARCHAR,Row),'-WFML000289,'), ErrorColumn = ErrorColumn + 'VoucherNo,'
WHERE VoucherNo IN (
SELECT DT.VoucherNo FROM (select VoucherNo FROM #WMP22901 Group by VoucherNo) Dt	
LEFT JOIN  (select VoucherNo FROM BT1002 Group by VoucherNo) B02 ON B02.VoucherNo = Dt.VoucherNo
WHERE Dt.VoucherNo = B02.VoucherNo
)

---- Kiểm tra ghi nhận trùng serial.
UPDATE T1
SET	ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + 'ASML000088 {0}=''SerialNo''', 
					ErrorMessage = CONCAT(ErrorMessage,(SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'SerialNo'),CONVERT(VARCHAR,Row),'-ASML000088,'), ErrorColumn = ErrorColumn + 'SerialNo,'
FROM #Data T1
INNER JOIN 
(
	SELECT SerialNo
	FROM #Data
	GROUP BY SerialNo
	HAVING COUNT(1) > 1
) T2 ON T1.SerialNo = T2.SerialNo

---- Kiểm tra tồn tại số serial trong phiếu nhập(KindVoucherID=1).
UPDATE #Data
SET	ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + 'WFML000295 {0}='''+SerialNo+'''', 
					ErrorMessage = CONCAT(ErrorMessage,(SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'SerialNo'),CONVERT(VARCHAR,Row),'-WFML000295,'), ErrorColumn = ErrorColumn + 'SerialNo,'
WHERE NOT Exists (select SeriNo as SerialNo FROM BT1002  where KindVoucherID = 1 and SeriNo = SerialNo) 

---- Kiểm tra tồn tại mã mặt hàng trong kho xuất
UPDATE #Data 
SET	ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + 'WFML000296 {0}='''+InventoryID+'''', 
					ErrorMessage = CONCAT(ErrorMessage,(SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'InventoryID'),CONVERT(VARCHAR,Row),'-WFML000296,'), ErrorColumn = ErrorColumn + 'InventoryID,'
WHERE NOT Exists (SELECT InventoryID FROM BT1002 
Left join (SELECT WareHouseID FROM AT1303 WITH (NOLOCK)
		WHERE DivisionID = (SELECT KeyValue FROM ST2101 WHERE KeyName = 'DealerDivisionID')) B02 on B02.WareHouseID = BT1002.WareHouseID 
		WHERE   KindVoucherID = 1 AND #Data.InventoryID = InventoryID
		) 
---- Kiểm tra kho không thuộc kho SELLOUT
UPDATE #Data 
SET	ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + 'WFML000297 {0}='''+WareHouseID+'''', 
					ErrorMessage = CONCAT(ErrorMessage,(SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK) 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'WareHouseID'),CONVERT(VARCHAR,Row),'-WFML000297,'), ErrorColumn = ErrorColumn + 'WareHouseID,'
WHERE NOT Exists (SELECT WareHouseID FROM AT1303 WITH (NOLOCK)
				   WHERE DivisionID = (SELECT KeyValue FROM ST2101 WHERE KeyName = 'DealerDivisionID') 
				   and #Data.WareHouseID =  AT1303.WareHouseID) 

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