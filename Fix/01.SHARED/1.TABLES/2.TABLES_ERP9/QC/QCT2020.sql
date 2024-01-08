---- Create by Le Hoang on 01/10/2020
---- Phiếu xử lý hàng lỗi
---- Modified by Le Hoang on 06/11/2020 : tách lưu riêng chi tiết sang bảng QCT2021

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[QCT2020]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[QCT2020](
	[APK] [uniqueidentifier] DEFAULT NEWID() NOT NULL,
	[DivisionID] [varchar](50) NOT NULL,
	[VoucherNo] [varchar](50) NULL,
	[VoucherDate] [datetime] NULL,
	[TranMonth] [int] NULL,
	[TranYear] [int] NULL,
	[Notes] [nvarchar](250) NULL,
	[DeleteFlg] [tinyint] DEFAULT 0 NOT NULL,
	[CreateDate] [datetime] DEFAULT GETDATE() NULL,
	[CreateUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] DEFAULT GETDATE() NULL,
	[LastModifyUserID] [varchar](50) NULL,
 CONSTRAINT [PK_QCT2020] PRIMARY KEY CLUSTERED 
(
	[APK] ASC,
	[DivisionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END

If Exists (Select * From sysobjects Where name = 'QCT2020' and xtype ='U') 
Begin
     If not exists (select * from syscolumns col inner join sysobjects tab 
     On col.id = tab.id where tab.name =   'QCT2020'  and col.name = 'VoucherTypeID')
     Alter Table QCT2020 ADD VoucherTypeID [varchar](50) NULL
END

If Exists (Select * From sysobjects Where name = 'QCT2020' and xtype ='U') 
Begin
           If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'QCT2020'  and col.name = 'Description')
           Alter Table QCT2020 DROP COLUMN Description 
		   If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'QCT2020'  and col.name = 'Method')
           Alter Table QCT2020 DROP COLUMN Method 
		   If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'QCT2020'  and col.name = 'NewInventoryID')
           Alter Table QCT2020 DROP COLUMN NewInventoryID 
		   If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'QCT2020'  and col.name = 'NewBatchID')
           Alter Table QCT2020 DROP COLUMN NewBatchID 
		   If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'QCT2020'  and col.name = 'NewQuantity')
           Alter Table QCT2020 DROP COLUMN NewQuantity 
		   If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'QCT2020'  and col.name = 'Notes01')
           Alter Table QCT2020 DROP COLUMN Notes01 
		   If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'QCT2020'  and col.name = 'Notes02')
           Alter Table QCT2020 DROP COLUMN Notes02 
		   If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'QCT2020'  and col.name = 'Notes03')
           Alter Table QCT2020 DROP COLUMN Notes03 
		   If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'QCT2020'  and col.name = 'RefAPKMaster')
           Alter Table QCT2020 DROP COLUMN RefAPKMaster 
		   If exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'QCT2020'  and col.name = 'RefAPKDetail')
           Alter Table QCT2020 DROP COLUMN RefAPKDetail 
End

---- [Le Hoang] Bổ sung các trường kế thừa thông tin Ngày sx, Ca, Máy [03/03/2021]
If Exists (Select * From sysobjects Where name = 'QCT2020' and xtype ='U') 
Begin
     If not exists (select * from syscolumns col inner join sysobjects tab 
     On col.id = tab.id where tab.name =   'QCT2020'  and col.name = 'InheritDate')
     Alter Table QCT2020 ADD InheritDate DATETIME NULL
END

If Exists (Select * From sysobjects Where name = 'QCT2020' and xtype ='U') 
Begin
     If not exists (select * from syscolumns col inner join sysobjects tab 
     On col.id = tab.id where tab.name =   'QCT2020'  and col.name = 'InheritShift')
     Alter Table QCT2020 ADD InheritShift [varchar](50) NULL
END

If Exists (Select * From sysobjects Where name = 'QCT2020' and xtype ='U') 
Begin
     If not exists (select * from syscolumns col inner join sysobjects tab 
     On col.id = tab.id where tab.name =   'QCT2020'  and col.name = 'InheritMachine')
     Alter Table QCT2020 ADD InheritMachine [varchar](50) NULL
END