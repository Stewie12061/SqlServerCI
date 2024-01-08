-------------------- 23/07/2019 - Vĩnh Tâm: Bổ sung cột CostDetailAnaTypeID --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'CostDetailAnaTypeID')
BEGIN
	ALTER TABLE AT0000 ADD CostDetailAnaTypeID VARCHAR(25) NULL
END

-------------------- 07/08/2020 - Tấn Lộc: Bổ sung cột SystemMailSettingReceives --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'SystemMailSettingReceives')
BEGIN
	ALTER TABLE AT0000 ADD SystemMailSettingReceives NVARCHAR (MAX) NULL
END

-------------------- 05/04/2021 - Đoàn Duy: Bổ sung cột SystemMailSettingReceives --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'IsConfirmPurchasePL')
BEGIN
	ALTER TABLE AT0000 ADD IsConfirmPurchasePL TINYINT NULL
END

-------------------- 05/05/2022 - Văn Tài: Bổ sung cột EContractSetting --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'EContractSetting')
	ALTER TABLE AT0000 ADD EContractSetting NVARCHAR (MAX) NULL

-------------------- 22/05/2022 - Văn Tài: Bổ sung cột EContractToken --------------------
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'EContractToken')
	ALTER TABLE AT0000 ADD EContractToken NVARCHAR (MAX) NULL

IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'AT0000' AND col.name = 'EContractExpTime')
	ALTER TABLE AT0000 ADD EContractExpTime DATETIME NULL