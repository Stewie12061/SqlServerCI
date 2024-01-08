---- Create by Le Hoang on 01/10/2020
---- Chi tiết Nguyên vật liệu của Phiếu nhập Thông số Nguyên vật liệu

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[QCT2011]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[QCT2011](
	[APK] [uniqueidentifier] DEFAULT NEWID() NOT NULL,
	[DivisionID] [varchar](50) NOT NULL,
	[APKMaster] [uniqueidentifier] NULL,
	[MaterialID] [varchar](50) NULL,
	[BatchID] [varchar](50) NULL,
	[UnitID] [varchar](50) NULL,
	[BeginQuantity] [decimal](28, 8) NULL,
	[DebitQuantity] [decimal](28, 8) NULL,
	[CreditQuantity] [decimal](28, 8) NULL,
	[RevokeQuantity] [decimal](28, 8) NULL,
	[ReturnQuantity] [decimal](28, 8) NULL,
	[EndQuantity] [decimal](28, 8) NULL,
	[RefAPKMaster] [uniqueidentifier] NULL,
	[RefAPKDetail] [uniqueidentifier] NULL,
	[DeleteFlg] [tinyint] DEFAULT 0 NOT NULL,
	[CreateDate] [datetime] DEFAULT GETDATE() NULL,
	[CreateUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] DEFAULT GETDATE() NULL,
	[LastModifyUserID] [varchar](50) NULL,
 CONSTRAINT [PK_QCT2011] PRIMARY KEY CLUSTERED 
(
	[APK] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END

IF EXISTS (SELECT * FROM sysobjects WHERE NAME = 'QCT2011' AND xtype ='U') 
BEGIN
     IF NOT EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name = 'QCT2011' AND col.name = 'Description')
     ALTER TABLE QCT2011 ADD Description [nvarchar](250) NULL
END

--Bổ sung cột Thứ tự
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'QCT2011' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'QCT2011' AND col.name = 'Orders')
   ALTER TABLE QCT2011 ADD Orders INT NULL
END
