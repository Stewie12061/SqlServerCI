-- <Summary>
---- 
-- <History>
---- Create on 24/12/2013 by Lưu Khánh Vân
---- Modified on ... by ...
---- <Example>
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT0336]') AND type in (N'U'))
CREATE TABLE [dbo].[HT0336](
	[APK] [uniqueidentifier] NULL,
	[DivisionID] [nvarchar](50) NOT NULL,
	[MethodID] [nvarchar](50) NOT NULL,
	[TaxStepID] [nvarchar](50) NOT NULL,
	[UnitAmount] [decimal](28,8) NULL,
	[Description] [nvarchar](250) NULL,
	[Disabled] [tinyint] NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
 CONSTRAINT [PK_HT0336] PRIMARY KEY CLUSTERED 
(
	[MethodID] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
---- Add giá trị default
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HT0336_APK]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HT0336] ADD  CONSTRAINT [DF_HT0336_APK]  DEFAULT (newid()) FOR [APK]
END

---- Modified by Tiểu Mai on 26/12/2016: Bổ sung check Áp dụng cho người nước ngoài (ANGEL)
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0336' AND xtype = 'U')
BEGIN
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
    ON col.id = tab.id WHERE tab.name = 'HT0336' AND col.name = 'IsForeigner')
    ALTER TABLE HT0336 ADD IsForeigner TINYINT DEFAULT(0)
END  
