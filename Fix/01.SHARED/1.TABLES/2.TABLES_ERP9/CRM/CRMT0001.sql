---- Create by Võ Bảo Toàn on 18/07/2019
---- Phân quyền sử dụng kế thừa 
---- Loại kế thừa: lập báo giá, yêu cầu mua hàng, đơn hàng mua, đơn hàng bán
---- Chi tiết nghiệp vụ:
----	- Bổ sung Màn hình Cập nhật phân quyền nhân viên được phép kế thừa nghiệp vụ. 
----	Tại màn hình này,  hệ thống hỗ trợ tìm kiếm thông tin:  tên cơ hội,  sản phẩm, địa điểm
----	- Khi nhân viên vào các màn hình nghiệp vụ như lập báo giá, yêu cầu mua hàng, đơn hàng mua, đơn hàng bán: 
----		nhân viên sẽ kế thừa được thông tin mà trưởng phòng đã phân quyền
IF NOT EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[CRMT0001]') AND TYPE IN (N'U'))
BEGIN
CREATE TABLE [dbo].[CRMT0001]
(
  [APK] UNIQUEIDENTIFIER DEFAULT newid() NOT NULL,
  [DivisionID] VARCHAR(50) NOT NULL,
  [VoucherNo] VARCHAR(50) NOT NULL,
  [VoucherTypeID] VARCHAR(50) NOT NULL,
  [StatusID] TINYINT,
  [OpportunityID] VARCHAR(50) NOT NULL,
  [AssignedToUserID] VARCHAR(50) NULL,
  [PermissionUserID] VARCHAR(500) NULL,  
  [TableContent] VARCHAR(50) NULL,
  [CreateUserID] VARCHAR(50) NULL,
  [CreateDate] DATETIME NULL,
  [LastModifyUserID] VARCHAR(50) NULL,
  [LastModifyDate] DATETIME NULL
CONSTRAINT [PK_CRMT30001] PRIMARY KEY CLUSTERED
(
  [APK]
)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)
ON [PRIMARY]
END

