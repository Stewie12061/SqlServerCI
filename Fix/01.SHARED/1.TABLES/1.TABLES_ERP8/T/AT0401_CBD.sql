-- <Summary>
---Đẩy dữ liệu search đối tượng và tài khoản khi search danh sách vượt quá dữ liệu biến 
-- <History>
---- Create on 29/5/2019 by Hồng Thảo
---- Modified on 21/01/2020 by Lê Hoàng : Thêm index cải tiến tốc 

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT0401_CBD]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AT0401_CBD](
	[ID] NVARCHAR(250) NULL,
	[ObjectID] VARCHAR(50) NULL,
	[AccountID] VARCHAR(50) NULL
) ON [PRIMARY]
END
ELSE
BEGIN
	DELETE AT0401_CBD
END


------Modified by Hồng Thảo on 8/7/2019: Bỏ sung cột hợp đồng, nhà lồng, ô vựa, khoản thu 
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0401_CBD' AND xtype = 'U')
BEGIN 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0401_CBD' AND col.name = 'ContractID') 
   ALTER TABLE AT0401_CBD ADD ContractID VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0401_CBD' AND col.name = 'BlockID') 
   ALTER TABLE AT0401_CBD ADD BlockID VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0401_CBD' AND col.name = 'StoreID') 
   ALTER TABLE AT0401_CBD ADD StoreID VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT0401_CBD' AND col.name = 'CostTypeID') 
   ALTER TABLE AT0401_CBD ADD CostTypeID VARCHAR(50) NULL


END 
ALTER TABLE AT0401_CBD ALTER COLUMN ID VARCHAR(250) NOT NULL 

----- INDEX --------------
IF NOT EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_AT04011_CBD')   
BEGIN
	CREATE NONCLUSTERED INDEX IX_AT04011_CBD ON AT0401_CBD (ID,AccountID);   
END 

IF NOT EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_AT04012_CBD')   
BEGIN
	CREATE NONCLUSTERED INDEX IX_AT04012_CBD ON AT0401_CBD (ID,ObjectID);   
END  

IF NOT EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_AT04013_CBD')   
BEGIN
	CREATE NONCLUSTERED INDEX IX_AT04013_CBD ON AT0401_CBD (ID,StoreID);   
END  

IF NOT EXISTS (SELECT name FROM sys.indexes WHERE name = N'IX_AT04014_CBD')   
BEGIN
	CREATE NONCLUSTERED INDEX IX_AT04014_CBD ON AT0401_CBD (ID,CostTypeID);   
END  