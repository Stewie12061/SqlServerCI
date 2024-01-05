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
SET @FormID = 'EDMF30001';

SET @LanguageValue = N'Báo cáo tình hình hoạt động trong tháng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF30001.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF30001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF30001.SchoolYearID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF30001.Date', @FormID, @LanguageValue, @Language;
