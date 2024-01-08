IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP00381]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP00381]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Import Phiếu số dư tồn kho
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Cao Thị Phượng on 13/11/2017
---- Modified on 16/03/2018 By Thị Phượng Chỉnh sửa kiểm tra dữ liệu trường hợp import cả kho của hàng với 
---- Modified on 18/03/2018 By Thị Phượng Chỉnh sửa lấy kỳ kế toán và ngày chứng từ là ngày đầu tiên của hệ thống 
-- <Example>
/*
    EXEC POSP00381,0, 1
*/

 CREATE PROCEDURE POSP00381
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
DECLARE @Cur CURSOR,
		@Row INT,
		@VoucherNo VARCHAR(100),
		@ShopID VARCHAR(50),
		@WareHouseID VARCHAR(50),
		@Description NVARCHAR(500),
		@InventoryID VARCHAR(50),
		@InventoryName NVARCHAR(250),
		@UnitID NVARCHAR(250),
		@Quantity int,
		@UnitPrice Decimal(28,8),
		@ErrorFlag TINYINT = 0,
		@ErrorColumn NVARCHAR(MAX)='',
		@APK1 VARCHAR(50), --lưu giá trị APK cập nhật vào bảng
		@ErrorMessage NVARCHAR(MAX)=''

---------INSERT dữ liệu từ file excel vào bảng tạm---------------------------------------
Create Table #POST0038
(
	TransactionKey UNIQUEIDENTIFIER DEFAULT(NEWID()),
	Row INT,
	DivisionID NVARCHAR(50),
	ShopID VARCHAR(50),
	WareHouseID VARCHAR(50),
	InventoryID VARCHAR(50),
	InventoryName NVARCHAR(250),
	UnitID NVARCHAR(250),
	Quantity int,
	UnitPrice Decimal(28,8),
	Description NVARCHAR(500),
	VoucherNo NVARCHAR(50),
	ErrorColumn NVARCHAR(MAX) DEFAULT (''),
	ErrorMessage NVARCHAR(MAX) DEFAULT (''),
	CONSTRAINT [PK_#POST0038] PRIMARY KEY CLUSTERED 
	(
		Row ASC
	) ON [PRIMARY]
)


---------INSERT dữ liệu từ file excel vào bảng tạm---------------------------------------			
	
SELECT	X.Data.query('OrderNo').value('.','INT') AS [Row],
		X.Data.query('DivisionID').value('.','VARCHAR(50)') AS DivisionID,
		X.Data.query('ShopID').value('.','VARCHAR(50)') AS ShopID,
		X.Data.query('WareHouseID').value('.','VARCHAR(50)') AS WareHouseID,
		X.Data.query('InventoryID').value('.','VARCHAR(50)') AS InventoryID,
		X.Data.query('InventoryName').value('.','NVARCHAR(250)') AS InventoryName,
		X.Data.query('UnitID').value('.','VARCHAR(50)') AS UnitID,
		X.Data.query('Quantity').value('.','VARCHAR(50)') AS Quantity,
		X.Data.query('UnitPrice').value('.', 'VARCHAR(50)') AS UnitPrice,
		X.Data.query('Description').value('.', 'NVARCHAR(500)') AS Description,
		'' AS VoucherNo,
		@TransactionKey AS TransactionKey,  '' as  ErrorColumn,'' as  ErrorMessage

into #POST0038_temp
FROM @XML.nodes('//Data') AS X (Data)


Insert Into #POST0038 ([Row], DivisionID, ShopID, WareHouseID, InventoryID, InventoryName,
 UnitID, Quantity, UnitPrice, Description, VoucherNo, TransactionKey, ErrorColumn, ErrorMessage)

 select
		CASE WHEN ISNULL([Row],'') = '' THEN NULL ELSE CAST([Row] AS INT) END OrderNo,
		DivisionID,
		ShopID,
		WareHouseID,
		InventoryID,
		InventoryName,
		UnitID,
		CASE WHEN ISNULL(Quantity,'') = '' THEN NULL ELSE CAST(Quantity AS INT) END Quantity,
		CASE WHEN ISNULL(UnitPrice,'') = '' THEN NULL ELSE CAST(UnitPrice AS DECIMAL(28,8)) END UnitPrice,
		Description,
		VoucherNo,
		TransactionKey,
		ErrorColumn,
		ErrorMessage
 from 
 #POST0038_temp

--select * from A00065 where ImportTransTypeID = 'InventoryBalance'




--------------Test dữ liệu import---------------------------------------------------
IF (SELECT TOP 1 DivisionID FROM #POST0038 WHERE TransactionKey = @TransactionKey) <> @DivisionID    -- Kiểm tra đơn vị hiện tại
BEGIN
	UPDATE #POST0038 SET ErrorMessage = (SELECT TOP 1 DataCol + '-POSFML000090' FROM A00065 WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'DivisionID'),
					   ErrorColumn = 'DivisionID'
	GOTO EndMessage
END

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT [Row], VoucherNo,ISNULL(ShopID,'') ShopID,WareHouseID ,InventoryID,
	ISNULL(InventoryName,'') InventoryName, ISNULL(UnitID,'') UnitID, 
	ISNULL(Quantity,0) Quantity,ISNULL(UnitPrice,0) UnitPrice,ISNULL(Description,'') Description
	FROM #POST0038 
	WHERE TransactionKey = @TransactionKey
		
OPEN @Cur
FETCH NEXT FROM @Cur INTO @Row,@VoucherNo,@ShopID, @WareHouseID,@InventoryID,@InventoryName, @UnitID,@Quantity,
                          @UnitPrice, @Description
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @ErrorColumn = ''
	SET @ErrorMessage = ''

---- Kiểm tra tồn tại Mã mặt hàng
	IF @InventoryID<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM AT1302 WHERE InventoryID=@InventoryID AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'InventoryID'
											) + CONVERT(VARCHAR,@Row) + '-POSFML000093,'
		SET @ErrorColumn = @ErrorColumn + 'InventoryID,'				
		SET @ErrorFlag = 1
	END
---- Kiểm tra tồn tại Mã đơn vị tính
	IF @InventoryID<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM AT1304 WHERE UnitID=@UnitID AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'UnitID'
											) + CONVERT(VARCHAR,@Row) + '-POSFML000094,'
		SET @ErrorColumn = @ErrorColumn + 'UnitID,'				
		SET @ErrorFlag = 1
	END	
---- Kiểm tra tồn tại Mã cửa hàng	
	IF @ShopID<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM POST0010 WHERE ShopID=@ShopID AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ShopID'
											) + CONVERT(VARCHAR,@Row) + '-POSFML000091,'
		SET @ErrorColumn = @ErrorColumn + 'ShopID,'				
		SET @ErrorFlag = 1
	END
---- Kiểm tra tồn tại Mã kho có trong cửa hàng 
	IF  @WareHouseID<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM POST0010 WHERE (WareHouseID=@WareHouseID  or DisplayWareHouseID = @WareHouseID Or BrokenWareHouseID = @WareHouseID) 
	and ShopID =@ShopID AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'WareHouseID'
											) + CONVERT(VARCHAR,@Row) + '-POSFML000092,'
		SET @ErrorColumn = @ErrorColumn + 'WareHouseID,'				
		SET @ErrorFlag = 1
	END

---- tạo mã mới
IF @VoucherNo=''		
BEGIN	
		--kiểm tra tôn tại mã thì lấy không có thì tạo mới
			CREATE TABLE #VoucherNo (APK VARCHAR(50), LastKey INT,VoucherNo VARCHAR(100))
			INSERT INTO #VoucherNo (APK, LastKey,VoucherNo)
			EXEC POSP0000 @DivisionID,@TranMonth,@TranYear,'POST0038', @ShopID
			SELECT @APK1 = APK, @VoucherNo = VoucherNo FROM #VoucherNo	
			UPDATE AT4444 SET LastKey = LastKey + 1 WHERE APK = @APK1
			DROP TABLE #VoucherNo
	UPDATE #POST0038 SET VoucherNo = @VoucherNo WHERE  TransactionKey=@TransactionKey AND ShopID=@ShopID
END
		
	IF @ErrorColumn <> ''
	BEGIN
		UPDATE #POST0038 SET ErrorMessage = LEFT(@ErrorMessage, LEN(@ErrorMessage) -1),
							ErrorColumn = LEFT(@ErrorColumn, LEN(@ErrorColumn) -1)
		WHERE [Row] = @Row

	END
	
FETCH NEXT FROM @Cur INTO @Row,@VoucherNo,@ShopID, @WareHouseID,@InventoryID,@InventoryName, @UnitID,@Quantity,
                          @UnitPrice, @Description
END
CLOSE @Cur

IF NOT EXISTS (SELECT TOP 1 1 FROM #POST0038 WHERE TransactionKey = @TransactionKey AND ErrorColumn <> '') --- nếu không có lỗi 
	BEGIN
	
		--- insert POST9000
		INSERT INTO POST9000 (APKMaster, DivisionID, ShopID, TableID, TranMonth, TranYear, VoucherNo, VoucherTypeID,
		            VoucherDate, EmployeeID, EmployeeName,WareHouseID, WareHouseName,
		            InventoryID, InventoryName, UnitID, UnitName,
					UnitPrice, Quantity, DeleteFlg,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, APK)
		SELECT B.* ,0,@UserID,GETDATE(),@UserID,GETDATE(), NEWID()
		FROM 
		(
			SELECT A.TransactionKey APKMaster,@DivisionID DivisionID, A.ShopID, 'POST0038' TableID
			 , (Select Top 1 TranMonth FROM POST9999 where Closing = 0 Order by Tranyear, TranMonth ) TranMonth, (Select Top 1 Tranyear FROM POST9999 where Closing = 0 Order by Tranyear, TranMonth ) TranYear,
			A.VoucherNo, F.VoucherType13 as VoucherTypeID, (Select Top 1 BeginDate FROM POST9999 where Closing = 0 Order by Tranyear, TranMonth ) VoucherDate, @UserID EmployeeID, B.FullName EmployeeName, A.WareHouseID, C.WareHouseName,  A.InventoryID, D.InventoryName,
			A.UnitID , E.UnitName, ISNULL(A.UnitPrice,0) as UnitPrice, A.Quantity
			FROM #POST0038 A 
			LEFT JOIN POST0004 F On A.ShopID = F.ShopID
			LEFT JOIN AT1103 B ON B.EmployeeID = @UserID
			LEFT JOIN AT1303 C ON A.WareHouseID = C.WareHouseID
			LEFT JOIN AT1302 D ON A.InventoryID = D.InventoryID
			LEFT JOIN AT1304 E ON E.UnitID = D.UnitID
			WHERE A.TransactionKey=@TransactionKey
		)B
		
			
		
	---	insert bảng master POST0038
		IF NOT EXISTS (SELECT TOP 1 1  FROM POST0038 WHERE APK = @TransactionKey  )
		Begin
				INSERT INTO POST0038 (APK, DivisionID, ShopID, TranMonth, TranYear, VoucherTypeID, VoucherNo,
							VoucherDate, EmployeeID, EmployeeName,
						   Description, DeleteFlg,
							CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
				SELECT Distinct A.*,0,@UserID,GETDATE(),@UserID,GETDATE() 
				FROM 
				(
					SELECT Distinct A.TransactionKey APK, @DivisionID DivisionID, A.ShopID 
					, (Select Top 1 TranMonth FROM POST9999 where Closing = 0 Order by Tranyear, TranMonth ) TranMonth, (Select Top 1 Tranyear FROM POST9999 where Closing = 0 Order by Tranyear, TranMonth ) TranYear,
					F.VoucherType13, A.VoucherNo, (Select Top 1 BeginDate FROM POST9999 where Closing = 0 Order by Tranyear, TranMonth ) VoucherDate ,
					@UserID EmployeeID, B.FullName EmployeeName,Isnull(@Description, N'SỐ DƯ TỒN KHO ĐẦU KỲ') as Description
					FROM #POST0038 A 
					LEFT JOIN POST0004 F On A.ShopID = F.ShopID
					LEFT JOIN AT1103 B ON B.EmployeeID = @UserID
					WHERE A.TransactionKey=@TransactionKey
				)A		
		END
			--- insert bảng master POST0039
		INSERT INTO POST0039 (APKMaster, DivisionID, ShopID,  WareHouseID, WareHouseName,
					InventoryID, InventoryName, UnitID, UnitName,
					UnitPrice, Quantity, StatusInventory, OrderNo , DeleteFlg,
					CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT A.*,0,@UserID,GETDATE(),@UserID,GETDATE()
		FROM 
		(
			SELECT A.TransactionKey APKMaster ,@DivisionID DivisionID, A.ShopID, A.WareHouseID, C.WareHouseName,  A.InventoryID, D.InventoryName,
			isnull(A.UnitID, D.UnitID) UnitID, E.UnitName, ISNULL(A.UnitPrice,0) as UnitPrice, A.Quantity, 
			Case WHEN A.WareHouseID = (SELECT A.WareHouseID FROM POST0010 A WITH (NOLOCK) WHERE ShopID =  @ShopID) THEN 0
			WHEN A.WareHouseID = (SELECT A.DisplayWareHouseID FROM POST0010 A WITH (NOLOCK) WHERE ShopID =  @ShopID) THEN 1
			WHEN A.WareHouseID = (SELECT A.BrokenWareHouseID FROM POST0010 A WITH (NOLOCK) WHERE ShopID =  @ShopID) THEN 2 END AS StatusInventory
			, A.ROW as OrderNo
			FROM #POST0038 A 
			LEFT JOIN AT1103 B ON B.EmployeeID = @UserID
			LEFT JOIN AT1303 C ON A.WareHouseID = C.WareHouseID
			LEFT JOIN AT1302 D ON A.InventoryID = D.InventoryID
			LEFT JOIN AT1304 E ON E.UnitID = D.UnitID
			WHERE A.TransactionKey=@TransactionKey
		)A	

	END

EndMessage:;
SELECT [Row], ErrorColumn, ErrorMessage FROM #POST0038 
WHERE TransactionKey = @TransactionKey  AND ErrorColumn <> ''
ORDER BY [Row]

Drop table #POST0038
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
