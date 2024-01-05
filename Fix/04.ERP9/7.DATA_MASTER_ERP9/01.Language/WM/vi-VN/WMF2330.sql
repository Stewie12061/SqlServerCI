-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2330- WM
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
SET @ModuleID = N'WM'
SET @FormID = 'WMF2330'

SET @LanguageValue = N'Danh mục định nghĩa tham số';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2330.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2330.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tham số';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2330.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên gọi (Vie)';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2330.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên gọi (Eng)';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2330.UserNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên gốc ';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2330.SystemName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên gốc (Eng)';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2330.SystemNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sử dụng';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2330.IsUsed', @FormID, @LanguageValue, @Language;

