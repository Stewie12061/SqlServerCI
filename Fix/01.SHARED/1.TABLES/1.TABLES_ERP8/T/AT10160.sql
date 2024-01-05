-- <Summary>
---- Bảng tạm lưu dữ liệu phục vụ báo cáo sổ tiền gửi ngân hàng.
-- <History>
---- Create on 03/08/2022 by Nhựt Trường
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT10160]') AND type in (N'U'))
CREATE TABLE [dbo].[AT10160](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[BankAccountID] [nvarchar](50) NOT NULL,
	[AccountID] [nvarchar](50) NULL,
	[CurrencyID] [nvarchar](50) NULL,
	[BankAccountNo] [nvarchar](50) NULL,
	[BankName] [nvarchar](250) NULL
 CONSTRAINT [PK_AT10160] PRIMARY KEY NONCLUSTERED 
(
	[BankAccountID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]