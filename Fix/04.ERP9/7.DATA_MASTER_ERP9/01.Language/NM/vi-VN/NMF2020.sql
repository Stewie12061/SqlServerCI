-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ NMF2020- NM
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
SET @FormID = 'NMF2020';

SET @LanguageValue = N'Phiếu kê chợ';
EXEC ERP9AddLanguage @ModuleID, 'NMF2020.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2020.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'NMF2020.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số kê chợ';
EXEC ERP9AddLanguage @ModuleID, 'NMF2020.MarketVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kê chợ';
EXEC ERP9AddLanguage @ModuleID, 'NMF2020.MarketVoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'NMF2020.Description', @FormID, @LanguageValue, @Language;

