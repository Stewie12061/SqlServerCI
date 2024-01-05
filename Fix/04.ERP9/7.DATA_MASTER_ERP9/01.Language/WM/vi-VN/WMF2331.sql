-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2331- WM
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
SET @FormID = 'WMF2331'

SET @LanguageValue = N'Cập nhật định nghĩa tham số';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2331.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên gọi (Vie)';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2331.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên gọi (Eng)';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2331.UserNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên gốc ';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2331.SystemName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sử dụng';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2331.IsUsed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định nghĩa tham số tổng hợp';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2331.TabWT00051', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định nghĩa tham số chi tiết';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2331.TabWT00052', @FormID, @LanguageValue, @Language;

