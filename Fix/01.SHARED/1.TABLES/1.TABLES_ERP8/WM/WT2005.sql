-- <Summary>
---- Thông tin Pallet Master
-- <History>
---- Create on 29/08/2019 by Khánh Đoan

---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WT2005]') AND type in (N'U'))
CREATE TABLE [dbo].[WT2005](
	[APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
	[DivisionID] VARCHAR(50) NOT NULL,
	[VoucherID]VARCHAR(50) NOT NULL,
	[VoucherNo]VARCHAR(50) NOT NULL,
	[VoucherDate]DATETIME NULL,
	[LocationIDOld] VARCHAR(50) NULL,
	[LocationIDNew] VARCHAR(50) NULL,
	[TranMonth]INT NULL,
	[TranYear] INT NULL,
	[Description] NVARCHAR(250) NULL,
	[DeleteFlg] TINYINT DEFAULT (0) NOT NULL,
	[CreateUserID] VARCHAR(50)NULL,
	[CreateDate] DATETIME NULL,
	[LastModifyUserID] VARCHAR(50) NULL,
	[LastModifyDate] DATETIME NULL
 CONSTRAINT [PK_WT2005] PRIMARY KEY NONCLUSTERED 
(
	[APK],
	[DivisionID]
	
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


