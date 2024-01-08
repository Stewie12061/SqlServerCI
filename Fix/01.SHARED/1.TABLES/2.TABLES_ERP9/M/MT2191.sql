-- <Summary>
---- Details nghiệp vụ Đóng gói thành phẩm (M - Quản lý sản xuất)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Minh Phúc on 01/06/2021

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[MT2191]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[MT2191]
(
	[APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL, -- Khóa chính
	[APKMaster] UNIQUEIDENTIFIER NULL,			-- Khóa ngoại
	[DivisionID] VARCHAR(50) NOT NULL,			-- Đơn vị
	[InheritVoucher] VARCHAR(50) NULL,			-- Phiếu kế thừa
	[InventoryID] VARCHAR(250) NOT NULL,		-- Mặt hàng
	[BoxID] VARCHAR(250)  NULL,				 	-- Thùng
	[Quantity] DECIMAL(28) NULL,				-- Số lượng mặt hàng
	[Length] VARCHAR(50) NULL,					-- Dài
	[Height] VARCHAR(50) NULL,					-- Cao
	[Width] VARCHAR(50) NULL,					-- Rộng
	[SizeM] NVARCHAR(500) NULL,					-- Khổ (Giấy  SX)	
	[CutM] VARCHAR(50) NULL,					-- Cắt (Giấy SX)
	[SizeWave] VARCHAR(50) NULL,				-- Khổ (Giấy sóng)
	[CutWave] VARCHAR(50) NULL,					-- Cắt (Giấy sóng)
	[Sheets] VARCHAR(50) NULL,					-- Số tờ
	[WayInside] NVARCHAR(500) NULL,				-- Cách vô hàng
	[BoxSize] VARCHAR(50) NULL,					-- Kích thước thùng
	[TransplantSize] NVARCHAR(50) NULL,			-- Kích thước
	[Description] NVARCHAR(500) NULL,			-- Ghi chú
	[CreateDate] DATETIME NULL,					-- Ngày tạo phiếu
	[CreateUserID] VARCHAR(50) NULL,			-- Người tạo phiếu
	[LastModifyDate] DATETIME NULL,				-- Ngày chỉnh sửa
	[LastModifyUserID] VARCHAR(50) NULL			-- Người chỉnh sửa

CONSTRAINT [PK_MT2191] PRIMARY KEY CLUSTERED
(
  [APK] ASC,
  [DivisionID] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

