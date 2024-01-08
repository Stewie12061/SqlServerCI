-- <Summary>
---- Detail tình hình sản xuất (Bê Tông Long An)
-- <History>
---- Create on 15/08/2017 by Hải Long
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MT1622]') AND type in (N'U'))
CREATE TABLE [dbo].[MT1622](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[VoucherID] [nvarchar](50) NOT NULL,
	[TransactionID] [nvarchar](50) NOT NULL,
	[TypeTab] [int] NULL,					
	[TeamID] [nvarchar](50) NULL,
	[BeginTime] [datetime] NULL,
	[EndTime] [datetime] NULL,	
	[PresentNumber] [int] NULL,		
	[AbsentNumber] [int] NULL,		
	[ConcreteID] [nvarchar](4000) NULL,			
	[MeasureTimes] [int] NULL,	
	[ReasonDescription] [nvarchar](1000) NULL,
	[SagNumber1] [nvarchar](1000) NULL,			
	[SagNumber2] [nvarchar](1000) NULL,	
	[Notes1] [nvarchar](4000) NULL,
	[Notes2] [nvarchar](4000) NULL,
	[Notes3] [nvarchar](4000) NULL,
	[Notes4] [nvarchar](4000) NULL,
	[Orders] [int] NULL	
 CONSTRAINT [PK_MT1622] PRIMARY KEY NONCLUSTERED 
(
	[VoucherID] ASC,
	[TransactionID] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]