-- <Summary>
---- Bảng chứa dữ liệu ảnh nghiệp vụ cho tài xế giao hàng (APP - MOBILE)
-- <History>
---- Create on 15/11/2023 by Thành Sang
---- Modified on
---- <Example>

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APT0018]') AND type in (N'U'))
CREATE TABLE [dbo].[APT0018](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[TransactionID] [nvarchar](50) NOT NULL,	
	[APKDelivery] [nvarchar](50) NOT NULL,		
	[Image] [XML] NOT NULL,
	[Orders] [tinyint] NULL,
	[CreateUserID] [nvarchar](50) NULL, 
	[CreateDate] [datetime] NULL
 CONSTRAINT [PK_APT0018] PRIMARY KEY NONCLUSTERED 
(
	[DivisionID] ASC,	
	[TransactionID] ASC,
	[APKDelivery] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
