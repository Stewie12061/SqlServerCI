-- <Summary>
---- Dữ liệu ngầm định nghĩa các loại chi phí sản xuất (Asoft-M)
-- <History>
---- Create on 16/03/2018 by Minh Kim: Them 20 loai chi phi SXC
---- Modified on
---- Modified on 22/09/2022 by Xuân Nguyên: Thêm 20 loai chi phí NVL/NC
--------------chi phi SXC-------------

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST003' and MaterialTypeID = 'O11')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'O11', 'COST003', 0, N'SXC 11'
FROM AT1101

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST003' and MaterialTypeID='O12')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID,'O12','COST003',0,N'SXC 12'
FROM AT1101

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST003' and MaterialTypeID = 'O13')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'O13', 'COST003', 0, N'SXC 13'
FROM AT1101

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST003' and MaterialTypeID = 'O14')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'O14', 'COST003', 0, N'SXC 14'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST003' and MaterialTypeID = 'O15')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'O15', 'COST003', 0, N'SXC 15'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST003' and MaterialTypeID = 'O16')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'O16', 'COST003', 0, N'SXC 16'
FROM AT1101
go 

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST003' and MaterialTypeID = 'O17')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'O17', 'COST003', 0, N'SXC 17'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST003' and MaterialTypeID = 'O18')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'O18', 'COST003', 0, N'SXC 18'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST003' and MaterialTypeID = 'O19')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'O19', 'COST003', 0, N'SXC 19'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST003' and MaterialTypeID = 'O20')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'O20', 'COST003', 0, N'SXC 20'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST003' and MaterialTypeID = 'O21')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'O21', 'COST003', 0, N'SXC 21'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST003' and MaterialTypeID = 'O22')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'O22', 'COST003', 0, N'SXC 22'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST003' and MaterialTypeID = 'O23')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'O23', 'COST003', 0, N'SXC 23'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST003' and MaterialTypeID = 'O24')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'O24', 'COST003', 0, N'SXC 24'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST003' and MaterialTypeID = 'O25')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'O25', 'COST003', 0, N'SXC 25'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST003' and MaterialTypeID = 'O26')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'O26', 'COST003', 0, N'SXC 26'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST003' and MaterialTypeID = 'O27')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'O27', 'COST003', 0, N'SXC 27'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST003' and MaterialTypeID = 'O28')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'O28', 'COST003', 0, N'SXC 28'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST003' and MaterialTypeID = 'O29')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'O29', 'COST003', 0, N'SXC 29'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST003' and MaterialTypeID = 'O30')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'O30', 'COST003', 0, N'SXC 30'
FROM AT1101
go

--------------chi phi NVL-------------

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST001' and MaterialTypeID = 'M11')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'M11', 'COST001', 0, N'NVL 11'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST001' and MaterialTypeID = 'M12')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'M12', 'COST001', 0, N'NVL 12'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST001' and MaterialTypeID = 'M13')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'M13', 'COST001', 0, N'NVL 13'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST001' and MaterialTypeID = 'M14')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'M14', 'COST001', 0, N'NVL 14'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST001' and MaterialTypeID = 'M15')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'M15', 'COST001', 0, N'NVL 15'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST001' and MaterialTypeID = 'M16')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'M16', 'COST001', 0, N'NVL 16'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST001' and MaterialTypeID = 'M17')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'M17', 'COST001', 0, N'NVL 17'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST001' and MaterialTypeID = 'M18')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'M18', 'COST001', 0, N'NVL 18'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST001' and MaterialTypeID = 'M19')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'M19', 'COST001', 0, N'NVL 19'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST001' and MaterialTypeID = 'M20')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'M20', 'COST001', 0, N'NVL 20'
FROM AT1101
go


IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST001' and MaterialTypeID = 'M21')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'M21', 'COST001', 0, N'NVL 21'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST001' and MaterialTypeID = 'M22')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'M22', 'COST001', 0, N'NVL 22'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST001' and MaterialTypeID = 'M23')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'M23', 'COST001', 0, N'NVL 23'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST001' and MaterialTypeID = 'M24')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'M24', 'COST001', 0, N'NVL 24'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST001' and MaterialTypeID = 'M25')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'M25', 'COST001', 0, N'NVL 25'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST001' and MaterialTypeID = 'M26')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'M26', 'COST001', 0, N'NVL 26'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST001' and MaterialTypeID = 'M27')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'M27', 'COST001', 0, N'NVL 27'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST001' and MaterialTypeID = 'M28')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'M28', 'COST001', 0, N'NVL 28'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST001' and MaterialTypeID = 'M29')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'M29', 'COST001', 0, N'NVL 29'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST001' and MaterialTypeID = 'M30')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'M30', 'COST001', 0, N'NVL 30'
FROM AT1101
go

--------------chi phi NC-------------
IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST002' and MaterialTypeID = 'H11')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'H11', 'COST002', 0, N'NC 11'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST002' and MaterialTypeID = 'H12')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'H12', 'COST002', 0, N'NC 12'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST002' and MaterialTypeID = 'H13')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'H13', 'COST002', 0, N'NC 13'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST002' and MaterialTypeID = 'H14')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'H14', 'COST002', 0, N'NC 14'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST002' and MaterialTypeID = 'H15')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'H15', 'COST002', 0, N'NC 15'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST002' and MaterialTypeID = 'H16')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'H16', 'COST002', 0, N'NC 16'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST002' and MaterialTypeID = 'H17')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'H17', 'COST002', 0, N'NC 17'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST002' and MaterialTypeID = 'H18')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'H18', 'COST002', 0, N'NC 18'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST002' and MaterialTypeID = 'H19')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'H19', 'COST002', 0, N'NC 19'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST002' and MaterialTypeID = 'H20')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'H20', 'COST002', 0, N'NC 20'
FROM AT1101
go
IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST002' and MaterialTypeID = 'H11')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'H11', 'COST002', 0, N'NC 11'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST002' and MaterialTypeID = 'H12')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'H12', 'COST002', 0, N'NC 12'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST002' and MaterialTypeID = 'H13')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'H13', 'COST002', 0, N'NC 13'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST002' and MaterialTypeID = 'H14')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'H14', 'COST002', 0, N'NC 14'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST002' and MaterialTypeID = 'H15')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'H15', 'COST002', 0, N'NC 15'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST002' and MaterialTypeID = 'H16')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'H16', 'COST002', 0, N'NC 16'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST002' and MaterialTypeID = 'H17')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'H17', 'COST002', 0, N'NC 17'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST002' and MaterialTypeID = 'H18')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'H18', 'COST002', 0, N'NC 18'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST002' and MaterialTypeID = 'H19')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'H19', 'COST002', 0, N'NC 19'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST002' and MaterialTypeID = 'H20')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'H20', 'COST002', 0, N'NC 20'
FROM AT1101
go
IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST002' and MaterialTypeID = 'H21')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'H21', 'COST002', 0, N'NC 21'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST002' and MaterialTypeID = 'H22')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'H22', 'COST002', 0, N'NC 22'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST002' and MaterialTypeID = 'H23')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'H23', 'COST002', 0, N'NC 23'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST002' and MaterialTypeID = 'H24')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'H24', 'COST002', 0, N'NC 24'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST002' and MaterialTypeID = 'H25')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'H25', 'COST002', 0, N'NC 25'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST002' and MaterialTypeID = 'H26')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'H26', 'COST002', 0, N'NC 26'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST002' and MaterialTypeID = 'H27')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'H27', 'COST002', 0, N'NC 27'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST002' and MaterialTypeID = 'H28')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'H28', 'COST002', 0, N'NC 28'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST002' and MaterialTypeID = 'H29')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'H29', 'COST002', 0, N'NC 29'
FROM AT1101
go

IF NOT EXISTS (SELECT TOP 1 1 FROM MT0699 WHERE ExpenseID = 'COST002' and MaterialTypeID = 'H30')
INSERT INTO MT0699 (DivisionID, MaterialTypeID, ExpenseID, IsUsed, SystemName)
SELECT AT1101.DivisionID, 'H30', 'COST002', 0, N'NC 30'
FROM AT1101
go