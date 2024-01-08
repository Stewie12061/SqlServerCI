---- Create by Cao Thị Phượng on 12/8/2017 1:59:35 PM
---- Bảng giá bán theo gói (Master)

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CT0146]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CT0146]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [PackagePriceID] VARCHAR(50) NOT NULL,
  [PackagePriceName] NVARCHAR(250) NOT NULL,
  [FromDate] DATETIME NOT NULL,
  [ToDate] DATETIME NOT NULL,
  [IsCommon] TINYINT DEFAULT (0) NULL,
  [Disabled] TINYINT DEFAULT (0) NULL,
  [InventoryTypeID] VARCHAR(50) NULL,
  [Description] NVARCHAR(250) NULL,
  [CreateDate] DATETIME NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL
CONSTRAINT [PK_CT0146] PRIMARY KEY CLUSTERED
(
  [DivisionID],
  [PackagePriceID]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

-- Danh - 2018/04/13 Thêm trường xử lý bảng giá trước/sau thuế
If Exists (Select * From sysobjects Where name = 'CT0146' and xtype ='U') 
Begin
           If not exists (select * from syscolumns col inner join sysobjects tab 
           On col.id = tab.id where tab.name =   'CT0146'  and col.name = 'IsTaxIncluded')
           Alter Table  CT0146 Add IsTaxIncluded tinyint Null DEFAULT (0)
End
