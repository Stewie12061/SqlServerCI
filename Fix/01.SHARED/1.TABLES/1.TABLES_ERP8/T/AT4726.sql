-- <Summary>
---- 
-- <History>
---- Create on 16/04/2019 by Kim Thư: Bảng chứa số liệu tính doanh thu cho báo cáo quản trị dạng 2
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AT4726]') AND type in (N'U'))
CREATE TABLE [dbo].[AT4726](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] NVARCHAR(50) NOT NULL,
	[AccountID] NVARCHAR(50) NULL,
	[CorAccountID] NVARCHAR(50) NULL,
	[SignAmount] DECIMAL(28,8) NULL,
	[SignOriginal] DECIMAL(28,8) NULL,
	[TranMonth] INT NULL,
	[TranYear] INT NULL,
	[TransactionTypeID] NVARCHAR(50) NULL,
	[BudgetID] NVARCHAR(50) NULL,
	[D_C] NVARCHAR(3) NULL,
	[Level01] NVARCHAR(50) NULL,
	[Level02] NVARCHAR(50) NULL
	CONSTRAINT [PK_AT4726] PRIMARY KEY NONCLUSTERED 
(
	[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

) ON [PRIMARY]

