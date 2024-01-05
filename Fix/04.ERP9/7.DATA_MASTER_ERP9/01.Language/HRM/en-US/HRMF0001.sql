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


SET @Language = 'en-US';
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF0001'

SET @LanguageValue  = N'Set up auto increasing code business'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0001.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Training Budget'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0001.VTBudgetID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Training Plan'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0001.VTTrainingPlanID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Training Request'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0001.VTTrainingRequestID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Training Propose'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0001.VTTrainingProposeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Training Schedule'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0001.VTTrainingScheduleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Training Cost'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0001.VTTrainingCostID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Training Result'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0001.VTTrainingResultID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0001.VoucherTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Voucher Name'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0001.VoucherTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Black List'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0001.VTTrainingBlackListID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Transfer Of Personnel'
EXEC ERP9AddLanguage @ModuleID, 'HRMF0001.VTTrainingTransferOfPersonnelID',  @FormID, @LanguageValue, @Language;