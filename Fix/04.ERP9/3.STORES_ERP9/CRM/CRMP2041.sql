IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2041]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP2041]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO













-- <Summary>
---- Import Excel nghiệp vụ Chiến dịch module CRM
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Trọng Kiên: + on 26/08/2020
----                        + on 08/09/2020: Bổ sung tính năng tăng mã tự động
---- Modified by Hoài Bảo on 06/09/2022: Cập nhật lấy mã chứng từ tự động theo version 2
-- <Example>

CREATE PROCEDURE CRMP2041
(
    @DivisionID VARCHAR(50),
    @UserID VARCHAR(50),
    @ImportTransTypeID VARCHAR(50),
    @XML XML
) 
AS
DECLARE @cCURSOR CURSOR,
        @sSQL NVARCHAR(MAX),
        @ColID VARCHAR(50), 
        @ColSQLDataType VARCHAR(50)

CREATE TABLE #Data
(
    [Row] INT,
    APK UNIQUEIDENTIFIER,
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
    EXEC (@sSQL)
    FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
END
CLOSE @cCURSOR


SELECT  X.Data.query('OrderNo').value('.', 'INT') AS [Row],
        NEWID() AS APK,
        X.Data.query('DivisionID').value('.', 'VARCHAR(50)') AS DivisionID,
        X.Data.query('CampaignID').value('.','VARCHAR(50)') AS CampaignID,
        X.Data.query('CampaignName').value('.','NVARCHAR(250)') AS CampaignName,
        X.Data.query('AssignedToUserID').value('.','NVARCHAR(50)') AS AssignedToUserID,
		X.Data.query('CampaignType').value('.','VARCHAR(50)') AS CampaignType,
		(CASE WHEN X.Data.query('ExpectOpenDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('ExpectOpenDate').value('.', 'VARCHAR(50)') END) AS ExpectOpenDate,
		(CASE WHEN X.Data.query('ExpectCloseDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('ExpectCloseDate').value('.', 'VARCHAR(50)') END) AS ExpectCloseDate,
		(CASE WHEN X.Data.query('PlaceDate').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('PlaceDate').value('.', 'DATETIME') END) AS PlaceDate,
        X.Data.query('CampaignStatus').value('.','VARCHAR(50)') AS CampaignStatus,
        X.Data.query('InventoryID').value('.','VARCHAR(50)') AS InventoryID,
        X.Data.query('Sponsor').value('.','NVARCHAR(250)') AS Sponsor,
        X.Data.query('Description').value('.','NVARCHAR(MAX)') AS Description,
        X.Data.query('BudgetCost').value('.','FLOAT') AS BudgetCost,
        X.Data.query('ExpectedRevenue').value('.','FLOAT') AS ExpectedRevenue,
        X.Data.query('ExpectedSales').value('.','INT') AS ExpectedSales,
        X.Data.query('ExpectedROI').value('.','FLOAT') AS ExpectedROI,
        X.Data.query('ActualCost').value('.','FLOAT') AS ActualCost,
        X.Data.query('ExpectedResponse').value('.','VARCHAR(50)') AS ExpectedResponse,
        X.Data.query('ActualSales').value('.','INT') AS ActualSales,
        X.Data.query('ActualROI').value('.','FLOAT') AS ActualROI,
        X.Data.query('IsCommon').value('.','INT') AS IsCommon
INTO #CRMP2041
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]




--select * From #CRMP2041

INSERT INTO #Data ([Row], APK, DivisionID, CampaignID, CampaignName, AssignedToUserID, CampaignType, ExpectOpenDate, ExpectCloseDate, PlaceDate, CampaignStatus, InventoryID, Sponsor, Description ,BudgetCost, ExpectedRevenue, ExpectedSales, ExpectedROI, ActualCost, ExpectedResponse, ActualSales, ActualROI, IsCommon)
SELECT [Row], APK, DivisionID, CampaignID, CampaignName, AssignedToUserID, CampaignType, ExpectOpenDate, ExpectCloseDate, PlaceDate, CampaignStatus, InventoryID, Sponsor, Description ,BudgetCost, ExpectedRevenue, ExpectedSales, ExpectedROI, ActualCost, ExpectedResponse, ActualSales, ActualROI, IsCommon
FROM #CRMP2041





---- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

---- Kiểm tra dữ liệu detail
DECLARE @ColumnName1 VARCHAR(50),
        @ColName1 NVARCHAR(50),
        @Cur CURSOR,
        @CampaignID VARCHAR(50)

SELECT TOP 1 @ColumnName1 = DataCol, @ColName1 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'CampaignID'

---- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
                UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
                                 ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
        WHERE ErrorMessage <> ''
        GOTO LB_RESULT
END

DECLARE 
        @TableBusiness VARCHAR(10) = 'CRMT20401',
        @VoucherNo VARCHAR(50),
        @NewVoucherNo VARCHAR(50),
        @KeyString VARCHAR(50),
        @LastKey INT

---- BEGIN - Xử lý tăng số chứng từ tự động

SELECT DISTINCT [Row], [Row] AS NewVoucherNo
INTO #VoucherData
FROM #CRMP2041
ORDER BY [Row]

WHILE EXISTS (SELECT TOP 1 1 FROM #VoucherData)
BEGIN
    SELECT @VoucherNo = [Row] FROM #VoucherData

    --EXEC GetVoucherNo_Ver1 @DivisionID, 'CRM', 'AT0002', 'S1', @TableBusiness, 'CD', @NewVoucherNo OUTPUT, @KeyString OUTPUT, @LastKey OUTPUT
	EXEC GetVoucherNo_Ver2 @DivisionID, 'CRM', 'CRMF2041', @TableBusiness, @NewVoucherNo OUTPUT, @KeyString OUTPUT, @LastKey OUTPUT
	PRINT @NewVoucherNo

    -- Cập nhật số chứng từ vào bảng dữ liệu import từ Excel
	UPDATE #CRMP2041 SET CampaignID = @NewVoucherNo WHERE [Row] = @VoucherNo

    -- Cập nhật LastKey cho bảng đăng ký số chứng từ tự động
    UPDATE AT4444 SET LastKey = @LastKey WHERE TableName = @TableBusiness AND KeyString = @KeyString

    DELETE #VoucherData WHERE [Row] = @VoucherNo
END

---- END - Xử lý tăng số chứng từ tự động

-- Insert dữ liệu vào bảng Chiến dịch (CRMT20401)

INSERT INTO CRMT20401(APK, DivisionID, CampaignID, CampaignName, AssignedToUserID, CampaignType, ExpectOpenDate, ExpectCloseDate, PlaceDate, CampaignStatus, InventoryID, Sponsor, Description ,BudgetCost,
                      ExpectedRevenue, ExpectedSales, ExpectedROI, ActualCost, ExpectedResponse, ActualSales, ActualROI, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT DISTINCT APK, DivisionID, CampaignID, CampaignName, AssignedToUserID, CampaignType, ExpectOpenDate, ExpectCloseDate,PlaceDate, CampaignStatus, InventoryID, Sponsor, Description ,BudgetCost,
                      ExpectedRevenue, ExpectedSales, ExpectedROI, ActualCost, ExpectedResponse, ActualSales, ActualROI, IsCommon, @UserID, GETDATE(), @UserID, GETDATE()
FROM #CRMP2041

--- Insert dữ liệu vào bảng Người dùng và đối tượng liên quan - AT1103_REL
INSERT INTO AT1103_REL (RelatedToID, UserID, RelatedToTypeID)
SELECT DISTINCT APK, AssignedToUserID, 6
FROM #CRMP2041

--UPDATE AT4444 
--SET LastKey = (SELECT SUBSTRING(MAX(CampaignID), 4, 8) FROM CRMT20401)
--WHERE TableName = 'CRMT20401' AND KEYSTRING = 'CD'

LB_RESULT:
SELECT [Row], ErrorColumn, ErrorMessage FROM #Data
WHERE  ErrorColumn <> ''
ORDER BY [Row]













GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
