-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2011- EDM
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
SET @FormID = 'EDMF2011';

SET @LanguageValue = N'Cập nhật hồ sơ học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.DivisionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa từ kết quả tư vấn';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.IsInheritConsultant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.StudentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.DateOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.PlaceOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc tịch';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.NationalityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dân tộc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.NationID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giới tính';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.SexID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giới tính';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.SexName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ thường trú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.SchoolID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.SchoolName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.ClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.ClassName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xếp lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.ArrangeClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin khác';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.Image', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.FileAttach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.ComfirmID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.ComfirmName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.RegistrationDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.Receiver', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.APKConsultant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.FatherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.FatherNameFilter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.FatherName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.FatherDateOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.FatherPlaceOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc tịch';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.FatherNationalityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dân tộc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.FatherNationID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nghề nghiệp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.FatherJob', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi làm việc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.FatherOffice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại nhà';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.FatherPhone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐT di động';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.FatherMobiphone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.FatherEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.FatherImage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.MotherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.MotherNameFilter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.MotherName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.MotherDateOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.MotherPlaceOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc tịch';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.MotherNationalityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dân tộc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.MotherNationID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nghề nghiệp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.MotherJob', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi làm việc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.MotherOffice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại nhà';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.MotherPhone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐT di động';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.MotherMobiphone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.MotherEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.MotherImage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.Picker1Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.Picker1RelateTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.Picker1HomePhone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.Picker1MobiPhone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.Picker1OfficePhone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.Picker1Image', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.Picker2PickerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.Picker2RelateTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.Picker2HomePhone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.Picker2MobiPhone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.Picker2OfficePhone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.Picker2Image', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.PickerNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nam';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.Male', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nữ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.Female', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.ClassID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.ClassName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.GradeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.GradeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân loại 1';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.CB_S1_StudentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân loại 2';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.CB_S2_StudentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân loại 3';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.CB_S3_StudentID' , @FormID, @LanguageValue, @Language;

-- Đình Hòa [07/04/2021] - Bổ sung ngôn ngữ

SET @LanguageValue = N'Ngày nhập học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.AdmissionDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bắt đầu học thử từ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.BeginTrialDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết thúc học thử đến';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2011.EndTrialDate' , @FormID, @LanguageValue, @Language;