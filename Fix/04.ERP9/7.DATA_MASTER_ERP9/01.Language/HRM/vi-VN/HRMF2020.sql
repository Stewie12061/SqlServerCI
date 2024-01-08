-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2020- OO
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
SET @FormID = 'HRMF2020'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục đợt tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'APK'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.APK',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.Cost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.Costs',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'InheritRecruitPeriodID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.InheritRecruitPeriodID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày thay đổi'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người thay đổi'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thực hiện từ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.PeriodFromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thực hiện đến'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.PeriodToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ReceiveFromDate'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.ReceiveFromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ReceiveToDate'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.ReceiveToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đợt tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.RecruitPeriodID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đợt tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.RecruitPeriodName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã kế hoạch tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.RecruitPlanID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên kế hoạch tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.RecruitPlanName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.RecruitQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày yêu cầu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.RequireDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'TotalLevel'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.TotalLevel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'WorkPlace'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.WorkPlace',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'WorkType'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.WorkType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phòng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã vị trí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên vị trí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2020.DutyName.CB',  @FormID, @LanguageValue, @Language;


