-- <Summary>
---- 
-- <History>
---- Create by Tiểu Mai on 19/01/2016: Add table master for Angel (CustomizeIndex = 57) 
---- Modified on ... by ...
---- <Example>
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OT0149]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OT0149](
	[APK] [uniqueidentifier] DEFAULT NEWID(),
	[DivisionID] [nvarchar](50) NOT NULL,
	[VoucherID] [nvarchar](50) NOT NULL,
	[VoucherTypeID] [nvarchar](50) NULL,
	[VoucherNo] [nvarchar](50) NULL,
	[VoucherDate] [datetime] NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,	
	[Description] [nvarchar](250) NULL,
	[PlanPrice] [nvarchar](50) NULL,
	[InventoryTypeID] [nvarchar] (50) NULL,
	[EmployeeID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUserID] [nvarchar](50) NULL,
	[LastModifyDate] [datetime] NULL,
	[LastModifyUserID] [nvarchar](50) NULL,
	CONSTRAINT [PK_OT0149] PRIMARY KEY NONCLUSTERED 
(
	[DivisionID],
	[VoucherID]
    )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END

--- 22/10/2020 - Trọng Kiên: Bổ sung cột PlanTypeID
IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	   ON col.id = tab.id WHERE tab.name = 'OT0149' AND col.name = 'PlanTypeID')
BEGIN
	ALTER TABLE OT0149 ADD PlanTypeID VARCHAR(50) NULL
END

IF EXISTS (SELECT * FROM sysobjects WHERE NAME='OT0149' AND xtype='U')
BEGIN
	IF EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
	ON col.id=tab.id WHERE tab.name='OT0149' AND col.name='DivisionID')
	Alter Table OT0149
		Alter column DivisionID [nvarchar](50) NOT NULL
END	
