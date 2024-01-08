-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2034- OO
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
SET @FormID = 'HRMF2034'

SET @LanguageValue  = N'Chọn đợt tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2034.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2034.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2034.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2034.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2034.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2034.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa điểm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2034.InterviewAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vòng phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2034.InterviewLevel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đợt tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2034.RecruitPeriodID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đợt tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2034.RecruitPeriodName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế hoạch tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2034.RecruitPlanID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'RowNum'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2034.RowNum',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'TotalRow'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2034.TotalRow',  @FormID, @LanguageValue, @Language;

