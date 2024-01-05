/*
=====================================================================
--- Script message tiếng Việt
--- select * from a00002 where id like '%MTFML%'
--- Delete from a00002 where id = 'MTFML000001'
=====================================================================
*/
------------------------------------------------------------------------------------------------------
-- Script tạo message CRM
------------------------------------------------------------------------------------------------------
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
SET @ModuleID = 'SO';

SET @MessageValue = N'{0} đã khóa sổ / không tồn tại kỳ kế toán bên module {1}. Bạn mở khóa sổ trước khi Sửa / Xóa';
EXEC ERP9AddMessage @ModuleID, 'SOFML000002' , @MessageValue, @Language;

SET @MessageValue = N'Đã quét barcode xác nhận thời gian đi cho phiếu giao hàng. Bạn muốn quét lại không?';
EXEC ERP9AddMessage @ModuleID, 'SOFML000004' , @MessageValue, @Language;

SET @MessageValue = N'Đã quét barcode xác nhận thời gian về cho phiếu giao hàng, bạn không được quét lại.';
EXEC ERP9AddMessage @ModuleID, 'SOFML000005' , @MessageValue, @Language;

SET @MessageValue = N'Phiếu điều phối {0} chưa xác nhận đi, sẽ lấy thời gian khi in làm thời gian xác nhận đi';
EXEC ERP9AddMessage @ModuleID, 'SOFML000006' , @MessageValue, @Language;

SET @MessageValue = N'Vui lòng thiết lập cho loại chứng từ {0}';
EXEC ERP9AddMessage @ModuleID, 'SOFML000007' , @MessageValue, @Language;

SET @MessageValue = N'Vui lòng chọn loại chứng từ';
EXEC ERP9AddMessage @ModuleID, 'SOFML000008' , @MessageValue, @Language;

SET @MessageValue = N'Đơn hàng {0} đã thực hiện giao hộ. Bạn vui lòng kiểm tra lại!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000009' , @MessageValue, @Language;

SET @MessageValue = N'Phiếu điều phối {0} đã sinh hàng bán trả lại, không thể quét lại phiếu này. Bạn vui lòng kiểm tra lại';
EXEC ERP9AddMessage @ModuleID, 'SOFML000010' , @MessageValue, @Language;

SET @MessageValue = N'Đơn hàng {0} đã thực hiện điều phối. Bạn không thể thực hiện giao hộ cho đơn hàng này. Vui lòng kiểm tra lại!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000011' , @MessageValue, @Language;

SET @MessageValue = N'Hóa đơn bán hàng của Đơn hàng {0} không tồn tại. Bạn không thể lập phiếu Giao hộ, vui lòng kiểm tra lại!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000012' , @MessageValue, @Language;

SET @MessageValue = N'Phiếu báo giá này đã được kế thừa sang đơn hàng bán. Bạn chỉ sửa được các thông tin: Diễn giải, ghi chú 1, 2, 3, hoàn tất.';
EXEC ERP9AddMessage @ModuleID, 'SOFML000016' , @MessageValue, @Language;

SET @MessageValue = N'Phiếu báo giá này đã được duyệt. Bạn chỉ sửa được các thông tin: Diễn giải, ghi chú 1,2,3, hoàn tất, mã phân tích.';
EXEC ERP9AddMessage @ModuleID, 'SOFML000017' , @MessageValue, @Language;

SET @MessageValue = N'Đơn hàng này đã được hạch toán vào sổ cái kế toán. Bạn chỉ sửa được các thông tin: Diễn giải, ghi chú 1, 2, 3, hoàn tất';
EXEC ERP9AddMessage @ModuleID, 'SOFML000018' , @MessageValue, @Language;

SET @MessageValue = N'Đơn hàng này đã được duyệt. Bạn chỉ sửa được các thông tin: Diễn giải, ghi chú 1,2,3, hoàn tất, mã phân tích.';
EXEC ERP9AddMessage @ModuleID, 'SOFML000019' , @MessageValue, @Language;

SET @MessageValue = N'Đơn hàng này đã lập kế hoạch giao hàng. Bạn có muốn sửa không?';
EXEC ERP9AddMessage @ModuleID, 'SOFML000020' , @MessageValue, @Language;

SET @MessageValue = N'Số lượng phải nhập lớn hơn 0.';
EXEC ERP9AddMessage @ModuleID, 'SOFML000021' , @MessageValue, @Language;

SET @MessageValue = N'Đơn hàng này đã được duyệt. Bạn không được phép Sửa/Xóa!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000022' , @MessageValue, @Language;

SET @MessageValue = N'Bạn phải nhập số lượng mặt hàng cho kế hoạch!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000023' , @MessageValue, @Language;

SET @MessageValue = N'Có nhiều hơn một khách hàng được kế thừa, hệ thống sẽ lấy thông tin khách hàng đầu tiên!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000024' , @MessageValue, @Language;

SET @MessageValue = N'Không thể chuyển trạng thái, phiếu báo giá đã được tính lương. \nHãy [Hủy Tính Lương] để thực hiện thao tác này!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000026' , @MessageValue, @Language;

SET @MessageValue = N'Đơn hàng đã có tiến độ giao hàng !';
EXEC ERP9AddMessage @ModuleID, 'SOFML000025' , @MessageValue, @Language;

SET @MessageValue = N'Chưa có thông tin người duyệt. Bạn cần bổ sung người duyệt ở phiếu thông tin sản xuất!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000027' , @MessageValue, @Language;

SET @MessageValue = N'Phiếu {0} đã được duyệt. Bạn không được phép Sửa / Xóa.';
EXEC ERP9AddMessage @ModuleID, 'SOFML000028' , @MessageValue, @Language;

SET @MessageValue = N'Công thức chưa đúng. Biến {0} chưa được tạo hoặc thiết lập trong Thông số và Vật tư của thành phẩm. Bạn vui lòng kiểm tra lại!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000029' , @MessageValue, @Language;

SET @MessageValue = N'Biến {0} có công thức chưa đúng. Bạn vui lòng kiểm tra lại!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000030' , @MessageValue, @Language;

SET @MessageValue = N'Dữ liệu đã được kế thừa từ báo giá Sale, không được xóa!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000031' , @MessageValue, @Language;

-- Đinh Hoà [27/08/2021] : Bổ sung message 
SET @MessageValue = N'Hệ số thay đổi ở mặt hàng nhỏ hơn hệ số quy định.Bạn vui lòng thiết lập và chọn người duyệt khi thay đổi hệ số!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000032' , @MessageValue, @Language;

-- Minh Hiếu [01/03/2022] : Bổ sung message 
SET @MessageValue = N'Ngày kết thúc và ngày bắt đầu không thể cách nhau hơn 31 ngày!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000033' , @MessageValue, @Language;

SET @MessageValue = N'Chỉ được chọn 1 kỳ!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000034' , @MessageValue, @Language;

--Begin - Nhật Quang [19/09/2022] : Bổ sung message
SET @MessageValue = N'Bạn có một phiếu báo giá cần duyệt của {0} - {1}.';
EXEC ERP9AddMessage @ModuleID, 'SOFML000035' , @MessageValue, @Language;
--End - Nhật Quang [19/09/2022]

--Begin - Kiều Nga [05/12/2022] : Bổ sung message
SET @MessageValue = N'Bạn có đơn hàng bán {0} cần duyệt!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000036' , @MessageValue, @Language;
--End - Kiều Nga [05/12/2022]

--Begin - Viết Toàn [23/03/2023] : Bổ sung message
SET @MessageValue = N'Mã hàng không tồn tại trong đơn hàng bán!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000037' , @MessageValue, @Language;

SET @MessageValue = N'Đơn hàng bán không đúng!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000038' , @MessageValue, @Language;

SET @MessageValue = N'Số lượng nhận không được lớn hơn số lượng Còn lại!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000039' , @MessageValue, @Language;

SET @MessageValue = N'Số lượng nhận không được nhỏ hơn số lượng Còn lại!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000040' , @MessageValue, @Language;
--End - Viết Toàn [23/03/2023]

--Begin - Viết Toàn [01/04/2023] : Bổ sung message
SET @MessageValue = N'Mã đơn hàng bán đã tồn tại!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000041' , @MessageValue, @Language;

SET @MessageValue = N'Người duyệt 01 không được trùng với người dùng tạo đơn!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000042' , @MessageValue, @Language;

SET @MessageValue = N'Bảng giá không tồn tại!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000043' , @MessageValue, @Language;

SET @MessageValue = N'Địa chỉ giao hàng không được trống!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000044' , @MessageValue, @Language;
--End - Viết Toàn [01/04/2023]

--Begin - Văn Tài [24/05/2023]

-- Đơn hàng: DHB/05/2023/0002, DHB/05/2023/0001 đang ở trạng thái Đang giao hàng, Hoàn thành không thể Hủy đơn.
SET @MessageValue = N'Đơn hàng: {0} đang ở trạng thái Đang giao hàng, Hoàn thành nên không thể Hủy đơn.';
EXEC ERP9AddMessage @ModuleID, 'SOFML000045' , @MessageValue, @Language;

SET @MessageValue = N'Bạn có muốn Hủy đơn điều phối không?';
EXEC ERP9AddMessage @ModuleID, 'SOFML000046' , @MessageValue, @Language;

SET @MessageValue = N'Bạn vừa nhận được thông tin Điều phối - Giao hàng mới {0}';
EXEC ERP9AddMessage @ModuleID, 'SOFML000050' , @MessageValue, @Language;

--End - Văn Tài [24/05/2023]

SET @MessageValue = N'Chiết khấu trong ví tích lũy không đủ!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000047' , @MessageValue, @Language;

SET @MessageValue = N'Chương trình không cho phép dùng ví chiết khấu tích lũy!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000048' , @MessageValue, @Language;

SET @MessageValue = N'Phải chọn thêm mặt hàng khác khi dùng ví chiết khấu tích lũy!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000049' , @MessageValue, @Language;

SET @MessageValue = N'Mặt hàng {0} không có đủ số lượng trong ví chiết khấu tích lũy!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000051' , @MessageValue, @Language;

SET @MessageValue = N'Đơn hàng này đã lập kế hoạch giao hàng.';
EXEC ERP9AddMessage @ModuleID, 'SOFML000052' , @MessageValue, @Language;

SET @MessageValue = N'Đơn hàng bán đã tồn tại ở tiến độ giao hàng khác.';
EXEC ERP9AddMessage @ModuleID, 'SOFML000053' , @MessageValue, @Language;

SET @MessageValue = N'Mặt hàng {0} chưa được thiết lập mã phân tích 03';
EXEC ERP9AddMessage @ModuleID, 'SOFML000054' , @MessageValue, @Language;

SET @MessageValue = N'Mã {0} chưa được thiết lập tăng tự động!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000055' , @MessageValue, @Language;

SET @MessageValue = N'Không được dùng ví tích lũy vượt quá giá trị đơn hàng!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000056' , @MessageValue, @Language;

-- 07/07/2023 - [Thanh Lượng] - Tạo mới message "Bạn có kế hoạch doanh của dối tương {0} cần duyệt!"
SET @MessageValue = N'Bạn có kế hoạch doanh số của dối tương {0} cần duyệt';
EXEC ERP9AddMessage @ModuleID, 'SOFML000057' , @MessageValue, @Language;

-- 13/07/2023 - [Thanh Lượng] - Tạo mới message "Kế hoạch đã được duyệt bạn không được phép xóa/sửa!"
SET @MessageValue = N'Kế hoạch đã được duyệt bạn không được phép xóa/sửa!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000058' , @MessageValue, @Language;

-- 13/07/2023 - [Thanh Lượng] - Tạo mới message ""
SET @MessageValue = N'Kế hoạch đã được duyệt bạn không được phép xóa/sửa!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000059' , @MessageValue, @Language;

-- 13/07/2023 - [Thanh Lượng] - Tạo mới message ""
SET @MessageValue = N'Kế hoạch tháng đã được lập bạn không được phép xóa/sửa!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000060' , @MessageValue, @Language;

-- 09/08/2023 - [Nhật Thanh] - Tạo mới message ""
SET @MessageValue = N'Bạn có muốn cập nhật diễn giải được tính từ chương trình khuyến mãi?';
EXEC ERP9AddMessage @ModuleID, 'SOFML000061' , @MessageValue, @Language;

-- 15/12/2023 - [Hoàng Long] - Tạo mới message ""
SET @MessageValue = N'Mã tài khoản đã tồn tại!';
EXEC ERP9AddMessage @ModuleID, 'SOFML000062' , @MessageValue, @Language;
-- 19/12/2023 - [Bi Phan] - Tạo mới message ""
SET @MessageValue=N'Bạn phải nhập vào Doanh số tháng/quý/năm!'
EXEC ERP9AddMessage @ModuleID,'SOFML000110', @MessageValue, @Language;