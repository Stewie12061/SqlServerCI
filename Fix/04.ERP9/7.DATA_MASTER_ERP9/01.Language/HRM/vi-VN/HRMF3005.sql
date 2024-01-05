
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF3005- OO
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
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF3005';

SET @LanguageValue = N'Kế hoạch đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3005.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3005.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3005.GroupReport' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiêu chí lọc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3005.GroupFilter' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3005.ReportID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3005.ReportName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3005.ReportTitle' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3005.FromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3005.ToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lĩnh vực đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3005.TrainingFieldID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3005.TrainingType' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế hoạch đào tạo định kỳ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3005.TrainingPlanID' , @FormID, @LanguageValue, @Language;
