---- Create by Nguyễn Thành Sang on 25/04/2022 11:01:51 AM

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HT2503]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HT2504](
	[APK] [uniqueidentifier] NOT NULL,
	[APKMaster] [uniqueidentifier] NOT NULL,
	[FarmID] [varchar](50) NOT NULL,
	[JobID]  [varchar](50) NOT NULL,
	[Quantity] [int] NOT NULL,
	[UnitPrice] [decimal](28, 5) NOT NULL,
	[ConvertedAmount] [decimal](28, 5) NOT NULL,
	[Weight] [decimal](28, 5) NOT NULL,
	[ProductionQuantity] [decimal](28, 5) NOT NULL,
 CONSTRAINT [PK_HT2504] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

END

