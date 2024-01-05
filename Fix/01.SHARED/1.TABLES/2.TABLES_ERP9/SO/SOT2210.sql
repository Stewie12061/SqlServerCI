-- <Summary>
---- 
-- <History>
---- Create on 29/11/2023 by Hoàng Long
---- <Example>

--DROP TABLE [SOT2210]
--sp [SOT2210]

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SOT2210]') AND type in (N'U'))
CREATE TABLE [SOT2210](
	[APK] [uniqueidentifier] NOT NULL DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[TranMonth] [INT] NULL,
    [TranYear] [INT] NULL,
	[SeriNo] [nvarchar](50) NULL,
	[TAccount] [nvarchar](50) NULL,
	[TAccountNumber] [nvarchar](50) NULL,
	[TAccountDate] [datetime] NULL,
	[Enduser] [nvarchar](50) NULL,
	[Tel] [nvarchar](10) NULL,
	[Apartment] [nvarchar](50) NULL,
	[Road] [nvarchar](50) NULL,
	[Ward] [nvarchar](50)  NULL,
	[District] [nvarchar](50) NULL,
	[Province] [nvarchar](50) NULL,
	[DAccount] [nvarchar](50) NULL,
	[DAccountNumber] [nvarchar](50) NULL,
	[DAccountDate] [datetime] NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [varchar](50) NULL,
	[LastModifyUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] NULL
 CONSTRAINT [PK_SOT2210] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
