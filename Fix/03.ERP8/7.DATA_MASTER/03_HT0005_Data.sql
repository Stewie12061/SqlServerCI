-- <Summary>
---- 
-- <History>
---- Create on 05/12/2016 by Trương Ngọc Phương Thảo
---- Modified on ... by ...
---- <Example>

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S21')
	INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
	VALUES (N'S21', N'S21', N'Giảm trừ 21', N'Giảm trừ 21', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S21'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S21')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S22')
	INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S22','S22',N'Giảm trừ 22',N'Giảm trừ 22', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S22'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S22')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S23')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S23','S23',N'Giảm trừ 23',N'Giảm trừ 23', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S23'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S23')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S24')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S24','S24',N'Giảm trừ 24',N'Giảm trừ 24', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S24'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S24')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S25')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S25','S25',N'Giảm trừ 25',N'Giảm trừ 25', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S25'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S25')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S26')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S26','S26',N'Giảm trừ 26',N'Giảm trừ 26', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S26'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S26')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S27')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S27','S27',N'Giảm trừ 27',N'Giảm trừ 27', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S27'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S27')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S28')
	INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S28','S28',N'Giảm trừ 28',N'Giảm trừ 28', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S28'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S28')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S29')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S29','S29',N'Giảm trừ 29',N'Giảm trừ 29', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S29'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S29')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S30')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S30','S30',N'Giảm trừ 30',N'Giảm trừ 30', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S30'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S30')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S31')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S31','S31',N'Giảm trừ 31',N'Giảm trừ 31', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S31'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S31')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S32')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S32','S32',N'Giảm trừ 32',N'Giảm trừ 32', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S32'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S32')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S33')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S33','S33',N'Giảm trừ 33',N'Giảm trừ 33', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S33'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S33')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S34')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S34','S34',N'Giảm trừ 34',N'Giảm trừ 34', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S34'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S34')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S35')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S35','S35',N'Giảm trừ 35',N'Giảm trừ 35', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S35'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S35')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S36')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S36','S36',N'Giảm trừ 36',N'Giảm trừ 36', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S36'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S36')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S37')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S37','S37',N'Giảm trừ 37',N'Giảm trừ 37', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S37'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S37')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S38')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S38','S38',N'Giảm trừ 38',N'Giảm trừ 38', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S38'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S38')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S39')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S39','S39',N'Giảm trừ 39',N'Giảm trừ 39', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S39'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S39')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S40')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S40','S40',N'Giảm trừ 40',N'Giảm trừ 40', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S40'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S40')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S41')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S41','S41',N'Giảm trừ 41',N'Giảm trừ 41', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S41'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S41')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S42')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S42','S42',N'Giảm trừ 42',N'Giảm trừ 42', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S42'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S42')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S43')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S43','S43',N'Giảm trừ 43',N'Giảm trừ 43', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S43'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S43')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S44')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S44','S44',N'Giảm trừ 44',N'Giảm trừ 44', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S44'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S44')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S45')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S45','S45',N'Giảm trừ 45',N'Giảm trừ 45', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S45'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S45')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S46')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S46','S46',N'Giảm trừ 46',N'Giảm trừ 46', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S46'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S46')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S47')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S47','S47',N'Giảm trừ 47',N'Giảm trừ 47', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S47'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S47')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S48')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S48','S48',N'Giảm trừ 48',N'Giảm trừ 48', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S48'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S48')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S49')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S49','S49',N'Giảm trừ 49',N'Giảm trừ 49', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S49'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S49')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S50')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S50','S50',N'Giảm trừ 50',N'Giảm trừ 50', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S50'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S50')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S51')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S51','S51',N'Giảm trừ 51',N'Giảm trừ 51', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S51'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S51')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S52')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S52','S52',N'Giảm trừ 52',N'Giảm trừ 52', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S52'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S52')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S53')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S53','S53',N'Giảm trừ 53',N'Giảm trừ 53', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S53'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S53')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S54')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S54','S54',N'Giảm trừ 54',N'Giảm trừ 54', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S54'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S54')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S55')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S55','S55',N'Giảm trừ 55',N'Giảm trừ 55', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S55'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S55')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S56')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S56','S56',N'Giảm trừ 56',N'Giảm trừ 56', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S56'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S56')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S57')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S57','S57',N'Giảm trừ 57',N'Giảm trừ 57', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S57'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S57')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S58')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S58','S58',N'Giảm trừ 58',N'Giảm trừ 58', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S58'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S58')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S59')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S59','S59',N'Giảm trừ 59',N'Giảm trừ 59', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S59'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S59')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S60')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S60','S60',N'Giảm trừ 60',N'Giảm trừ 60', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S60'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S60')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S61')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S61','S61',N'Giảm trừ 61',N'Giảm trừ 61', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S61'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S61')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S62')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S62','S62',N'Giảm trừ 62',N'Giảm trừ 62', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S62'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S62')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S63')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S63','S63',N'Giảm trừ 63',N'Giảm trừ 63', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S63'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S63')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S64')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S64','S64',N'Giảm trừ 64',N'Giảm trừ 64', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S64'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S64')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S65')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S65','S65',N'Giảm trừ 65',N'Giảm trừ 65', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S65'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S65')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S66')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S66','S66',N'Giảm trừ 66',N'Giảm trừ 66', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S66'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S66')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S67')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S67','S67',N'Giảm trừ 67',N'Giảm trừ 67', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S67'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S67')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S68')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S68','S68',N'Giảm trừ 68',N'Giảm trừ 68', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S68'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S68')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S69')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S69','S69',N'Giảm trừ 69',N'Giảm trừ 69', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S69'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S69')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S70')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S70','S70',N'Giảm trừ 70',N'Giảm trừ 70', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S70'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S70')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S71')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S71','S71',N'Giảm trừ 71',N'Giảm trừ 71', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S71'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S71')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S72')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S72','S72',N'Giảm trừ 72',N'Giảm trừ 72', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S72'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S72')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S73')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S73','S73',N'Giảm trừ 73',N'Giảm trừ 73', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S73'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S73')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S74')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S74','S74',N'Giảm trừ 74',N'Giảm trừ 74', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S74'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S74')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S75')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S75','S75',N'Giảm trừ 75',N'Giảm trừ 75', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S75'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S75')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S76')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S76','S76',N'Giảm trừ 76',N'Giảm trừ 76', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S76'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S76')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S77')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S77','S77',N'Giảm trừ 77',N'Giảm trừ 77', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S77'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S77')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S78')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S78','S78',N'Giảm trừ 78',N'Giảm trừ 78', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S78'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S78')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S79')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S79','S79',N'Giảm trừ 79',N'Giảm trừ 79', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S79'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S79')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S80')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S80','S80',N'Giảm trừ 80',N'Giảm trừ 80', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S80'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S80')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S81')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S81','S81',N'Giảm trừ 81',N'Giảm trừ 81', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S81'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S81')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S82')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S82','S82',N'Giảm trừ 82',N'Giảm trừ 82', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S82'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S82')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S83')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S83','S83',N'Giảm trừ 83',N'Giảm trừ 83', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S83'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S83')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S84')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S84','S84',N'Giảm trừ 84',N'Giảm trừ 84', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S84'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S84')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S85')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S85','S85',N'Giảm trừ 85',N'Giảm trừ 85', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S85'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S85')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S86')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S86','S86',N'Giảm trừ 86',N'Giảm trừ 86', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S86'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S86')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S87')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S87','S87',N'Giảm trừ 87',N'Giảm trừ 87', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S87'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S87')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S88')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S88','S88',N'Giảm trừ 88',N'Giảm trừ 88', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S88'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S88')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S89')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S89','S89',N'Giảm trừ 89',N'Giảm trừ 89', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S89'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S89')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S90')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S90','S90',N'Giảm trừ 90',N'Giảm trừ 90', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S90'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S90')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S91')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S91','S91',N'Giảm trừ 91',N'Giảm trừ 91', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S91'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S91')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S92')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S92','S92',N'Giảm trừ 92',N'Giảm trừ 92', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S92'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S92')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S93')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S93','S93',N'Giảm trừ 93',N'Giảm trừ 93', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S93'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S93')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S94')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S94','S94',N'Giảm trừ 94',N'Giảm trừ 94', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S94'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S94')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S95')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S95','S95',N'Giảm trừ 95',N'Giảm trừ 95', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S95'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S95')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S96')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S96','S96',N'Giảm trừ 96',N'Giảm trừ 96', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S96'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S96')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S97')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S97','S97',N'Giảm trừ 97',N'Giảm trừ 97', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S97'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S97')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S98')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S98','S98',N'Giảm trừ 98',N'Giảm trừ 98', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S98'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S98')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S99')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S99','S99',N'Giảm trừ 99',N'Giảm trừ 99', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S99'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S99')

IF NOT EXISTS(SELECT TOP 1 1 FROM HT0005STD WHERE SubID = N'S100')
	 INSERT INTO HT0005STD(SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome) 
	VALUES ('S100','S100',N'Giảm trừ 100',N'Giảm trừ 100', 0, 0, NULL, NULL, 0, NULL, NULL, 0)
INSERT INTO HT0005(APK, DivisionID, SubID, FieldName, SubName, Caption, IsTranfer, IsUsed, SourceFieldName, SourceTableName, IsTax, CaptionE, SubNameE, IsCalculateNetIncome)
SELECT NEWID(), A00.DefDivisionID, STD.SubID, STD.FieldName, STD.SubName, STD.Caption, STD.IsTranfer, STD.IsUsed, STD.SourceFieldName, STD.SourceTableName, STD.IsTax, STD.CaptionE, SubNameE, STD.IsCalculateNetIncome
FROM HT0005STD STD CROSS JOIN (SELECT DISTINCT DefDivisionID FROM AT0000) A00
WHERE STD.SubID = 'S100'
    AND NOT EXISTS(SELECT TOP 1 1 FROM HT0005 WHERE DivisionID = A00.DefDivisionID AND SubID = 'S100')
