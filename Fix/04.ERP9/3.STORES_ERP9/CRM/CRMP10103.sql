IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP10103]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP10103]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- <Summary>
--- Import Danh mục khách hàng
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Cao Thị Phượng Date 29/05/2017
---- Edited by: Truong Lam Date 17/12/2019 -- Thêm ObjectTypeID khách hàng khi insert từ CRM Khách Hàng
---- Modified by: Trọng Kiên Date 07/09/2020 -- Xử lý tăng mã tự động
---- Modified by: Văn Tài	 Date 08/01/2022 -- Xử lý cột dữ liệu.
---- Modified by: Văn Tài	 Date 09/05/2022 -- Bổ sung xử trường hợp không dùng mã tăng tự động của hệ thống.
-- <Example>
/*
    EXEC CRMP10103 'AS','PHUONG','','', 1,'','',''
*/

 CREATE PROCEDURE CRMP10103
(
     @DivisionID VARCHAR(50),
     @UserID VARCHAR(50), 
     @TranMonth Int = null,
     @TranYear Int = null,
     @Mode TINYINT, --0 chưa hết dữ liệu, 1: hết dữ liệu
     @ImportTransTypeID NVARCHAR(250),
     @TransactionKey NVARCHAR(50),
     @XML XML
)
AS
DECLARE @Cur CURSOR,
        @Row INT,
		@CustomerIndex INT = (SELECT TOP 1 CustomerIndex.CustomerName FROM CustomerIndex WITH (NOLOCK)),
        @MemberID VARCHAR(50),
        @MemberName NVARCHAR(250),
        @AssignedToUserID VARCHAR(50),
        @Address NVARCHAR(250),
        @Tel NVARCHAR(100),
        @Email NVARCHAR(100),
        @Fax NVARCHAR(100),
        @Website NVARCHAR(100),
        @Birthday Datetime,
        @DeliveryAddress NVARCHAR(250),
        @BillAddress NVARCHAR(250),
        @Description NVARCHAR(250),
        @IsCommon TinyInt,
        @ErrorFlag TINYINT,
        @ErrorColumn NVARCHAR(MAX) = '',
        @ErrorMessage NVARCHAR(MAX) = ''
		
Create Table #POST0011
(
    TransactionKey UNIQUEIDENTIFIER DEFAULT(NEWID()),
    Row INT,
    DivisionID NVARCHAR(50),
    MemberID NVARCHAR(50),
    MemberName NVARCHAR(250) NULL,
    AssignedToUserID NVARCHAR(50) NULL,
    [Address] NVARCHAR(250) NULL, 
    Tel NVARCHAR(100) NULL, 
    Email NVARCHAR(100) NULL,
    Fax NVARCHAR(100) NULL,
    Website NVARCHAR(100) NULL, 
    Birthday Datetime,
    DeliveryAddress NVARCHAR(250) NULL,
    BillAddress NVARCHAR(250) NULL,
    [Description] NVARCHAR(250) NULL,
    IsCommon Tinyint DEFAULT (0), 
    ErrorColumn NVARCHAR(MAX) DEFAULT (''),
    ErrorMessage NVARCHAR(MAX) DEFAULT (''),
    CONSTRAINT [PK_#CRMT10101] PRIMARY KEY CLUSTERED 
    (
        Row ASC
    ) ON [PRIMARY]
)
---------INSERT dữ liệu từ file excel vào bảng tạm---------------------------------------
PRINT(N'INSERT dữ liệu từ file excel vào bảng tạm #POST0011')
--Insert Into #CRMT10101 ([Row], DivisionID, AccountID, AccountName, AssignedToUserID, [Address],
-- Tel, Email, Fax, Website, BirthDate, DeliveryAddress, BillAddress, [Description], IsCommon, TransactionKey, ErrorColumn, ErrorMessage)		
Insert Into #POST0011 ([Row]
, DivisionID
, MemberID
, MemberName
, AssignedToUserID
, [Address]
, Tel
, Email
, Fax
, Website
, Birthday
, DeliveryAddress
, BillAddress
, [Description]
, IsCommon
, TransactionKey
, ErrorColumn
, ErrorMessage)	
SELECT	X.Data.query('OrderNo').value('.','INT') AS [Row],
        X.Data.query('DivisionID').value('.','NVARCHAR(50)') AS DivisionID,
        X.Data.query('MemberID').value('.','NVARCHAR(50)') AS MemberID,
        X.Data.query('MemberName').value('.','NVARCHAR(250)') AS MemberName,
        X.Data.query('AssignedToUserID').value('.','NVARCHAR(50)') AS AssignedToUserID,
        X.Data.query('Address').value('.','NVARCHAR(250)') AS [Address],
        X.Data.query('Tel').value('.','NVARCHAR(100)') AS Tel,
        X.Data.query('Email').value('.','NVARCHAR(100)') AS Email,
        X.Data.query('Fax').value('.','NVARCHAR(100)') AS Fax,
        X.Data.query('Website').value('.', 'NVARCHAR(100)') AS Website,
        X.Data.query('BirthDate').value('.', 'DATETIME') AS Birthday,
        X.Data.query('DeliveryAddress').value('.', 'NVARCHAR(250)') AS DeliveryAddress,
        X.Data.query('DepartmentName').value('.', 'NVARCHAR(250)') AS BillAddress,
        X.Data.query('Description').value('.', 'NVARCHAR(250)') AS [Description],
        X.Data.query('IsCommon').value('.', 'TINYINT') AS IsCommon, 
        @TransactionKey AS TransactionKey,  '' as  ErrorColumn,'' as  ErrorMessage
FROM @XML.nodes('//Data') AS X (Data)
PRINT(N'Kết thúc insert vào bảng tạm #POST0011')

--------------Test dữ liệu import---------------------------------------------------
IF (SELECT TOP 1 DivisionID FROM #POST0011 WHERE TransactionKey = @TransactionKey) <> @DivisionID    -- Kiểm tra đơn vị hiện tại
BEGIN
    UPDATE #POST0011 SET ErrorMessage = (SELECT TOP 1 DataCol + '-CRMFML000008' FROM A00065 WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'DivisionID'),
                         ErrorColumn = 'DivisionID'
    GOTO EndMessage
END

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT [Row],ISNULL(MemberID,'') MemberID,MemberName,AssignedToUserID,
    ISNULL(Address,'') [Address], ISNULL(Tel,'') Tel, 
    ISNULL(Email,'') Email,ISNULL(Website,'') Website, ISNULL(Fax,'') Fax ,ISNULL(Birthday,'') BirthDate,
    ISNULL(DeliveryAddress,'') DeliveryAddress,ISNULL(BillAddress,'') BillAddress,
    ISNULL([Description],'') [Description],ISNULL(IsCommon,'') IsCommon
    FROM #POST0011 
    WHERE TransactionKey = @TransactionKey

OPEN @Cur
FETCH NEXT FROM @Cur INTO @Row, @MemberID, @MemberName, @AssignedToUserID,@Address,@Tel, @Email,@Fax,
                          @Website, @Birthday, @DeliveryAddress, @BillAddress, @Description, @IsCommon
WHILE @@FETCH_STATUS = 0
BEGIN
---- Kiểm tra tồn tại mã người phụ trách
    IF NOT EXISTS (SELECT TOP 1 1 FROM AT1103 WHERE EmployeeID = @AssignedToUserID )		
    BEGIN
        SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
                                            WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'AssignedToUserID'
                                            ) + CONVERT(VARCHAR,@Row) + '-CRMFML000016,'
        SET @ErrorColumn = @ErrorColumn + 'AssignedToUserID,'				
        SET @ErrorFlag = 1
    END

    IF @ErrorColumn <>''
    BEGIN
        UPDATE #POST0011 SET ErrorMessage = LEFT(@ErrorMessage, LEN(@ErrorMessage) -1),
                             ErrorColumn = LEFT(@ErrorColumn, LEN(@ErrorColumn) -1)
        WHERE [Row] = @Row
    END

    FETCH NEXT FROM @Cur INTO  @Row, @MemberID, @MemberName, @AssignedToUserID,@Address,@Tel, @Email,@Fax,
                          @Website, @Birthday, @DeliveryAddress, @BillAddress, @Description, @IsCommon
END
CLOSE @Cur

DECLARE 
        @TableBusiness VARCHAR(10) = 'AT1202',
        @VoucherNo VARCHAR(50),
        @NewVoucherNo VARCHAR(50),
        @KeyString VARCHAR(50),
        @LastKey INT,
        @S1 VARCHAR(50)

---- BEGIN - Xử lý tăng số chứng từ tự động

SELECT DISTINCT [Row], [Row] AS NewVoucherNo
INTO #VoucherData
FROM #POST0011
ORDER BY [Row]

-- Select lấy động dữ liệu mã thiết lập trong bảng ATAT0002
Set @S1 = (SELECT S1 From AT0002 where TableID = @TableBusiness AND DivisionID = @DivisionID)

WHILE EXISTS (SELECT TOP 1 1 FROM #VoucherData)
BEGIN
     SELECT @VoucherNo = [Row] FROM #VoucherData

	 IF (@CustomerIndex <> 152) -- Cảng Sài Gòn
	 BEGIN
		--EXEC GetVoucherNo_Ver1 @DivisionID, 'CRM', 'AT0002', 'S1', @TableBusiness, 'KH', @NewVoucherNo OUTPUT, @KeyString OUTPUT, @LastKey OUTPUT
		--EXEC GetVoucherNo_Ver1 @DivisionID, 'CRM', 'AT0002', 'S1', @TableBusiness, @S1, @NewVoucherNo OUTPUT, @KeyString OUTPUT, @LastKey OUTPUT
		EXEC GetVoucherNo_Ver2 @DivisionID, 'CRM', 'CRMF1011', @TableBusiness, @NewVoucherNo OUTPUT, @KeyString OUTPUT, @LastKey OUTPUT

		-- Cập nhật số chứng từ vào bảng dữ liệu import từ Excel
		UPDATE #POST0011 SET MemberID = @NewVoucherNo WHERE [Row] = @VoucherNo
		-- Cập nhật LastKey cho bảng đăng ký số chứng từ tự động
		IF NOT EXISTS (SELECT TOP 1 1 FROM AT4444 WITH (NOLOCK) WHERE ISNULL(TableName,'') = @TableBusiness AND ISNULL(KeyString,'') = @KeyString)
		BEGIN
		INSERT INTO AT4444 (DivisionID,LastKey,TableName,KeyString) VALUES (@DivisionID,@LastKey,@TableBusiness,@KeyString)
		END
		ELSE
		BEGIN
			UPDATE AT4444 SET LastKey = @LastKey WHERE TableName = @TableBusiness AND KeyString = @KeyString
		END

	--	print @LastKey 
	--	print @TableBusiness 
	--	print @KeyString 

	END

    DELETE #VoucherData WHERE [Row] = @VoucherNo
END

---- END - Xử lý tăng số chứng từ tự động

IF @Mode = 1 -- nếu dữ liệu truyền xuống đã hết
BEGIN

    IF NOT EXISTS (SELECT TOP 1 1 FROM #POST0011 WHERE TransactionKey = @TransactionKey AND ErrorColumn <> '') --- nếu không có lỗi
    BEGIN
        --- insert POST0011
        INSERT INTO POST0011 ( 
                    DivisionID, MemberID, MemberName, AssignedToUserID, [Address], Tel, Email, Fax,
                    Website, Birthday, DeliveryAddress, BillAddress, [Description], IsCommon, IsCustomer, 
                    EmployeeID, [Disabled], [RelatedToTypeID], 
                    CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
        SELECT A.DivisionID, A.MemberID, A.MemberName, A.AssignedToUserID, A.Address, A.Tel, A.Email, A.Fax,
				A.Website, A.Birthday, A.DeliveryAddress, a.BillAddress, a.Description, A.IsCommon,
					1, @UserID, 0, 3, @UserID, GETDATE(), @UserID, GETDATE()
        FROM 
        (
            SELECT  Case when IsCommon = 1 then '@@@' else DivisionID end DivisionID ,
                    MemberID, MemberName, AssignedToUserID, [Address], Tel, Email, Fax,
                    Website, Birthday, DeliveryAddress, BillAddress, [Description], IsCommon
            FROM #POST0011
            WHERE TransactionKey=@TransactionKey

        )A

        --- insert select top 1 * From AT1202
        INSERT INTO AT1202 ( 
                    DivisionID, ObjectID, ObjectName, [Address], Tel, Email, Fax,
                    Website, DeAddress, ReAddress, Note1, IsCommon, IsCustomer, 
                    EmployeeID, [Disabled], 
                    CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, ObjectTypeID)
        SELECT A.DivisionID, A.MemberID, A.MemberName, A.[Address], A.Tel, A.Email, A.Fax,
				A.Website, A.DeliveryAddress, A.BillAddress, A.[Description], A.IsCommon,
				 1, @UserID, 0, @UserID, GETDATE(), @UserID, GETDATE(), 'KH'
        FROM 
        (
            SELECT  Case when IsCommon = 1 then '@@@' else DivisionID end DivisionID ,
                    MemberID, MemberName, [Address], Tel, Email, Fax,
                    Website, DeliveryAddress, BillAddress, [Description], IsCommon
            FROM #POST0011
            WHERE TransactionKey=@TransactionKey

        )A

    END

END

EndMessage:
SELECT [Row], ErrorColumn, ErrorMessage FROM #POST0011 
WHERE TransactionKey = @TransactionKey AND ErrorColumn <> ''
ORDER BY [Row]









GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
