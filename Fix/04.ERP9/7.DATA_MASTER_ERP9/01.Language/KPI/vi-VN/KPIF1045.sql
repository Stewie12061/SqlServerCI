-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF1045- KPI
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
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF1045';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1045.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1045.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tham số';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1045.ParameterID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên tham số';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1045.ParameterName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1045.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1045.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1045.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1045.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1045.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1045.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1045.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật tham số tính chỉ tiêu KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1045.Title', @FormID, @LanguageValue, @Language;

