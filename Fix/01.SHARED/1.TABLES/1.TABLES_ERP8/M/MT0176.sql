---- Create by Đặng Thị Tiểu Mai on 19/08/2016 3:16:51 PM
---- Đề nghị sửa bộ định mức theo quy cách

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[MT0176]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[MT0176]
     (
		[APK] UNIQUEIDENTIFIER DEFAULT NEWID() NULL,
		[DivisionID] VARCHAR(50) NOT NULL,
		[VoucherNo] VARCHAR(50) NOT NULL,
		[VoucherID] VARCHAR(50) DEFAULT NewID() NOT NULL,
		[TransactionID] VARCHAR(50) DEFAULT NewID() NOT NULL,
		[VoucherDate] DATETIME NULL,
		[CreateUserID] VARCHAR(50) NULL,
		[CreateDate] DATETIME NULL,
		[LastModifyUserID] VARCHAR(50) NULL,
		[LastModifyDate] DATETIME NULL,
		[Disabled] TINYINT DEFAULT (0) NULL,
		[Description] NVARCHAR(250) NULL,
		[TypeID] TINYINT NULL,
		[InheritApportionID] VARCHAR(50) NULL,
		[InheritTransactionID] VARCHAR(50) NULL,
		[ProductID] VARCHAR(50) NULL,
		[UnitID] VARCHAR(50) NULL,
		[ProductQuantity] DECIMAL(28,8) NULL,
		[Begin_ProductQuantity] DECIMAL(28,8) NULL,
		[S01ID] VARCHAR(50) NULL,
		[S02ID] VARCHAR(50) NULL,
		[S03ID] VARCHAR(50) NULL,
		[S04ID] VARCHAR(50) NULL,
		[S05ID] VARCHAR(50) NULL,
		[S06ID] VARCHAR(50) NULL,
		[S07ID] VARCHAR(50) NULL,
		[S08ID] VARCHAR(50) NULL,
		[S09ID] VARCHAR(50) NULL,
		[S10ID] VARCHAR(50) NULL,
		[S11ID] VARCHAR(50) NULL,
		[S12ID] VARCHAR(50) NULL,
		[S13ID] VARCHAR(50) NULL,
		[S14ID] VARCHAR(50) NULL,
		[S15ID] VARCHAR(50) NULL,
		[S16ID] VARCHAR(50) NULL,
		[S17ID] VARCHAR(50) NULL,
		[S18ID] VARCHAR(50) NULL,
		[S19ID] VARCHAR(50) NULL,
		[S20ID] VARCHAR(50) NULL,
		[Parameter01] NVARCHAR(250) NULL,
		[Parameter02] NVARCHAR(250) NULL,
		[Parameter03] NVARCHAR(250) NULL,
		[Status] TINYINT DEFAULT(0) NULL,
		[IsConfirm01]	TINYINT NULL,
		[ConfDescription01]	NVARCHAR(250) NULL,
		[IsConfirm02]	TINYINT NULL,
		[ConfDescription02]	NVARCHAR(250) NULL,
		[Orders] INT NULL
    CONSTRAINT [PK_MT0176] PRIMARY KEY CLUSTERED
      (
      	[DivisionID],
      	[VoucherID],
      	[TransactionID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END

---- Modified by Tiểu Mai on 07/09/2016: Bổ sung số thứ tự đề nghị định mức (AN PHÁT)
If Exists (Select * From sysobjects Where name = 'MT0176' and xtype ='U') 
BEGIN 
	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'MT0176'  and col.name = 'NumberSuggest')
	ALTER TABLE  MT0176 Add NumberSuggest INT NULL

END 

---- Modified by Tiểu Mai on 12/09/2016: Bổ sung Ghi chú (AN PHÁT)
If Exists (Select * From sysobjects Where name = 'MT0176' and xtype ='U') 
BEGIN 
	If not exists (select * from syscolumns col inner join sysobjects tab 
	On col.id = tab.id where tab.name =   'MT0176'  and col.name = 'Notes')
	ALTER TABLE  MT0176 Add Notes NVARCHAR(250) NULL

END 
