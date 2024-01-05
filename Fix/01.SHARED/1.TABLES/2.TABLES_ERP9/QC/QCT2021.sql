---- Create by Le Hoang on 06/11/2020
---- Chi tiết Phiếu xử lý hàng lỗi

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[QCT2021]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[QCT2021](
	[APK] [uniqueidentifier] DEFAULT NEWID() NOT NULL,
	[DivisionID] [varchar](50) NOT NULL,
	[APKMaster] [uniqueidentifier] NOT NULL,
	[Description] [nvarchar](250) NULL,
	[Method] [varchar](50) NULL,
	[NewInventoryID] [varchar](50) NULL,
	[NewBatchID] [varchar](50) NULL,
	[NewQuantity] [decimal](28, 8) NULL,
	[MaterialID] [nvarchar](50) NULL,
	[MaterialUnitID] [nvarchar](50) NULL,
	[MaterialQuantity] [decimal](28, 8) NULL,
	[Notes01] [nvarchar](250) NULL,
	[Notes02] [nvarchar](250) NULL,
	[Notes03] [nvarchar](250) NULL,
	[RefAPKMaster] [uniqueidentifier] NULL,
	[RefAPKDetail] [uniqueidentifier] NULL,
	[DeleteFlg] [tinyint] DEFAULT 0 NOT NULL,
	[CreateDate] [datetime] DEFAULT GETDATE() NULL,
	[CreateUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] DEFAULT GETDATE() NULL,
	[LastModifyUserID] [varchar](50) NULL,
 CONSTRAINT [PK_QCT2021] PRIMARY KEY CLUSTERED 
(
	[APK] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END


If Exists (Select * From sysobjects Where name = 'QCT2021' and xtype ='U') 
Begin
     If exists (select * from syscolumns col inner join sysobjects tab 
     On col.id = tab.id where tab.name =   'QCT2021'  and col.name = 'Method')
     Alter Table QCT2021 Alter column Method [varchar](50) NULL
END

--Bổ sung cột Thứ tự
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'QCT2021' AND xtype = 'U')
BEGIN
   IF NOT EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'QCT2021' AND col.name = 'Orders')
   ALTER TABLE QCT2021 ADD Orders INT NULL
END