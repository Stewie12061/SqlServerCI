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
SET @ModuleID = 'BEM'

SET @MessageValue=N'Trùng lặp MPT chi phí và MPT phòng ban, vui lòng kiểm tra lại'
EXEC ERP9AddMessage @ModuleID,'BEMFML000000', @MessageValue, @Language;
SET @MessageValue=N'Bạn phải chọn Đối tượng trước khi lọc dữ liệu!'
EXEC ERP9AddMessage @ModuleID,'BEMFML000001', @MessageValue, @Language;
SET @MessageValue=N'Số tiền yêu cầu không được vượt quá Số tiền còn lại!'
EXEC ERP9AddMessage @ModuleID,'BEMFML000002', @MessageValue, @Language;
SET @MessageValue=N'Thời hạn công tác không hợp lệ, vui lòng kiểm tra lại!'
EXEC ERP9AddMessage @ModuleID,'BEMFML000003', @MessageValue, @Language;
SET @MessageValue=N'Bạn phải chọn danh sách chỉ có PDN hoặc không có PDN trong danh sách'
EXEC ERP9AddMessage @ModuleID,'BEMFML000004', @MessageValue, @Language;
SET @MessageValue=N'Bạn chưa nhập Lý do, vui lòng kiểm tra lại!'
EXEC ERP9AddMessage @ModuleID,'BEMFML000005', @MessageValue, @Language;
SET @MessageValue=N'Số ngày công tác không hợp lệ, vui lòng kiểm tra lại!'
EXEC ERP9AddMessage @ModuleID,'BEMFML000006', @MessageValue, @Language;
SET @MessageValue=N'Bạn chưa nhập Công tác phí theo ngày, vui lòng kiểm tra lại!'
EXEC ERP9AddMessage @ModuleID,'BEMFML000007', @MessageValue, @Language;
SET @MessageValue=N'Vui lòng chọn loại là Phiếu đề nghị!'
EXEC ERP9AddMessage @ModuleID,'BEMFML000008', @MessageValue, @Language;
SET @MessageValue=N'Thay đổi Phiếu đề nghị sẽ xóa toàn bộ dữ liệu trên lưới. Bạn có muốn tiếp tục?'
EXEC ERP9AddMessage @ModuleID,'BEMFML000009', @MessageValue, @Language;
SET @MessageValue=N'Chỉ được kế thừa các phiếu có cùng đối tượng'
EXEC ERP9AddMessage @ModuleID,'BEMFML000010', @MessageValue, @Language;
SET @MessageValue=N'Vui nhập đầy đủ Từ ngày - Đến ngày'
EXEC ERP9AddMessage @ModuleID,'BEMFML000011', @MessageValue, @Language;
SET @MessageValue=N'Chỉ được kế thừa các phiếu có cùng loại tiền'
EXEC ERP9AddMessage @ModuleID,'BEMFML000012', @MessageValue, @Language;
SET @MessageValue=N'Lưu không thành công, Đề nghị công tác {0} đang được sử dụng!'
EXEC ERP9AddMessage @ModuleID,'BEMFML000013', @MessageValue, @Language;
SET @MessageValue=N'Phiếu tạm thu/tạm chi của {0} đã được duyệt, bạn không thể chuyển trạng thái duyệt!'
EXEC ERP9AddMessage @ModuleID,'BEMFML000014', @MessageValue, @Language;
SET @MessageValue=N'{0} đã ghi chú cho phiếu {1}. Bạn hãy kiểm tra lại!'
EXEC ERP9AddMessage @ModuleID,'BEMFML000015', @MessageValue, @Language;
SET @MessageValue=N'Số tiền yêu cầu lớn hơn số tiền còn lại của phiếu!'
EXEC ERP9AddMessage @ModuleID,'BEMFML000016', @MessageValue, @Language;
SET @MessageValue=N'{0} được tạo tự động, bạn không đươc phép xóa/sửa!'
EXEC ERP9AddMessage @ModuleID,'BEMFML000017', @MessageValue, @Language;
SET @MessageValue=N'Vui lòng chọn Loại đề nghị!'
EXEC ERP9AddMessage @ModuleID,'BEMFML000018', @MessageValue, @Language;
SET @MessageValue=N'Dữ liệu chi tiết không hợp lệ, vui lòng kiểm tra lại!'
EXEC ERP9AddMessage @ModuleID,'BEMFML000019', @MessageValue, @Language;