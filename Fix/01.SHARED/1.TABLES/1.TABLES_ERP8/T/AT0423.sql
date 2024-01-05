-- <Summary>
---- 
-- <History>
---- Create on 27/04/2022 by Kiều Nga
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT0423]') AND type in (N'U'))
CREATE TABLE [dbo].[AT0423](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[Orders] INT NULL,
	[JobID] [nvarchar](50) NULL,
	[VoucherNo] [nvarchar](50) NULL,
	[ObjectID]  [nvarchar](50) NULL,
	[Serial] [nvarchar](50) NULL,
	[InvoiceNo] [nvarchar](50) NULL,
	[InvoiceDate] [datetime]NULL,
	[AccountID] [nvarchar](50) NULL,
	[ConvertedAmount] [decimal](28,8) NULL,
	[Description] [nvarchar](250) NULL,
	[InheritTableID] [nvarchar](50) NULL,
	[InheritVoucherID] [nvarchar](50) NULL,
	[ContractNo] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
 CONSTRAINT [PK_AT0423] PRIMARY KEY CLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
