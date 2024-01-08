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
SET @FormID = 'EDMF1071';

SET @LanguageValue = N'Cập nhật điều tra tâm lý';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1071.Title', @FormID, @LanguageValue, @Language;



SET @LanguageValue = N'Loại điều tra tâm lý';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1071.PsychologizeType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã điều tra tâm lý';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1071.PsychologizeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên điều tra tâm lý';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1071.PsychologizeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều tra tâm lý cha';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1071.PsychologizeGroup', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số thứ tự';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1071.Orders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1071.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1071.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1071.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1071.Description.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1071.PsychologizeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1071.PsychologizeName.CB', @FormID, @LanguageValue, @Language;

