IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP1155]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP1155]
GO
/****** Object:  StoredProcedure [dbo].[CIP1155]    Script Date: 12/4/2020 7:55:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- <Summary>
---- Import Excel danh mục máy
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by nhttai 2/12/2020
---- Modified by Le Hoang on 24/02/2021 : bổ sung kiểm tra đồng nhất dữ liệu
---- Modified by on
-- <Example>

CREATE PROCEDURE [dbo].[CIP1155]
(
    @DivisionID VARCHAR(50),
    @UserID VARCHAR(50),
    @ImportTransTypeID VARCHAR(50),
    @XML XML
) 
AS
BEGIN
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
    SET @sSQL = 'ALTER TABLE #Data ADD ' + @ColID + ' ' + @ColSQLDataType + CASE WHEN @ColSQLDataType LIKE '%char%' THEN ' COLLATE SQL_Latin1_General_CP1_CI_AS' ELSE '' END + ' NULL'
    PRINT @sSQL
    EXEC (@sSQL)
    FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
END
CLOSE @cCURSOR


SELECT  X.Data.query('OrderNo').value('.', 'INT') AS [Row],
        X.Data.query('DivisionID').value('.', 'VARCHAR(50)') AS DivisionID,
        X.Data.query('MachineID').value('.','VARCHAR(50)') AS MachineID,
        X.Data.query('MachineName').value('.','NVARCHAR(250)') AS MachineName,
        X.Data.query('MachineNameE').value('.','NVARCHAR(250)') AS MachineNameE,
        X.Data.query('DepartmentID').value('.','VARCHAR(50)') AS DepartmentID,
        X.Data.query('Model').value('.','VARCHAR(250)') AS Model,
        X.Data.query('Year').value('.','INT') AS Year,
        X.Data.query('StartDate').value('.','DATETIME') AS StartDate,
        X.Data.query('Notes').value('.','NVARCHAR(MAX)') AS Notes,
        X.Data.query('Disabled').value('.','INT') AS Disabled,
        X.Data.query('StandardID').value('.','VARCHAR(50)') AS StandardID,
        X.Data.query('NotesStandard').value('.','NVARCHAR(MAX)') AS NotesStandard,
        X.Data.query('DisabledStandard').value('.','INT') AS DisabledStandard
INTO #CIP1155
FROM @XML.nodes('//Data') AS X (Data)
ORDER BY [Row]

 INSERT INTO #Data ([Row],  DivisionID, MachineID, MachineName, MachineNameE, DepartmentID, Model, Year, StartDate, Notes,Disabled,StandardID,NotesStandard,DisabledStandard)
 SELECT [Row], DivisionID, MachineID, MachineName, MachineNameE, DepartmentID, Model, Year, StartDate, Notes,Disabled,StandardID,NotesStandard,DisabledStandard
 FROM #CIP1155
--SELECT * from #Data

---- Kiểm tra check code mặc định
EXEC CMNP8105 @ImportTemplateID = @ImportTransTypeID, @UserID = @UserID

---- Kiểm tra dữ liệu không đồng nhất tại phần master 
EXEC CMNP8100 @UserID = @UserID, @ImportTemplateID = @ImportTransTypeID, @CheckCode = 'CheckIdenticalValues', @Module = 'ASOFT-QC', @ColID = 'MachineID', 
@Param1 = 'MachineID, MachineName, MachineNameE, DepartmentID, Model, Year, StartDate, Notes, Disabled'

---- Kiểm tra dữ liệu detail
DECLARE @ColumnName1 VARCHAR(50),
        @ColName1 NVARCHAR(50),
        @Cur CURSOR,
        @MachineID VARCHAR(50)

SELECT TOP 1 @ColumnName1 = DataCol, @ColName1 = ColName
FROM A00065 WITH (NOLOCK)
WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'MachineID'

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT MachineID FROM #Data

OPEN @Cur
FETCH NEXT FROM @Cur INTO @MachineID

WHILE @@FETCH_STATUS = 0
BEGIN

    ---- Kiểm tra trùng mã mã máy
    IF EXISTS (SELECT TOP  1 1 FROM CIT1150 WITH (NOLOCK) WHERE MachineID = @MachineID)
    BEGIN
        UPDATE #Data 
        SET ErrorMessage = @ColumnName1 + LTRIM(RTRIM(STR([Row]))) +'-CIFML000002,',
                ErrorColumn = @ColName1 + ','
    END

    FETCH NEXT FROM @Cur INTO @MachineID
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

DECLARE @OutputMachineAPK TABLE (APK NVARCHAR(250),MachineID NVARCHAR(250))
-- Insert dữ liệu vào bảng Master (CIT1150)

INSERT INTO CIT1150(APK, DivisionID, MachineID, MachineName, MachineNameE, DepartmentID, Model, Year, StartDate, Notes,Disabled, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
OUTPUT INSERTED.APK,INSERTED.MachineID INTO @OutputMachineAPK(APK, MachineID)
select NEWID() as APK, DataMachineID.*
from 
(
SELECT DISTINCT DivisionID, MachineID, MachineName, MachineNameE, DepartmentID, Model, CASE WHEN Year = 0 THEN null ELSE Year END as 'Year', NULLIF(StartDate, '') as StartDate, Notes, Disabled, @UserID as CreateUserID, GETDATE() as CreateDate, @UserID as LastModifyUserID, GETDATE() as LastModifyDate
FROM #Data
) as DataMachineID

INSERT INTO CIT00003(APK,DivisionID,HistoryID,Description,RelatedToID,RelatedToTypeID,CreateDate,CreateUserID,StatusID,ScreenID,TableID)
SELECT NEWID() AS APK, @DivisionID AS DivisionID, NULL AS HistoryID, 
'''A00.AddNew'' ''A00.CIT1150''</br>''A00.AddNew'' ''A00.CIT1151''</br>' AS Description, 
APK AS RelatedToID, 47 AS RelatedToTypeID, GETDATE() AS CreateDate, @UserID AS CreateUserID, 
1 AS StatusID, 'CIF1371' AS ScreenID, 'CIT1150' AS TableID
FROM @OutputMachineAPK

-- Lưu nguoi theo doi
INSERT INTO QCT9020(DivisionID,APKMaster,RelatedToID,TableID,FollowerID01,FollowerName01,TypeFollow,CreateDate,CreateUserID,RelatedToTypeID)
SELECT @DivisionID, A.APK, NULL, 'CIT1150', @UserID, (SELECT TOP 1 FullName FROM AT1103 WHERE EmployeeID = @UserID), 0, GETDATE(), @UserID, 0
FROM @OutputMachineAPK A

--select * from @OutputMachineAPK
IF @@ROWCOUNT >0
Begin
INSERT INTO CIT1151( DivisionID, MachineID, StandardID, Notes, Disabled,CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
SELECT  DivisionID, DataOut.APK , StandardID, NotesStandard, DisabledStandard, @UserID, GETDATE(), @UserID, GETDATE()
FROM #Data DataIN
join @OutputMachineAPK DataOut on DataOut.MachineID = DataIN.MachineID
where StandardID !='' and  StandardID is not null
End

--SELECT * from #Data

UPDATE AT4444 
SET LastKey = (SELECT SUBSTRING(MAX(MachineID), 4, 8) FROM CIT1150)
WHERE TableName = 'CIT1150' AND KEYSTRING = 'MCV'   

LB_RESULT:
SELECT [Row], ErrorColumn, ErrorMessage FROM #Data
WHERE  ErrorColumn <> ''
ORDER BY [Row]


END