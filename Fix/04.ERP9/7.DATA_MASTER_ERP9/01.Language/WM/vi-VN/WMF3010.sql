-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF3010 - WM
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
SET @ModuleID = 'WM';
SET @FormID = 'WMF3010';

SET @LanguageValue = N'Báo cáo nhập xuất theo kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF3010.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'WMF3010.ReportID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'WMF3010.ReportName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'WMF3010.ReportTitle' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF3010.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF3010.WareHouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'WMF3010.GroupTitle1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiêu chí lọc';
EXEC ERP9AddLanguage @ModuleID, 'WMF3010.GroupTitle2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'WMF3010.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF3010.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mẫu báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'WMF3010.GetPathTemplate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm cấp 1';
EXEC ERP9AddLanguage @ModuleID, 'WMF3010.GroupID1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm cấp 2';
EXEC ERP9AddLanguage @ModuleID, 'WMF3010.GroupID2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'WMF3010.IsGroup' , @FormID, @LanguageValue, @Language;