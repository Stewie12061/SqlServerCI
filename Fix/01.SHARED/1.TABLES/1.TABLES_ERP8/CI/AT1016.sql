-- <Summary>
---- 
-- <History>
---- Create on 06/08/2010 by Tố Oanh
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT1016]') AND type in (N'U'))
CREATE TABLE [dbo].[AT1016](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[BankAccountID] [nvarchar](50) NOT NULL,
	[AccountID] [nvarchar](50) NULL,
	[CurrencyID] [nvarchar](50) NULL,
	[BankAccountNo] [nvarchar](50) NULL,
	[BankName] [nvarchar](250) NULL,
	[Notes] [nvarchar](250) NULL,
	[Disabled] [tinyint] NOT NULL,
	[OpenDate] [datetime] NULL,
	[CloseDate] [datetime] NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[BankID] [nvarchar](50) NULL,
 CONSTRAINT [PK_AT1016] PRIMARY KEY NONCLUSTERED 
(
	[BankAccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AT1016_Disabled]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AT1016] ADD  CONSTRAINT [DF_AT1016_Disabled]  DEFAULT ((0)) FOR [Disabled]
END


--Hoàng vũ on 14/05/2018: Customize = 87 (OKIA) Tài khoản theo đối tượng
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1016' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1016' AND col.name = 'IsObjectID') 
   ALTER TABLE AT1016 ADD IsObjectID TINYINT NULL 
END
/*===============================================END IsObjectID===============================================*/ 

--Hoàng vũ on 14/05/2018: Customize = 87 (OKIA) Tài khoản theo đối tượng
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT1016' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'AT1016' AND col.name = 'ObjectID') 
   ALTER TABLE AT1016 ADD ObjectID VARCHAR(50) NULL 
END
/*===============================================END ObjectID===============================================*/ 