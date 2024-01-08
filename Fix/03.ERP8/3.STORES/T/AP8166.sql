IF EXISTS(SELECT TOP 1  1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DBO].[AP8166]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
    DROP PROCEDURE [dbo].[AP8166];
GO
SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_NULLS ON;
GO



-- <Summary>
----    Thực hiện đẩy dữ liệu import số serial cho phiếu nhập kho
-- <Param>
---- 
-- <Return>
---- 
---- 
-- <History>
---- Created  on 06/06/2023 by Nhật Thanh
---- Updated  on 03/07/2023 by Nhật Thanh: Cải tiến cách import
---- Updated  on 12/07/2023 by Hoàng Long: Không cho import trùng số serial
---- Updated  on 05/12/2023 by Thanh Lượng: [2023/11/TA/0239] - Bổ sung create các trường cần thiết vào bảng tạm fix lỗi import trên 9.9
---- Updated  on 15/12/2023 by Thanh Lượng: [2023/12/IS/0167] - Bổ sung chỉnh sửa fix lỗi Import không đồng bộ erp 8.3.7 và 9.9
-- <Example>
CREATE PROCEDURE AP8166
(
    @DivisionID AS NVARCHAR(50),
    @UserID AS NVARCHAR(50),
    @ImportTemplateID AS NVARCHAR(50) = NULL, -- ERP8
    @XML AS XML
)
AS
DECLARE @cCURSOR AS CURSOR,
        @sSQL AS VARCHAR(1000);

DECLARE @ColID AS NVARCHAR(50),
        @ColSQLDataType AS NVARCHAR(50),
		@VoucherNo AS NVARCHAR(50),
		@InventoryID AS NVARCHAR(50),
		@SerialNo AS NVARCHAR(50)

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
	   X.Data.query('OrderNo').value('.', 'INT') AS OrderNo, -- OrderNo XML trên 9
    X.Data.query('Period').value('.', 'NVARCHAR(50)') AS Period,
       X.Data.query('VoucherNo').value('.', 'NVARCHAR(50)') AS VoucherNo,
       X.Data.query('InventoryID').value('.', 'NVARCHAR(50)') AS InventoryID,
       X.Data.query('SerialNo').value('.', 'NVARCHAR(50)') AS SerialNo,
	   @DivisionID AS DivisionID
INTO #AP8166
FROM @XML.nodes('//Data') AS X(Data);

-- Insert dữ liệu vào bảng tạm
INSERT INTO #Data(Row, DivisionID, Period, VoucherNo, InventoryID, SerialNo)
SELECT Case when Isnull(Row,0) =0 Then OrderNo else Row END Row, DivisionID, Period, VoucherNo, InventoryID, SerialNo
FROM #AP8166;

---- Kiểm tra check code mặc định(Thiết lập trong dữ liệu ngầm)
EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID;

-- Kiểm tra trước khi update
UPDATE #Data 
SET	ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + 'WFML000289 {0}='''+VoucherNo+''''
WHERE VoucherNo IN (
SELECT DT.VoucherNo FROM (select COUNT(*) RowsCount,VoucherNo, InventoryID FROM #AP8166 Group by VoucherNo, InventoryID) Dt	
LEFT JOIN  (select COUNT(*) RowsCount,VoucherNo, InventoryID FROM BT1002 Group by VoucherNo, InventoryID) B02 ON B02.VoucherNo = Dt.VoucherNo AND B02.InventoryID = Dt.InventoryID
WHERE ISNULL(Dt.RowsCount,0) != ISNULL(B02.RowsCount,0)
)

-- Kiểm tra serial tồn tại trong BT1002
UPDATE T1
SET	ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + '00ML000162 {0}='''+SeriNo+''''
FROM #Data T1
INNER JOIN BT1002 ON T1.SerialNo = BT1002.SeriNo

---- Kiểm tra ghi nhận trùng serial
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


-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS (SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
    GOTO LB_RESULT;

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

LB_RESULT:
SELECT *
FROM #Data;

DROP Table #Data

GO
SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO