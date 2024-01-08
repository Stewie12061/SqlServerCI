-- <Summary>
---- 
-- <History>
--- Master Ngân sách
---- Create on 12/11/2018 by Như Hàn 
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TT2100]') AND type in (N'U'))
CREATE TABLE [dbo].[TT2100](
    [APK] [uniqueidentifier] DEFAULT NEWID() NOT NULL,
    [DivisionID] [varchar] (50) NOT NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[VoucherTypeID] [varchar](50) NULL,
	[VoucherNo] [varchar](50) NULL,
	[VoucherDate] [datetime] NULL,
	[BudgetType] [varchar](5) NULL,
	[Description] [nvarchar](250) NULL,
	[CurrencyID] [varchar](50) NULL,
	[ExchangeRate] [decimal](28, 8) NULL,
	[DepartmentID] [varchar](50) NULL,
	[Status] [Int] NOT NULL,
	[ApprovalDate] [datetime] NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [varchar](50) NULL,
	[DeleteFlag] TINYINT DEFAULT (0) NOT NULL
CONSTRAINT [PK_TT2100] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'TT2100' AND xtype = 'U')
BEGIN 

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'TT2100' AND col.name = 'APKMaster_9000') 
   ALTER TABLE TT2100 ADD APKMaster_9000 VARCHAR(50) NULL

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'TT2100' AND col.name = 'MonthBP') 
   ALTER TABLE TT2100 ADD MonthBP NVARCHAR(50) NULL ----Month của Kỳ ngân sách

   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
   ON col.id = tab.id WHERE tab.name = 'TT2100' AND col.name = 'YearBP') 
   ALTER TABLE TT2100 ADD YearBP NVARCHAR(50) NULL ----Year của Kỳ ngân sách

END

---------------- 24/08/2021 - Lê Hoàng: Bổ sung trường Loại Ngân sách chi phí / doanh thu ----------------
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'TT2100' AND xtype = 'U')
BEGIN 
	IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
    ON col.id = tab.id WHERE tab.name = 'TT2100' AND col.name = 'BudgetKindID') 
    ALTER TABLE TT2100 ADD BudgetKindID VARCHAR(50) NULL
END

