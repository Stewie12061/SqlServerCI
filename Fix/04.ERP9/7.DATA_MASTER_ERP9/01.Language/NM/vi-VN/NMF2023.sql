-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ NMF2034- NM
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
SET @ModuleID = 'NM';
SET @FormID = 'NMF2023';

SET @LanguageValue = N'Chọn thực đơn';
EXEC ERP9AddLanguage @ModuleID, 'NMF2023.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã thực đơn';
EXEC ERP9AddLanguage @ModuleID, 'NMF2023.MenuVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày thực đơn';
EXEC ERP9AddLanguage @ModuleID, 'NMF2023.MenuVoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'NMF2023.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'NMF2023.VoucherNo', @FormID, @LanguageValue, @Language;

