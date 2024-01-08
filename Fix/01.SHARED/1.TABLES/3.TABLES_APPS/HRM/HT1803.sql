---- Create by Nguyễn Thành Sang on 25/04/2022 11:01:51 AM

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[HT1803]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[HT1803](
	[APK] [uniqueidentifier] NOT NULL,
	[DivisionID] [varchar](50) NULL,
	[TranDay] [int] NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[Date] [datetime] NULL,
	[FarmID] [varchar](50) NULL,
	[Labour200] [decimal](28, 5) NULL,
	[Labour170] [decimal](28, 5) NULL,
	[BoxPerPeople] [decimal](28, 5) NULL,
	[QuantityPerRoom] [int] NULL,
	[ProductionQuantity] [decimal](28, 5)  NULL,
	[Rate] [decimal](28, 5) NULL,
	[TotalBox] [decimal] NULL,
	[TotalCost][decimal](28, 5)  NULL,
	[CostPerBox] [decimal](28, 5)  NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
 CONSTRAINT [PK_HT1803] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

END


