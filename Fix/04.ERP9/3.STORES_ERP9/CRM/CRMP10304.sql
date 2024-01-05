IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP10304]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP10304]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
---- Import Excel danh sách người nhận email
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Tấn Lộc on 30/11/2020
-- <Example>

CREATE PROCEDURE CRMP10304
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
    PRINT @sSQL
    EXEC (@sSQL)
    FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
END
CLOSE @cCURSOR

SELECT  X.Data.query('OrderNo').value('.', 'INT') AS [Row],
        NEWID() AS APK,
        X.Data.query('DivisionID').value('.', 'VARCHAR(50)') AS DivisionID,
        X.Data.query('GroupReceiverID').value('.','VARCHAR(50)') AS GroupReceiverID,
        X.Data.query('Prefix').value('.','NVARCHAR(250)') AS Prefix,
        X.Data.query('FirstName').value('.','NVARCHAR(MAX)') AS FirstName,
        X.Data.query('LastName').value('.','NVARCHAR(MAX)') AS LastName,
        X.Data.query('ReceiverName').value('.','NVARCHAR(MAX)') AS ReceiverName,
        X.Data.query('Email').value('.','NVARCHAR(MAX)') AS Email,
        X.Data.query('Address').value('.','NVARCHAR(MAX)') AS Address,
        X.Data.query('Mobile').value('.','VARCHAR(250)') AS Mobile
INTO #CRMP10304
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

-- Tạo bảng giả #Data để check dữ liệu, Dữ liệu bảng #Data được clone ra từ bảng #CRMP10304
INSERT INTO #Data ([Row], APK, DivisionID, GroupReceiverID, Prefix, FirstName, LastName, ReceiverName, Email, Address, Mobile)
SELECT [Row], APK, DivisionID, GroupReceiverID, Prefix, FirstName, LastName, ReceiverName, Email, Address, Mobile
FROM #CRMP10304

---- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

---- Kiểm tra dữ liệu detail
DECLARE @ColumnName1 VARCHAR(50),
        @ColName1 NVARCHAR(50),
        @Cur CURSOR,
        @Email VARCHAR(50),
        @GroupReceiverID VARCHAR(50)

SELECT TOP 1 @ColumnName1 = DataCol, @ColName1 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'Email'

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT Email, GroupReceiverID FROM #Data

OPEN @Cur
FETCH NEXT FROM @Cur INTO @Email, @GroupReceiverID
WHILE @@FETCH_STATUS = 0
BEGIN
	---- Kiểm tra trùng Email
	IF EXISTS (SELECT TOP  1 1 FROM CRMT10302 WITH (NOLOCK) WHERE Email = @Email AND GroupReceiverID = @GroupReceiverID)
		BEGIN
			UPDATE #Data 
			SET	ErrorMessage = @ColumnName1 + LTRIM(RTRIM(STR([Row]))) +'-SFML000077,',
					ErrorColumn = @ColName1 + ','
		END
	FETCH NEXT FROM @Cur INTO @Email, @GroupReceiverID
END

CLOSE @Cur

---- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ErrorMessage <> '')
BEGIN
        UPDATE #Data SET ErrorMessage = LEFT(ErrorMessage, LEN(ErrorMessage) -1),
                         ErrorColumn = LEFT(ErrorColumn, LEN(ErrorColumn) -1)
        WHERE ErrorMessage <> ''
        GOTO LB_RESULT
END

-- Insert dữ liệu vào bảng danh sách người nhận email (CRMT10302)
INSERT INTO CRMT10302(APK, DivisionID, APKGroupReceiverEmail, GroupReceiverID, Prefix, FirstName, LastName, ReceiverName, Email, Address, Mobile
						,RelatedToTypeID_REL, RelatedToTypeName, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT DISTINCT T1.APK, T1.DivisionID, C1.APK AS APKGroupReceiverEmail, T1.GroupReceiverID, T1.Prefix, T1.FirstName, T1.LastName, T1.ReceiverName, T1.Email, T1.Address, T1.Mobile
						,'4' AS RelatedToTypeID_REL, 'Import' AS RelatedToTypeName,  @UserID, GETDATE(), @UserID, GETDATE()
FROM #CRMP10304 T1
	INNER JOIN CRMT10301 C1 WITH (NOLOCK) ON T1.DivisionID = C1.DivisionID AND T1.GroupReceiverID = C1.GroupReceiverID

---- Insert dữ liệu vào bảng danh sách người nhận email (CRMT10303)
--INSERT INTO CRMT10303(APKCRMT10302, GroupReceiverID, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
--SELECT T1.APK, T1.GroupReceiverID, @UserID, GETDATE(), @UserID, GETDATE()
--FROM #CRMP10304 T1

LB_RESULT:
SELECT [Row], ErrorColumn, ErrorMessage FROM #Data
WHERE  ErrorColumn <> ''
ORDER BY [Row]







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
