-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1032- OO
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
SET @FormID = 'HRMF2010'

SET @LanguageValue  = N'Yêu cầu công việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã yêu cầu công việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.RecruitRequireID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên yêu cầu công việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.RecruitRequireName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã vị trí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên vị trí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu chung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.GroupRequireCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu kỹ năng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.GroupRequire',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình độ ngoại ngữ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.GroupRequireLanguage',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu sức khỏe'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.GroupRequireHealth',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Độ tuổi'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.GroupAge',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức lương'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2010.GroupSalary',  @FormID, @LanguageValue, @Language;