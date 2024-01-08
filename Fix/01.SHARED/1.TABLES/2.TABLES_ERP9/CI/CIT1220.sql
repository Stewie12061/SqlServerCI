-- <Summary> Danh mục thiết lập chương trình khuyến mãi theo điều kiện (Master)
-- <History>
---- Create on 19/04/2023 by Lê Thanh Lượng 
---- Modified on ... by ...
---- <Example>

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CIT1220]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[CIT1220]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(50) NOT NULL,
      [PromoteID] NVARCHAR(50) NOT NULL, -- mã chương trình
	  [PromoteName] NVARCHAR(250) NOT NULL,
      [FromDate] DATETIME NOT NULL,
      [ToDate] DATETIME NOT NULL,
      [OID] NVARCHAR(50)  NULL, -- Nhóm đối tượng (MPT nhóm đối tượng: O01ID)
	  [IsDiscountWallet]TINYINT DEFAULT (0) NOT NULL, -- 0: Không sử dụng ví chiết khấu tích lũy  -- 1: Có sử dụng ví chiết khấu tích lũy
      [Description] NVARCHAR(250) NULL,
      [Disabled] TINYINT DEFAULT (0) NOT NULL,
      [IsCommon] TINYINT DEFAULT (0) NOT NULL,
      [CreateDate] DATETIME NULL,
      [CreateUserID] VARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL,
      [LastModifyUserID] VARCHAR(50) NULL
    CONSTRAINT [PK_CIT1220] PRIMARY KEY CLUSTERED
      (
      [PromoteID]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY]
END
-- Người duyệt
If Exists (Select * From sysobjects Where name = 'CIT1220' and xtype ='U') 
Begin
	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'CIT1220'  and col.name = 'Levels')
    Alter Table CIT1220 ADD Levels INT NULL

	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'CIT1220'  and col.name = 'StatusSS')
    Alter Table CIT1220 ADD StatusSS TinyInt NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CIT1220' AND col.name = 'ApprovingLevel')
    ALTER TABLE CIT1220 ADD ApprovingLevel INT NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CIT1220' AND col.name = 'ApproveLevel')
    ALTER TABLE CIT1220 ADD ApproveLevel INT NULL

	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'CIT1220' AND col.name = 'APKMaster_9000')
	BEGIN
    ALTER TABLE CIT1220 ADD APKMaster_9000 uniqueidentifier NULL
	END
		IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id where tab.name =   'CIT1220'  and col.name = 'ApprovalNotes')
	ALTER TABLE CIT1220 ADD ApprovalNotes NVARCHAR(250) NULL
END

If Exists (Select * From sysobjects Where name = 'CIT1220' and xtype ='U') 
Begin
	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'CIT1220'  and col.name = 'InheritID')
    Alter Table CIT1220 ADD InheritID NVARCHAR(50) NULL

	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'CIT1220'  and col.name = 'IsEnd')
    Alter Table CIT1220 ADD IsEnd INT NULL

	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'CIT1220'  and col.name = 'OID')
    Alter Table CIT1220 ADD OID NVARCHAR(250) NULL

	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'CIT1220'  and col.name = 'ObjectID')
    Alter Table CIT1220 ADD ObjectID NVARCHAR(250) NULL
END

