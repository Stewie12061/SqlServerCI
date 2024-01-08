-- <Summary>
---- 
-- <History>
---- Bang Master ke hoach thu chi
---- Create on 01/11/2018 by Như Hàn
---- Modified on 20/03/2019 by Như Hàn: Bổ sung các trường thông tin duyệt
---- Modified on ... by ...:
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WITH (NOLOCK) WHERE object_id = OBJECT_ID(N'[dbo].[FNT2000]') AND type in (N'U'))
CREATE TABLE [dbo].[FNT2000](
    [APK] [uniqueidentifier] DEFAULT NEWID(),
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
	--[TypeID] [varchar] (50) DEFAULT 'PB', --- Loại kế hoạch thu chi tổng hợp (TH) hay từng phòng ban (PB)
	[ApprovalDate] [Datetime],
	--[ApprovalDescriptions] [nvarchar] (500),
	[CreateUserID] VARCHAR(50) NULL,
    [CreateDate] DATETIME NULL,
    [LastModifyUserID] VARCHAR(50) NULL,
    [LastModifyDate] DATETIME NULL,
	[DeleteFlag] TINYINT DEFAULT (0) NOT NULL

CONSTRAINT [PK_FNT2000] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'FNT2000' AND xtype = 'U')
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2000' AND col.name = 'TypeID') 
   ALTER TABLE FNT2000 ADD TypeID VARCHAR(50) NULL

   	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2000' AND col.name = 'TransactionType') 
   ALTER TABLE FNT2000 ADD TransactionType VARCHAR(50) NULL

   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2000' AND col.name = 'APKMaster') 
   ALTER TABLE FNT2000 DROP COLUMN APKMaster;

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2000' AND col.name = 'ApprovalDescriptions') 
   ALTER TABLE FNT2000 ADD ApprovalDescriptions NVARCHAR(500) NULL

END


IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'FNT2000' AND xtype = 'U')
BEGIN 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'FNT2000' AND col.name = 'APKMaster_9000') 
   ALTER TABLE FNT2000 ADD APKMaster_9000 VARCHAR(50) NULL

END