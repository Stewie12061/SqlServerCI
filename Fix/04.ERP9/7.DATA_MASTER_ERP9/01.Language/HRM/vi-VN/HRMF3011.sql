-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF3011
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


SET @Language = 'vi-VN';
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF3011'

SET @LanguageValue  = N'Báo cáo kết quả phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3011.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Báo cáo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3011.ReportID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên báo cáo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3011.ReportName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiêu đề'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3011.ReportTitle',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3011.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3011.DepartmentID_Traning',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đợt tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3011.RecruitPeriodName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3011.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3011.CandidateName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vòng phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3011.InterviewLevelName',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3011.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'ReportView.DivisionID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'ReportView.DivisionName.CB',  @FormID, @LanguageValue, @Language;






