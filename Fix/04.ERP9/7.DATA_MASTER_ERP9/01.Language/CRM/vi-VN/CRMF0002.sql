declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'vi-VN'
SET @FormID = 'CRMF0002'

SET @LanguageValue = N'Thiết lập tính hao hụt';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0002.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại giấy';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0002.ScreenHeader' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0002.IsCommon' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'STT';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0002.Orders' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số mặt in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0002.SidePrint' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0002.PhaseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại điều kiện';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0002.ConditionType' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số mặt in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0002.ConditionName1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng màu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0002.ConditionName2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguyên vật liệu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0002.ConditionName3' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ số lượng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0002.Condition4' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến số lượng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0002.Condition5' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hệ số';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0002.Coefficient' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phần trăm hao hụt';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0002.PercentLoss' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng hao hụt';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0002.Quantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0002.PhaseIDSetting.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0002.PhaseNameSetting.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0002.ID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0002.Description.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm dán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0002.ConditionName6' , @FormID, @LanguageValue, @Language;

