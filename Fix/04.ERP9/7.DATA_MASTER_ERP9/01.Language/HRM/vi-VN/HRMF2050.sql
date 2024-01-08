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
SET @FormID = 'HRMF2050'

SET @LanguageValue  = N'Danh mục quyết định tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số quyết định'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.RecDecisionNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.CandidateID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã quyết định tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.RecruitPeriodID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã người đề nghị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.UserID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên người đề nghị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.UserName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người đề nghị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày quyết định'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.DecisionDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2050.Description',  @FormID, @LanguageValue, @Language;