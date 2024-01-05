-- <Summary>
---- 
-- <History>
---- Create on 28/04/2021 by Đình Hòa: Bảng Thông số kĩ thuật (Detail)
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SOT2111]') AND type in (N'U'))
CREATE TABLE [dbo].[SOT2111](
	[APK] [uniqueidentifier] NOT NULL DEFAULT NEWID(),
	[DivisionID] [varchar](50) NOT NULL,
	[APKMaster] [uniqueidentifier] NOT NULL,
	[StandardID] [varchar](50) NULL,
	[StandardValue] [nvarchar](250) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [varchar](50) NULL,
	[LastModifyUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[DeleteFlag] [int] NULL
	
 CONSTRAINT [PK_SOT2111] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

-- Đình Hoà [15/07/2021] : Bổ sung số thứ tự(OrderNo)(OrderNo)
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2111' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2111' AND col.name = 'OrderStd')
	BEGIN
    ALTER TABLE SOT2111 ADD OrderStd INT DEFAULT(0) NULL
	END
END