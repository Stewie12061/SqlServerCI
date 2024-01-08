-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2160- HRM
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
SET @Language = 'zh-CN' 
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2160';

SET @LanguageValue = N'傭金清單';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'員工程式碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'員工姓名';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'變成金錢';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.RevenueAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'聯絡電話姓名';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'命名項目';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合同/發票';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'付款金額（未含增值稅）';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.PayAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'傭金計算金額';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'尚未加入Firm的Lead';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.BonusRate01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'已加入的Lead';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.BonusRate02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銷售';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.BonusRate03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Coach';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.BonusRate04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'凱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.Period', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'月';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'年';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.TranYear', @FormID, @LanguageValue, @Language;

