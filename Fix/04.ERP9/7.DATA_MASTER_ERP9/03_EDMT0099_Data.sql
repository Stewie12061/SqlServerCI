-- Created by HỒNG THẢO
-- Add dữ liệu ngầm Module ASOFT-EDM
-- Modified by Lê Hoàng ON 16/11/2020 : kiểm tra insert nếu không tồn tại và cập nhật nếu đã tồn tại
-- Modified by Tấn Lộc ON 29/07/2021 : Bổ sung dữ liệu cho cột CodeMasterName
-- Modified by on
-- Select * from EDMT0099

DECLARE @CodeMaster VARCHAR(50)
DECLARE @TableID VARCHAR(50) = 'EDMT0099'

-----------------------------------------Dùng chung, Không hiển thị (Disabled)-------------------------------------
--[CodeMaster], [ID], [OrderNo], [Description], [DescriptionE], [Disabled]
--EXEC AddDataMasterERP9 @TableID,@CodeMaster,@ID,@ID1,@OrderNo,@Description,@DescriptionE,@Disabled,@LanguageID,@CodeMasterName
EXEC AddDataMasterERP9 @TableID, 'Disabled', '0', NULL, 1, N'Không', N'No', 0, NULL, N'Không hiển thị'
EXEC AddDataMasterERP9 @TableID, 'Disabled', '1', NULL, 2, N'Có', N'Yes', 0, NULL, N'Không hiển thị'

-----------------------------------------Dùng chung, cấp bậc học (Level)-------------------------------------
EXEC AddDataMasterERP9 @TableID, 'Level', '0', NULL, 1, N'Nhà trẻ', N'Nursery', 0, NULL, N'Cấp (Màn hình Cập nhật danh mục định mức - EDMF1011)'
EXEC AddDataMasterERP9 @TableID, 'Level', '1', NULL, 2, N'Mẫu giáo', N'Kindergarten', 0, NULL, N'Cấp (Màn hình Cập nhật danh mục định mức - EDMF1011)'
EXEC AddDataMasterERP9 @TableID, 'Level', '2', NULL, 3, N'Tiểu học', N'Primary', 0, NULL, N'Cấp (Màn hình Cập nhật danh mục định mức - EDMF1011)'
EXEC AddDataMasterERP9 @TableID, 'Level', '3', NULL, 4, N'Trung học cơ sở', N'Junior high', 0, NULL, N'Cấp (Màn hình Cập nhật danh mục định mức - EDMF1011)'
EXEC AddDataMasterERP9 @TableID, 'Level', '4', NULL, 5, N'Trung học phổ thông', N'High', 0, NULL, N'Cấp (Màn hình Cập nhật danh mục định mức - EDMF1011)'

-----------------------------------------Loại điều tra tâm lý (PsychologizeType)-------------------------------------
EXEC AddDataMasterERP9 @TableID, 'PsychologizeType', '0', NULL, 1, N'Đặc điểm tâm lý', N'Psychological characteristics', 0, NULL, N'Loại hình tâm lý'
EXEC AddDataMasterERP9 @TableID, 'PsychologizeType', '1', NULL, 2, N'Cách giáo dục trẻ của phụ huynh', N'Child education method', 0, NULL, N'Loại hình tâm lý'

-----------------------------------------Loại dữ liệu (FeeType)-------------------------------------
EXEC AddDataMasterERP9 @TableID, 'FeeType', '0', NULL, 1, N'Phí ban đầu', N'Initial Fee', 0, NULL, N'Loại phí (Màn hình Cập nhật biểu phí - EDMF1091)'
EXEC AddDataMasterERP9 @TableID, 'FeeType', '1', NULL, 2, N'Phí định kỳ', N'Royalty Fee', 0, NULL, N'Loại phí (Màn hình Cập nhật biểu phí - EDMF1091)'



-----------------------------------------Đơn vị tính thời gian (Time)-------------------------------------
EXEC AddDataMasterERP9 @TableID, 'Time', '1', NULL, 1, N'Ngày', N'Date', 0, NULL, N'Đơn bị tính thời gian (Màn hình Cập nhật biểu phí - EDMF1091)'
EXEC AddDataMasterERP9 @TableID, 'Time', '2', NULL, 2, N'Tháng', N'Quarters', 0, NULL, N'Đơn bị tính thời gian (Màn hình Cập nhật biểu phí - EDMF1091)'
EXEC AddDataMasterERP9 @TableID, 'Time', '3', NULL, 3, N'Năm', N'Year', 0, NULL, N'Đơn bị tính thời gian (Màn hình Cập nhật biểu phí - EDMF1091)'


-----------------------------------------Tháng (Month)-------------------------------------
EXEC AddDataMasterERP9 @TableID, 'Month', '1', NULL, 1, N'Tháng 1', N'January', 0, NULL, N'Tháng (Màn hình Cập nhật chương trình học tháng - EDMF2121)'
EXEC AddDataMasterERP9 @TableID, 'Month', '2', NULL, 2, N'Tháng 2', N'February', 0, NULL, N'Tháng (Màn hình Cập nhật chương trình học tháng - EDMF2121)'
EXEC AddDataMasterERP9 @TableID, 'Month', '3', NULL, 3, N'Tháng 3', N'March', 0, NULL, N'Tháng (Màn hình Cập nhật chương trình học tháng - EDMF2121)'
EXEC AddDataMasterERP9 @TableID, 'Month', '4', NULL, 4, N'Tháng 4', N'April', 0, NULL, N'Tháng (Màn hình Cập nhật chương trình học tháng - EDMF2121)'
EXEC AddDataMasterERP9 @TableID, 'Month', '5', NULL, 5, N'Tháng 5', N'May', 0, NULL, N'Tháng (Màn hình Cập nhật chương trình học tháng - EDMF2121)'
EXEC AddDataMasterERP9 @TableID, 'Month', '6', NULL, 6, N'Tháng 6', N'June', 0, NULL, N'Tháng (Màn hình Cập nhật chương trình học tháng - EDMF2121)'
EXEC AddDataMasterERP9 @TableID, 'Month', '7', NULL, 7, N'Tháng 7', N'July', 0, NULL, N'Tháng (Màn hình Cập nhật chương trình học tháng - EDMF2121)'
EXEC AddDataMasterERP9 @TableID, 'Month', '8', NULL, 8, N'Tháng 8', N'August', 0, NULL, N'Tháng (Màn hình Cập nhật chương trình học tháng - EDMF2121)'
EXEC AddDataMasterERP9 @TableID, 'Month', '9', NULL, 9, N'Tháng 9', N'September', 0, NULL, N'Tháng (Màn hình Cập nhật chương trình học tháng - EDMF2121)'
EXEC AddDataMasterERP9 @TableID, 'Month', '10', NULL, 10, N'Tháng 10', N'October', 0, NULL, N'Tháng (Màn hình Cập nhật chương trình học tháng - EDMF2121)'
EXEC AddDataMasterERP9 @TableID, 'Month', '11', NULL, 11, N'Tháng 11', N'November', 0, NULL, N'Tháng (Màn hình Cập nhật chương trình học tháng - EDMF2121)'
EXEC AddDataMasterERP9 @TableID, 'Month', '12', NULL, 12, N'Tháng 12', N'December', 0, NULL, N'Tháng (Màn hình Cập nhật chương trình học tháng - EDMF2121)'


-----------------------------------------Kết quả tư vấn (ConsultancyResult) -------------------------------------

EXEC AddDataMasterERP9 @TableID, 'ConsultancyResult', '0', NULL, 0, N'Không phản hồi', N'No rely', 0, NULL, N'Kết quả tư vấn'
EXEC AddDataMasterERP9 @TableID, 'ConsultancyResult', '1', NULL, 1, N'Đăng ký nhập học', N'Confirm', 0, NULL, N'Kết quả tư vấn'
EXEC AddDataMasterERP9 @TableID, 'ConsultancyResult', '2', NULL, 2, N'Học thử', N'Try out', 0, NULL, N'Kết quả tư vấn'
EXEC AddDataMasterERP9 @TableID, 'ConsultancyResult', '3', NULL, 3, N'Giữ chỗ', N'Place Reservation', 0, NULL, N'Kết quả tư vấn'



-----------------------------------------Trạng thái tại Hồ sơ học sinh (StudentStatus) -------------------------------------

EXEC AddDataMasterERP9 @TableID, 'StudentStatus', '0', NULL, 0, N'Học chính thức', N'Confirm', 0, NULL, N'Trạng thái học sinh (Màn hình Cập nhật loại hình thu - EDMF1051)'
EXEC AddDataMasterERP9 @TableID, 'StudentStatus', '1', NULL, 1, N'Học thử', N'Try out', 0, NULL, N'Trạng thái học sinh (Màn hình Cập nhật loại hình thu - EDMF1051)'
EXEC AddDataMasterERP9 @TableID, 'StudentStatus', '2', NULL, 2, N'Giữ chỗ', N'Place Reservation', 0, NULL, N'Trạng thái học sinh (Màn hình Cập nhật loại hình thu - EDMF1051)'
EXEC AddDataMasterERP9 @TableID, 'StudentStatus', '3', NULL, 3, N'Nghỉ học', N'Offline', 0, NULL, N'Trạng thái học sinh (Màn hình Cập nhật loại hình thu - EDMF1051)'
EXEC AddDataMasterERP9 @TableID, 'StudentStatus', '4', NULL, 4, N'Bảo lưu', N'Reserve', 0, NULL, N'Trạng thái học sinh (Màn hình Cập nhật loại hình thu - EDMF1051)'
EXEC AddDataMasterERP9 @TableID, 'StudentStatus', '5', NULL, 5, N'Chuyển trường', N'Transfer', 0, NULL, N'Trạng thái học sinh (Màn hình Cập nhật loại hình thu - EDMF1051)'


-----------------------------------------Trạng thái Xác nhận Hồ sơ học sinh (ComfirmStatus) -------------------------------------

EXEC AddDataMasterERP9 @TableID, 'ComfirmStatus', '0', NULL, 0, N'Không hơp lệ', N'Invalid', 0, NULL, N'Trạng thái Xác nhận Hồ sơ học sinh (Màn hình Cập nhật xác nhận hồ sơ học sinh - EDMF2015)'
EXEC AddDataMasterERP9 @TableID, 'ComfirmStatus', '1', NULL, 1, N'Hợp lệ', N'Valid', 0, NULL, N'Trạng thái Xác nhận Hồ sơ học sinh (Màn hình Cập nhật xác nhận hồ sơ học sinh - EDMF2015)'


-----------------------------------------Trạng thái thanh toán (PaymentStatus) -------------------------------------

EXEC AddDataMasterERP9 @TableID, 'PaymentStatus', '0', NULL, 0, N'Chưa thanh toán', N'Unpaid', 0, NULL, N'Tình trạng thanh toán (Màn hình Cập nhật thông tin hợp dồng - CIF1361)'
EXEC AddDataMasterERP9 @TableID, 'PaymentStatus', '1', NULL, 1, N'Đã thanh toán', N'Paid', 0, NULL, N'Tình trạng thanh toán (Màn hình Cập nhật thông tin hợp dồng - CIF1361)'



-----------------------------------------Giới tính (Sex) -------------------------------------

EXEC AddDataMasterERP9 @TableID, 'Sex', '0', NULL, 0, N'Nam', N'Male', 0, NULL, N'Giới tính'
EXEC AddDataMasterERP9 @TableID, 'Sex', '1', NULL, 1, N' Nữ', N'Female', 0, NULL, N'Giới tính'

-----------------------------------------Trạng thái điểm danh học sinh (StudentAttendance) -------------------------------------
EXEC AddDataMasterERP9 @TableID, 'StudentAttendance', 'HD', NULL, 0, N'Hiện diện', N'Available', 0, NULL, N'Trạng thái điểm danh học sinh (Màn hình Cập nhật điểm danh - EDMF2041)'
EXEC AddDataMasterERP9 @TableID, 'StudentAttendance', 'CP', NULL, 1, N'Nghỉ phép', N'AbsentPermission', 0, NULL, N'Trạng thái điểm danh học sinh (Màn hình Cập nhật điểm danh - EDMF2041)'
EXEC AddDataMasterERP9 @TableID, 'StudentAttendance', 'KP', NULL, 2, N'Nghỉ không phép', N'AbsentNotPermission', 0, NULL, N'Trạng thái điểm danh học sinh (Màn hình Cập nhật điểm danh - EDMF2041)'

-----------------------------------------Kết quả đánh giá (EvaluetionResult) -------------------------------------

EXEC AddDataMasterERP9 @TableID, 'EvaluetionResult', 'TOT', NULL, 0, N'Tốt', N'Good', 0, NULL, N'Kết quả đánh giá (Màn hình cập nhật kết quả dự giờ - EDMF2061)'
EXEC AddDataMasterERP9 @TableID, 'EvaluetionResult', 'KHA', NULL, 1, N' Khá', N'Rather', 0, NULL, N'Kết quả đánh giá (Màn hình cập nhật kết quả dự giờ - EDMF2061)'
EXEC AddDataMasterERP9 @TableID, 'EvaluetionResult', 'DAT', NULL, 2, N'Đạt yêu cầu', N'Passably', 0, NULL, N'Kết quả đánh giá (Màn hình cập nhật kết quả dự giờ - EDMF2061)'
EXEC AddDataMasterERP9 @TableID, 'EvaluetionResult', 'KHO', NULL, 3, N' Chưa đạt yêu cầu', N'Fail', 0, NULL, N'Kết quả đánh giá (Màn hình cập nhật kết quả dự giờ - EDMF2061)'


-----------------------------------------Tình trạng ăn của bé (EatingStatus) -------------------------------------

EXEC AddDataMasterERP9 @TableID, 'EatingStatus', '0', NULL, 0, N'Ăn hết', N'Eat All', 0, NULL, N'Tình trạng ăn của bé (Màn hình cập nhật kết quả học tập - EDMF2051)'
EXEC AddDataMasterERP9 @TableID, 'EatingStatus', '1', NULL, 1, N'Ăn nửa suất', N'Eat Half', 0, NULL, N'Tình trạng ăn của bé (Màn hình cập nhật kết quả học tập - EDMF2051)'
EXEC AddDataMasterERP9 @TableID, 'EatingStatus', '2', NULL, 2, N'Bỏ bữa', N'Skip Meals', 0, NULL, N'Tình trạng ăn của bé (Màn hình cập nhật kết quả học tập - EDMF2051)'
EXEC AddDataMasterERP9 @TableID, 'EatingStatus', '3', NULL, 3, N'Bị nôn', N'Vomiting', 0, NULL, N'Tình trạng ăn của bé (Màn hình cập nhật kết quả học tập - EDMF2051)'

-----------------------------------------Trạng thái loại tin tức (NewType) -------------------------------------

EXEC AddDataMasterERP9 @TableID, 'NewType', '0', NULL, 0, N'Tin tức', N'News', 0, NULL, N'Loại tin  tức (Màn hình Quản lý tin tức - EDMF2170)'
EXEC AddDataMasterERP9 @TableID, 'NewType', '1', NULL, 1, N'Thông báo chung', N'Announcement', 0, NULL, N'Loại tin  tức (Màn hình Quản lý tin tức - EDMF2170)'

-----------------------------------------Tuổi (YearOld) -------------------------------------
EXEC AddDataMasterERP9 @TableID, 'YearOld', '0', NULL, 0, N'Tuổi', N'Old', 0, NULL, N'Tuổi'


----------------------------------------Loại đăng ký dịch vụ (ServiceTypeID) -------------------------------------
EXEC AddDataMasterERP9 @TableID, 'ServiceTypeID', '1', NULL, 1, N'Hoạt động ngoại khóa', N'ExtracurricularActivity', 0, NULL, N'Loại dịch vụ (Màn hình Đăng ký dịch vụ - EDMF2130)'
EXEC AddDataMasterERP9 @TableID, 'ServiceTypeID', '2', NULL, 2, N'Đưa đón', N'Shuttle', 0, NULL, N'Loại dịch vụ (Màn hình Đăng ký dịch vụ - EDMF2130)'
EXEC AddDataMasterERP9 @TableID, 'ServiceTypeID', '3', NULL, 3, N'Giữ ngoài giờ', N'OverTime', 0, NULL, N'Loại dịch vụ (Màn hình Đăng ký dịch vụ - EDMF2130)'


-----------------------------------------Loại đưa đón (RoundTrip)-------------------------------------
EXEC AddDataMasterERP9 @TableID, 'RoundTrip', '0', NULL, 1, N'Một chiều', N'1 Way', 0, NULL, N'Loại đưa đón (Màn hình Cập nhật đăng ký dịch vụ - EDMF2131)'
EXEC AddDataMasterERP9 @TableID, 'RoundTrip', '1', NULL, 2, N'Hai chiều', N'2 Way', 0, NULL, N'Loại đưa đón (Màn hình Cập nhật đăng ký dịch vụ - EDMF2131)'


-----------------------------------------Nguồn thu (OriginTypeID)-------------------------------------
EXEC AddDataMasterERP9 @TableID, 'OriginTypeID', '1', NULL, 1, N'Đăng ký nhập học', N'Confirm', 0, NULL, N'Nguồn thu'
EXEC AddDataMasterERP9 @TableID, 'OriginTypeID', '2', NULL, 2, N'Học thử', N'Try out', 0, NULL, N'Nguồn thu'
EXEC AddDataMasterERP9 @TableID, 'OriginTypeID', '3', NULL, 3, N'Giữ chỗ', N'Place Reservation', 0, NULL, N'Nguồn thu'
EXEC AddDataMasterERP9 @TableID, 'OriginTypeID', '4', NULL, 4, N'Hoạt động ngoại khóa', N'ExtracurricularActivity', 0, NULL, N'Nguồn thu'
EXEC AddDataMasterERP9 @TableID, 'OriginTypeID', '5', NULL, 5, N'Đưa đón', N'Shuttle', 0, NULL, N'Nguồn thu'
EXEC AddDataMasterERP9 @TableID, 'OriginTypeID', '6', NULL, 6, N'Giữ ngoài giờ', N'OverTime', 0, NULL, N'Nguồn thu'
EXEC AddDataMasterERP9 @TableID, 'OriginTypeID', '7', NULL, 7, N'Dự thu học phí', N'Parent', 0, NULL, N'Nguồn thu'
EXEC AddDataMasterERP9 @TableID, 'OriginTypeID', '8', NULL, 8, N'Thay đổi mức đóng phí', N'Change the premium rate', 0, NULL, N'Nguồn thu'
--EXEC AddDataMasterERP9 @TableID, 'OriginTypeID', '9', 9, N'Thiết lập khoản phí đầu năm', N'Set the fee for the beginning of the year', 0)


 
 -----------------------------------------Trạng thái Điều chuyển học sinh (MoveStatus)-------------------------------------

EXEC AddDataMasterERP9 @TableID, 'MoveStatus', '0', NULL, 0, N'Đang học', N'No Move', 0, NULL, N'Chuyển trạng thái'
EXEC AddDataMasterERP9 @TableID, 'MoveStatus', '1', NULL, 1, N'Chuyển đi', N'Move Away', 0, NULL, N'Chuyển trạng thái'
EXEC AddDataMasterERP9 @TableID, 'MoveStatus', '2', NULL, 2, N'Chuyển đến', N'Move In', 0, NULL, N'Chuyển trạng thái'
EXEC AddDataMasterERP9 @TableID, 'MoveStatus', '3', NULL, 3, N'Bảo lưu', N'TranferStudent', 0, NULL, N'Chuyển trạng thái'
EXEC AddDataMasterERP9 @TableID, 'MoveStatus', '4', NULL, 4, N'Nghỉ học', N'LeaveSchool', 0, NULL, N'Chuyển trạng thái'
EXEC AddDataMasterERP9 @TableID, 'MoveStatus', '5', NULL, 5, N'Chuyển trường', N'Transfer', 0, NULL, N'Chuyển trạng thái'

 

 -----------------------------------------Mẫu báo cáo dự thu học phí-------------------------------------

EXEC AddDataMasterERP9 @TableID, 'EDMF30007', 'EDMR30007', NULL, 0, N'Phiếu dự thu học phí', N'Phiếu dự thu học phí', 0, NULL, N'Loại mẫu báo cáo (Màn hình Báo cáo dự thu học phí - EDMF30007)'
EXEC AddDataMasterERP9 @TableID, 'EDMF30007', 'EDMR30008', NULL, 1, N'Báo cáo dự toán doanh thu', N'Báo cáo dự toán doanh thu', 0, NULL, N'Loại mẫu báo cáo (Màn hình Báo cáo dự thu học phí - EDMF30007)'



 -----------------------------------------Loại tiền ăn-------------------------------------

EXEC AddDataMasterERP9 @TableID, 'Money', '1', NULL, 1, N'Tiền ăn', N'Tiền ăn', 0, NULL, N'Loại tiền ăn'
EXEC AddDataMasterERP9 @TableID, 'Money', '2', NULL, 2, N'Tiền ăn trả lại/ngày', N'Tiền ăn trả lại/ngày', 0, NULL, N'Loại tiền ăn'
EXEC AddDataMasterERP9 @TableID, 'Money', '3', NULL, 3, N'Tiền ăn trả lại trưa/xế', N'Tiền ăn trả lại trưa/xế', 0, NULL, N'Loại tiền ăn'
 

 ----------------------------------Loại hình thu hoàn trả tiền ăn-------------------------------------------------------

EXEC AddDataMasterERP9 @TableID, 'ReceiptReturn', '1', NULL, 1, N'Dự thu học phí', N'Dự thu học phí', 0, NULL, N'Biên lai hoàn trả'
EXEC AddDataMasterERP9 @TableID, 'ReceiptReturn', '2', NULL, 2, N'Quyết toán', N'Quyết toán', 0, NULL, N'Biên lai hoàn trả'
EXEC AddDataMasterERP9 @TableID, 'ReceiptReturn', '3', NULL, 3, N'Bảo lưu', N'Bảo lưu', 0, NULL, N'Biên lai hoàn trả'


----------------------------------Dùng bữa-----------------------------------------------------------------------------------

EXEC AddDataMasterERP9 @TableID, 'IsEat', '0', NULL, 0, N'Không', N'Not Eat', 0, NULL, N'Có dùng bữa (Màn hình Cập nhật đăng ký dịch vụ - EDMF2131)'
EXEC AddDataMasterERP9 @TableID, 'IsEat', '1', NULL, 1, N'Có', N'Eat', 0, NULL, N'Có dùng bữa (Màn hình Cập nhật đăng ký dịch vụ - EDMF2131)'

 
  -----------------------------------------Mẫu báo cáo hoàn trả tiền ăn-------------------------------------

EXEC AddDataMasterERP9 @TableID, 'EDMF30004', 'EDMR30004', NULL, 0, N'Báo cáo tổng hợp hoàn trả tiền ăn mẫu 1', N'Báo cáo tổng hợp hoàn trả tiền ăn mẫu 1', 0, NULL, N'Mẫu báo cáo (Màn hình Báo cáo danh sách hoàn trả tiền ăn - EDMF30004)'
EXEC AddDataMasterERP9 @TableID, 'EDMF30004', 'EDMR30009', NULL, 2, N'Báo cáo chi tiết hoàn trả tiền ăn', N'Báo cáo chi tiết hoàn trả tiền ăn', 0, NULL, N'Mẫu báo cáo (Màn hình Báo cáo danh sách hoàn trả tiền ăn - EDMF30004)'
EXEC AddDataMasterERP9 @TableID, 'EDMF30004', 'EDMR30011', NULL, 1, N'Báo cáo tổng hợp hoàn trả tiền ăn mẫu 2', N'Báo cáo tổng hợp hoàn trả tiền ăn mẫu 2', 0, NULL, N'Mẫu báo cáo (Màn hình Báo cáo danh sách hoàn trả tiền ăn - EDMF30004)'

  -----------------------------------------Mẫu báo cáo danh sách tham quan-------------------------------------

EXEC AddDataMasterERP9 @TableID, 'EDMF30010', '1', NULL, 1, N'Báo cáo tổng hợp', N'Báo cáo tổng hợp ', 0, NULL, N'Loại báo cáo ( Màn hình Báo cáo tình hình hoạt động trong tráng - EDMF30010)'
EXEC AddDataMasterERP9 @TableID, 'EDMF30010', '2', NULL, 2, N'Báo cáo chi tiết', N'Báo cáo chi tiết', 0, NULL, N'Loại báo cáo ( Màn hình Báo cáo tình hình hoạt động trong tráng - EDMF30010)'


----------------------------------Khuyến mãi(PromotionType) -----------------------------------------------------------------------------------

EXEC AddDataMasterERP9 @TableID, 'PromotionType', '0', NULL, 0, N'Giảm theo %', N'Percent', 0, NULL, N'Hình thức khuyến mãi (Màn hình Cập nhật khuyến mãi - EDMF1101)'
EXEC AddDataMasterERP9 @TableID, 'PromotionType', '1', NULL, 1, N'Giảm theo giá trị', N'Value', 0, NULL, N'Hình thức khuyến mãi (Màn hình Cập nhật khuyến mãi - EDMF1101)'


   -----------------------------------------------------Loại phí---------------------------------------------------------------

EXEC AddDataMasterERP9 @TableID, N'TypeOfFee', N'0', NULL, 0, N'Phí ghi danh', N'Registration Fee', 0, NULL, N'Loại phí (Màn hình Cập nhật thông tin tư vấn học sinh - EDMF2001)'

EXEC AddDataMasterERP9 @TableID, N'TypeOfFee', N'1', NULL, 1, N'Phí cơ sở vật chất', N'Infrastructure charges', 0, NULL, N'Loại phí (Màn hình Cập nhật thông tin tư vấn học sinh - EDMF2001)'

EXEC AddDataMasterERP9 @TableID, N'TypeOfFee', N'2', NULL, 2, N'Phí học phẩm', N'School supplies fee', 0, NULL, N'Loại phí (Màn hình Cập nhật thông tin tư vấn học sinh - EDMF2001)'

EXEC AddDataMasterERP9 @TableID, N'TypeOfFee', N'3', NULL, 3, N'Phí bộ kits', N'Kits fee', 0, NULL, N'Loại phí (Màn hình Cập nhật thông tin tư vấn học sinh - EDMF2001)'

EXEC AddDataMasterERP9 @TableID, N'TypeOfFee', N'4', NULL, 4, N'Phí giáo trình tiếng anh', N'English book fee ', 0, NULL, N'Loại phí (Màn hình Cập nhật thông tin tư vấn học sinh - EDMF2001)'

EXEC AddDataMasterERP9 @TableID, N'TypeOfFee', N'5', NULL, 5, N'Học phí', N'School fees', 0, NULL, N'Loại phí (Màn hình Cập nhật thông tin tư vấn học sinh - EDMF2001)'

EXEC AddDataMasterERP9 @TableID, N'TypeOfFee', N'6', NULL, 6, N'Hoạt động ngoại khóa', N'Extracurricular Activitie', 0, NULL, N'Loại phí (Màn hình Cập nhật thông tin tư vấn học sinh - EDMF2001)'

EXEC AddDataMasterERP9 @TableID, N'TypeOfFee', N'7', NULL, 7, N'Học thử', N'Learn trial', 0, NULL, N'Loại phí (Màn hình Cập nhật thông tin tư vấn học sinh - EDMF2001)'

EXEC AddDataMasterERP9 @TableID, N'TypeOfFee', N'8', NULL, 8, N'Phí đưa đón', N'Shuttle fee', 0, NULL, N'Loại phí (Màn hình Cập nhật thông tin tư vấn học sinh - EDMF2001)'

EXEC AddDataMasterERP9 @TableID, N'TypeOfFee', N'9', NULL, 9, N'Phí giữ trẻ', N'Child care fee', 0, NULL, N'Loại phí (Màn hình Cập nhật thông tin tư vấn học sinh - EDMF2001)'

EXEC AddDataMasterERP9 @TableID, N'TypeOfFee', N'10', NULL, 13, N'Tiền ăn trả lại ngày', N'Refund food one day', 0, NULL, N'Loại phí (Màn hình Cập nhật thông tin tư vấn học sinh - EDMF2001)'

EXEC AddDataMasterERP9 @TableID, N'TypeOfFee', N'11', NULL, 14, N'Tiền ăn trả lại trưa/xế', N'Refund of lunch and dinner', 0, NULL, N'Loại phí (Màn hình Cập nhật thông tin tư vấn học sinh - EDMF2001)'

EXEC AddDataMasterERP9 @TableID, N'TypeOfFee', N'12', NULL, 11, N'Tiền ăn sáng', N'Money for breakfast', 0, NULL, N'Loại phí (Màn hình Cập nhật thông tin tư vấn học sinh - EDMF2001)'

EXEC AddDataMasterERP9 @TableID, N'TypeOfFee', N'13', NULL, 12, N'Tiền ăn trưa xế & 2 bữa phụ', N'Lunch, dinner and two snacks', 0, NULL, N'Loại phí (Màn hình Cập nhật thông tin tư vấn học sinh - EDMF2001)'

EXEC AddDataMasterERP9 @TableID, N'TypeOfFee', N'14', NULL, 10, N'Tiền ăn học thử', N'Money for meal learn trial', 0, NULL, N'Loại phí (Màn hình Cập nhật thông tin tư vấn học sinh - EDMF2001)'
 
 -----------------------------------------------------Nghiệp vụ---------------------------------------------------------------

EXEC AddDataMasterERP9 @TableID, N'Business', N'0', NULL, 0, N'Phiếu thông tin tư vấn', N'Consultancy information sheet	', 0, NULL, N'Nghiệp vụ'
EXEC AddDataMasterERP9 @TableID, N'Business', N'1', NULL, 1, N'Hoạt động ngoại khóa', N'Extracurricular Activities', 0, NULL, N'Nghiệp vụ'
EXEC AddDataMasterERP9 @TableID, N'Business', N'2', NULL, 2, N'Đưa đón', N'Shuttle', 0, NULL, N'Nghiệp vụ'
EXEC AddDataMasterERP9 @TableID, N'Business', N'3', NULL, 3, N'Giữ trẻ ngoài giờ', N'Overtime care', 0, NULL, N'Nghiệp vụ'
EXEC AddDataMasterERP9 @TableID, N'Business', N'4', NULL, 4, N'Dự thu học phí', N'Tuition Fees are expected', 0, NULL, N'Nghiệp vụ'


-----------------------------------------------------------Phương thức đóng(PaymentMethod)-----------------------------------------------------------------------------------

EXEC AddDataMasterERP9 @TableID, N'PaymentMethod', N'1', NULL, 0, N'1 tháng', N'Month', 0, NULL, N'Phương thức đóng (Màn hình Cập nhật phiếu thông tin tư vấn - EDMF2001)'
EXEC AddDataMasterERP9 @TableID, N'PaymentMethod', N'6', NULL, 1, N'6 tháng', N' SixMonths', 0, NULL, N'Phương thức đóng (Màn hình Cập nhật phiếu thông tin tư vấn - EDMF2001)'
EXEC AddDataMasterERP9 @TableID, N'PaymentMethod', N'9', NULL, 2, N'9 tháng', N'NineMonths', 0, NULL, N'Phương thức đóng (Màn hình Cập nhật phiếu thông tin tư vấn - EDMF2001)'
EXEC AddDataMasterERP9 @TableID, N'PaymentMethod', N'12', NULL, 3, N'12 tháng', N'TwelveMonths', 0, NULL, N'Phương thức đóng (Màn hình Cập nhật phiếu thông tin tư vấn - EDMF2001)'


-----------------------------------------------------------Thời gian tính phí(ChargingTime)-----------------------------------------------------------------------------------

EXEC AddDataMasterERP9 @TableID, N'ChargingTime' , N'1', NULL, 0, N'1', N'1', 0, NULL, N'Thời gian sạc'
EXEC AddDataMasterERP9 @TableID, N'ChargingTime' , N'2', NULL, 1, N'2', N'2', 0, NULL, N'Thời gian sạc'
EXEC AddDataMasterERP9 @TableID, N'ChargingTime' , N'3', NULL, 2, N'3', N'3', 0, NULL, N'Thời gian sạc'
EXEC AddDataMasterERP9 @TableID, N'ChargingTime' , N'4', NULL, 3, N'4', N'4', 0, NULL, N'Thời gian sạc'
EXEC AddDataMasterERP9 @TableID, N'ChargingTime' , N'5', NULL, 4, N'5', N'5', 0, NULL, N'Thời gian sạc'
EXEC AddDataMasterERP9 @TableID, N'ChargingTime' , N'6', NULL, 5, N'6', N'6', 0, NULL, N'Thời gian sạc'
EXEC AddDataMasterERP9 @TableID, N'ChargingTime' , N'7', NULL, 6, N'7', N'7', 0, NULL, N'Thời gian sạc'
EXEC AddDataMasterERP9 @TableID, N'ChargingTime' , N'8', NULL, 7, N'8', N'8', 0, NULL, N'Thời gian sạc'
EXEC AddDataMasterERP9 @TableID, N'ChargingTime' , N'9', NULL, 8, N'9', N'9', 0, NULL, N'Thời gian sạc'
EXEC AddDataMasterERP9 @TableID, N'ChargingTime' , N'10', NULL, 9, N'10', N'10', 0, NULL, N'Thời gian sạc'
EXEC AddDataMasterERP9 @TableID, N'ChargingTime' , N'11', NULL, 10, N'11', N'11', 0, NULL, N'Thời gian sạc'
EXEC AddDataMasterERP9 @TableID, N'ChargingTime' , N'12', NULL, 11, N'12', N'12', 0, NULL, N'Thời gian sạc'
EXEC AddDataMasterERP9 @TableID, N'ChargingTime' , N'13', NULL, 12, N'13', N'13', 0, NULL, N'Thời gian sạc'
EXEC AddDataMasterERP9 @TableID, N'ChargingTime' , N'14', NULL, 13, N'14', N'14', 0, NULL, N'Thời gian sạc'
EXEC AddDataMasterERP9 @TableID, N'ChargingTime' , N'15', NULL, 14, N'15', N'15', 0, NULL, N'Thời gian sạc'
EXEC AddDataMasterERP9 @TableID, N'ChargingTime' , N'16', NULL, 15, N'16', N'16', 0, NULL, N'Thời gian sạc'
EXEC AddDataMasterERP9 @TableID, N'ChargingTime' , N'17', NULL, 16, N'17', N'17', 0, NULL, N'Thời gian sạc'
EXEC AddDataMasterERP9 @TableID, N'ChargingTime' , N'18', NULL, 17, N'18', N'18', 0, NULL, N'Thời gian sạc'
EXEC AddDataMasterERP9 @TableID, N'ChargingTime' , N'19', NULL, 18, N'19', N'19', 0, NULL, N'Thời gian sạc'
EXEC AddDataMasterERP9 @TableID, N'ChargingTime' , N'20', NULL, 19, N'20', N'20', 0, NULL, N'Thời gian sạc'
EXEC AddDataMasterERP9 @TableID, N'ChargingTime' , N'21', NULL, 20, N'21', N'21', 0, NULL, N'Thời gian sạc'
EXEC AddDataMasterERP9 @TableID, N'ChargingTime' , N'22', NULL, 21, N'22', N'22', 0, NULL, N'Thời gian sạc'
EXEC AddDataMasterERP9 @TableID, N'ChargingTime' , N'23', NULL, 22, N'23', N'23', 0, NULL, N'Thời gian sạc'
EXEC AddDataMasterERP9 @TableID, N'ChargingTime' , N'24', NULL, 23, N'24', N'24', 0, NULL, N'Thời gian sạc'
EXEC AddDataMasterERP9 @TableID, N'ChargingTime' , N'25', NULL, 24, N'25', N'25', 0, NULL, N'Thời gian sạc'
EXEC AddDataMasterERP9 @TableID, N'ChargingTime' , N'26', NULL, 25, N'26', N'26', 0, NULL, N'Thời gian sạc'
EXEC AddDataMasterERP9 @TableID, N'ChargingTime' , N'27', NULL, 26, N'27', N'27', 0, NULL, N'Thời gian sạc'
EXEC AddDataMasterERP9 @TableID, N'ChargingTime' , N'28', NULL, 27, N'28', N'28', 0, NULL, N'Thời gian sạc'
EXEC AddDataMasterERP9 @TableID, N'ChargingTime' , N'29', NULL, 28, N'29', N'29', 0, NULL, N'Thời gian sạc'
EXEC AddDataMasterERP9 @TableID, N'ChargingTime' , N'30', NULL, 29, N'30', N'30', 0, NULL, N'Thời gian sạc'
EXEC AddDataMasterERP9 @TableID, N'ChargingTime' , N'31', NULL, 30, N'31', N'31', 0, NULL, N'Thời gian sạc'





 




 