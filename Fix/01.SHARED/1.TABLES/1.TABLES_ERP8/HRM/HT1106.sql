-- <Summary>
---- 
-- <History>
---- Create on 11/10/2010 by Thanh Trẫm
---- Modified on ... by ...
---- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HT1106]') AND type in (N'U'))
CREATE TABLE [dbo].[HT1106](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[TitleID] [nvarchar](50) NOT NULL,
	[TitleName] [nvarchar](250) NULL,
	[TitleNameE] [nvarchar](250) NULL,
	[Disabled] [tinyint] NOT NULL,
	[CreateUserID] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastModifyUserID] [nvarchar](50) NOT NULL,
	[Note] [nvarchar](250) NULL,
	[LastModifyDate] [datetime] NOT NULL,
	CONSTRAINT [PK_HT1106] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


-- Modify by Phương Thảo
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1106' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1106' AND col.name = 'BaseSalary')
        ALTER TABLE HT1106 ADD BaseSalary DECIMAL(28,8) NULL
    END
	   
-- Modify by Phương Thảo on 11/04/2016: Bổ sung số giờ công tiêu chuẩn
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT1106' AND xtype = 'U')
    BEGIN
        IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
        ON col.id = tab.id WHERE tab.name = 'HT1106' AND col.name = 'StandardAbsentAmount')
        ALTER TABLE HT1106 ADD StandardAbsentAmount DECIMAL(28,8) NULL
    END