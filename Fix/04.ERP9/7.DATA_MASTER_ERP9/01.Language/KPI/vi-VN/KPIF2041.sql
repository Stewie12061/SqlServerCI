-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF2041- KPI
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
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF2041';

SET @LanguageValue = N'Tính Lương mềm';
EXEC ERP9AddLanguage @ModuleID, 'KPIT2041.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị cộng thêm cho dự án: {0}';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.BonusSale', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Theo kỳ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.CheckListPeriodControl', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vi Pham: {0}';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.IsViolated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phát triển tổ chức';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.OrganizationalDevelopment', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Doanh thu từ dự án: {0}';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.RevenueProJect', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'KPITF2041.Type1', @FormID, @LanguageValue, @Language;

EXEC ERP9AddLanguage @ModuleID, 'KPIF2041.OrganizationalDevelopment', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'KPITF2041.Type2', @FormID, @LanguageValue, @Language;
