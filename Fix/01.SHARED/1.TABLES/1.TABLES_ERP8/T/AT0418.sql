-- <Summary>
---- Danh mục chuyển nhượng thanh toán
-- <History>
---- Create on Kiều Nga on 31/03/2022

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[AT0418]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[AT0418](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
    [DivisionID] VARCHAR(50) NOT NULL,
	[TranMonth] INT NULL,
	[TranYear] INT NULL,
	[TransactionTypeID] TINYINT NULL, -- 0 chuyển nhượng , 1 thanh lý
	[ContractNo] VARCHAR(50) NULL,
	[NewContractNo] VARCHAR(50) NULL,
	[NewObjectID] VARCHAR(50)  NULL,
	[TransactionDate] DATETIME  NULL,
	[BeginDateTranfer] DATETIME  NULL,
	[Reason] NVARCHAR(250) NULL,
	[CreateEmployeeID] VARCHAR(50) NULL,
	[Note] NVARCHAR(250) NULL,
    [CreateUserID] VARCHAR(50) NULL,
    [CreateDate] DATETIME NULL,
    [LastModifyUserID] VARCHAR(50) NULL,
    [LastModifyDate] DATETIME NULL
	CONSTRAINT [PK_AT0418] PRIMARY KEY NONCLUSTERED 
	(
		[APK] ASC
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON

)) ON [PRIMARY]
END
