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
SET @ModuleID = 'CRM';

SET @MessageValue = N'Bạn chưa khai báo khách hàng, Bạn muốn thêm khách hàng không?';
EXEC ERP9AddMessage @ModuleID, 'CRMFML000001' , @MessageValue, @Language;

SET @MessageValue = N'{0} đã khóa sổ bên module {1}. Bạn mở khóa sổ trước khi Sửa / Xóa';
EXEC ERP9AddMessage @ModuleID, 'CRMFML000002' , @MessageValue, @Language;

SET @MessageValue = N'{0} đang còn nợ phiếu giao hàng. Bạn có muốn tiếp tục không?';
EXEC ERP9AddMessage @ModuleID, 'CRMFML000003' , @MessageValue, @Language;

SET @MessageValue = N'Khách hàng đang còn nợ phiếu giao hàng. Bạn có muốn tiếp tục không?';
EXEC ERP9AddMessage @ModuleID, 'CRMFML000003' , @MessageValue, @Language;

SET @MessageValue = N'Số lượng điều phối lớn hơn số lượng trong đơn hàng đã lập, bạn vui lòng điều phối lại!';
EXEC ERP9AddMessage @ModuleID, 'CRMFML000004' , @MessageValue, @Language;

SET @MessageValue = N'Đơn hàng {0} đã lập điều phối hoàn tất. Bạn vui lòng kiểm tra lại!';
EXEC ERP9AddMessage @ModuleID, 'CRMFML000005' , @MessageValue, @Language;

SET @MessageValue = N'Đơn hàng {0} đã thực thi giao hộ, bạn không thể điều phối đơn hàng này được. Vui lòng kiểm tra lại';
EXEC ERP9AddMessage @ModuleID, 'CRMFML000006' , @MessageValue, @Language;

SET @MessageValue = N'Đơn hàng hiện tại chưa được lưu, bạn có muốn thoát và tạo đơn hàng mới hay không?';
EXEC ERP9AddMessage @ModuleID, 'CRMFML000007' , @MessageValue, @Language;

SET @MessageValue = N'{0} đã chuyển đổi thành khách hàng. Bạn có muốn chuyển đổi tiếp tục không?';
EXEC ERP9AddMessage @ModuleID, 'CRMFML000012' , @MessageValue, @Language;

SET @MessageValue = N'{0} đã chuyển đổi thành khách hàng. Bạn không thể thực thi hoạt động này.';
EXEC ERP9AddMessage @ModuleID, 'CRMFML000013' , @MessageValue, @Language;

SET @MessageValue = N'{0} trạng thái đã hoàn tất. Bạn không thể xóa.';
EXEC ERP9AddMessage @ModuleID, 'CRMFML000015' , @MessageValue, @Language;

SET @MessageValue = N'{0} đã được tổ chức. Bạn không thể xóa!';
EXEC ERP9AddMessage @ModuleID, 'CRMFML000014' , @MessageValue, @Language;

SET @MessageValue = N'Mã đơn vị đang import không đúng với mã đơn vị đang sử dụng!';
EXEC ERP9AddMessage @ModuleID, 'CRMFML000008' , @MessageValue, @Language;

SET @MessageValue = N'Mã {0} đã tồn tại. Bạn không thể import, vui lòng nhập mã khác';
EXEC ERP9AddMessage @ModuleID, 'CRMFML000011' , @MessageValue, @Language;

SET @MessageValue = N'Mã người phụ trách {0} không tồn tại!';
EXEC ERP9AddMessage @ModuleID, 'CRMFML000016' , @MessageValue, @Language;

--[Ngày thêm: 10/07/2019] [Người tạo: Bảo Toàn] [Sử dụng cho scrip CRMF2052.js]
SET @MessageValue = N'Cơ hội đã có dự án [{0}] phụ thuộc!';
EXEC ERP9AddMessage @ModuleID, 'CRMFML000017' , @MessageValue, @Language;

--[Ngày thêm: 10/07/2019] [Người tạo: Bảo Toàn] [Sử dụng cho scrip CRMF2052.js]
SET @MessageValue = N'Thêm dự án cho cơ hội không thành công!';
EXEC ERP9AddMessage @ModuleID, 'CRMFML000018' , @MessageValue, @Language;

--[Ngày thêm: 16/07/2019] [Người tạo: Bảo Toàn] [Sử dụng cho scrip CRMF9005.js]
SET @MessageValue = N'[Thời gian bắt đầu] không được lớn hơn [Thời gian kết thúc]!';
EXEC ERP9AddMessage @ModuleID, 'CRMFML000019' , @MessageValue, @Language;

--[Ngày thêm: 31/07/2019] [Người tạo: Bảo Toàn] [Sử dụng cho scrip CRMF0001.js]
SET @MessageValue = N'Chưa chọn chứng từ!';
EXEC ERP9AddMessage @ModuleID, 'CRMFML000020' , @MessageValue, @Language;

--[Ngày thêm: 03/09/2019] [Người tạo: Bảo Toàn] [Sử dụng cho scrip CRMF2081.js]
SET @MessageValue = N'Cơ hội được gán chưa đến giai đoạn tìm hiểu quyết định,không thể lập yêu cầu báo giá!';
EXEC ERP9AddMessage @ModuleID, 'CRMFML000021' , @MessageValue, @Language;

--[Ngày thêm: 23/09/2019] [Người tạo: Kiều Nga] [Sử dụng cho scrip CRMF2052.js]
SET @MessageValue = N'Cơ hội chưa đủ thông tin {0} bạn không thể chuyển giao dự án!';
EXEC ERP9AddMessage @ModuleID, 'CRMFML000024' , @MessageValue, @Language;

--[Ngày thêm: 31/12/2019] [Người tạo: Kiều Nga] [Sử dụng cho scrip CRMF2052.js]
SET @MessageValue = N'Bạn phải khai báo thông tin ghi chú, đính kèm!';
EXEC ERP9AddMessage @ModuleID, 'CRMFML000025' , @MessageValue, @Language;

--[Ngày thêm: 21/01/2020] [Người tạo: Học Huy] [Sử dụng cho script CRMF2101.js]
SET @MessageValue = N'Hệ thống chưa thiết lập Chủng loại.';
EXEC ERP9AddMessage @ModuleID, 'CRMFML000026' , @MessageValue, @Language;

--[Ngày thêm: 03/03/2020] [Người tạo: Kiều Nga]
SET @MessageValue = N'Thông tin cơ hội đã được sử dụng !';
EXEC ERP9AddMessage @ModuleID, 'CRMFML000027' , @MessageValue, @Language;

-- [Ngày thêm: 20/07/2020] [Người tạo: Tấn Lộc]
SET @MessageValue=N'Có lỗi trong quá trình đọc file. Vui lòng chọn đúng file!'
EXEC ERP9AddMessage @ModuleID,'CRMFML000028', @MessageValue, @Language;

-- [Ngày thêm: 04/11/2020] [Người tạo: Đình Hòa]
SET @MessageValue=N'Ngày diễn ra không được nhỏ hơn Ngày bắt đầu và không được lớn hơn Ngày kết thúc!'
EXEC ERP9AddMessage @ModuleID,'CRMFML000029', @MessageValue, @Language;

-- [Ngày thêm: 19/11/2020] [Người tạo: Tân Lộc]
SET @MessageValue=N'Số lượng gửi mail/lần phải nằm trong khoảng 1-14'
EXEC ERP9AddMessage @ModuleID,'CRMFML000030', @MessageValue, @Language;

-- [Ngày thêm: 31/12/2020] [Người tạo: Tân Lộc]
SET @MessageValue=N'Bạn phải nhập vào Phiên bản'
EXEC ERP9AddMessage @ModuleID,'CRMFML000031', @MessageValue, @Language;

-- [Ngày thêm: 26/01/2021] [Người tạo: Đình Hòa]
SET @MessageValue=N'Leads {0} có số điện thoại {1} hoặc email {2} đã tồn tại trong hệ thống. Bạn có muốn tiếp tục?'
EXEC ERP9AddMessage @ModuleID,'CRMFML000032', @MessageValue, @Language;

-- [Ngày thêm: 26/04/2021] [Người tạo: Đoàn Duy]
SET @MessageValue=N'Điều phối giao hàng'
EXEC ERP9AddMessage @ModuleID,'CRMFML000033', @MessageValue, @Language;

-- [Ngày thêm: 26/04/2021] [Người tạo: Đoàn Duy]
SET @MessageValue=N'Bạn vừa được điều phối giao hàng cho khách hàng {0} sản phẩm {1}, tại địa chỉ {2}'
EXEC ERP9AddMessage @ModuleID,'CRMFML000034', @MessageValue, @Language;

-- [Ngày thêm: 26/04/2021] [Người tạo: Đoàn Duy]
SET @MessageValue=N'Điều phối bảo hành'
EXEC ERP9AddMessage @ModuleID,'CRMFML000035', @MessageValue, @Language;

-- [Ngày thêm: 26/04/2021] [Người tạo: Đoàn Duy]
SET @MessageValue=N'Điều phối sửa chửa'
EXEC ERP9AddMessage @ModuleID,'CRMFML000036', @MessageValue, @Language;

-- [Ngày thêm: 26/04/2021] [Người tạo: Đoàn Duy]
SET @MessageValue=N'Khách hàng {0} vừa yêu cầu dịch vụ {1} cho sản phẩm {2} tại địa chỉ {3}'
EXEC ERP9AddMessage @ModuleID,'CRMFML000037', @MessageValue, @Language;

-- [Ngày thêm: 30/06/2021] [Người tạo: Tân Lộc]
SET @MessageValue=N'Bạn vừa được giao 1 yêu cầu hỗ trợ có độ ưu tiên thấp: {0}'
EXEC ERP9AddMessage @ModuleID,'CRMFML000038', @MessageValue, @Language;

-- [Ngày thêm: 30/06/2021] [Người tạo: Tân Lộc]
SET @MessageValue=N'Bạn vừa được giao 1 yêu cầu hỗ trợ có độ ưu tiên khẩn cấp: {0}'
EXEC ERP9AddMessage @ModuleID,'CRMFML000039', @MessageValue, @Language;

-- [Ngày thêm: 30/06/2021] [Người tạo: Tân Lộc]
SET @MessageValue=N'Bạn vừa được giao 1 yêu cầu hỗ trợ có độ ưu tiên cao: {0}'
EXEC ERP9AddMessage @ModuleID,'CRMFML000040', @MessageValue, @Language;

-- [Ngày thêm: 13/07/2021] [Người tạo: Tân Lộc]
SET @MessageValue=N'Bạn có 1 sự kiện: {0} ngày {1}'
EXEC ERP9AddMessage @ModuleID,'CRMFML000041', @MessageValue, @Language;

-- [Ngày thêm: 06/10/2021] [Người tạo: Hoài Bảo]
SET @MessageValue=N'Danh sách đã được gọi hoàn tất. Bạn có muốn tiếp tục gọi lại không?'
EXEC ERP9AddMessage @ModuleID,'CRMFML000042', @MessageValue, @Language;

-- [Ngày thêm: 15/10/2021] [Người tạo: Hoài Bảo]
SET @MessageValue=N'Thông tin kết nối của bạn chưa đủ, vui lòng kiểm tra lại!'
EXEC ERP9AddMessage @ModuleID,'CRMFML000043', @MessageValue, @Language;

-- [Ngày thêm: 30/11/2021] [Người tạo: Tấn Lộc]
SET @MessageValue=N'Dữ liệu này đã được chuyển thành khách hàng. Bạn không thể thao tác!'
EXEC ERP9AddMessage @ModuleID,'CRMFML000044', @MessageValue, @Language;

-- [Ngày thêm: 30/11/2021] [Người tạo: Tấn Lộc]
SET @MessageValue=N'Ao đầu mối {0} này đã được chuyển thành Đầu mối {1}. Bạn không thể thao tác!'
EXEC ERP9AddMessage @ModuleID,'CRMFML000045', @MessageValue, @Language;

-- [Ngày thêm: 22/03/2022] [Người tạo: Hoài Thanh]
SET @MessageValue=N'Bạn vừa được giao chăm sóc đầu mối {0}'
EXEC ERP9AddMessage @ModuleID,'CRMFML000046', @MessageValue, @Language;

-- [Ngày thêm: 23/03/2022] [Người tạo: Hoài Thanh]
SET @MessageValue=N'Bạn vừa được giao chăm sóc ao đầu mối {0}'
EXEC ERP9AddMessage @ModuleID,'CRMFML000047', @MessageValue, @Language;

-- [Ngày thêm: 12/04/2022] [Người tạo: Tấn Lộc]
SET @MessageValue=N'Dữ liệu chuyển thành công!'
EXEC ERP9AddMessage @ModuleID,'CRMFML000048', @MessageValue, @Language;

-- [Ngày thêm: 12/04/2022] [Người tạo: Tấn Lộc]
SET @MessageValue=N'Bạn có muốn hủy các đầu mối này không!'
EXEC ERP9AddMessage @ModuleID,'CRMFML000049', @MessageValue, @Language;

-- [Ngày thêm: 12/04/2022] [Người tạo: Tấn Lộc]
SET @MessageValue=N'Dữ liệu người phụ trách trùng nhau!'
EXEC ERP9AddMessage @ModuleID,'CRMFML000050', @MessageValue, @Language;

-- [Ngày thêm: 27/04/2022] [Người tạo: Tấn Lộc]
SET @MessageValue=N'Bạn chưa chọn Dùng thử hay Chính thức.'
EXEC ERP9AddMessage @ModuleID,'CRMFML000051', @MessageValue, @Language;

-- [Ngày thêm: 27/04/2022] [Người tạo: Tấn Lộc]
SET @MessageValue=N'Tên miền {0} đã tồn tại. Vui lòng nhập tên miền khác!'
EXEC ERP9AddMessage @ModuleID,'CRMFML000052', @MessageValue, @Language;

-- [Ngày thêm: 12/04/2022] [Người tạo: Đoàn Duy]
SET @MessageValue=N'Thuê bao {0} đã được tạo dữ liệu thành công!'
EXEC ERP9AddMessage @ModuleID,'CRMFML000053', @MessageValue, @Language;

-- [Ngày thêm: 12/04/2022] [Người tạo: Đoàn Duy]
SET @MessageValue=N'Thuê bao {0} đã xảy ra lỗi khi tạo dữ liệu!'
EXEC ERP9AddMessage @ModuleID,'CRMFML000054', @MessageValue, @Language;

-- [Ngày thêm: 12/04/2022] [Người tạo: Đoàn Duy]
SET @MessageValue=N'{0} đã được thêm vào Ao đầu mối!'
EXEC ERP9AddMessage @ModuleID,'CRMFML000055', @MessageValue, @Language;

-- [Ngày thêm: 12/05/2022] [Người tạo: Tấn Lộc]
SET @MessageValue=N'Thông báo sẽ gửi đến bạn sau khi thông tin truy cập tạo thành công!'
EXEC ERP9AddMessage @ModuleID,'CRMFML000056', @MessageValue, @Language;

-- [Ngày thêm: 12/05/2022] [Người tạo: Tấn Lộc]
SET @MessageValue=N'Thông tin truy cập sẽ được gửi đến địa chỉ email: {0}'
EXEC ERP9AddMessage @ModuleID,'CRMFML000057', @MessageValue, @Language;

-- [Ngày thêm: 12/05/2022] [Người tạo: Tấn Lộc]
SET @MessageValue=N'Thông tin dữ liệu không đầy đủ, không thể tạo dữ liệu!'
EXEC ERP9AddMessage @ModuleID,'CRMFML000058', @MessageValue, @Language;

-- [Ngày thêm: 12/05/2022] [Người tạo: Tấn Lộc]
SET @MessageValue=N'Thuê bao phải thuộc Nguồn online, Đầu mối, Cơ hôi hoặc Khách hàng!'
EXEC ERP9AddMessage @ModuleID,'CRMFML000059', @MessageValue, @Language;

-- [Ngày thêm: 26/05/2022] [Người tạo: Tấn Lộc]
SET @MessageValue=N'Cần phải chọn người phụ trách trước khi chuyển trạng thái!'
EXEC ERP9AddMessage @ModuleID,'CRMFML000060', @MessageValue, @Language;

-- [Ngày thêm: 26/05/2022] [Người tạo: Tấn Lộc]
SET @MessageValue=N'Bạn vừa được giao 1 yêu cầu hỗ trợ có độ ưu tiên cao: {0}'
EXEC ERP9AddMessage @ModuleID,'CRMFML000061', @MessageValue, @Language;

SET @MessageValue=N'Bạn vừa được giao 1 yêu cầu hỗ trợ có độ ưu tiên thấp: {0}'
EXEC ERP9AddMessage @ModuleID,'CRMFML000062', @MessageValue, @Language;

SET @MessageValue=N'Yêu cầu hỗ trợ {0} của bạn vừa được chuyển sang cho {1}'
EXEC ERP9AddMessage @ModuleID,'CRMFML000063', @MessageValue, @Language;

SET @MessageValue=N'Yêu cầu hỗ trợ {0} của bạn đã được chuyển thành Yêu cầu hỗ trợ có độ ưu tiên cao'
EXEC ERP9AddMessage @ModuleID,'CRMFML000064', @MessageValue, @Language;

SET @MessageValue=N'Yêu cầu hỗ trợ {0} của bạn đã được chuyển sang trạng thái {1}'
EXEC ERP9AddMessage @ModuleID,'CRMFML000065', @MessageValue, @Language;

-- [Ngày thêm: 07/12/2022] [Người tạo: Kiều Nga]
SET @MessageValue = N'Bạn có dự toán {0} cần duyệt!';
EXEC ERP9AddMessage @ModuleID, 'CRMFML000066' , @MessageValue, @Language;

-- [Ngày thêm: 19/12/2022] [Người tạo: Anh Đô]
SET @MessageValue = N'Bạn chưa chọn kỳ';
EXEC ERP9AddMessage @ModuleID, 'CRMFML000067' , @MessageValue, @Language;

SET @MessageValue = N'Bạn chưa chọn đơn vị';
EXEC ERP9AddMessage @ModuleID, 'CRMFML000068' , @MessageValue, @Language;