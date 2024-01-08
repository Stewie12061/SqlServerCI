-- <Summary>
---- 
-- <History>
---- Created by Tiểu Mai on 03/01/2016
---- Modified by ... on ...
---- <Example>
---- Add Data

IF NOT EXISTS(SELECT TOP 1 1 FROM CT0005 WHERE TypeID LIKE 'M%')	
	INSERT INTO CT0005 (DivisionID, TypeID,SystemName,UserName,IsUsed,UserNameE,SystemNameE)
		SELECT	AT.DivisionID, STD.TypeID, STD.SystemName, STD.UserName, STD.IsUsed, STD.UserNameE, STD.SystemNameE 
		FROM	CT0005STD STD, (SELECT DISTINCT DivisionID FROM AT1101) AT	
		WHERE	STD.TypeID  LIKE 'M%'

IF NOT EXISTS(SELECT TOP 1 1 FROM CT0005 WHERE TypeID LIKE 'DC%')	
	INSERT INTO CT0005 (DivisionID, TypeID,SystemName,UserName,IsUsed,UserNameE,SystemNameE)
		SELECT	AT.DivisionID, STD.TypeID, STD.SystemName, STD.UserName, STD.IsUsed, STD.UserNameE, STD.SystemNameE 
		FROM	CT0005STD STD, (SELECT DISTINCT DivisionID FROM AT1101) AT	
		WHERE	STD.TypeID  LIKE 'DC%'		