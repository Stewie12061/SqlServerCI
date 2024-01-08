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
SET @FormID = 'EDMF2163';

SET @LanguageValue = N'Mã biểu phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2163.FeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên biểu phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2163.FeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2163.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2163.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn biểu phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2163.Title', @FormID, @LanguageValue, @Language;

