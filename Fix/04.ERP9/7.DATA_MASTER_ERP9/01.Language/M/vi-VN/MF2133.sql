-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2133- M
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
SET @ModuleID = 'M';
SET @FormID = 'MF2133';

SET @LanguageValue = N'Chọn danh mục công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'MF2133.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'MF2133.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'MF2133.PhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'MF2133.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trình tự';
EXEC ERP9AddLanguage @ModuleID, 'MF2133.PhaseOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'MF2133.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả ';
EXEC ERP9AddLanguage @ModuleID, 'MF2133.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'MF2133.IsCommon', @FormID, @LanguageValue, @Language;

