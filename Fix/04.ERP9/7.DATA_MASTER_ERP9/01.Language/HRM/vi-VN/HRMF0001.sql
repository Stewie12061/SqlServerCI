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
SET @FormID = 'HRMF0001'

SET @LanguageValue  = N'Thiết lập mã tự động nghiệp vụ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0001.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngân sách đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0001.VTBudgetID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế hoạch đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0001.VTTrainingPlanID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0001.VTTrainingRequestID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đề xuất đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0001.VTTrainingProposeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0001.VTTrainingScheduleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi nhận chi phí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0001.VTTrainingCostID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Black List'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0001.VTTrainingBlackListID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điều chuyển nhân sự'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0001.VTTrainingTransferOfPersonnelID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi nhận kết quả'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0001.VTTrainingResultID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi nhận kết quả'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0001.VTTrainingResultID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0001.VoucherTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0001.VoucherTypeName.CB',  @FormID, @LanguageValue, @Language;

