-- <Summary>
---- Hợp đồng vay, tab thông tin chung
-- <History>
---- Create on 20/10/2017 by Hải Long
---- Modified on 11/01/2019 by Như Hàn: Bổ sung trường đối tượng (AIC)
-- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[LMT2004]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[LMT2004]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
	  [VoucherID] VARCHAR(50) NOT NULL,
	  [TransactionID] VARCHAR(50) NOT NULL,
	  [OriginalAmount] DECIMAL(28,8) NULL,	  
	  [ConvertedAmount] DECIMAL(28,8) NULL,
	  [CostTypeID] VARCHAR(50) NULL,
      [Notes] NVARCHAR(250) NULL,
	  [Ana01ID] NVARCHAR(50) NULL,
	  [Ana02ID] NVARCHAR(50) NULL,
	  [Ana03ID] NVARCHAR(50) NULL,
	  [Ana04ID] NVARCHAR(50) NULL,
	  [Ana05ID] NVARCHAR(50) NULL,
	  [Ana06ID] NVARCHAR(50) NULL,
	  [Ana07ID] NVARCHAR(50) NULL,
	  [Ana08ID] NVARCHAR(50) NULL,
	  [Ana09ID] NVARCHAR(50) NULL,
	  [Ana10ID] NVARCHAR(50) NULL,
	  [Orders] INT NULL	           
    CONSTRAINT [PK_LMT2004] PRIMARY KEY CLUSTERED
      (
      [TransactionID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'LMT2004' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'LMT2004' AND col.name = 'ObjectID') 
   ALTER TABLE LMT2004 ADD ObjectID VARCHAR(50) NULL 
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'LMT2004' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'LMT2004' AND col.name = 'InheritTableID') 
   ALTER TABLE LMT2004 ADD InheritTableID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'LMT2004' AND col.name = 'InheritVoucherID') 
   ALTER TABLE LMT2004 ADD InheritVoucherID VARCHAR(50) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'LMT2004' AND col.name = 'InheritTransactionID') 
   ALTER TABLE LMT2004 ADD InheritTransactionID VARCHAR(50) NULL 
END