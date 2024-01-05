-- <Summary>
---- 
-- <History>
---- Bang Master ke hoach thu chi _ Dieu chinh
---- Create on 26/12/2018 by Như Hàn
---- Modified on ... by ...:
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WITH (NOLOCK) WHERE object_id = OBJECT_ID(N'[dbo].[FNT2000_DC]') AND type in (N'U'))
CREATE TABLE [dbo].[FNT2000_DC](
    [APK] [uniqueidentifier] DEFAULT NEWID(),
	[FNT2000APK] [uniqueidentifier], 
	[ModifyNo] [INT] NOT NULL, 
	[TypeID] [varchar] (50) NOT NULL, --- Loại kế hoạch thu chi tổng hợp hay từng phòng ban
    [DivisionID] [varchar] (50) NOT NULL,
	[TranMonth] [INT] NULL,
	[TranYear] [INT] NULL,
	[VoucherTypeID] [varchar] (50) NOT NULL,
	[VoucherNo] [nvarchar] (50) NOT NULL,
	[VoucherDate] [Datetime] NULL,
	[EmployeeID] [varchar] (50) NULL,
	[TransactionType] [varchar] (50) NULL,
	[PayMentTypeID] [varchar] (50) NULL,
	[PayMentPlanDate] [Datetime] NULL,
	[CurrencyID] [varchar] (50) NULL,
	[ExchangeRate] [decimal] NULL,
	[Descriptions] [nvarchar] (500),
	[PriorityID] [varchar] (50) NULL,
	[Status] [INT], 
	[ApprovalDate] [Datetime],
	[ApprovalDescriptions] [nvarchar] (500),
	[CreateUserID] VARCHAR(50) NULL,
    [CreateDate] DATETIME NULL,
    [LastModifyUserID] VARCHAR(50) NULL,
    [LastModifyDate] DATETIME NULL,
	[DeleteFlag] TINYINT DEFAULT (0) NOT NULL

CONSTRAINT [PK_FNT2000_DC] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC

)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

