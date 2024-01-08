---- Create by Le Hoang on 01/10/2020
---- Danh mục Tiêu chuẩn

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[QCT1000]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[QCT1000](
	[APK] [uniqueidentifier] DEFAULT NEWID() NOT NULL,
	[DivisionID] [varchar](50) NOT NULL,
	[StandardID] [varchar](50) NOT NULL,
	[StandardName] [nvarchar](250) NULL,
	[StandardNameE] [nvarchar](250) NULL,
	[UnitID] [varchar](50) NOT NULL DEFAULT (''),
	[Description] [nvarchar](max) NULL,
	[Disabled] [tinyint] DEFAULT 0 NOT NULL,
	[IsCommon] [tinyint] DEFAULT 0 NOT NULL,
	[IsDefault] [tinyint] DEFAULT 0 NULL,
	[IsVisible] [tinyint] DEFAULT 0 NULL,
	[TypeID] [varchar](50) NULL,
	[ParentID] [varchar](50) NULL,
	[DataType] [int] DEFAULT 0 NOT NULL,
	[CreateUserID] [varchar](50) NULL,
	[CreateDate] [datetime] DEFAULT GETDATE() NULL,
	[LastModifyUserID] [varchar](50) NULL,
	[LastModifyDate] [datetime] DEFAULT GETDATE() NULL,
 CONSTRAINT [PK_QCT1000] PRIMARY KEY CLUSTERED 
(
	[DivisionID] ASC,
	[StandardID] ASC,
	[UnitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END

IF (OBJECT_ID('dbo.DF_QCT1000_UnitID', 'D') IS NOT NULL)
BEGIN
    ALTER TABLE QCT1000 DROP CONSTRAINT DF_QCT1000_UnitID
	ALTER TABLE QCT1000 ADD CONSTRAINT DF_QCT1000_UnitID DEFAULT '' FOR UnitID;
END

If Exists (Select * From sysobjects Where name = 'QCT1000' and xtype ='U') 
Begin
     If exists (select * from syscolumns col inner join sysobjects tab 
     On col.id = tab.id where tab.name =   'QCT1000'  and col.name = 'StandardNameE')
     Alter Table QCT1000 Alter column StandardNameE [nvarchar](250) NULL
END

If Exists (Select * From sysobjects Where name = 'QCT1000' and xtype ='U') 
Begin
     If not exists (select * from syscolumns col inner join sysobjects tab 
     On col.id = tab.id where tab.name = 'QCT1000' and col.name = 'CalculateType')
     Alter Table QCT1000 Add CalculateType [nvarchar](50) NULL
END

---- Cập nhật - Đình Ly on 31/12/2020 ----
---- Cột công đoạn sản xuất
If Exists (Select * From sysobjects Where name = 'QCT1000' and xtype ='U') 
Begin
     If not exists (select * from syscolumns col inner join sysobjects tab 
     On col.id = tab.id where tab.name = 'QCT1000' and col.name = 'PhaseID')
     Alter Table QCT1000 Add PhaseID [varchar](50) NULL
END

---- Cột tên hiển thị (xác định nguyên vật liệu).
If Exists (Select * From sysobjects Where name = 'QCT1000' and xtype ='U') 
Begin
     If not exists (select * from syscolumns col inner join sysobjects tab 
     On col.id = tab.id where tab.name = 'QCT1000' and col.name = 'DisplayName')
     Alter Table QCT1000 Add DisplayName [varchar](250) NULL
END

---- Cột thông số kỹ thuật
If Exists (Select * From sysobjects Where name = 'QCT1000' and xtype ='U') 
Begin
     If not exists (select * from syscolumns col inner join sysobjects tab 
     On col.id = tab.id where tab.name = 'QCT1000' and col.name = 'Specification')
     Alter Table QCT1000 Add Specification [varchar](50) NULL
END

---- Cột công thức tính
If Exists (Select * From sysobjects Where name = 'QCT1000' and xtype ='U') 
Begin
     If not exists (select * from syscolumns col inner join sysobjects tab 
     On col.id = tab.id where tab.name = 'QCT1000' and col.name = 'Recipe')
     Alter Table QCT1000 Add Recipe [varchar](500) NULL
END

---- Cột có khai báo công thức cho thông số kỹ thuật.
If Exists (Select * From sysobjects Where name = 'QCT1000' and xtype ='U') 
Begin
     If not exists (select * from syscolumns col inner join sysobjects tab 
     On col.id = tab.id where tab.name = 'QCT1000' and col.name = 'DeclareSO')
     Alter Table QCT1000 Add DeclareSO tinyint NULL
END

---- Cột sử dụng Nguyên vật liệu.
If Exists (Select * From sysobjects Where name = 'QCT1000' and xtype ='U') 
Begin
     If not exists (select * from syscolumns col inner join sysobjects tab 
     On col.id = tab.id where tab.name = 'QCT1000' and col.name = 'UsingMaterialID')
     Alter Table QCT1000 Add UsingMaterialID tinyint NULL
END

---- Thay đổi đồ dài trường ParentID
If Exists (Select * From sysobjects Where name = 'QCT1000' and xtype ='U') 
Begin
     If exists (select * from syscolumns col inner join sysobjects tab 
     On col.id = tab.id where tab.name =   'QCT1000'  and col.name = 'ParentID')
     Alter Table QCT1000 Alter column ParentID [varchar](MAX) NULL
END

---- Đình Hòa [04/06/2021] - Thêm cột loại cho bảng tính giá
If Exists (Select * From sysobjects Where name = 'QCT1000' and xtype ='U') 
Begin
     If not exists (select * from syscolumns col inner join sysobjects tab 
     On col.id = tab.id where tab.name = 'QCT1000' and col.name = 'TypeSpreadsheetID')
     Alter Table QCT1000 ADD TypeSpreadsheetID [varchar](100) NULL
END

