
-----------------------------------------------------------------------------------------------------
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
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF1051';

SET @LanguageValue = N'Cập nhật khóa đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lĩnh vực đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.TrainingFieldID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã lĩnh vực';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.TrainingFieldID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên lĩnh vực';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.TrainingFieldName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khóa đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.TrainingCourseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.TrainingType' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.TrainingType' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hình thức';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.TrainingType.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hình thức';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.TrainingTypeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.Disabled' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lĩnh vực đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.TrainingFieldName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.TrainingTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tác đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.IsCommon' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tác đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.ObjectID' , @FormID, @LanguageValue, @Language;


