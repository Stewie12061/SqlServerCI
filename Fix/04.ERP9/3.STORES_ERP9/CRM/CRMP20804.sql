IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP20804]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP20804]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Import Excel yêu cầu
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Kiều Nga on 06/05/2020
---- Modified by on Kiều Nga 08/05/2020 Thay đổi kiểu dữ liệu TimeRequest,DeadlineRequest
-- <Example>
/* 
 EXEC CRMP20804 @DivisionID, @UserID, @ImportTransTypeID, @XML
 */
 
CREATE PROCEDURE CRMP20804
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),	
	@ImportTransTypeID VARCHAR(50),
	@XML XML
) 
AS
DECLARE @cCURSOR CURSOR,
		@sSQL NVARCHAR(MAX) ='',
		@sSQL2 NVARCHAR(MAX) ='',
		@ColID VARCHAR(50), 
		@ColSQLDataType VARCHAR(50)
		
CREATE TABLE #Data
(
	[Row] INT,
	Orders INT,
	ErrorMessage NVARCHAR(MAX) DEFAULT (''),
	ErrorColumn NVARCHAR(MAX) DEFAULT (''),
	CONSTRAINT [PK_#Data] PRIMARY KEY CLUSTERED 
	(
		Row ASC
	) ON [PRIMARY]	
)

SET @cCURSOR = CURSOR STATIC FOR
	SELECT A00065.ColID, A00065.ColSQLDataType
	FROM A01065 WITH (NOLOCK) 
	INNER JOIN A00065 WITH (NOLOCK) ON A01065.ImportTemplateID = A00065.ImportTransTypeID
	WHERE A01065.ImportTemplateID = @ImportTransTypeID
	ORDER BY A00065.OrderNum
			
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
CLOSE @cCURSOR

SET @sSQL =' ALTER TABLE #Data ADD APKMaster VARCHAR(50) NULL'
EXEC (@sSQL)

SELECT  X.Data.query('OrderNo').value('.', 'INT') AS [Row],
		X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
		X.Data.query('RequestCustomerID').value('.', 'NVARCHAR(50)') AS RequestCustomerID,
		X.Data.query('RequestSubject').value('.', 'NVARCHAR(4000)') AS RequestSubject,
		X.Data.query('RelatedToID').value('.', 'NVARCHAR(50)') AS RelatedToID,
		X.Data.query('RequestStatus').value('.', 'INT') AS RequestStatus, 
		X.Data.query('PriorityID').value('.', 'INT') AS PriorityID, 
		X.Data.query('RequestDescription').value('.', 'NVARCHAR(4000)') AS RequestDescription, 
		X.Data.query('TimeRequest').value('.', 'NVARCHAR(50)') AS TimeRequest, 
		X.Data.query('DeadlineRequest').value('.', 'NVARCHAR(50)') AS DeadlineRequest, 
		X.Data.query('AssignedToUserID').value('.', 'NVARCHAR(50)') AS AssignedToUserID,
		X.Data.query('OpportunityID').value('.', 'NVARCHAR(50)') AS OpportunityID,
		X.Data.query('FeedbackDescription').value('.', 'NVARCHAR(4000)') AS FeedbackDescription,
		IDENTITY(int, 1, 1) AS Orders			
INTO #CRMT20801
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

INSERT INTO #Data ([Row],Orders,DivisionID, RequestCustomerID,RequestSubject, RelatedToID, RequestStatus, PriorityID, RequestDescription, TimeRequest,DeadlineRequest,AssignedToUserID,OpportunityID,FeedbackDescription)
SELECT [Row],Orders,DivisionID,RequestCustomerID,RequestSubject, RelatedToID, RequestStatus, PriorityID, RequestDescription, TimeRequest,DeadlineRequest,AssignedToUserID,OpportunityID,FeedbackDescription
FROM #CRMT20801 WITH (NOLOCK)

---------- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

---------- Kiểm tra trùng mã khối  
--EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckDuplicateData', @ColID = 'RequestCustomerID', @Param1 = 'Orders', @Param2 = 'CRMT20801', 
--@Param3 = 'RequestCustomerID'

-------- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
		UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
							ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
		WHERE ErrorMessage <> ''

		GOTO LB_RESULT
END

BEGIN TRY
    BEGIN TRANSACTION

	DECLARE 
        @TableBusiness VARCHAR(10) = 'CRMT20801',
        @VoucherNo VARCHAR(50),
        @NewVoucherNo VARCHAR(50),
        @KeyString VARCHAR(50),
        @LastKey INT

	---- BEGIN - Xử lý tăng số chứng từ tự động

	SELECT DISTINCT [Row], [Row] AS NewVoucherNo
	INTO #VoucherData
	FROM #Data
	ORDER BY [Row]

	WHILE EXISTS (SELECT TOP 1 1 FROM #VoucherData)
	BEGIN
		 SELECT @VoucherNo = [Row] FROM #VoucherData

		EXEC GetVoucherNo_Ver2 @DivisionID, 'CRM', 'CRMF2081', @TableBusiness, @NewVoucherNo OUTPUT, @KeyString OUTPUT, @LastKey OUTPUT
		PRINT @NewVoucherNo

		-- Cập nhật số chứng từ vào bảng dữ liệu import từ Excel
		UPDATE #Data SET RequestCustomerID = @NewVoucherNo WHERE [Row] = @VoucherNo

		-- Cập nhật LastKey cho bảng đăng ký số chứng từ tự động
		UPDATE AT4444 SET LastKey = @LastKey WHERE TableName = @TableBusiness AND KeyString = @KeyString

		DELETE #VoucherData WHERE [Row] = @VoucherNo
	END

	-- Lấy requestID
	IF IDENT_CURRENT('CRMT20801') IS NOT NULL
    SET IDENTITY_INSERT CRMT20801 ON
    DECLARE @countRequestID INT = 0
    SET @countRequestID = ISNULL((SELECT COUNT(1) FROM CRMT20801 WITH (NOLOCK)),0) + 1

	-- Thêm mới Yêu cầu
	INSERT INTO CRMT20801 (APK,RequestID,RequestCustomerID,RelatedToTypeID,DivisionID, RequestSubject,RequestStatus, PriorityID, RequestDescription, TimeRequest,DeadlineRequest,AssignedToUserID,OpportunityID,FeedbackDescription, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	SELECT NEWID(),@countRequestID,RequestCustomerID,20,DivisionID,RequestSubject,RequestStatus, PriorityID, RequestDescription, TimeRequest,DeadlineRequest,AssignedToUserID,OpportunityID,FeedbackDescription, @UserID AS CreateUserID,GETDATE() AS CreateDate, @UserID AS LastModifyUserID, GETDATE() AS LastModifyDate				
	FROM #Data WITH(NOLOCK)

	-- Thêm  mới khách hàng
	Insert into CRMT20801_CRMT10101_REL(APK, AccountID , RequestID) 
	SELECT NEWID(),AT1202.APK,@countRequestID
	FROM #Data P WITH(NOLOCK)  
	INNER JOIN AT1202  With (NOLOCK) ON AT1202.ObjectID = P.RelatedToID

	COMMIT
END TRY
BEGIN CATCH
    ROLLBACK
END CATCH

LB_RESULT:
SELECT [Row], ErrorColumn, ErrorMessage FROM #Data 
WHERE  ErrorColumn <> ''
ORDER BY [Row]

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
