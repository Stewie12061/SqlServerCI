-- <Summary>
---- Details nghiệp vụ sắp xếp cont module M (Quản lý sản xuất)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Đình Ly on 17/02/2021

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[MT2201]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[MT2201]
(
	[APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
	[APKMaster] UNIQUEIDENTIFIER NULL,
	[DivisionID] VARCHAR(50) NOT NULL,
	[InheritVoucher] VARCHAR(50) NULL, 
	[ObjectID] VARCHAR(250) NULL, -- Khách hàng
	[Container] VARCHAR(250) NULL, -- Khai báo container
	[InventoryID] VARCHAR(250) NOT NULL, -- Mặt hàng
	[Quantity] DECIMAL(28) NULL, -- Số lượng mặt hàng
	[CBM] DECIMAL(28) NULL, -- Thể tích khối lượng trong container
	[CountryID] VARCHAR(250) NULL, -- Quốc gia
	[Branch] NVARCHAR(500) NULL, -- Chi nhánh
	[Address] NVARCHAR(500) NULL, -- Chi nhánh
	[Description] NVARCHAR(500) NULL, -- Ghi chú
	[CreateDate] DATETIME NULL,
	[CreateUserID] VARCHAR(50) NULL,
	[LastModifyDate] DATETIME NULL,
	[LastModifyUserID] VARCHAR(50) NULL

CONSTRAINT [PK_MT2201] PRIMARY KEY CLUSTERED
(
  [APK] ASC,
  [DivisionID] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END