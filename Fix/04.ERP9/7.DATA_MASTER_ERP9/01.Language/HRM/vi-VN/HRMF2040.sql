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
SET @FormID = 'HRMF2040'

SET @LanguageValue  = N'Danh mục kết quả phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đợt tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.RecruitPeriodID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày nhận việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.Startdate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí ứng tuyển'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.CandidateName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí ứng tuyển'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.RecruitStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.CandidateID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã vị trí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên vị trí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2040.Description.CB',  @FormID, @LanguageValue, @Language;