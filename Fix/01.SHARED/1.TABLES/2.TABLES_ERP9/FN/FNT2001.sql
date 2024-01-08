-- <Summary>
---- 
-- <History>
---- Bang Detail ke hoach thu chi
---- Create on 01/11/2018 by Như Hàn
---- Modified on 28/02/2019 by Như Hàn: Điều chỉnh KHTC
---- Modified on 20/03/2019 by Như Hàn: Bổ sung các trường thông tin duyệt
---- Modified on ... by ...: 
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WITH (NOLOCK) WHERE object_id = OBJECT_ID(N'[dbo].[FNT2001]') AND type in (N'U'))
CREATE TABLE [dbo].[FNT2001](
    [APK] [UNIQUEIDENTIFIER] DEFAULT NEWID(),
	[APKMaster] [UNIQUEIDENTIFIER],
	[DivisionID] [VARCHAR] (50) NOT NULL,
	[Orders] [INT],
	[JobName] [NVARCHAR](500),
	[OriginalAmount] [DECIMAL] (28,8),
	[ConvertedAmount] [DECIMAL] (28,8),
	--[ApprovalOAmount] [DECIMAL] (28,8), --- Đổi tên lại
	--[ApprovalCAmount] [DECIMAL] (28,8), --- Đổi tên lại
	[StatusDetail] [INT],
	[ApprovalNotes] [NVARCHAR](500),
	--[ObjectTransferID] [VARCHAR] (50),--- bổ sung lại ở đoạn edit, ok
	[ObjectBeneficiaryID] [VARCHAR] (50),
	[NormID] [VARCHAR](50),
	--[ResponsibleID] [VARCHAR](50),  --- bổ sung lại ở đoạn edit, ok
	--[ObjectProposalID] [VARCHAR](50), --- bổ sung lại ở đoạn edit, ok
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
	--[ContractAmount] [DECIMAL] (28,8), --- bổ sung lại ở đoạn edit, ok
	--[Accumulated] [DECIMAL] (28,8), --- bổ sung lại ở đoạn edit, ok
	--[ExtantPayment] [DECIMAL] (28,8), --- bổ sung lại ở đoạn edit, ok
	--[ProvinceID] [VARCHAR](50), --- bổ sung lại ở đoạn edit, ok
	[Notes]	[NVARCHAR](500),
	--[OverdueID] [VARCHAR](50), --- bổ sung lại ở đoạn edit, ok
	--[OverdueDay] [NVARCHAR](50), --- bổ sung lại ở đoạn edit, ok
	--[DateHaveFile] [Datetime], --- bổ sung lại ở đoạn edit, ok
	--[StatusFileID] [INT],--- bổ sung lại ở đoạn edit, ok
	--[AmountApproval] [DECIMAL] (28,8),--- bổ sung lại ở đoạn edit, ok
	--[AmountEstimation] [DECIMAL] (28,8),--- bổ sung lại ở đoạn edit, ok
	--[Delegacy] [NVARCHAR](100),--- bổ sung lại ở đoạn edit, ok
	--[WeekNo] [NVARCHAR](100),--- bổ sung lại ở đoạn edit, ok
	--[AmountApprovalBOD] [DECIMAL] (28,8),--- bổ sung lại ở đoạn edit, ok
	--[ApprovalDes] [NVARCHAR](500),--- bổ sung lại ở đoạn edit, ok
	--[TCKTDebt] [NVARCHAR](250),--- bổ sung lại ở đoạn edit, ok
	--[TCKTExpired] [NVARCHAR](250),--- bổ sung lại ở đoạn edit, ok
	--[TCKTDisbursement] [NVARCHAR](250),--- bổ sung lại ở đoạn edit, ok
	--[TCKTGeneral] [NVARCHAR](250),--- bổ sung lại ở đoạn edit, ok
	--[TCKTGuarantee] [NVARCHAR](250),--- bổ sung lại ở đoạn edit, ok
	--[TCKTAmountApproval] [DECIMAL] (28,8),--- bổ sung lại ở đoạn edit, ok
	--[TCKTApprovalDes] [NVARCHAR](500),--- bổ sung lại ở đoạn edit, ok
	[DeleteFlag] TINYINT DEFAULT (0) NULL,
	--[InheritTableID] [VARCHAR] (50),--- bổ sung lại ở đoạn edit
	--[InheritVoucherID] [VARCHAR] (50),--- bổ sung lại ở đoạn edit
	--[InheritTransactionID] [VARCHAR] (50)--- bổ sung lại ở đoạn edit

CONSTRAINT [PK_FNT2001] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'FNT2001' AND xtype = 'U')
BEGIN 
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'PaymentDate') 
   ALTER TABLE FNT2001 ADD PaymentDate Datetime NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'POAmount') 
   ALTER TABLE FNT2001 ADD POAmount DECIMAL(28,8) NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'PCAmount') 
   ALTER TABLE FNT2001 ADD PCAmount DECIMAL(28,8) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'ObjectTransferID') 
   ALTER TABLE FNT2001 ADD ObjectTransferID VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'ObjectProposalID') 
   ALTER TABLE FNT2001 ADD ObjectProposalID VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'ContractAmount') 
   ALTER TABLE FNT2001 ADD ContractAmount DECIMAL(28,8) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'Accumulated') 
   ALTER TABLE FNT2001 ADD Accumulated DECIMAL(28,8) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'ExtantPayment') 
   ALTER TABLE FNT2001 ADD ExtantPayment DECIMAL(28,8) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'ProvinceID') 
   ALTER TABLE FNT2001 ADD ProvinceID VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'OverdueID') 
   ALTER TABLE FNT2001 ADD OverdueID VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'OverdueDay') 
   ALTER TABLE FNT2001 ADD OverdueDay VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'StatusFileID') 
   ALTER TABLE FNT2001 ADD StatusFileID INT NULL 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'AmountApproval') 
   ALTER TABLE FNT2001 ADD AmountApproval DECIMAL(28,8) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'AmountEstimation') 
   ALTER TABLE FNT2001 ADD AmountEstimation DECIMAL(28,8) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'Delegacy') 
   ALTER TABLE FNT2001 ADD Delegacy NVARCHAR(100) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'WeekNo') 
   ALTER TABLE FNT2001 ADD WeekNo NVARCHAR(100) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'AmountApprovalBOD') 
   ALTER TABLE FNT2001 ADD AmountApprovalBOD DECIMAL(28,8) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'ApprovalDes') 
   ALTER TABLE FNT2001 ADD ApprovalDes NVARCHAR(500) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'TCKTDebt') 
   ALTER TABLE FNT2001 ADD TCKTDebt NVARCHAR(250) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'TCKTExpired') 
   ALTER TABLE FNT2001 ADD TCKTExpired NVARCHAR(250) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'TCKTDisbursement') 
   ALTER TABLE FNT2001 ADD TCKTDisbursement NVARCHAR(250) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'TCKTGeneral') 
   ALTER TABLE FNT2001 ADD TCKTGeneral NVARCHAR(250) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'TCKTGuarantee') 
   ALTER TABLE FNT2001 ADD TCKTGuarantee NVARCHAR(250) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'TCKTAmountApproval') 
   ALTER TABLE FNT2001 ADD TCKTAmountApproval DECIMAL (28,8) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'TCKTApprovalDes') 
   ALTER TABLE FNT2001 ADD TCKTApprovalDes NVARCHAR(250) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'InheritTableID') 
   ALTER TABLE FNT2001 ADD InheritTableID VARCHAR(50) NULL
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'InheritVoucherID') 
   ALTER TABLE FNT2001 ADD InheritVoucherID VARCHAR(50) NULL
   
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'InheritTransactionID') 
   ALTER TABLE FNT2001 ADD InheritTransactionID VARCHAR(50) NULL
   
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'ApprovalOriginalAmount')
   EXEC sp_rename 'FNT2001.ApprovalOriginalAmount', 'ApprovalOAmount', 'COLUMN';

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'ApprovalConvertedAmount')
   EXEC sp_rename 'FNT2001.ApprovalConvertedAmount', 'ApprovalCAmount', 'COLUMN';

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'ResponsibleID') 
   ALTER TABLE FNT2001 ADD ResponsibleID VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'DateHaveFile') 
   ALTER TABLE FNT2001 ADD DateHaveFile Datetime NULL 

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'StatusFileID') 
   ALTER TABLE FNT2001 ALTER COLUMN StatusFileID VARCHAR(50) NULL

END



IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'FNT2001' AND xtype = 'U')
BEGIN 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'APKMaster_9000') 
   ALTER TABLE FNT2001 ADD APKMaster_9000 VARCHAR(50) NULL

   	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'ApproveLevel') 
		ALTER TABLE FNT2001 ADD ApproveLevel TINYINT NOT NULL DEFAULT(0)

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'ApprovingLevel') 
		ALTER TABLE FNT2001 ADD ApprovingLevel TINYINT NOT NULL DEFAULT(0)

	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id = tab.id WHERE tab.name = 'FNT2001' AND col.name = 'Status') 
		ALTER TABLE FNT2001 ADD Status TINYINT NOT NULL DEFAULT(0)
END



