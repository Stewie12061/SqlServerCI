-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2013- EDM
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
SET @FormID = 'EDMF2013';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.DivisionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa từ kết quả tư vấn';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.IsInheritConsultant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.StudentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.DateOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.PlaceOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc tịch';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.NationalityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dân tộc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.NationID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giới tính';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.SexID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giới tính';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.SexName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ thường trú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.SchoolID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.SchoolName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.ClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.ClassName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xếp lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.ArrangeClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin khác';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ảnh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.Image', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.FileAttach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xác nhận hợp lệ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.ComfirmID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xác nhận hợp lệ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.ComfirmName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đăng ký';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.RegistrationDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người nhận';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.Receiver', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.APKConsultant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.FatherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.FatherNameFilter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.FatherName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.FatherDateOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.FatherPlaceOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc tịch';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.FatherNationalityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dân tộc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.FatherNationID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nghề nghiệp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.FatherJob', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi làm việc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.FatherOffice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại nhà';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.FatherPhone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐT di động';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.FatherMobiphone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.FatherEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ảnh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.FatherImage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.MotherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.MotherNameFilter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.MotherName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.MotherDateOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.MotherPlaceOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc tịch';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.MotherNationalityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dân tộc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.MotherNationID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nghề nghiệp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.MotherJob', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi làm việc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.MotherOffice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại nhà';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.MotherPhone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐT di động';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.MotherMobiphone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.MotherEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ảnh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.MotherImage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.Picker1Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mối quan hệ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.Picker1RelateTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại nhà';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.Picker1HomePhone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐT di động';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.Picker1MobiPhone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐT nơi làm việc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.Picker1OfficePhone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ảnh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.Picker1Image', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.Picker2PickerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mối quan hệ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.Picker2RelateTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại nhà';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.Picker2HomePhone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐT di động';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.Picker2MobiPhone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐT nơi làm việc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.Picker2OfficePhone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ảnh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.Picker2Image', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.PickerNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật uỷ quyền đón học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2013.Title', @FormID, @LanguageValue, @Language;
