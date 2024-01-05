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
SET @ModuleID = 'KPI'


SET @MessageValue = N'Điểm đánh giá giữa nhân viên và cấp trên có sự chênh lệch vượt mức cho phép. Bạn có muốn lưu không?';
EXEC ERP9AddMessage @ModuleID, 'HRMFML000036' , @MessageValue, @Language;
SET @MessageValue=N'Đến kỳ không được nhỏ hơn Từ Kỳ!'
EXEC ERP9AddMessage @ModuleID,'KPIFML000001', @MessageValue, @Language;
SET @MessageValue=N'Dữ liệu không hợp lệ'
EXEC ERP9AddMessage @ModuleID,'KPIFML0000010', @MessageValue, @Language;
SET @MessageValue=N'Kỳ không hợp lệ'
EXEC ERP9AddMessage @ModuleID,'KPIFML0000011', @MessageValue, @Language;
SET @MessageValue=N'Không thể thực hiện thao tác khi kỳ đã được chốt'
EXEC ERP9AddMessage @ModuleID,'KPIFML0000012', @MessageValue, @Language;
SET @MessageValue=N'Kỳ hiện tại chưa được tính lương'
EXEC ERP9AddMessage @ModuleID,'KPIFML0000013', @MessageValue, @Language;
SET @MessageValue=N'Có lỗi trong quá trình tính lương'
EXEC ERP9AddMessage @ModuleID,'KPIFML0000014', @MessageValue, @Language;
SET @MessageValue=N'Kỳ hiện tại đã được chốt'
EXEC ERP9AddMessage @ModuleID,'KPIFML0000015', @MessageValue, @Language;
SET @MessageValue=N'Kỳ hiện tại đã được chỉnh sửa'
EXEC ERP9AddMessage @ModuleID,'KPIFML0000016', @MessageValue, @Language;
SET @MessageValue=N'Khoảng thời gian từ kỳ, đến kỳ đã được tạo. Vui lòng thiết lập thời gian khác.'
EXEC ERP9AddMessage @ModuleID,'KPIFML000002', @MessageValue, @Language;
SET @MessageValue=N'Dữ liệu không thể trùng lặp'
EXEC ERP9AddMessage @ModuleID,'KPIFML000003', @MessageValue, @Language;
SET @MessageValue=N'Không được nhập giá trị âm!'
EXEC ERP9AddMessage @ModuleID,'KPIFML000004', @MessageValue, @Language;
SET @MessageValue=N'Giá trị nhập vào nằm trong khoảng 0 đến 200'
EXEC ERP9AddMessage @ModuleID,'KPIFML000005', @MessageValue, @Language;
SET @MessageValue=N'Bạn có muốn nhận lương mềm không?'
EXEC ERP9AddMessage @ModuleID,'KPIFML000006', @MessageValue, @Language;
SET @MessageValue=N'Bạn không muốn nhận lương mềm không?'
EXEC ERP9AddMessage @ModuleID,'KPIFML000007', @MessageValue, @Language;
SET @MessageValue=N'Đến kỳ không được trùng từ kỳ!'
EXEC ERP9AddMessage @ModuleID,'KPIFML000008', @MessageValue, @Language;
SET @MessageValue=N'Bạn muốn chỉnh sửa?'
EXEC ERP9AddMessage @ModuleID,'KPIFML000009', @MessageValue, @Language;
SET @MessageValue=N'Dữ liệu chi tiết bị trùng nhau!'
EXEC ERP9AddMessage @ModuleID,'KPIFML000017', @MessageValue, @Language;
SET @MessageValue=N'Mở khóa kỳ thành công'
EXEC ERP9AddMessage @ModuleID,'KPIFML000018', @MessageValue, @Language;
SET @MessageValue=N'Phòng ban đã được tính lương mềm: '
EXEC ERP9AddMessage @ModuleID,'KPIFML000019', @MessageValue, @Language;
SET @MessageValue=N'Bạn vừa được giao đánh giá KPI bởi {0}'
EXEC ERP9AddMessage @ModuleID,'KPIFML000020', @MessageValue, @Language;
-- [Hoài Bảo] - [08/11/2021] - Bổ sung thông báo cho màn hình cập nhật cá nhân tự đánh giá KPIF2001
SET @MessageValue=N'Bạn phải thực hiện tình hình Kpis trước khi đánh giá.'
EXEC ERP9AddMessage @ModuleID,'KPIFML000021', @MessageValue, @Language;