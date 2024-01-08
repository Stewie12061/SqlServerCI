-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ 
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
SET @FormID = 'EDMF1070';

SET @LanguageValue = N'Danh mục điều tra tâm lý';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1070.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1070.DivisionID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Loại điều tra tâm lý';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1070.PsychologizeType', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã điều tra tâm lý';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1070.PsychologizeID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Tên điều tra tâm lý';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1070.PsychologizeName', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Điều tra tâm lý cha';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1070.PsychologizeGroup', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1070.IsCommon', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1070.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại điều tra tâm lý';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1070.PsychologizeTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều tra tâm lý cha';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1070.PsychologizeGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1070.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1070.Description.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1070.PsychologizeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1070.PsychologizeName.CB', @FormID, @LanguageValue, @Language;

