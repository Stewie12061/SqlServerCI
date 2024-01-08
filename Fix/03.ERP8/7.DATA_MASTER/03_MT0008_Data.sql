-- <Summary>
---- 
-- <History>
---- Create on 04/09/2015 by Tiểu Mai: Tham số cho Kết quả sản xuất thành phẩm
---- Modified by Tiểu Mai on 03/03/2016: Bổ sung 20 tham số tổng hợp và 20 tham số chi tiết
---- <Example>
---- Add Data
	
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008 WHERE TypeID LIKE 'MD%')	
	INSERT INTO MT0008 (DivisionID, TypeID,SystemName,UserName,IsUsed,UserNameE,SystemNameE)
		SELECT	AT.DivisionID, STD.TypeID,STD.SystemName,STD.UserName,STD.IsUsed,STD.UserNameE,STD.SystemNameE 
		FROM	MT0008STD STD, (SELECT DISTINCT DivisionID FROM AT1101) AT	
		WHERE	STD.TypeID  LIKE 'MD%'			
-----------------------------------------

IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008 WHERE TypeID LIKE 'MC%')	
	INSERT INTO MT0008 (DivisionID, TypeID,SystemName,UserName,IsUsed,UserNameE,SystemNameE)
		SELECT	AT.DivisionID, STD.TypeID,STD.SystemName,STD.UserName,STD.IsUsed,STD.UserNameE,STD.SystemNameE 
		FROM	MT0008STD STD, (SELECT DISTINCT DivisionID FROM AT1101) AT	
		WHERE	STD.TypeID  LIKE 'MC%'
		
IF NOT EXISTS(SELECT TOP 1 1 FROM MT0008 WHERE TypeID LIKE 'DC%')	
	INSERT INTO MT0008 (DivisionID, TypeID,SystemName,UserName,IsUsed,UserNameE,SystemNameE)
		SELECT	AT.DivisionID, STD.TypeID,STD.SystemName,STD.UserName,STD.IsUsed,STD.UserNameE,STD.SystemNameE 
		FROM	MT0008STD STD, (SELECT DISTINCT DivisionID FROM AT1101) AT	
		WHERE	STD.TypeID  LIKE 'DC%'		