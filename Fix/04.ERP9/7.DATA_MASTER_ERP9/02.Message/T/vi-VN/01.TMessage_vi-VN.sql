DECLARE @ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
@MessageValue NVARCHAR(400),
------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT
------------------------------------------------------------------------------------------------------
-- Set value và Execute query
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US
- Tieng Nhat: ja-JP
- Tieng Trung: zh-CN
*/
SET @Language = 'vi-VN'
SET @ModuleID = 'T'

SET @MessageValue=N'Đề nghị {0} đã được duyệt bởi {1}'
EXEC ERP9AddMessage @ModuleID,'TFML000273', @MessageValue, @Language;

SET @MessageValue=N'Đề nghị {0} đã bị từ chối duyệt'
EXEC ERP9AddMessage @ModuleID,'TFML000274', @MessageValue, @Language;

SET @MessageValue=N'Bạn có đề nghị {0} cần duyệt'
EXEC ERP9AddMessage @ModuleID,'TFML000271', @MessageValue, @Language;

SET @MessageValue = N'Người dùng {0} , Không có quyền sửa /xóa!';
EXEC ERP9AddMessage @ModuleID, 'TFML000118' , @MessageValue, @Language;
