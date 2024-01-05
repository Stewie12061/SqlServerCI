--- Created on 20/03/2014 by Phan thanh hoàng vu
--- D? li?u Ngi?p v? Phi?u xu?t t?m (Master)
IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[POST00152]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[POST00152](
	[APK] [uniqueidentifier] DEFAULT NEWID() NOT NULL,
	[DivisionID] [varchar](50) NOT NULL,
	[VoucherTypeID] [varchar](50) NULL,
	[VoucherNo] [varchar](50) NULL,
	[VoucherDate] [datetime] NULL,
	[InvoiceNo] [varchar](50) NULL,
	[InvoiceDate] [datetime] NULL,
	[ObjectID] [varchar](50) NULL,
	[ObjectName] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[EmployeeID] [varchar](50) NULL,
	[EmployeeName] [nvarchar](250) NULL,
	[DelivererName] [nvarchar](250) NULL,
	[DelivererAddress] [nvarchar](250) NULL,
	[DeleteFlg] [tinyint] NOT NULL DEFAULT 0,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [varchar](50) NULL,
	[LastModifyUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
 CONSTRAINT [PK_POST00152] PRIMARY KEY CLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
End