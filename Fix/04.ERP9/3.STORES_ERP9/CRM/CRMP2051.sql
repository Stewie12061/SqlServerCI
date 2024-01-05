IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2051]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP2051]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO











-- <Summary>
---- Import Excel nghiệp vụ Cơ hội module CRM
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Trọng Kiên: + on 25/08/2020
----                        + on 08/09/2020: Bổ sung tính năng tăng mã tự động
---- Modified by Hoài Bảo on 06/09/2022: Cập nhật lấy mã chứng từ tự động theo version 2
-- <Example>

CREATE PROCEDURE CRMP2051
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
	PRINT @ColID
    SET @sSQL = 'ALTER TABLE #Data ADD ' + @ColID + ' ' + @ColSQLDataType + CASE WHEN @ColSQLDataType LIKE '%char%' THEN ' COLLATE SQL_Latin1_General_CP1_CI_AS' ELSE '' END + ' NULL'
    PRINT @sSQL
    EXEC (@sSQL)
    FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
END
CLOSE @cCURSOR


SELECT  X.Data.query('OrderNo').value('.', 'INT') AS [Row],
        X.Data.query('DivisionID').value('.', 'VARCHAR(50)') AS DivisionID,
        X.Data.query('OpportunityID').value('.','VARCHAR(50)') AS OpportunityID,
        X.Data.query('OpportunityName').value('.','NVARCHAR(MAX)') AS OpportunityName,
        X.Data.query('StageID').value('.','NVARCHAR(250)') AS StageID,
        X.Data.query('CampaignID').value('.','VARCHAR(50)') AS CampaignID,
        X.Data.query('AccountID').value('.','VARCHAR(50)') AS AccountID,
        CASE WHEN X.Data.query('ExpectAmount').value('.','VARCHAR(50)') = '' THEN CONVERT(DECIMAL(28), 0) ELSE X.Data.query('ExpectAmount').value('.','DECIMAL(28)') END AS ExpectAmount,
        X.Data.query('PriorityID').value('.','INT') AS PriorityID,
        X.Data.query('CauseID').value('.','VARCHAR(50)') AS CauseID,
        X.Data.query('Notes').value('.','VARCHAR(MAX)') AS Notes,
        X.Data.query('AssignedToUserID').value('.','NVARCHAR(250)') AS AssignedToUserID,
        X.Data.query('StartDate').value('.','VARCHAR(50)') AS StartDate,
        X.Data.query('ExpectedCloseDate').value('.','VARCHAR(50)') AS ExpectedCloseDate,
		CASE WHEN  X.Data.query('Rate').value('.','VARCHAR(50)') = '' THEN CONVERT(DECIMAL(28), 0) ELSE  X.Data.query('Rate').value('.','DECIMAL(28)') END AS Rate,
        X.Data.query('NextActionID').value('.','VARCHAR(50)') AS NextActionID,
        X.Data.query('NextActionDate').value('.','VARCHAR(50)') AS NextActionDate,
        X.Data.query('SourceID').value('.','VARCHAR(50)') AS SourceID,
		X.Data.query('IsCommon').value('.','INT') AS IsCommon
INTO #CRMP2051
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

INSERT INTO #Data ([Row], DivisionID, OpportunityID, OpportunityName, StageID, CampaignID, AccountID, ExpectAmount, PriorityID, CauseID, Notes, AssignedToUserID, StartDate, ExpectedCloseDate, Rate, NextActionID, NextActionDate, SourceID, IsCommon)
SELECT [Row], DivisionID, OpportunityID, OpportunityName, StageID, CampaignID, AccountID, ExpectAmount, PriorityID, CauseID, Notes, AssignedToUserID, StartDate, ExpectedCloseDate, Rate, NextActionID, NextActionDate, SourceID, IsCommon
FROM #CRMP2051

---- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

---- Kiểm tra dữ liệu detail
DECLARE @ColumnName1 VARCHAR(50),
        @ColName1 NVARCHAR(50),
        @Cur CURSOR,
        @OpportunityID VARCHAR(50)

SELECT TOP 1 @ColumnName1 = DataCol, @ColName1 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'OpportunityID'

---- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
        UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
                         ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
        WHERE ErrorMessage <> ''
        GOTO LB_RESULT
END

DECLARE 
        @TableBusiness VARCHAR(10) = 'CRMT20501',
        @VoucherNo VARCHAR(50),
        @NewVoucherNo VARCHAR(50),
        @KeyString VARCHAR(50),
        @LastKey INT,
		@ColumnSetting VARCHAR(50)

---- BEGIN - Xử lý tăng số chứng từ tự động

SELECT DISTINCT [Row], [Row] AS NewVoucherNo
INTO #VoucherData
FROM #CRMP2051
ORDER BY [Row]

--SET  @ColumnSetting = (SELECT  S1 FROM AT0002 WHERE TableID = @TableBusiness AND TypeID = 'OPP')

WHILE EXISTS (SELECT TOP 1 1 FROM #VoucherData)
BEGIN
     SELECT @VoucherNo = [Row] FROM #VoucherData

    --EXEC GetVoucherNo_Ver1 @DivisionID, 'CRM', 'AT0002', 'S1', @TableBusiness, @ColumnSetting, @NewVoucherNo OUTPUT, @KeyString OUTPUT, @LastKey OUTPUT
	EXEC GetVoucherNo_Ver2 @DivisionID, 'CRM', 'CRMF2051', @TableBusiness, @NewVoucherNo OUTPUT, @KeyString OUTPUT, @LastKey OUTPUT
	PRINT @NewVoucherNo
    -- Cập nhật số chứng từ vào bảng dữ liệu import từ Excel
    UPDATE #CRMP2051 SET OpportunityID = @NewVoucherNo WHERE [Row] = @VoucherNo
    -- Cập nhật LastKey cho bảng đăng ký số chứng từ tự động
    UPDATE AT4444 SET LastKey = @LastKey WHERE TableName = @TableBusiness AND KeyString = @KeyString

    DELETE #VoucherData WHERE [Row] = @VoucherNo
END
---- END - Xử lý tăng số chứng từ tự động

-- Insert dữ liệu vào bảng Cơ hội (CRMT20501)
INSERT INTO CRMT20501(DivisionID, OpportunityID, OpportunityName, StageID, CampaignID, AccountID, ExpectAmount, PriorityID, CauseID, Notes, AssignedToUserID, 
                     StartDate, ExpectedCloseDate, Rate, NextActionID, NextActionDate, SourceID, IsCommon, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT DISTINCT DivisionID, OpportunityID, OpportunityName, StageID, CampaignID, AccountID, ExpectAmount, PriorityID, CauseID, Notes, AssignedToUserID, 
                     StartDate, ExpectedCloseDate, Rate, NextActionID, NextActionDate, SourceID, IsCommon, @UserID, GETDATE(), @UserID, GETDATE()
FROM #CRMP2051

--UPDATE AT4444 
--SET LastKey = (SELECT SUBSTRING(MAX(OpportunityID), 4, 8) FROM CRMT20501)
--WHERE TableName = 'CRMT20501' AND KEYSTRING = 'S'

LB_RESULT:
SELECT [Row], ErrorColumn, ErrorMessage FROM #Data
WHERE  ErrorColumn <> ''
ORDER BY [Row]

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
