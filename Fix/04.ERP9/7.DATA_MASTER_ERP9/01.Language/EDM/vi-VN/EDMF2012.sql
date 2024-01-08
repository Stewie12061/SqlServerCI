-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2012- EDM
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT


------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
------------------------------------------------------------------------------------------------------
/*
 - Tieng Viet: vi-VN 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'vi-VN' 
SET @ModuleID = 'EDM';
SET @FormID = 'EDMF2012';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.DivisionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa từ kết quả tư vấn';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.IsInheritConsultant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.StudentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.Attach.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.DateOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.PlaceOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc tịch';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.NationalityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dân tộc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.NationID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giới tính';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.SexID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giới tính';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.SexName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ thường trú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.SchoolID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.SchoolName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.ClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.ClassName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xếp lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.ArrangeClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin khác';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ảnh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.Image', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.FileAttach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xác nhận hợp lệ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.ComfirmID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xác nhận hợp lệ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.ComfirmName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đăng ký';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.RegistrationDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã người nhận';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.Receiver', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người nhận';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.ReceiverName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.APKConsultant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.FatherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.FatherNameFilter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.FatherName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.FatherDateOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.FatherPlaceOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc tịch';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.FatherNationalityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dân tộc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.FatherNationID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nghề nghiệp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.FatherJob', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi làm việc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.FatherOffice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại nhà';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.FatherPhone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐT di động';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.FatherMobiphone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.FatherEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ảnh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.FatherImage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.MotherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.MotherNameFilter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.MotherName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.MotherDateOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.MotherPlaceOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc tịch';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.MotherNationalityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dân tộc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.MotherNationID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nghề nghiệp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.MotherJob', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi làm việc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.MotherOffice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại nhà';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.MotherPhone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐT di động';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.MotherMobiphone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.MotherEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ảnh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.MotherImage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.Picker1Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mối quan hệ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.Picker1RelateTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại nhà';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.Picker1HomePhone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐT di động';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.Picker1MobiPhone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐT nơi làm việc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.Picker1OfficePhone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ảnh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.Picker1Image', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.Picker2PickerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mối quan hệ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.Picker2RelateTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại nhà';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.Picker2HomePhone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐT di động';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.Picker2MobiPhone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐT nơi làm việc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.Picker2OfficePhone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ảnh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.Picker2Image', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.PickerNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem thông tin hồ sơ học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.Lich_su', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin uỷ quyền đón học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.Delegate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin nhà trường xác nhận';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2015.Verify', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin điều tra tâm lý học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2014.Investigate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc tịch';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.FatherNationalityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dân tộc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.FatherNationName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc tịch';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.MotherNationalityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dân tộc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.MotherNationName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tâm lý học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.StudentMetality', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cách giáo dục trẻ của phụ huynh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.ChildrentEducatingWays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảng điều tra tâm lý';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.ReportPsychologize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'In bảng điều tra tâm lý';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.PrintStudentPsychologize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'In đơn xin nhập học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.PrintStudentInfomatics', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giấy xác nhận vào lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.ReportConfirmIntoClass', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'In giấy xác nhận vào lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.PrintConfirmIntoClass', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.Attach.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.UpdateStatusStudent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh sách Xếp lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.ArrangeClass', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.SchoolYearID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.ClassName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xếp lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.ArrangeClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.Notes.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Các khoản phí trong năm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.ListReceiptTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoản phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.ReceiptTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.PaymentMethodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử thay đổi mức đóng phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.ListHistoryReceiptTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương thức thanh toán cũ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.OldPaymentMethodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương thức thanh toán mới';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.NewPaymentMethodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền chêch lệch';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.AmountReceived', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hiệu lực';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.ImlementationDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.AmountTotalPromotion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phí mới';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.IsNew', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2012.FeeName', @FormID, @LanguageValue, @Language;