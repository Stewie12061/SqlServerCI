-- <Summary>
---- 
-- <History>
---- Create by Tiểu Mai on 09/03/2016
---- Modified by ... on ...
---- <Example>
---- Add Data
	
IF NOT EXISTS(SELECT TOP 1 1 FROM HT0010 WHERE TypeID LIKE 'HM%')	
	INSERT INTO HT0010 (DivisionID, TypeID,SystemName,UserName,IsUsed,UserNameE,SystemNameE)
		SELECT	AT.DivisionID, STD.TypeID,STD.SystemName,STD.UserName,STD.IsUsed,STD.UserNameE,STD.SystemNameE 
		FROM	HT0010STD STD, (SELECT DISTINCT DivisionID FROM AT1101) AT	
		WHERE	STD.TypeID  LIKE 'HM%'	
		
IF NOT EXISTS(SELECT TOP 1 1 FROM HT0010 WHERE TypeID LIKE 'HD%')	
	INSERT INTO HT0010 (DivisionID, TypeID,SystemName,UserName,IsUsed,UserNameE,SystemNameE)
		SELECT	AT.DivisionID, STD.TypeID,STD.SystemName,STD.UserName,STD.IsUsed,STD.UserNameE,STD.SystemNameE 
		FROM	HT0010STD STD, (SELECT DISTINCT DivisionID FROM AT1101) AT	
		WHERE	STD.TypeID  LIKE 'HD%'	