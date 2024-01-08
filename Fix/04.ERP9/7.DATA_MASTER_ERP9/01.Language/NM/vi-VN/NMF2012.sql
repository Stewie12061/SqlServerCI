-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ NMF2012- NM
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
SET @FormID = 'NMF2012';

SET @LanguageValue = N'Xem thông tin Thực đơn';
EXEC ERP9AddLanguage @ModuleID, 'NMF2012.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chính';
EXEC ERP9AddLanguage @ModuleID, 'NMF2012.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thực đơn tuần';
EXEC ERP9AddLanguage @ModuleID, 'NMF2012.Detail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'NMF2012.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'NMF2012.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'NMF2012.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'NMF2012.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'NMF2012.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'NMF2012.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'NMF2012.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'NMF2012.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'NMF2012.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bữa ăn phụ';
EXEC ERP9AddLanguage @ModuleID, 'NMF2012.BuaPhu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bữa xế';
EXEC ERP9AddLanguage @ModuleID, 'NMF2012.BuaXe', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bữa trưa';
EXEC ERP9AddLanguage @ModuleID, 'NMF2012.BuaTrua', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bữa sáng';
EXEC ERP9AddLanguage @ModuleID, 'NMF2012.BuaSang', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ';
EXEC ERP9AddLanguage @ModuleID, 'NMF2012.DayOfWeeks', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày';
EXEC ERP9AddLanguage @ModuleID, 'NMF2012.MenuDate', @FormID, @LanguageValue, @Language;