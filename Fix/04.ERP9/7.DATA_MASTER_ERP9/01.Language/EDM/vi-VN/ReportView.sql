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
SET @FormID = 'ReportView';

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.DivisionID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.DivisionName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã năm học';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.SchoolYearID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.DateFrom.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.DateTo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.Description.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng (số)';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.Month.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng (chữ)';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.Description.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã lớp';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.ClassID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.ClassName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khối';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.GradeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.GradeName.CB', @FormID, @LanguageValue, @Language;