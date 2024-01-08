IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP8167]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP8167]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
----    Thực hiện đẩy dữ liệu import phiếu xuất kho mã vạch 
-- <Param>
---- 
-- <Return>
---- 
---- 
-- <History>
---- Created  on 03/07/2023 by Thanh Lượng
---- Modified on 18/07/2023 by Thanh Lượng :[2023/07/IS/0068]+[2023/07/IS/0144] - Bổ sung chỉnh sửa gộp mặt hàng vào 1 phiếu xuất kho + cảnh báo trùng phiếu chứng từ.
---- Modified on 03/08/2023 by Thanh Lượng :[2023/08/IS/0042] - Bổ sung chỉnh sửa cảnh báo + dữ liệu cột (GREE).
---- Updated  on 05/12/2023 by Thanh Lượng: [2023/11/TA/0240] - Bổ sung create các trường cần thiết vào bảng tạm fix lỗi import trên 9.3.7
---- Updated  on 20/12/2023 by Hoàng Long : [2023/12/IS/0214] - Lỗi import phiếu xuất kho serial
---- Updated  on 21/12/2023 by Thanh Lượng ft Bi Phan: [2023/12/IS/0214][2023/12/IS/0227] - Lỗi import phiếu xuất kho serial(Fix đồng bộ cho 8.3.7 và 9.9).
-- <Example> EXEC AP8167 @DivisionID = @DivisionID, @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @XML = @XML 

CREATE PROCEDURE AP8167
(
    @DivisionID AS NVARCHAR(50),
    @UserID AS NVARCHAR(50),
    @ImportTemplateID AS NVARCHAR(50) = NULL, -- ERP8
    @XML AS XML
)
AS
DECLARE @cCURSOR AS CURSOR,
        @sSQL AS VARCHAR(1000),
		@VoucherID AS NVARCHAR(100);

DECLARE @ColID AS NVARCHAR(50),
        @ColSQLDataType AS NVARCHAR(50)
					
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

SET @cCURSOR = CURSOR STATIC FOR
SELECT TLD.ColID,
       BTL.ColSQLDataType
FROM A01065 TL
    INNER JOIN A01066 TLD ON TL.ImportTemplateID = TLD.ImportTemplateID
    INNER JOIN A00065 BTL ON BTL.ImportTransTypeID = TL.ImportTransTypeID AND BTL.ColID = TLD.ColID
WHERE TL.ImportTemplateID = @ImportTemplateID
ORDER BY TLD.OrderNum;


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
INTO #AP8167
FROM @XML.nodes('//Data') AS X(Data);

-- Insert dữ liệu vào bảng tạm
INSERT INTO #Data(Row, DivisionID, Period,VoucherTypeID, VoucherNo, VoucherDate, ObjectID, WareHouseID, RDAddress, Description, SerialNo, InventoryID, Quantity, Notes)
SELECT Case when Isnull(Row,0) =0 Then OrderNo else Row END Row,  DivisionID, Period, VoucherTypeID, VoucherNo, VoucherDate, ObjectID,WareHouseID, RDAddress, Description, SerialNo, InventoryID, Quantity, Notes
FROM #AP8167;

---- Kiểm tra check code mặc định(Thiết lập trong dữ liệu ngầm)
EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID;
--select * from #DataWFML000295

-- Kiểm tra trước khi update
---- Check phiếu đã được xuất
UPDATE #Data 
SET	ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + 'WFML000292 {0}='''+VoucherNo+''''
WHERE VoucherNo IN (
SELECT DT.VoucherNo FROM (select VoucherNo FROM #AP8167 Group by VoucherNo) Dt	
LEFT JOIN  (select VoucherNo FROM BT1002 Group by VoucherNo) B02 ON B02.VoucherNo = Dt.VoucherNo
WHERE Dt.VoucherNo = B02.VoucherNo
)

---- Kiểm tra ghi nhận trùng serial.
UPDATE T1
SET	ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + 'ASML000088 {0}=''SerialNo'''
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
SET	ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + 'WFML000295 {0}='''+SerialNo+''''
WHERE NOT Exists (select SeriNo as SerialNo FROM BT1002  where KindVoucherID = 1 and SeriNo = SerialNo) 

---- Kiểm tra tồn tại mã mặt hàng trong kho xuất
UPDATE #Data 
SET	ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + 'WFML000296 {0}='''+InventoryID+''''
WHERE NOT Exists (SELECT InventoryID FROM BT1002 
Left join (SELECT WareHouseID FROM AT1303 WITH (NOLOCK)
		WHERE DivisionID = (SELECT KeyValue FROM ST2101 WHERE KeyName = 'DealerDivisionID')) B02 on B02.WareHouseID = BT1002.WareHouseID 
		WHERE   KindVoucherID = 1 AND #Data.InventoryID = InventoryID
		) 
---- Kiểm tra kho không thuộc kho SELLOUT
UPDATE #Data 
SET	ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + 'WFML000297 {0}='''+WareHouseID+''''
WHERE NOT Exists (SELECT WareHouseID FROM AT1303 WITH (NOLOCK)
				   WHERE DivisionID = (SELECT KeyValue FROM ST2101 WHERE KeyName = 'DealerDivisionID') 
				   and #Data.WareHouseID =  AT1303.WareHouseID) 

-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS (SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
    GOTO LB_RESULT;
	set @VoucherID = NEWID(); 
	INSERT INTO BT1002(							
	DivisionID, TranMonth, TranYear, VoucherTypeID,
	VoucherID, VoucherNo, VoucherDate, Description,			
	ObjectID, RDAddress, WareHouseID, KindVoucherID,			
	SeriNo,	InventoryID, Quantity, Notes,					
	CreateDate,	CreateUserID, LastModifyDate, 
	LastModifyUserID,TransactionID)
	SELECT 
	DivisionID, LEFT(Period, 2), RIGHT(Period, 4), VoucherTypeID,	
	@VoucherID, VoucherNo, VoucherDate, Description, 
	ObjectID, RDAddress, WareHouseID, 2,
	SerialNo,	InventoryID, Quantity, Notes,
	GETDATE(), @UserID, GETDATE(),
	@UserID, NEWID()				
	FROM #Data								 

LB_RESULT:
SELECT *
FROM #Data;

DROP Table #Data

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
