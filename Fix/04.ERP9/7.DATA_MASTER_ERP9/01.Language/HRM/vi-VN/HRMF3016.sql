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
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF3016';

SET @LanguageValue = N'Báo cáo theo dõi tình hình nghỉ việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3016.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3016.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3016.ReportID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3016.ReportName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3016.ReportTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3016.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3016.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổ Nhóm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3016.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số CNV nghỉ việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3016.chartTitle1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tuổi CNV nghỉ việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3016.chartTitle2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nữ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3016.Female' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nam';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3016.Male' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều kiện lọc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3016.GroupFilter' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3016.GroupReport' , @FormID, @LanguageValue, @Language;