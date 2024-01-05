-- <Summary>
---- Bảng tạm lưu dữ liệu phục vụ báo cáo sổ tiền gửi ngân hàng.
-- <History>
---- Create on 03/08/2022 by Nhựt Trường
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT75120]') AND type in (N'U'))
CREATE TABLE [dbo].[AT75120](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[BankAccountID] [nvarchar](50) NOT NULL,
	[StartOriginalAmount] decimal(28,8) NULL,
	[StartConvertedAmount] decimal(28,8) NULL
 CONSTRAINT [PK_AT75120] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]