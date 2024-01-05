
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF0203- OO
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
SET @ModuleID = 'QC';
SET @FormID = 'QCF3012';

SET @LanguageValue = N'Báo cáo dữ liệu kiểm tra';
EXEC ERP9AddLanguage @ModuleID, 'QCF3012.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'QCF3012.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'QCF3012.ToDate', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'QCF3012.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tiêu chuẩn';
EXEC ERP9AddLanguage @ModuleID, 'QCF3012.StandardID', @FormID, @LanguageValue, @Language;
