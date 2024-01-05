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
SET @FormID = 'EDMF30010';

SET @LanguageValue = N'Báo cáo danh sách tham quan';
EXEC ERP9AddLanguage @ModuleID, 'EDMF30010.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF30010.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF30010.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF30010.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF30010.SpecialDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF30010.Type', @FormID, @LanguageValue, @Language;

