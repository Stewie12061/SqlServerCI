DECLARE
@ModuleID VARCHAR(10),
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
SET @ModuleID = 'PA';
SET @FormID = 'PA';

SET @MessageValue = N'Bạn phải nhập số dòng chi tiết mức độ bằng với số mức độ năng lực!';
EXEC ERP9AddMessage @ModuleID, 'PAML000001' , @MessageValue, @Language;

SET @MessageValue = N'Mức độ chi tiết bị trùng. Bạn vui lòng kiểm tra lại mức độ!';
EXEC ERP9AddMessage @ModuleID, 'PAML000002' , @MessageValue, @Language;

SET @MessageValue = N'Bạn phải nhập [Mức độ năng lực tiêu chuẩn] chứa trong danh sách [Chi tiết mức năng lực tiêu chuẩn].';
EXEC ERP9AddMessage @ModuleID, 'PAML000003' , @MessageValue, @Language;

SET @MessageValue = N'Năng lực chi tiết bị trùng. Bạn vui lòng kiểm tra lại!';
EXEC ERP9AddMessage @ModuleID, 'PAML000004' , @MessageValue, @Language;

SET @MessageValue = N'[Mức năng lực đánh giá] hoặc [Mức năng lực đánh giá lại] phải nhỏ hơn [mức năng lực tiêu chuẩn]. Bạn phải kiểm tra lại!';
EXEC ERP9AddMessage @ModuleID, 'PAML000005' , @MessageValue, @Language;

SET @MessageValue = N'Bạn có muốn chuyển sang trạng thái làm việc chính thức cho nhân viên này?';
EXEC ERP9AddMessage @ModuleID, 'HRMFML000035' , @MessageValue, @Language;

SET @MessageValue = N'Điểm đánh giá giữa nhân viên và cấp trên có sự chênh lệch vượt mức cho phép. Bạn có muốn lưu không?';
EXEC ERP9AddMessage @ModuleID, 'HRMFML000036' , @MessageValue, @Language;