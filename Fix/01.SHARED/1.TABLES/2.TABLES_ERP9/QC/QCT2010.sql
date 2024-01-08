---- Create by Le Hoang on 01/10/2020
---- Phiếu nhập Thông số Nguyên vật liệu, Thông số Kỹ thuật, Thông số vận hành Máy.

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[QCT2010]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[QCT2010](
	[APK] [uniqueidentifier] DEFAULT NEWID() NOT NULL,
	[DivisionID] [varchar](50) NOT NULL,
	[VoucherID] [varchar](50) NULL,
	[VoucherNo] [varchar](50) NULL,
	[VoucherDate] [datetime] NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[VoucherType] [int] NULL,
	[Notes] [nvarchar](250) NULL,
	[APKMaster] [uniqueidentifier] NULL,
	[DeleteFlg] [tinyint] DEFAULT 0 NOT NULL,
	[CreateDate] [datetime] DEFAULT GETDATE() NULL,
	[CreateUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] DEFAULT GETDATE() NULL,
	[LastModifyUserID] [varchar](50) NULL,
 CONSTRAINT [PK_QCT2010] PRIMARY KEY CLUSTERED 
(
	[APK] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END

If Exists (Select * From sysobjects Where name = 'QCT2010' and xtype ='U') 
Begin
     If not exists (select * from syscolumns col inner join sysobjects tab 
     On col.id = tab.id where tab.name =   'QCT2010'  and col.name = 'VoucherTypeID')
     Alter Table QCT2010 ADD VoucherTypeID [varchar](50) NULL
END

---- [Le Hoang] Bổ sung các trường kế thừa thông tin Ngày sx, Ca, Máy [20/01/2021]
If Exists (Select * From sysobjects Where name = 'QCT2010' and xtype ='U') 
Begin
     If not exists (select * from syscolumns col inner join sysobjects tab 
     On col.id = tab.id where tab.name =   'QCT2010'  and col.name = 'InheritDate')
     Alter Table QCT2010 ADD InheritDate DATETIME NULL
END

If Exists (Select * From sysobjects Where name = 'QCT2010' and xtype ='U') 
Begin
     If not exists (select * from syscolumns col inner join sysobjects tab 
     On col.id = tab.id where tab.name =   'QCT2010'  and col.name = 'InheritShift')
     Alter Table QCT2010 ADD InheritShift [varchar](50) NULL
END

If Exists (Select * From sysobjects Where name = 'QCT2010' and xtype ='U') 
Begin
     If not exists (select * from syscolumns col inner join sysobjects tab 
     On col.id = tab.id where tab.name =   'QCT2010'  and col.name = 'InheritMachine')
     Alter Table QCT2010 ADD InheritMachine [varchar](50) NULL
END