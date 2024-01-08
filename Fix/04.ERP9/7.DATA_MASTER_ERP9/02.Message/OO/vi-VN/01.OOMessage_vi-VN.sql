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
SET @ModuleID = 'OO'

SET @MessageValue=N'Mã đơn vị đang import không đúng với mã đơn vị đang sử dụng!'
EXEC ERP9AddMessage @ModuleID,'OOFML000001', @MessageValue, @Language;
SET @MessageValue=N'Kỳ đang import không đúng với kỳ đang sử dụng!'
EXEC ERP9AddMessage @ModuleID,'OOFML000002', @MessageValue, @Language;
SET @MessageValue=N'Mã khối chưa được khai báo!'
EXEC ERP9AddMessage @ModuleID,'OOFML000003', @MessageValue, @Language;
SET @MessageValue=N'Mã phòng chưa được khai báo!'
EXEC ERP9AddMessage @ModuleID,'OOFML000004', @MessageValue, @Language;
SET @MessageValue=N'Mã ban chưa được khai báo!'
EXEC ERP9AddMessage @ModuleID,'OOFML000005', @MessageValue, @Language;
SET @MessageValue=N'Mã công đoạn chưa được khai báo'
EXEC ERP9AddMessage @ModuleID,'OOFML000006', @MessageValue, @Language;
SET @MessageValue=N'Mã ca chưa được khai báo!'
EXEC ERP9AddMessage @ModuleID,'OOFML000007', @MessageValue, @Language;
SET @MessageValue=N'Mã nhân viên chưa được khai báo!'
EXEC ERP9AddMessage @ModuleID,'OOFML000008', @MessageValue, @Language;
SET @MessageValue=N'Tên nhân viên và mã nhân viên không đồng nhất'
EXEC ERP9AddMessage @ModuleID,'OOFML000009', @MessageValue, @Language;
SET @MessageValue=N'Mã bị trùng xin nhập mã khác!'
EXEC ERP9AddMessage @ModuleID,'OOFML000010', @MessageValue, @Language;
SET @MessageValue=N'Người duyệt chưa được khai báo'
EXEC ERP9AddMessage @ModuleID,'OOFML000011', @MessageValue, @Language;
SET @MessageValue=N'Người duyệt không nằm trong khối, phòng, ban, công đoạn được chọn'
EXEC ERP9AddMessage @ModuleID,'OOFML000012', @MessageValue, @Language;
SET @MessageValue=N'Bước '
EXEC ERP9AddMessage @ModuleID,'OOFML000013', @MessageValue, @Language;
SET @MessageValue=N'Nhân viên đã được phân ca bạn không thể phân ca thêm'
EXEC ERP9AddMessage @ModuleID,'OOFML000014', @MessageValue, @Language;
SET @MessageValue=N'Mã đã được sử dụng bởi người dùng khác! Vui lòng thực hiện lưu lại'
EXEC ERP9AddMessage @ModuleID,'OOFML000015', @MessageValue, @Language;
SET @MessageValue=N'Bạn phải check phân quyền cho lưới của các cấp duyệt'
EXEC ERP9AddMessage @ModuleID,'OOFML000016', @MessageValue, @Language;
SET @MessageValue=N'Thời gian xin nghỉ của nhân viên bị trùng'
EXEC ERP9AddMessage @ModuleID,'OOFML000017', @MessageValue, @Language;
SET @MessageValue=N'Thời gian xin ra ngoài của nhân viên bị trùng'
EXEC ERP9AddMessage @ModuleID,'OOFML000018', @MessageValue, @Language;
SET @MessageValue=N'Thời gian xin làm thêm của nhân viên bị trùng'
EXEC ERP9AddMessage @ModuleID,'OOFML000019', @MessageValue, @Language;
SET @MessageValue=N'Thời gian xin bổ sung quẹt thẻ của nhân viên bị trùng'
EXEC ERP9AddMessage @ModuleID,'OOFML000020', @MessageValue, @Language;
SET @MessageValue=N'Thời gian cập nhật của nhân viên bị trùng'
EXEC ERP9AddMessage @ModuleID,'OOFML000021', @MessageValue, @Language;
SET @MessageValue=N'Thời gian từ ngày phải trước thời gian đến ngày'
EXEC ERP9AddMessage @ModuleID,'OOFML000022', @MessageValue, @Language;
SET @MessageValue=N'Phải chọn phương pháp xử lý'
EXEC ERP9AddMessage @ModuleID,'OOFML000023', @MessageValue, @Language;
SET @MessageValue=N'Bạn không được chọn trạng thái chờ duyệt!'
EXEC ERP9AddMessage @ModuleID,'OOFML000024', @MessageValue, @Language;
SET @MessageValue=N'Chỉ chọn được một dòng để kế thừa'
EXEC ERP9AddMessage @ModuleID,'OOFML000025', @MessageValue, @Language;
SET @MessageValue=N'Nhân viên đã được chấm công ở HRM bạn không thể duyệt lại'
EXEC ERP9AddMessage @ModuleID,'OOFML000026', @MessageValue, @Language;
SET @MessageValue=N'Bạn phải chọn thời gian sau ngày hiện tại'
EXEC ERP9AddMessage @ModuleID,'OOFML000027', @MessageValue, @Language;
SET @MessageValue=N'Bạn phải chọn từ giờ nhỏ hơn đến giờ'
EXEC ERP9AddMessage @ModuleID,'OOFML000028', @MessageValue, @Language;
SET @MessageValue=N'Nhân viên {0} có ngày {1} đã trùng ca {2}'
EXEC ERP9AddMessage @ModuleID,'OOFML000029', @MessageValue, @Language;
SET @MessageValue=N'Phải chọn Từ ngày, Đến ngày nằm trong kỳ kế toán'
EXEC ERP9AddMessage @ModuleID,'OOFML000030', @MessageValue, @Language;
SET @MessageValue=N'Nhân viên này không thuộc Khối, Phòng, Ban, Công đoạn vừa được khai báo'
EXEC ERP9AddMessage @ModuleID,'OOFML000031', @MessageValue, @Language;
SET @MessageValue=N'Nhân viên này đã được phân ca. Bạn không thể phân ca thêm!'
EXEC ERP9AddMessage @ModuleID,'OOFML000032', @MessageValue, @Language;
SET @MessageValue=N'Thời gian xin phép có nhiều hơn 1 ca làm việc. Vui lòng chọn lại thời gian xin phép!'
EXEC ERP9AddMessage @ModuleID,'OOFML000033', @MessageValue, @Language;
SET @MessageValue=N'Nhân viên {0} không có email'
EXEC ERP9AddMessage @ModuleID,'OOFML000034', @MessageValue, @Language;
SET @MessageValue=N'Đơn {0} chưa/không được duyệt. Bạn không thể in!'
EXEC ERP9AddMessage @ModuleID,'OOFML000035', @MessageValue, @Language;
SET @MessageValue=N'Nhân viên {0} có thời gian OT vượt quá thời gian cho phép!'
EXEC ERP9AddMessage @ModuleID,'OOFML000036', @MessageValue, @Language;
SET @MessageValue=N'Mã nhân viên bị trùng trong file import'
EXEC ERP9AddMessage @ModuleID,'OOFML000038', @MessageValue, @Language;
SET @MessageValue=N'Nhân viên chưa có trong hồ sơ phép!'
EXEC ERP9AddMessage @ModuleID,'OOFML000039', @MessageValue, @Language;
SET @MessageValue=N'Bạn chưa nhập ca thay đổi. Bạn có muốn tiếp tục lưu không?'
EXEC ERP9AddMessage @ModuleID,'OOFML000048', @MessageValue, @Language;
SET @MessageValue=N'Không được phân ca trước ngày {0} cho nhân viên {1}!'
EXEC ERP9AddMessage @ModuleID,'OOFML000049', @MessageValue, @Language;
SET @MessageValue=N'Bạn phải chọn quy định đi trễ về sớm!'
EXEC ERP9AddMessage @ModuleID,'OOFML000050', @MessageValue, @Language;
SET @MessageValue=N'Ngày tạo đơn đã vượt quá {0} ngày kể từ ngày xin phép'
EXEC ERP9AddMessage @ModuleID,'OOFML000051', @MessageValue, @Language;
SET @MessageValue=N'Phiếu này đã {0}. Bạn không thể {0} lại!'
EXEC ERP9AddMessage @ModuleID,'OOFML000052', @MessageValue, @Language;
SET @MessageValue=N'Không được phân ca từ ngày {0} trở về sau cho nhân viên {1}!'
EXEC ERP9AddMessage @ModuleID,'OOFML000053', @MessageValue, @Language;
SET @MessageValue=N'Không được phân ca làm thêm giờ cho nhân viên đang trong chế độ thai sản từ tháng thứ 7 trở đi!'
EXEC ERP9AddMessage @ModuleID,'OOFML000054', @MessageValue, @Language;
SET @MessageValue=N'Bạn vừa được giao công việc {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000055', @MessageValue, @Language;
SET @MessageValue=N'Bạn vừa được theo dõi công việc {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000056', @MessageValue, @Language;
SET @MessageValue=N'Bạn vừa được hỗ trợ công việc {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000057', @MessageValue, @Language;
SET @MessageValue=N'Bạn vừa được giám sát công viêc {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000058', @MessageValue, @Language;
SET @MessageValue=N'Bạn vừa được tham gia vào dự án {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000059', @MessageValue, @Language;
SET @MessageValue=N'Bạn được đưa vào theo dõi dự án {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000060', @MessageValue, @Language;
SET @MessageValue=N'Công việc {0} bạn phụ trách đã bị xóa'
EXEC ERP9AddMessage @ModuleID,'OOFML000061', @MessageValue, @Language;
SET @MessageValue=N'Công việc {0} bạn hỗ trợ đã bị xóa'
EXEC ERP9AddMessage @ModuleID,'OOFML000062', @MessageValue, @Language;
SET @MessageValue=N'Công việc {0} bạn theo dõi đã bị xóa'
EXEC ERP9AddMessage @ModuleID,'OOFML000063', @MessageValue, @Language;
SET @MessageValue=N'Bạn phải phân ca thử việc cho nhân viên {0} từ ngày {1} đến ngày {2}!'
EXEC ERP9AddMessage @ModuleID,'OOFML000064', @MessageValue, @Language;
SET @MessageValue=N'Bạn phải phân ca thử việc vào các ngày {0} cho nhân viên {1}!'
EXEC ERP9AddMessage @ModuleID,'OOFML000065', @MessageValue, @Language;
SET @MessageValue=N'Không được xin phép trước ngày {0} cho nhân viên {1}!'
EXEC ERP9AddMessage @ModuleID,'OOFML000066', @MessageValue, @Language;
SET @MessageValue=N'Không được xin phép từ ngày {0} trở về sau cho nhân viên {1}!'
EXEC ERP9AddMessage @ModuleID,'OOFML000067', @MessageValue, @Language;
SET @MessageValue=N'Nhân viên {0} chưa được phân ca trong kỳ.'
EXEC ERP9AddMessage @ModuleID,'OOFML000068', @MessageValue, @Language;
SET @MessageValue=N'Người duyệt không hợp lệ!'
EXEC ERP9AddMessage @ModuleID,'OOFML000069', @MessageValue, @Language;
SET @MessageValue=N'Kỳ kế toán đã phát sinh dữ liệu. Bạn không thể thay đổi số cấp duyệt.'
EXEC ERP9AddMessage @ModuleID,'OOFML000070', @MessageValue, @Language;
SET @MessageValue=N'Mẫu công việc phải thuộc một Bước quy trình!'
EXEC ERP9AddMessage @ModuleID,'OOFML000092', @MessageValue, @Language;
SET @MessageValue=N'Đối tượng này đã được sử dụng trong Quy trình!'
EXEC ERP9AddMessage @ModuleID,'OOFML000093', @MessageValue, @Language;
SET @MessageValue=N'Các đối tượng con cũng sẽ bị xóa. Đồng ý xóa?'
EXEC ERP9AddMessage @ModuleID,'OOFML000094', @MessageValue, @Language;
SET @MessageValue=N'Bước quy trình phải thuộc một Quy trình!'
EXEC ERP9AddMessage @ModuleID,'OOFML000095', @MessageValue, @Language;
SET @MessageValue=N'Quy trình làm việc phải thuộc Dự án/Nhóm công việc hoặc một Quy trình khác!'
EXEC ERP9AddMessage @ModuleID,'OOFML000096', @MessageValue, @Language;
SET @MessageValue=N'Ngày áp dụng không hợp lệ!'
EXEC ERP9AddMessage @ModuleID,'OOFML000097', @MessageValue, @Language;
SET @MessageValue=N'Ngày kết thúc không hợp lệ!'
EXEC ERP9AddMessage @ModuleID,'OOFML000098', @MessageValue, @Language;
SET @MessageValue=N'Ngày kết thúc không được nhỏ hơn Ngày bắt đầu!'
EXEC ERP9AddMessage @ModuleID,'OOFML000099', @MessageValue, @Language;
SET @MessageValue=N'Ngày bắt đầu không được lớn hơn ngày kết thúc!'
EXEC ERP9AddMessage @ModuleID,'OOFML000100', @MessageValue, @Language;
SET @MessageValue=N'Ngày đến không hợp lệ!'
EXEC ERP9AddMessage @ModuleID,'OOFML000101', @MessageValue, @Language;
SET @MessageValue=N'Mỗi...Ngày không hợp lệ!'
EXEC ERP9AddMessage @ModuleID,'OOFML000102', @MessageValue, @Language;
SET @MessageValue=N'Bạn chưa chọn ngày trong tuần!'
EXEC ERP9AddMessage @ModuleID,'OOFML000103', @MessageValue, @Language;
SET @MessageValue=N'Dữ liệu Ngày chưa hợp lệ!'
EXEC ERP9AddMessage @ModuleID,'OOFML000104', @MessageValue, @Language;
SET @MessageValue=N'Dữ liệu Tháng chưa hợp lệ!'
EXEC ERP9AddMessage @ModuleID,'OOFML000105', @MessageValue, @Language;
SET @MessageValue=N'Giờ bắt đầu không hợp lệ!'
EXEC ERP9AddMessage @ModuleID,'OOFML000106', @MessageValue, @Language;
SET @MessageValue=N'Giờ kết thúc không hợp lệ!'
EXEC ERP9AddMessage @ModuleID,'OOFML000107', @MessageValue, @Language;
SET @MessageValue=N'Bạn chưa nhập giờ!'
EXEC ERP9AddMessage @ModuleID,'OOFML000108', @MessageValue, @Language;
SET @MessageValue=N'Bạn chưa nhập ngày!'
EXEC ERP9AddMessage @ModuleID,'OOFML000109', @MessageValue, @Language;
SET @MessageValue=N'Ngày bắt đầu không hợp lệ!'
EXEC ERP9AddMessage @ModuleID,'OOFML000110', @MessageValue, @Language;
SET @MessageValue=N'Bạn phải thiết lập thông tin cho Nhóm chỉ tiêu!'
EXEC ERP9AddMessage @ModuleID,'OOFML000111', @MessageValue, @Language;
SET @MessageValue=N'Thời gian kết thúc không hợp lệ!'
EXEC ERP9AddMessage @ModuleID,'OOFML000112', @MessageValue, @Language;
SET @MessageValue=N'Thời gian làm việc không hợp lệ!'
EXEC ERP9AddMessage @ModuleID,'OOFML000113', @MessageValue, @Language;
SET @MessageValue=N'Bạn phải chọn tối thiểu 1 ngày!'
EXEC ERP9AddMessage @ModuleID,'OOFML000114', @MessageValue, @Language;
SET @MessageValue=N'Số giờ làm việc vượt quá 24 giờ!'
EXEC ERP9AddMessage @ModuleID,'OOFML000115', @MessageValue, @Language;
SET @MessageValue=N'Bạn phải nhập quy trình!'
EXEC ERP9AddMessage @ModuleID,'OOFML000116', @MessageValue, @Language;
SET @MessageValue=N'Bạn phải nhập bước!'
EXEC ERP9AddMessage @ModuleID,'OOFML000117', @MessageValue, @Language;
SET @MessageValue=N'Bạn phải chọn Công việc dự án!'
EXEC ERP9AddMessage @ModuleID,'OOFML000118', @MessageValue, @Language;
SET @MessageValue=N'Bạn phải chọn Công việc định kỳ!'
EXEC ERP9AddMessage @ModuleID,'OOFML000119', @MessageValue, @Language;
SET @MessageValue=N'Bạn phải chọn Công việc phát sinh!'
EXEC ERP9AddMessage @ModuleID,'OOFML000120', @MessageValue, @Language;
SET @MessageValue=N'Giờ không thể là giá trị âm!'
EXEC ERP9AddMessage @ModuleID,'OOFML000121', @MessageValue, @Language;
SET @MessageValue=N'Ngày nhắc lại không phù hợp!'
EXEC ERP9AddMessage @ModuleID,'OOFML000122', @MessageValue, @Language;
SET @MessageValue=N'Mẫu mail không hợp lệ!'
EXEC ERP9AddMessage @ModuleID,'OOFML000123', @MessageValue, @Language;
SET @MessageValue=N'Mẫu SMS không hợp lệ!'
EXEC ERP9AddMessage @ModuleID,'OOFML000124', @MessageValue, @Language;
SET @MessageValue=N'Phần trăm không thể là giá trị âm!'
EXEC ERP9AddMessage @ModuleID,'OOFML000125', @MessageValue, @Language;
SET @MessageValue=N'{0} đã được thiết lập ở một dòng khác!'
EXEC ERP9AddMessage @ModuleID,'OOFML000126', @MessageValue, @Language;
SET @MessageValue=N'Tên nhân viên không hợp lệ!'
EXEC ERP9AddMessage @ModuleID,'OOFML000127', @MessageValue, @Language;
SET @MessageValue=N'Ngày bắt đầu không đúng với thời gian làm việc!'
EXEC ERP9AddMessage @ModuleID,'OOFML000128', @MessageValue, @Language;
SET @MessageValue=N'Ngày kết thúc không đúng với thời gian làm việc!'
EXEC ERP9AddMessage @ModuleID,'OOFML000129', @MessageValue, @Language;
SET @MessageValue=N'Dữ liệu không thể trùng lặp!'
EXEC ERP9AddMessage @ModuleID,'OOFML000130', @MessageValue, @Language;
SET @MessageValue=N'Cập nhật dữ liệu thành công.'
EXEC ERP9AddMessage @ModuleID,'OOFML000131', @MessageValue, @Language;
SET @MessageValue=N'Ngày bắt đầu công việc {0} đang nhỏ hơn Ngày bắt đầu dự án!'
EXEC ERP9AddMessage @ModuleID,'OOFML000132', @MessageValue, @Language;
SET @MessageValue=N'Ngày nghiệm thu không nhỏ hơn ngày bắt đầu!'
EXEC ERP9AddMessage @ModuleID,'OOFML000133', @MessageValue, @Language;
SET @MessageValue=N'Ngày nghiệm thu không đúng với thời gian làm việc!'
EXEC ERP9AddMessage @ModuleID,'OOFML000134', @MessageValue, @Language;
SET @MessageValue=N'Ngày bắt đầu công việc {0} đang lớn hơn Ngày kết thúc dự án!'
EXEC ERP9AddMessage @ModuleID,'OOFML000135', @MessageValue, @Language;
SET @MessageValue=N'Ngày kết thúc công việc {0} đang lớn hơn Ngày kết thúc dự án!'
EXEC ERP9AddMessage @ModuleID,'OOFML000136', @MessageValue, @Language;
SET @MessageValue=N'Bạn chưa thiết lập thời gian lặp lại!'
EXEC ERP9AddMessage @ModuleID,'OOFML000137', @MessageValue, @Language;
SET @MessageValue=N'{0} đã {1}, bạn không thể dùng chức năng {2}!'
EXEC ERP9AddMessage @ModuleID,'OOFML000138', @MessageValue, @Language;
SET @MessageValue=N'Đánh giá công việc: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000139', @MessageValue, @Language;
SET @MessageValue=N'Công việc {0} vừa hoàn thành cần bạn đánh giá.'
EXEC ERP9AddMessage @ModuleID,'OOFML000140', @MessageValue, @Language;
SET @MessageValue=N'{0} đang vi phạm công việc này, bạn không thể tiếp tục gán cho {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000141', @MessageValue, @Language;
SET @MessageValue=N'{0} đã Hoàn thành/Đóng, bạn không thể Xóa!'
EXEC ERP9AddMessage @ModuleID,'OOFML000142', @MessageValue, @Language;
SET @MessageValue=N'Không thể thay đổi trạng thái của Công việc Cố tình vi phạm!'
EXEC ERP9AddMessage @ModuleID,'OOFML000143', @MessageValue, @Language;
SET @MessageValue=N'Mã sự kiện không được để trống'
EXEC ERP9AddMessage @ModuleID,'OOFML000144', @MessageValue, @Language;
SET @MessageValue=N'Tên sự kiện không được để trống'
EXEC ERP9AddMessage @ModuleID,'OOFML000145', @MessageValue, @Language;
SET @MessageValue=N'Ngày nghiệm thu không được để trống'
EXEC ERP9AddMessage @ModuleID,'OOFML000146', @MessageValue, @Language;
SET @MessageValue=N'Hiện tại bạn đang có thông báo: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000147', @MessageValue, @Language;
SET @MessageValue=N'Thông báo : {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000148', @MessageValue, @Language;
SET @MessageValue=N'Phòng ban không được để trống'
EXEC ERP9AddMessage @ModuleID,'OOFML000149', @MessageValue, @Language;
SET @MessageValue=N'Bạn phải chọn người thực hiện!'
EXEC ERP9AddMessage @ModuleID,'OOFML000150', @MessageValue, @Language;
SET @MessageValue=N'Bạn phải chọn Đánh giá QTCM!'
EXEC ERP9AddMessage @ModuleID,'OOFML000151', @MessageValue, @Language;
SET @MessageValue=N'Có một công việc chưa hoàn thành cần bạn xem xét'
EXEC ERP9AddMessage @ModuleID,'OOFML000152', @MessageValue, @Language;
SET @MessageValue=N'Bạn phải chọn Đánh giá VHPT!'
EXEC ERP9AddMessage @ModuleID,'OOFML000153', @MessageValue, @Language;
SET @MessageValue=N'Công việc bị trễ: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000154', @MessageValue, @Language;
SET @MessageValue=N'Có một công việc chưa hoàn thành cần bạn xem xét: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000155', @MessageValue, @Language;
SET @MessageValue=N'{0} bị trễ công việc {1}'
EXEC ERP9AddMessage @ModuleID,'OOFML000156', @MessageValue, @Language;
SET @MessageValue=N'{0} đã được khởi tạo'
EXEC ERP9AddMessage @ModuleID,'OOFML000157', @MessageValue, @Language;
SET @MessageValue=N'Bạn phải nhập dự án!'
EXEC ERP9AddMessage @ModuleID,'OOFML000158', @MessageValue, @Language;
SET @MessageValue=N'Bạn vừa được giao 1 công việc: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000159', @MessageValue, @Language;
SET @MessageValue=N'Bạn vừa được giao hỗ trợ cho công việc: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000160', @MessageValue, @Language;
SET @MessageValue=N'Bạn vừa được giao giám sát công việc: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000161', @MessageValue, @Language;
SET @MessageValue=N'Ngày bắt đầu hoặc ngày kết thúc thuộc vào ngày nghỉ của công ty. Bạn có muốn tiếp tục không?'
EXEC ERP9AddMessage @ModuleID,'OOFML000162', @MessageValue, @Language;
SET @MessageValue=N'Thay đổi mẫu sẽ làm mất các dữ liệu đã nhập. Bạn có muốn đổi mẫu không?'
EXEC ERP9AddMessage @ModuleID,'OOFML000163', @MessageValue, @Language;
SET @MessageValue=N'Ngày bắt đầu/Ngày kết thúc/Ngày nghiệm thu thuộc vào ngày nghỉ của công ty. Bạn có muốn tiếp tục không?'
EXEC ERP9AddMessage @ModuleID,'OOFML000164', @MessageValue, @Language;
SET @MessageValue=N'Ngày bắt đầu hoặc ngày kết thúc thuộc vào ngày nghỉ của công ty. Bạn có muốn tiếp tục không?'
EXEC ERP9AddMessage @ModuleID,'OOFML000165', @MessageValue, @Language;
SET @MessageValue=N'Bạn vừa được giao 1 công việc có độ ưu tiên cao: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000166', @MessageValue, @Language;
SET @MessageValue=N'Công việc {0} của bạn đã được chuyển thành công việc có độ ưu tiên cao'
EXEC ERP9AddMessage @ModuleID,'OOFML000167', @MessageValue, @Language;
SET @MessageValue=N'Công việc {0} của bạn vừa được chuyển sang cho {1}'
EXEC ERP9AddMessage @ModuleID,'OOFML000170', @MessageValue, @Language;
SET @MessageValue=N'{0} là công việc được tạo do nhân viên khác cố tình vi phạm, bạn không thể xóa!'
EXEC ERP9AddMessage @ModuleID,'OOFML000171', @MessageValue, @Language;
SET @MessageValue=N'Công việc {0} do bạn hỗ trợ đã được chuyển thành công việc có độ ưu tiên cao'
EXEC ERP9AddMessage @ModuleID,'OOFML000172', @MessageValue, @Language;
SET @MessageValue=N'Công việc {0} do bạn giám sát đã được chuyển thành công việc có độ ưu tiên cao'
EXEC ERP9AddMessage @ModuleID,'OOFML000173', @MessageValue, @Language;
SET @MessageValue=N'Không thể chỉnh sửa khi công việc đã hoàn thành hoặc đóng'
EXEC ERP9AddMessage @ModuleID,'OOFML000174', @MessageValue, @Language;
SET @MessageValue=N'Không thể tạo mới công việc khi đã chốt kỳ'
EXEC ERP9AddMessage @ModuleID,'OOFML000177', @MessageValue, @Language;
SET @MessageValue=N'Không thể tạo mới dự án khi đã chốt kỳ'
EXEC ERP9AddMessage @ModuleID,'OOFML000178', @MessageValue, @Language;
SET @MessageValue=N'{0} đã được đánh giá, bạn không thể {1}!'
EXEC ERP9AddMessage @ModuleID,'OOFML000179', @MessageValue, @Language;
SET @MessageValue=N'thay đổi trạng thái'
EXEC ERP9AddMessage @ModuleID,'OOFML000180', @MessageValue, @Language;
SET @MessageValue=N'chỉnh sửa checklist'
EXEC ERP9AddMessage @ModuleID,'OOFML000181', @MessageValue, @Language;
SET @MessageValue=N'chỉnh sửa đính kèm'
EXEC ERP9AddMessage @ModuleID,'OOFML000182', @MessageValue, @Language;
SET @MessageValue=N'Công việc không thể có đối tượng con!'
EXEC ERP9AddMessage @ModuleID,'OOFML000183', @MessageValue, @Language;
SET @MessageValue=N'Bạn không có quyền từ chối hoàn thành {0} tại đây'
EXEC ERP9AddMessage @ModuleID,'OOFML000184', @MessageValue, @Language;
SET @MessageValue=N'Đã tồn tại công việc trong khoảng thời gian này. Bạn có muốn tiếp tục không?'
EXEC ERP9AddMessage @ModuleID,'OOFML000185', @MessageValue, @Language;
SET @MessageValue=N'Bước không thể chuyển thành Công Việc'
EXEC ERP9AddMessage @ModuleID,'OOFML000186', @MessageValue, @Language;
SET @MessageValue=N'Đối tượng dự án không thể chuyển thành công việc hay bước'
EXEC ERP9AddMessage @ModuleID,'OOFML000187', @MessageValue, @Language;
SET @MessageValue=N'Đối tượng công việc không thể chuyển thành bước hay quy trình'
EXEC ERP9AddMessage @ModuleID,'OOFML000188', @MessageValue, @Language;
SET @MessageValue=N'Bước được tạo từ Quy Trình không thể đổi thành Công Việc'
EXEC ERP9AddMessage @ModuleID,'OOFML000189', @MessageValue, @Language;
SET @MessageValue=N'Dữ liệu được không thể xóa'
EXEC ERP9AddMessage @ModuleID,'OOFML000190', @MessageValue, @Language;
SET @MessageValue=N'Mã phân tích không được trùng nhau'
EXEC ERP9AddMessage @ModuleID,'OOFML000191', @MessageValue, @Language;
SET @MessageValue=N'Bạn chưa nhập tên nhân viên'
EXEC ERP9AddMessage @ModuleID,'OOFML000192', @MessageValue, @Language;
SET @MessageValue=N'Không thể gán công việc cho Bước quy trình đã sử dụng!'
EXEC ERP9AddMessage @ModuleID,'OOFML000193', @MessageValue, @Language;
SET @MessageValue=N'Không thể xóa đối tượng đã sử dụng!'
EXEC ERP9AddMessage @ModuleID,'OOFML000194', @MessageValue, @Language;
SET @MessageValue=N'Công việc đã được chốt lương mềm!'
EXEC ERP9AddMessage @ModuleID,'OOFML000195', @MessageValue, @Language;
SET @MessageValue=N'Bạn phải chuyển sang Trạng thái Đang thực hiện trước khi chuyển sang các Trạng thái khác!'
EXEC ERP9AddMessage @ModuleID,'OOFML000196', @MessageValue, @Language;
SET @MessageValue=N'Công việc đã bắt đầu không thể chuyển sang Trạng thái Chưa thực hiện!'
EXEC ERP9AddMessage @ModuleID,'OOFML000197', @MessageValue, @Language;
SET @MessageValue=N'Bạn muốn chuyển sang trạng thái {0}?'
EXEC ERP9AddMessage @ModuleID,'OOFML000198', @MessageValue, @Language;
SET @MessageValue=N'Vấn đề phải thuộc Dự án, Công việc hoặc Yêu cầu'
EXEC ERP9AddMessage @ModuleID,'OOFML000199', @MessageValue, @Language;
SET @MessageValue=N'Thời hạn kết thúc không được nhỏ hơn thời gian phát sinh vấn đề'
EXEC ERP9AddMessage @ModuleID,'OOFML000200', @MessageValue, @Language;
SET @MessageValue=N'Điểm số không được bỏ trống!'
EXEC ERP9AddMessage @ModuleID,'OOFML000201', @MessageValue, @Language;
SET @MessageValue=N'Điểm số không được vượt nhỏ hơn 0 và vượt quá 100!'
EXEC ERP9AddMessage @ModuleID,'OOFML000202', @MessageValue, @Language;
SET @MessageValue=N'Bạn chưa nhập Dự án'
EXEC ERP9AddMessage @ModuleID,'OOFML000203', @MessageValue, @Language;
SET @MessageValue=N'{0} đã được tính lương, bạn không thể {1}!'
EXEC ERP9AddMessage @ModuleID,'OOFML000204', @MessageValue, @Language;
SET @MessageValue=N'Thời hạn kết thúc không được nhỏ hơn thời gian phát sinh yêu cầu'
EXEC ERP9AddMessage @ModuleID,'OOFML000205', @MessageValue, @Language;
SET @MessageValue=N'Danh sách tồn tại định mức đã được xét duyệt.'
EXEC ERP9AddMessage @ModuleID,'OOFML000206', @MessageValue, @Language;
SET @MessageValue=N'Công việc định kỳ: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000207', @MessageValue, @Language;
SET @MessageValue=N'{0} là Trạng thái của hệ thống, bạn không thể Sửa/Xóa!'
EXEC ERP9AddMessage @ModuleID,'OOFML000208', @MessageValue, @Language;
SET @MessageValue=N'{0} có công việc định kỳ {1}'
EXEC ERP9AddMessage @ModuleID,'OOFML000209', @MessageValue, @Language;
SET @MessageValue=N'Bạn vừa được giao 1 vấn đề có độ ưu tiên cao: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000210', @MessageValue, @Language;
SET @MessageValue=N'Bạn vừa được giao 1 vấn đề có độ ưu tiên thấp: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000211', @MessageValue, @Language;
SET @MessageValue=N'Vấn đề {0} của bạn vừa được chuyển sang cho {1}'
EXEC ERP9AddMessage @ModuleID,'OOFML000212', @MessageValue, @Language;
SET @MessageValue=N'Vấn đề {0} của bạn đã được chuyển thành vấn đề có độ ưu tiên cao'
EXEC ERP9AddMessage @ModuleID,'OOFML000213', @MessageValue, @Language;
SET @MessageValue=N'Bạn vừa được giao 1 yêu cầu hỗ trợ có độ ưu tiên cao: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000214', @MessageValue, @Language;
SET @MessageValue=N'Bạn vừa được giao 1 yêu cầu hỗ trợ có độ ưu tiên thấp: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000215', @MessageValue, @Language;
SET @MessageValue=N'Yêu cầu hỗ trợ {0} của bạn vừa được chuyển sang cho {1}'
EXEC ERP9AddMessage @ModuleID,'OOFML000216', @MessageValue, @Language;
SET @MessageValue=N'Yêu cầu hỗ trợ {0} của bạn đã được chuyển thành Yêu cầu hỗ trợ có độ ưu tiên cao'
EXEC ERP9AddMessage @ModuleID,'OOFML000217', @MessageValue, @Language;
SET @MessageValue=N'Bạn có muốn tiếp tục không?'
EXEC ERP9AddMessage @ModuleID,'OOFML000218', @MessageValue, @Language;
SET @MessageValue=N'Vấn đề {0} của bạn đã được chuyển sang trạng thái {1}'
EXEC ERP9AddMessage @ModuleID,'OOFML000219', @MessageValue, @Language;
SET @MessageValue=N'Yêu cầu hỗ trợ {0} của bạn đã được chuyển sang trạng thái {1}'
EXEC ERP9AddMessage @ModuleID,'OOFML000220', @MessageValue, @Language;
SET @MessageValue=N'Không thể cập nhật tiến độ 100% khi ở trạng thái đang thực hiện!'
EXEC ERP9AddMessage @ModuleID,'OOFML000221', @MessageValue, @Language;
SET @MessageValue=N'Ngày kết thúc công việc đang nhỏ hơn Ngày kết thúc dự án!'
EXEC ERP9AddMessage @ModuleID,'OOFML000222', @MessageValue, @Language;
SET @MessageValue=N'Bạn chỉ có thể tạo Yêu cầu hỗ trợ cho cuộc gọi vào thành công'
EXEC ERP9AddMessage @ModuleID,'OOFML000223', @MessageValue, @Language;
SET @MessageValue=N'Hệ thống đang xử lý. Vui lòng chờ và không tải lại trình duyệt!'
EXEC ERP9AddMessage @ModuleID,'OOFML000224', @MessageValue, @Language;
SET @MessageValue=N' Dữ liệu Khách Hàng và Liên Hệ khi kế thừa phải trùng khớp với Dữ liệu Khách Hàng và Liên Hệ của cuộc gọi'
EXEC ERP9AddMessage @ModuleID,'OOFML000225', @MessageValue, @Language;
SET @MessageValue=N'Ngày tạo trước công việc không được lớn hơn ngày kết thúc hiệu lực'
EXEC ERP9AddMessage @ModuleID,'OOFML000227', @MessageValue, @Language;
SET @MessageValue=N'Không thể xóa dữ liệu từ báo giá'
EXEC ERP9AddMessage @ModuleID,'OOFML000228', @MessageValue, @Language;
SET @MessageValue=N'Chưa thiết lập thời gian làm việc'
EXEC ERP9AddMessage @ModuleID,'OOFML000229', @MessageValue, @Language;
SET @MessageValue=N'Thời hạn kết thúc {0} đang nhỏ hơn ngày bắt đầu!'
EXEC ERP9AddMessage @ModuleID,'OOFML000233', @MessageValue, @Language;
SET @MessageValue=N'Thời gian bắt đâu/ kết thúc của công việc đang nằm ngoài Ngày bắt đầu/ kết thúc của dự án'
EXEC ERP9AddMessage @ModuleID,'OOFML000234', @MessageValue, @Language;
SET @MessageValue=N'- Xóa phiếu vấn đề: '
EXEC ERP9AddMessage @ModuleID,'OOFML000235', @MessageValue, @Language;
SET @MessageValue=N'- Xóa phiếu yêu cầu: '
EXEC ERP9AddMessage @ModuleID,'OOFML000236', @MessageValue, @Language;
SET @MessageValue=N'Công việc {0} không thể chuyển sang {1}!'
EXEC ERP9AddMessage @ModuleID,'OOFML000237', @MessageValue, @Language;
SET @MessageValue=N'Công việc được {0} khi bạn xét duyệt phiếu {1}!'
EXEC ERP9AddMessage @ModuleID,'OOFML000238', @MessageValue, @Language;
SET @MessageValue=N'Công việc {0} phụ thuộc vào trạng thái Duyệt/Từ chối của phiếu {1}!'
EXEC ERP9AddMessage @ModuleID,'OOFML000239', @MessageValue, @Language;
SET @MessageValue=N'Bạn vừa được giao 1 vấn đề có độ ưu tiên khẩn cấp: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000240', @MessageValue, @Language;
SET @MessageValue=N'Bạn vừa được giao 1 yêu cầu hỗ trợ có độ ưu tiên khẩn cấp: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000241', @MessageValue, @Language;
SET @MessageValue=N'Bạn chưa chọn dữ liệu in'
EXEC ERP9AddMessage @ModuleID,'OOFML000242', @MessageValue, @Language;
SET @MessageValue=N'Bạn chưa chọn đơn vị'
EXEC ERP9AddMessage @ModuleID,'OOFML000243', @MessageValue, @Language;
SET @MessageValue=N'Bạn chưa chọn dự án'
EXEC ERP9AddMessage @ModuleID,'OOFML000244', @MessageValue, @Language;
SET @MessageValue=N'Vấn đề đã bắt đầu không thể chuyển sang Trạng thái Chưa thực hiện!'
EXEC ERP9AddMessage @ModuleID,'OOFML000245', @MessageValue, @Language;
SET @MessageValue=N'Vấn đề {0} không thể chuyển sang {1}!'
EXEC ERP9AddMessage @ModuleID,'OOFML000246', @MessageValue, @Language;
SET @MessageValue=N'Yêu cầu hỗ trợ đã bắt đầu không thể chuyển sang Trạng thái Chưa thực hiện! '
EXEC ERP9AddMessage @ModuleID,'OOFML000247', @MessageValue, @Language;
SET @MessageValue=N'Yêu cầu hỗ trợ {0} không thể chuyển sang {1}!'
EXEC ERP9AddMessage @ModuleID,'OOFML000248', @MessageValue, @Language;
SET @MessageValue=N'Milestone đã bắt đầu không thể chuyển sang Trạng thái Chưa thực hiện!'
EXEC ERP9AddMessage @ModuleID,'OOFML000249', @MessageValue, @Language;
SET @MessageValue=N'Milestone {0} không thể chuyển sang {1}!'
EXEC ERP9AddMessage @ModuleID,'OOFML000250', @MessageValue, @Language;
SET @MessageValue=N'Nhận mail thành công'
EXEC ERP9AddMessage @ModuleID,'OOFML000252', @MessageValue, @Language;
SET @MessageValue=N'Dữ liệu email lưu không thành công!'
EXEC ERP9AddMessage @ModuleID,'OOFML000253', @MessageValue, @Language;
SET @MessageValue=N'Bạn không có email mới'
EXEC ERP9AddMessage @ModuleID,'OOFML000254', @MessageValue, @Language;
SET @MessageValue=N'Vui lòng thiết lập thông tin nhận mail'
EXEC ERP9AddMessage @ModuleID,'OOFML000255', @MessageValue, @Language;
SET @MessageValue=N'Dữ liệu Email đã tồn tại'
EXEC ERP9AddMessage @ModuleID,'OOFML000256', @MessageValue, @Language;
SET @MessageValue=N'Thay đổi Từ điển hỗ trợ sẽ làm mất các dữ liệu đang nhập.'
EXEC ERP9AddMessage @ModuleID,'OOFML000257', @MessageValue, @Language;
SET @MessageValue=N'Giờ bắt đầu hoặc giờ kết thúc không nằm trong giờ làm việc. Bạn có muốn tiếp tục không?'
EXEC ERP9AddMessage @ModuleID,'OOFML000258', @MessageValue, @Language;
SET @MessageValue=N'Thời gian bắt đầu và thời gian kết thúc đã bị trùng, xin chọn thời gian khác!'
EXEC ERP9AddMessage @ModuleID,'OOFML000259', @MessageValue, @Language;
SET @MessageValue=N'Bạn không được phép xóa {0}!!!'
EXEC ERP9AddMessage @ModuleID,'OOFML000260', @MessageValue, @Language;
SET @MessageValue=N'Thời gian lặp đã được đặt. Vui lòng chọn thời gian khác!!!'
EXEC ERP9AddMessage @ModuleID,'OOFML000261', @MessageValue, @Language;
SET @MessageValue=N'Khoảng thời gian cho phép là 365 ngày. Vui lòng chọn lại thời gian!!!'
EXEC ERP9AddMessage @ModuleID,'OOFML000262', @MessageValue, @Language;
SET @MessageValue=N'Phiếu {0} không phải dữ liệu kế thừa, bạn không thể gỡ bỏ.'
EXEC ERP9AddMessage @ModuleID,'OOFML000263', @MessageValue, @Language;
SET @MessageValue=N'Thời gian {0} từ {1} đến {2} đã xác nhận đặt. Bạn phải chọn lại thời gian khác cho mã đặt {3} !!!'
EXEC ERP9AddMessage @ModuleID,'OOFML000264', @MessageValue, @Language;
SET @MessageValue=N'Bạn vừa nhận {0} email mới.'
EXEC ERP9AddMessage @ModuleID,'OOFML000265', @MessageValue, @Language;
SET @MessageValue=N'Chiến dịch email {0} đã gửi hoàn tất. Số lượng email đã gửi {1}/{2}'
EXEC ERP9AddMessage @ModuleID,'OOFML000266', @MessageValue, @Language;
SET @MessageValue=N'Chiến dịch SMS {0} đã gửi hoàn tất. Số lượng SMS đã gửi {1}/{2}'
EXEC ERP9AddMessage @ModuleID,'OOFML000267', @MessageValue, @Language;

SET @MessageValue=N'{0} chưa có tài khoản Văn bản điện tử.'
EXEC ERP9AddMessage @ModuleID,'OOFML000268', @MessageValue, @Language;

SET @MessageValue=N'Văn bản {0} cần ký số không thể duyệt!'
EXEC ERP9AddMessage @ModuleID,'OOFML000269', @MessageValue, @Language;

SET @MessageValue=N'Cấp duyệt của người duyệt phải liên tiếp!'
EXEC ERP9AddMessage @ModuleID,'OOFML000270', @MessageValue, @Language;

SET @MessageValue=N'Bạn có văn bản {0} cần duyệt'
EXEC ERP9AddMessage @ModuleID,'OOFML000271', @MessageValue, @Language;

SET @MessageValue=N'Bạn có văn bản {0} cần được duyệt và ký số'
EXEC ERP9AddMessage @ModuleID,'OOFML000272', @MessageValue, @Language;

SET @MessageValue=N'Văn bản {0} đã được duyệt bởi {1}'
EXEC ERP9AddMessage @ModuleID,'OOFML000273', @MessageValue, @Language;

SET @MessageValue=N'Văn bản {0} đã bị từ chối duyệt'
EXEC ERP9AddMessage @ModuleID,'OOFML000274', @MessageValue, @Language;

SET @MessageValue=N'Văn bản {0} đã được duyệt ký số bởi {1}'
EXEC ERP9AddMessage @ModuleID,'OOFML000275', @MessageValue, @Language;

SET @MessageValue=N'Bạn vừa được giao quyền chỉ đạo giải quyết văn bản {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000276', @MessageValue, @Language;

SET @MessageValue=N'Bạn được gán phụ trách văn bản {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000277', @MessageValue, @Language;

SET @MessageValue=N'Hạn hoàn thành không hợp lệ.'
EXEC ERP9AddMessage @ModuleID,'OOFML000278', @MessageValue, @Language;

SET @MessageValue=N'Bạn đã khai báo thông tin đăng ký dự án. Bạn chỉ được chỉnh sửa'
EXEC ERP9AddMessage @ModuleID,'OOFML000279', @MessageValue, @Language;

SET @MessageValue=N'Bạn vừa được giao 1 chỉ tiêu/công việc có độ ưu tiên thấp: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000280', @MessageValue, @Language;

SET @MessageValue=N'Bạn vừa được giao 1 chỉ tiêu/công việc có độ ưu tiên cao: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000281', @MessageValue, @Language;

SET @MessageValue=N'Bạn vừa được giao 1 chỉ tiêu/công việc có độ ưu tiên khẩn cấp: {0}'
EXEC ERP9AddMessage @ModuleID,'OOFML000282', @MessageValue, @Language;

SET @MessageValue=N'Chỉ tiêu/Công việc đã hủy không thể chuyển sang trạng thái Đã xong!'
EXEC ERP9AddMessage @ModuleID,'OOFML000283', @MessageValue, @Language;

SET @MessageValue=N'Chỉ tiêu/Công việc đã bắt đầu không thể chuyển sang trạng thái Chưa thực hiện!'
EXEC ERP9AddMessage @ModuleID,'OOFML000284', @MessageValue, @Language;

SET @MessageValue=N'Bạn phải chuyển sang trạng thái Đang xử lý trước khi chuyển sang các trạng thái khác!'
EXEC ERP9AddMessage @ModuleID,'OOFML000285', @MessageValue, @Language;

SET @MessageValue=N'{0} đã hoàn thành công việc {1}'
EXEC ERP9AddMessage @ModuleID,'OOFML000286', @MessageValue, @Language;

-- [Thu Hà] - [31/10/2023]- Bổ sung thông báo Xóa phiếu chỉ tiêu/công việc
SET @MessageValue=N'- Xóa phiếu chỉ tiêu/công việc: '
EXEC ERP9AddMessage @ModuleID,'OOFML000287', @MessageValue, @Language;

-- [Tấn Lộc] - [09/11/2023] - Begin add
SET @MessageValue=N'Vấn đề phải thuộc nghiệp vụ cụ thể!'
EXEC ERP9AddMessage @ModuleID,'OOFML000288', @MessageValue, @Language;

