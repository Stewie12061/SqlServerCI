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
SET @FormID = 'NMF2035';

SET @LanguageValue = N'Chọn Điều tra dinh dưỡng';
EXEC ERP9AddLanguage @ModuleID, 'NMF2035.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã điều tra';
EXEC ERP9AddLanguage @ModuleID, 'NMF2035.InvestigateVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày điều tra';
EXEC ERP9AddLanguage @ModuleID, 'NMF2035.InvestigateVoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'NMF2035.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng học sinh';
EXEC ERP9AddLanguage @ModuleID, 'NMF2035.TotalStudent', @FormID, @LanguageValue, @Language;

