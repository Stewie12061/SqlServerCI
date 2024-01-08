-- <Summary>
---- 
-- <History>
---- Bảng tạm kế thừa dự án AIC
---- Create on 07/11/2018 by Như Hàn
---- Modified on ... by ...:
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WITH (NOLOCK) WHERE object_id = OBJECT_ID(N'[dbo].[FNT2000_AIC]') AND type in (N'U'))
CREATE TABLE [dbo].[FNT2000_AIC](
    [APK] [UNIQUEIDENTIFIER] DEFAULT NEWID(),
	[JobName] [NVARCHAR](500),
	[Amount] [DECIMAL],
	[NormID] [VARCHAR](50),
	[NormName] [NVARCHAR](50),
	[PriorityID][VARCHAR](50),
	[PriorityName][NVARCHAR](50),
	[EmployeeID] [varchar] (50),
	[EmployeeName] [Nvarchar] (50),
    [Ana01ID] [VARCHAR](50),
	[Ana01Name] [NVARCHAR](50),
	[Ana02ID] [VARCHAR](50),
	[Ana02Name] [NVARCHAR](50),
	[Ana03ID] [VARCHAR](50),
	[Ana03Name] [NVARCHAR](50),
	[Ana04ID] [VARCHAR](50),
	[Ana04Name] [NVARCHAR](50),
	[Ana05ID] [VARCHAR](50),
	[Ana05Name] [NVARCHAR](50),
	[Ana06ID] [VARCHAR](50),
	[Ana06Name] [NVARCHAR](50),
	[Ana07ID] [VARCHAR](50),
	[Ana07Name] [NVARCHAR](50),
	[Ana08ID] [VARCHAR](50),
	[Ana08Name] [NVARCHAR](50),
	[Ana09ID] [VARCHAR](50),
	[Ana09Name] [NVARCHAR](50),
	[Ana10ID] [VARCHAR](50),
	[Ana10Name] [NVARCHAR](50),
	[DeleteFlag] TINYINT DEFAULT (0) NOT NULL

CONSTRAINT [PK_FNT2000_AIC] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

