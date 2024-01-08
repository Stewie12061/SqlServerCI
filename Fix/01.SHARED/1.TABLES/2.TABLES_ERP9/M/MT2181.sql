-- <Summary>
---- Details nghiệp vụ Yêu cầu đóng gói (M - Quản lý sản xuất)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Đình Ly on 17/02/2021

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[MT2181]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[MT2181]
(
	[APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL, -- Khóa chính
	[APKMaster] UNIQUEIDENTIFIER NULL,			-- Khóa ngoại
	[DivisionID] VARCHAR(50) NOT NULL,			-- Đơn vị
	[InheritVoucher] VARCHAR(50) NULL,			-- Phiếu kế thừa
	[InventoryID] VARCHAR(250) NOT NULL,		-- Mặt hàng
	[InventoryFactoryID] VARCHAR(250) NOT NULL, -- Mặt hàng dưới xưởng tự đặt
	[Quantity] DECIMAL(28) NULL,				-- Số lượng mặt hàng
	[BranchTem] NVARCHAR(500) NULL,				-- Tem nhãn thương hiệu
	[NestCode] NVARCHAR(500) NULL,				-- Mã Nest Code
	[Rate] DECIMAL(28) NULL,					-- Tỉ lệ hàng/thùng
	[Total] DECIMAL(28) NULL,						-- Tỉ lệ hàng/thùng
	[Color] VARCHAR(500) NULL,					-- Màu hộp đựng lớp 2
	[NumberColor] DECIMAL(28) NULL,				-- Số màu
	[CountryID] VARCHAR(250) NULL,				-- Quốc gia
	[Branch] NVARCHAR(500) NULL,				-- Chi nhánh
	[CancelDay] DATETIME NULL,					-- Ngày cuối cùng ship hàng
	[Description] NVARCHAR(500) NULL,			-- Ghi chú
	[CreateDate] DATETIME NULL,					-- Ngày tạo phiếu
	[CreateUserID] VARCHAR(50) NULL,			-- Người tạo phiếu
	[LastModifyDate] DATETIME NULL,				-- Ngày chỉnh sửa
	[LastModifyUserID] VARCHAR(50) NULL			-- Người chỉnh sửa

CONSTRAINT [PK_MT2181] PRIMARY KEY CLUSTERED
(
  [APK] ASC,
  [DivisionID] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'MT2181' AND xtype = 'U')
BEGIN
   IF EXISTS (SELECT TOP 1 1 FROM syscolumns col INNER JOIN sysobjects tab
   ON col.id = tab.id WHERE tab.name = 'MT2181' AND col.name = 'Color')
	EXEC sp_rename 'MT2181.Color', 'Colors', 'COLUMN';  
END

----------------------27/05/2021 - Minh Phúc: Modify cột InventoryFactoryID---------------------
IF EXISTS (SELECT * From sysobjects WHERE name = 'MT2181' AND xtype ='U') 
BEGIN
     If EXISTS (SELECT * FROM syscolumns col INNER JOIN sysobjects tab 
     ON col.id = tab.id WHERE tab.name =   'MT2181'  AND col.name = 'InventoryFactoryID')
     ALTER TABLE MT2181 ALTER COLUMN InventoryFactoryID [varchar](50) NULL
END