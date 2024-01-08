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
SET @FormID = 'HRMF3012';

SET @LanguageValue = N'Báo cáo theo dõi tình hình HĐLĐ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3012.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Báo cáo theo dõi tình hình hợp đồng lao động';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3012.TitleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3012.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3012.ReportID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3012.ReportName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3012.ReportTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3012.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3012.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổ Nhóm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3012.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại HĐLĐ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3012.ContractTypeList', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều kiện lọc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3012.GroupFilter' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3012.GroupReport' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hợp đồng lao động';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3012.chartTitle1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tuổi CNV';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3012.chartTitle2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nam';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3012.Male' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nữ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3012.Female' , @FormID, @LanguageValue, @Language;