
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
SET @FormID = 'HRMF1050';

SET @LanguageValue = N'Danh mục khóa đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lĩnh vực đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.TrainingFieldID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã lĩnh vực';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.TrainingFieldID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên lĩnh vực';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.TrainingFieldName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khóa đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.TrainingCourseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.TrainingType' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.TrainingType' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hình thức';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.TrainingType.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hình thức';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.TrainingTypeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.Disabled' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lĩnh vực đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.TrainingFieldName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.TrainingTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tác đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.IsCommon' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1050.Address' , @FormID, @LanguageValue, @Language;
