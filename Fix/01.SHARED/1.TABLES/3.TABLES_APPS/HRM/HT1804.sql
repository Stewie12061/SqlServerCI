---- Create by Nguyễn Thành Sang on 25/04/2022 11:01:51 AM

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HT1803]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HT1804](
	[APK] [uniqueidentifier] NOT NULL,
	[APKMaster] [uniqueidentifier] NULL,
	[FarmID] [varchar](50) NULL,
	[InventoryID] [varchar](50) NULL,
	[Quantity] [int] NULL,
	[UnitPrice] [decimal](28, 5) NULL,
	[ConvertedAmount] [decimal](28, 5) NULL,
 CONSTRAINT [PK_HT1803Detail] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

END


