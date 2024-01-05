--Import du lieu ngam thiet lap thanh phan dinh duong

 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'MTP01' and Type=1)
 BEGIN 
		INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@','MTP01',N'Đạm động vật','Protein','',1,0,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'MTP02' and Type=1)
 BEGIN 
			INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@','MTP02',N'Đạm thực vật','ProteinVegetable','',1,0,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'MTP03' and Type=1)
 BEGIN 	
			INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@','MTP03','Beo dong vat','Lipit','',1,0,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'MTP04' and Type=1)
 BEGIN 		
	
			INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
				SELECT '@@@','MTP04',N'Béo thực vật','LipitVegetable','',1,0,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'MTP05' and Type=1)
 BEGIN 	
			INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@','MTP05','Canxi','Canxi','',1,0,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'MTP06' and Type=1)
 BEGIN 		
	
			INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@','MTP06','Sat','Iron','',1,0,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'MTP07' and Type=1)
 BEGIN 
			INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@','MTP07','','','',0,0,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'MTP08' and Type=1)
 BEGIN 
			  	INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@','MTP08','','','',0,0,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'MTP09' and Type=1)
 BEGIN 
			  	INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@','MTP09','','','',0,0,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'MTP10' and Type=1)
 BEGIN 
			  	INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@','MTP10','','','',0,0,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'MTP11' and Type=1)
 BEGIN 
			  	INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@','MTP11','','','',0,0,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'MTP12' and Type=1)
 BEGIN 
			  	INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@','MTP12','','','',0,0,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'MTP13' and Type=1)
 BEGIN 
			  	INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@','MTP13','','','',0,0,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'MTP14' and Type=1)
 BEGIN 
			  	INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@','MTP14','','','',0,0,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'MTP15' and Type=1)
 BEGIN 
			  	INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@','MTP15','','','',0,0,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'MTP16' and Type=1)
 BEGIN 
			  	INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@','MTP16','','','',0,0,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'MTP17' and Type=1)
 BEGIN 
			  	INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@','MTP17','','','',0,0,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'MTP18' and Type=1)
 BEGIN 
		INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@','MTP18','','','',0,0,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'MTP19' and Type=1)
 BEGIN 
	INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@','MTP19','','','',0,0,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'MTP20' and Type=1)
 BEGIN 
	INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@','MTP20','','','',0,0,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
	END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'WF01' and Type=2)
 BEGIN 
			INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT '@@@','WF01','Kho cho','WareHouseMarket','KHO1',1,0,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
	END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'WF02' and Type=2)
 BEGIN 	
			INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
			SELECT '@@@','WF02','Kho ','WareHouseMarket','KHO2',1,0,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
	END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'WF03' and Type=2)
 BEGIN 	
	INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
			SELECT '@@@','WF03','Kho 3','WareHouseMarket3','KHO3',1,0,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID='WF04' and Type=2)
 BEGIN 
			  INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
			SELECT '@@@','WF04',' ','','',0,0,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'WF05' and Type=2)
 BEGIN 
			  			  INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
			SELECT '@@@','WF05',' ','','',0,0,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'WF06' and Type=2)
 BEGIN 
			  			  INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
			SELECT '@@@','WF06',' ','','',0,0,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'WF07' and Type=2)
 BEGIN 
			  			  INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
			SELECT '@@@','WF07',' ','','',0,0,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'WF08' and Type=2)
 BEGIN 
			  			  INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
			SELECT '@@@','WF08',' ','','',0,0,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
	END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'WF09' and Type=2)
 BEGIN 
			  			  INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
			SELECT '@@@','WF09',' ','','',0,0,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'WF10' and Type=2)
 BEGIN 
			  			  INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
			SELECT '@@@','WF10',' ','','',0,0,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'WF11' and Type=2)
 BEGIN 
			  			  INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
			SELECT '@@@','WF11',' ','','',0,0,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'WF12' and Type=2)
 BEGIN 
			  			  INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
			SELECT '@@@','WF12',' ','','',0,0,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'WF13' and Type=2)
 BEGIN 
			  			  INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
			SELECT '@@@','WF13',' ','','',0,0,2,
						  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'WF14' and Type=2)
 BEGIN 
			  INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
			SELECT '@@@','WF14',' ','','',0,0,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'WF15' and Type=2)
 BEGIN 
			  			  INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
			SELECT '@@@','WF15',' ','','',0,0,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'WF16' and Type=2)
 BEGIN 
			  			  INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
			SELECT '@@@','WF16',' ','','',0,0,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'WF17' and Type=2)
 BEGIN 
			  			  INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
			SELECT '@@@','WF17',' ','','',0,0,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'WF18' and Type=2)
 BEGIN 
			  			  INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
			SELECT '@@@','WF18',' ','','',0,0,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'WF19' and Type=2)
 BEGIN 
			  			  INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
			SELECT '@@@','WF19',' ','','',0,0,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END 
 IF NOT EXISTS ( SELECT TOP 1 1 FROM NMT0001 WHERE SystemID= 'WF20' and Type=2)
 BEGIN 
			  			  INSERT INTO NMT0001(DivisionID, SystemID, SystemName,SystemNameE, WareHouseID,IsUse,IsCommon, Type,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
			SELECT '@@@','WF20',' ','','',0,0,2,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE()
END

	