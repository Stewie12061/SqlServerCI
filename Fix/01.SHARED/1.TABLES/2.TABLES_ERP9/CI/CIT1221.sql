-- <Summary> Danh mục thiết lập chương trình khuyến mãi theo điều kiện ( Chi tiết điều kiện) (Detail 1)
-- <History>
---- Create on 19/04/2023 by Lê Thanh Lượng 
---- Modified on ... by ...
---- <Example>

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CIT1221]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CIT1221]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [APKMaster] [uniqueidentifier] NULL,
  [DivisionID] [varchar](50) NOT NULL,
  [PromoteID] NVARCHAR(50) NULL, -- Mã chương trình
  [ConditionID] VARCHAR(50) NOT NULL, -- Mã Điều kiện
  [ConditionName] NVARCHAR(250) NULL, 
  [FromDate] DATETIME NULL,
  [ToDate] DATETIME NULL,
  [ToolID] VARCHAR(50) NULL, -- Mã công cụ
  [PaymentID] NVARCHAR(50) NULL, -- Mã điều kiện thanh toán
  [ObjectCustomID] NVARCHAR(50) NULL, -- Đối tượng chọn riêng
  [AnchorID] NVARCHAR(50) NULL, -- Mã neo
  [Disabled] NVARCHAR(250) NULL,
  [IsCommon] TINYINT DEFAULT (0) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME  DEFAULT GETDATE() NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME DEFAULT GETDATE() NULL,
CONSTRAINT [PK_CIT1221] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

If Exists (Select * From sysobjects Where name = 'CIT1221' and xtype ='U') 
Begin
	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'CIT1221'  and col.name = 'DiscountUnitID')
    Alter Table CIT1221 ADD DiscountUnitID VARCHAR(50) NULL
END
If Exists (Select * From sysobjects Where name = 'CIT1221' and xtype ='U') 
Begin
	If not exists (select * from syscolumns col inner join sysobjects tab 
    On col.id = tab.id where tab.name =   'CIT1221'  and col.name = 'MathID')
    Alter Table CIT1221 ADD MathID NVARCHAR(50) NULL
END