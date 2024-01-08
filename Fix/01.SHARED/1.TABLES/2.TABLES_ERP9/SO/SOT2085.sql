---- Create by Đình Ly on 06/10/2020
---- Bảng dữ liệu lưu vết khi kế thừa lắp ráp từ bán thành phẩm
---- Khi thêm mới/cập nhật phiếu Thông tin sản xuất (Mai Thư)

IF NOT EXISTS (SELECT * FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[SOT2085]') AND TYPE IN (N'U'))
BEGIN
     CREATE TABLE [dbo].[SOT2085]
     (
      [APK] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
      [DivisionID] VARCHAR(500) NOT NULL,
	  [VoucherNo] VARCHAR(500) NOT NULL,
      [VoucherAssemble] VARCHAR(500) NOT NULL,
      [InventoryAssemble] NVARCHAR(500) NULL,
      [CreateUserID] VARCHAR(50) NULL,
      [CreateDate] DATETIME NULL,
      [LastModifyUserID] VARCHAR(50) NULL,
      [LastModifyDate] DATETIME NULL
    CONSTRAINT [PK_SOT2085] PRIMARY KEY CLUSTERED
      (
		[APK]
      )
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
     )
 ON [PRIMARY] 
END