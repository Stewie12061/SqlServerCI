-- <Summary>
---- Thông tin Pallet Master
-- <History>
---- Create on 29/08/2019 by Khánh Đoan

---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WT2001]') AND type in (N'U'))
CREATE TABLE [dbo].[WT2001](
	[APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
	[DivisionID] VARCHAR(50) NOT NULL,
	[VoucherTypeID]VARCHAR(50) NOT NULL,
	[VoucherNo]VARCHAR(50) NOT NULL,
	[VoucherID]VARCHAR(50) NOT NULL,
	[VoucherDate]DATETIME NULL,
	[LocationID] VARCHAR(50) NULL,
	[KindVoucherID] INT NULL,
	[TranMonth]INT NULL,
	[TranYear] INT NULL,
	[ObjectID]	NVARCHAR(50) NULL,
	[WareHouseID]VARCHAR(50) NULL,
	[Orders]	INT NULL,
	[Description] NVARCHAR(250) NULL,
	[DeleteFlg] TINYINT DEFAULT (0) NOT NULL,
	[CreateUserID] VARCHAR(50)NULL,
	[CreateDate] DATETIME NULL,
	[LastModifyUserID] VARCHAR(50) NULL,
	[LastModifyDate] DATETIME NULL
 CONSTRAINT [PK_WT2001] PRIMARY KEY NONCLUSTERED 
(
	[APK],
	[DivisionID]
	
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

--Huỳnh Thử Date 27/03/2020 Thêm cột đã di chuyển pallet
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE NAME='AT9000' AND xtype='U')
	BEGIN
		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='WT2001' AND col.name='IsMove')
		ALTER TABLE WT2001 ADD IsMove BIGINT DEFAULT 0

		IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab 
		ON col.id=tab.id WHERE tab.name='WT2001' AND col.name='IsRent')
		ALTER TABLE WT2001 ADD IsRent BIGINT DEFAULT 0
	END
