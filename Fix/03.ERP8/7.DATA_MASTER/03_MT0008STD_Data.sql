-- <Summary>
---- 
-- <History>
---- Create  on 04/09/2015 by Tiểu Mai: Tham số kết quả sản xuất
---- Modified by Tiểu Mai on 03/03/2016: Bổ sung 20 tham số tổng hợp và 20 tham số chi tiết
---- <Example>
---- Add Data

---- Tham số Kết quả sản xuất thành phẩm
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'MD01') INSERT INTO MT0008STD (TypeID, SystemName, SystemNameE, IsUsed) values ('MD01'	,N'M01 - Tham số 01',N'Parameter 01',0)

IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'MD02') INSERT INTO MT0008STD (TypeID, SystemName, SystemNameE, IsUsed) values ('MD02',	N'M02 - Tham số 02',N'Parameter 02',0)

IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'MD03') INSERT INTO MT0008STD (TypeID, SystemName, SystemNameE, IsUsed) values ('MD03',	N'M03 - Tham số 03',N'Parameter 03',0)

IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'MD04') INSERT INTO MT0008STD (TypeID, SystemName, SystemNameE, IsUsed) values ('MD04',	N'M04 - Tham số 04',N'Parameter 04',0)

IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'MD05') INSERT INTO MT0008STD (TypeID, SystemName, SystemNameE, IsUsed) values ('MD05',	N'M05 - Tham số 05',N'Parameter 05',0)

IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'MD06') INSERT INTO MT0008STD (TypeID, SystemName, SystemNameE, IsUsed) values ('MD06',	N'M06 - Tham số 06',N'Parameter 06',0)

IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'MD07') INSERT INTO MT0008STD (TypeID, SystemName, SystemNameE, IsUsed) values ('MD07',	N'M07 - Tham số 07',N'Parameter 07',0)

IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'MD08') INSERT INTO MT0008STD (TypeID, SystemName, SystemNameE, IsUsed) values ('MD08',	N'M08 - Tham số 08',N'Parameter 08',0)

IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'MD09') INSERT INTO MT0008STD (TypeID, SystemName, SystemNameE, IsUsed) values ('MD09',	N'M09 - Tham số 09',N'Parameter 09',0)

IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'MD10') INSERT INTO MT0008STD (TypeID, SystemName, SystemNameE, IsUsed) values ('MD10',	N'M10 - Tham số 10',N'Parameter 10',0)


IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'MC01') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'MC01', N'M01 - Tham số 01', N'M01 - Tham số 01', N'M01 - Parameter 01', N'M01 - Parameter 01', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'MC02') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'MC02', N'M02 - Tham số 02', N'M02 - Tham số 02', N'M02 - Parameter 02', N'M02 - Parameter 02', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'MC03') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'MC03', N'M03 - Tham số 03', N'M03 - Tham số 03', N'M03 - Parameter 03', N'M03 - Parameter 03', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'MC04') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'MC04', N'M04 - Tham số 04', N'M04 - Tham số 04', N'M04 - Parameter 04', N'M04 - Parameter 04', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'MC05') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'MC05', N'M05 - Tham số 05', N'M05 - Tham số 05', N'M05 - Parameter 05', N'M05 - Parameter 05', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'MC06') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'MC06', N'M06 - Tham số 06', N'M06 - Tham số 06', N'M06 - Parameter 06', N'M06 - Parameter 06', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'MC07') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'MC07', N'M07 - Tham số 07', N'M07 - Tham số 07', N'M07 - Parameter 07', N'M07 - Parameter 07', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'MC08') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'MC08', N'M08 - Tham số 08', N'M08 - Tham số 08', N'M08 - Parameter 08', N'M08 - Parameter 08', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'MC09') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'MC09', N'M09 - Tham số 09', N'M09 - Tham số 09', N'M09 - Parameter 09', N'M09 - Parameter 09', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'MC10') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'MC10', N'M10 - Tham số 10', N'M10 - Tham số 10', N'M10 - Parameter 10', N'M10 - Parameter 10', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'MC11') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'MC11', N'M11 - Tham số 11', N'M11 - Tham số 11', N'M11 - Parameter 11', N'M11 - Parameter 11', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'MC12') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'MC12', N'M12 - Tham số 12', N'M12 - Tham số 12', N'M12 - Parameter 12', N'M12 - Parameter 12', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'MC13') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'MC13', N'M13 - Tham số 13', N'M13 - Tham số 13', N'M13 - Parameter 13', N'M13 - Parameter 13', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'MC14') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'MC14', N'M14 - Tham số 14', N'M14 - Tham số 14', N'M14 - Parameter 14', N'M14 - Parameter 14', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'MC15') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'MC15', N'M15 - Tham số 15', N'M15 - Tham số 15', N'M15 - Parameter 15', N'M15 - Parameter 15', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'MC16') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'MC16', N'M16 - Tham số 16', N'M16 - Tham số 16', N'M16 - Parameter 16', N'M16 - Parameter 16', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'MC17') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'MC17', N'M17 - Tham số 17', N'M17 - Tham số 17', N'M17 - Parameter 17', N'M17 - Parameter 17', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'MC18') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'MC18', N'M18 - Tham số 18', N'M18 - Tham số 18', N'M18 - Parameter 18', N'M18 - Parameter 18', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'MC19') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'MC19', N'M19 - Tham số 19', N'M19 - Tham số 19', N'M19 - Parameter 19', N'M19 - Parameter 19', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'MC20') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'MC20', N'M20 - Tham số 20', N'M20 - Tham số 20', N'M20 - Parameter 20', N'M20 - Parameter 20', 0)

IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'DC01') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'DC01', N'D01 - Tham số 01', N'D01 - Tham số 01', N'D01 - Parameter 01', N'D01 - Parameter 01', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'DC02') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'DC02', N'D02 - Tham số 02', N'D02 - Tham số 02', N'D02 - Parameter 02', N'D02 - Parameter 02', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'DC03') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'DC03', N'D03 - Tham số 03', N'D03 - Tham số 03', N'D03 - Parameter 03', N'D03 - Parameter 03', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'DC04') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'DC04', N'D04 - Tham số 04', N'D04 - Tham số 04', N'D04 - Parameter 04', N'D04 - Parameter 04', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'DC05') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'DC05', N'D05 - Tham số 05', N'D05 - Tham số 05', N'D05 - Parameter 05', N'D05 - Parameter 05', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'DC06') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'DC06', N'D06 - Tham số 06', N'D06 - Tham số 06', N'D06 - Parameter 06', N'D06 - Parameter 06', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'DC07') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'DC07', N'D07 - Tham số 07', N'D07 - Tham số 07', N'D07 - Parameter 07', N'D07 - Parameter 07', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'DC08') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'DC08', N'D08 - Tham số 08', N'D08 - Tham số 08', N'D08 - Parameter 08', N'D08 - Parameter 08', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'DC09') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'DC09', N'D09 - Tham số 09', N'D09 - Tham số 09', N'D09 - Parameter 09', N'D09 - Parameter 09', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'DC10') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'DC10', N'D10 - Tham số 10', N'D10 - Tham số 10', N'D10 - Parameter 10', N'D10 - Parameter 10', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'DC11') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'DC11', N'D11 - Tham số 11', N'D11 - Tham số 11', N'D11 - Parameter 11', N'D11 - Parameter 11', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'DC12') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'DC12', N'D12 - Tham số 12', N'D12 - Tham số 12', N'D12 - Parameter 12', N'D12 - Parameter 12', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'DC13') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'DC13', N'D13 - Tham số 13', N'D13 - Tham số 13', N'D13 - Parameter 13', N'D13 - Parameter 13', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'DC14') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'DC14', N'D14 - Tham số 14', N'D14 - Tham số 14', N'D14 - Parameter 14', N'D14 - Parameter 14', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'DC15') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'DC15', N'D15 - Tham số 15', N'D15 - Tham số 15', N'D15 - Parameter 15', N'D15 - Parameter 15', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'DC16') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'DC16', N'D16 - Tham số 16', N'D16 - Tham số 16', N'D16 - Parameter 16', N'D16 - Parameter 16', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'DC17') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'DC17', N'D17 - Tham số 17', N'D17 - Tham số 17', N'D17 - Parameter 17', N'D17 - Parameter 17', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'DC18') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'DC18', N'D18 - Tham số 18', N'D18 - Tham số 18', N'D18 - Parameter 18', N'D18 - Parameter 18', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'DC19') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'DC19', N'D19 - Tham số 19', N'D19 - Tham số 19', N'D19 - Parameter 19', N'D19 - Parameter 19', 0)
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008STD WHERE TypeID = N'DC20') INSERT INTO MT0008STD(TypeID, SystemName, UserName, SystemNameE, UserNameE, IsUsed) VALUES (N'DC20', N'D20 - Tham số 20', N'D20 - Tham số 20', N'D20 - Parameter 20', N'D20 - Parameter 20', 0)
