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

IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[MT2192]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[MT2192]
(
	[APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL, -- Khóa chính
	[APKMaster] UNIQUEIDENTIFIER NULL,			-- Khóa ngoại
	[DivisionID] VARCHAR(50) NOT NULL,			-- Đơn vị
	[InheritVoucher] VARCHAR(50) NULL,			-- Phiếu kế thừa
	[BoxID] VARCHAR(50) NULL,					-- Thùng
	ComponentQuantity DECIMAL(28) NULL,			-- Số lượng Phụ liệu
	ComponentID VARCHAR(50) NOT NULL,			-- Mã phụ liệu
	[CreateDate] DATETIME NULL,					-- Ngày tạo phiếu
	[CreateUserID] VARCHAR(50) NULL,			-- Người tạo phiếu
	[LastModifyDate] DATETIME NULL,				-- Ngày chỉnh sửa
	[LastModifyUserID] VARCHAR(50) NULL			-- Người chỉnh sửa

CONSTRAINT [PK_MT2192] PRIMARY KEY CLUSTERED
(
  [APK] ASC,
  [DivisionID] ASC
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END


