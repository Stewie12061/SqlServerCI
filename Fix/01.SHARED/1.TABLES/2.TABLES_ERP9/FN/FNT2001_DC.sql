-- <Summary>
---- 
-- <History>
---- Bang Detail ke hoach thu chi - Dieu chinh
---- Create on 26/12/2018 by Như Hàn
---- Modified on ... by ...:
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WITH (NOLOCK) WHERE object_id = OBJECT_ID(N'[dbo].[FNT2001_DC]') AND type in (N'U'))
CREATE TABLE [dbo].[FNT2001_DC](
    [APK] [UNIQUEIDENTIFIER] DEFAULT NEWID(),
	[APKMaster] [UNIQUEIDENTIFIER],
	[DivisionID] [VARCHAR] (50) NOT NULL,
	[Orders] [INT],
	[JobName] [NVARCHAR](500),
	[OriginalAmount] [DECIMAL] (28,8),
	[ConvertedAmount] [DECIMAL] (28,8),
	[ApprovalOAmount] [DECIMAL] (28,8),
	[ApprovalCAmount] [DECIMAL] (28,8),
	[StatusDetail] [INT],
	[ApprovalNotes] [NVARCHAR](500),
	[ObjectTransferID] [VARCHAR] (50),
	[ObjectBeneficiaryID] [VARCHAR] (50),
	[NormID] [VARCHAR](50),
	[ResponsibleID] [VARCHAR](50),
	[ObjectProposalID] [VARCHAR](50),
    [Ana01ID] [VARCHAR](50),
	[Ana02ID] [VARCHAR](50),
	[Ana03ID] [VARCHAR](50),
	[Ana04ID] [VARCHAR](50),
	[Ana05ID] [VARCHAR](50),
	[Ana06ID] [VARCHAR](50),
	[Ana07ID] [VARCHAR](50),
	[Ana08ID] [VARCHAR](50),
	[Ana09ID] [VARCHAR](50),
	[Ana10ID] [VARCHAR](50),
	[ContractAmount] [DECIMAL] (28,8),
	[Accumulated] [DECIMAL] (28,8),
	[ExtantPayment] [DECIMAL] (28,8),
	[ProvinceID] [VARCHAR](50),
	[Notes]	[NVARCHAR](500),
	[OverdueID] [VARCHAR](50),
	[OverdueDay] [NVARCHAR](50),
	[DateHaveFile] [Datetime],
	[StatusFileID] [INT],
	[AmountApproval] [DECIMAL] (28,8),
	[AmountEstimation] [DECIMAL] (28,8),
	[DeleteFlag] TINYINT DEFAULT (0) NULL,
	[InheritTableID] [VARCHAR] (50),
	[InheritVoucherID] [VARCHAR] (50),
	[InheritTransactionID] [VARCHAR] (50)

CONSTRAINT [PK_FNT2001_DC] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

