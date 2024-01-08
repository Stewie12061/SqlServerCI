-- <Summary>
---- Bảng master bút toán phân bổ theo nhiều cấp (PACIFIC)
-- <History>
---- Create on 10/04/2017 by Hải Long
---- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT9005]') AND type in (N'U'))
CREATE TABLE [dbo].[AT9005](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,	
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,	
	[VoucherID] [nvarchar](50) NOT NULL,
	[VoucherNo] [nvarchar](50) NULL,
	[AllocationID] [nvarchar](50) NOT NULL,
	[AllocationType] [tinyint] NULL,
	[AllocationLevelID] [tinyint] NULL,
	[VoucherTypeID] [nvarchar](50) NULL,
	[VoucherDate] [datetime] NULL,
	[EmployeeID] [nvarchar](50) NULL,
	[Description] [nvarchar](250) NULL,	
	[CurrencyID] [nvarchar](50) NULL,
	[ExchangeRate] DECIMAL(28),		
	[OriginalInheritVoucherID] [nvarchar](50) NULL,
	[OriginalInheritVoucherDate] [datetime] NULL,
	[InheritVoucherID] [nvarchar](50) NULL,
	[InheritVoucherNo] [nvarchar](50) NULL,		
	[IsAudit] TINYINT,				
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,	
	[LastModifyUserID] [nvarchar](50) NULL
 CONSTRAINT [PK_AT9005] PRIMARY KEY NONCLUSTERED 
(
	[VoucherID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9005' AND xtype='U')
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='AT9005' AND col.name='AllocationID')
		ALTER TABLE AT9005 ALTER COLUMN AllocationID NVARCHAR(50) NULL 
	END