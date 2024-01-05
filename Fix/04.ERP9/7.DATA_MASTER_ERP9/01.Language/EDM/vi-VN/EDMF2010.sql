-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2010- EDM
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
SET @FormID = 'EDMF2010';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.DivisionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.IsInheritConsultant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.StudentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.DateOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.PlaceOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.NationalityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.NationID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giới tính';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.SexID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giới tính';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.SexName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.SchoolID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.SchoolName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.ClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.ClassName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xếp lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.ArrangeClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin khác';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.Image', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.FileAttach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.ComfirmID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.ComfirmName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đăng ký';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.RegistrationDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.Receiver', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.APKConsultant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.FatherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ tên bố';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.FatherNameFilter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ tên bố';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.FatherName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sinh bố';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.FatherDateOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi ở bố';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.FatherPlaceOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc tịch bố';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.FatherNationalityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dân tộc bố';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.FatherNationID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.FatherJob', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.FatherOffice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.FatherPhone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.FatherMobiphone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.FatherEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.FatherImage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.MotherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ tên mẹ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.MotherNameFilter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ tên mẹ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.MotherName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.MotherDateOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.MotherPlaceOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.MotherNationalityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.MotherNationID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.MotherJob', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.MotherOffice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.MotherPhone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.MotherMobiphone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.MotherEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.MotherImage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.Picker1Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.Picker1RelateTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.Picker1HomePhone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.Picker1MobiPhone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.Picker1OfficePhone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.Picker1Image', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.Picker2PickerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.Picker2RelateTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.Picker2HomePhone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.Picker2MobiPhone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.Picker2OfficePhone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.Picker2Image', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.PickerNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hồ sơ học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.ClassIDFilter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.ClassID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.ClassName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xác nhận hợp lệ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.ComfirmName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn xin nhập học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.Report', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hồ sơ học sinh ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.ListReport', @FormID, @LanguageValue, @Language;

-- Đình Hòa [07/04/2021] - Bổ sung ngôn ngữ
SET @LanguageValue = N'Ngày nhập học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.AdmissionDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bắt đầu học thử từ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.BeginTrialDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết thúc học thử đến';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2010.EndTrialDate' , @FormID, @LanguageValue, @Language;