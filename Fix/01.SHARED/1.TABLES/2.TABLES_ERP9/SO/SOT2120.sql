-- <Summary>
---- 
-- <History>
---- Create on 28/07/2021 by Đình Hòa: Bảng phiếu báo giá Sale (Master)
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SOT2120]') AND type in (N'U'))
CREATE TABLE [dbo].[SOT2120](
	[APK] [uniqueidentifier] NOT NULL DEFAULT NEWID(),
	[DivisionID] [varchar](50) NOT NULL,
	[VouCherNo] [varchar](50) NULL,
	[VouCherDate] [datetime] NULL,
	[CurrencyID] [nvarchar](50) NULL,
	[ExchangeRate] [decimal](28, 8) NULL,
	[OrderStatus] [tinyint] NULL,
	[EmployeeID] [nvarchar](50) NULL,
	[ObjectID] [nvarchar](50) NULL,
	[Address] [nvarchar](MAX) NULL,
	[Tel] [nvarchar](100) NULL,
	[DeliveryAddress] [nvarchar](MAX) NULL,
	[Transport] [nvarchar](250) NULL,
	[PaymentTermID] [nvarchar](50) NULL,
	[PaymentID] [nvarchar](50) NULL,
	[PriceListID] [nvarchar](50) NULL,
	[Description] [nvarchar](250) NULL,
	[Attention1] [nvarchar](250) NULL, -- Tiêu đề
	[Attention2] [nvarchar](250) NULL, -- Điều kiện thanh toán
	[Dear] [nvarchar](100) NULL,
	[IsInheritTPQ] [tinyint] NULL, -- Check kế thừa Phiếu báo giá kĩ tuhật
	[DeleteFlag] [int] NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [varchar](50) NULL,
	[LastModifyUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] NULL
	
 CONSTRAINT [PK_SOT2120] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

-- Thêm cột TranMonth, TranYear
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2120' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2120' AND col.name = 'IsSO')
	BEGIN
    ALTER TABLE SOT2120 ADD [IsSO] [tinyint] NULL
	END
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2120' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2120' AND col.name = 'TranMonth')
	BEGIN
    ALTER TABLE SOT2120 ADD [TranMonth] [int] NULL
	END
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2120' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2120' AND col.name = 'TranYear')
	BEGIN
    ALTER TABLE SOT2120 ADD [TranYear] [int] NULL
	END
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2120' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2120' AND col.name = 'IsConfirm')
	BEGIN
    ALTER TABLE SOT2120 ADD [IsConfirm] [tinyint] default(0) NULL
	END
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2120' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2120' AND col.name = 'APKMaster_9000')
	BEGIN
    ALTER TABLE SOT2120 ADD [APKMaster_9000] VARCHAR(50) NULL
	END
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2120' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2120' AND col.name = 'Type_9000')
	BEGIN
    ALTER TABLE SOT2120 ADD [Type_9000]  VARCHAR(50) NULL
	END
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2120' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2120' AND col.name = 'ApproveLevel')
	BEGIN
    ALTER TABLE SOT2120 ADD [ApproveLevel] [int] NULL
	END
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2120' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2120' AND col.name = 'ApprovingLevel')
	BEGIN
    ALTER TABLE SOT2120 ADD [ApprovingLevel] [int] NULL
	END
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2120' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2120' AND col.name = 'ApprovalNotes')
	BEGIN
    ALTER TABLE SOT2120 ADD [ApprovalNotes] VARCHAR(250) NULL
	END
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2120' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2120' AND col.name = 'QuoType')
	BEGIN
    ALTER TABLE SOT2120 ADD [QuoType] TINYINT NULL
	END
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2120' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2120' AND col.name = 'Ana01ID')
	BEGIN
    ALTER TABLE SOT2120 ADD [Ana01ID] VARCHAR(50) NULL
	END
END

IF EXISTS (SELECT * FROM sysobjects WHERE name = 'SOT2120' AND xtype = 'U') 
BEGIN
	IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'SOT2120' AND col.name = 'ProjectAddress')
	BEGIN
    ALTER TABLE SOT2120 ADD [ProjectAddress] [nvarchar](MAX) NULL
	END
END


