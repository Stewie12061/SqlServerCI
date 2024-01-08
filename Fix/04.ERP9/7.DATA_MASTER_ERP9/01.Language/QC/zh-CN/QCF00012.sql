-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF00012- QC
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
SET @ModuleID = 'QC';
SET @FormID = 'QCF00012';

SET @LanguageValue = N'選擇班次開始訊息';
EXEC ERP9AddLanguage @ModuleID, 'QCF00012.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF00012.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'生産日期';
EXEC ERP9AddLanguage @ModuleID, 'QCF00012.WorkDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'轉移';
EXEC ERP9AddLanguage @ModuleID, 'QCF00012.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'轉移';
EXEC ERP9AddLanguage @ModuleID, 'QCF00012.ShiftName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工廠';
EXEC ERP9AddLanguage @ModuleID, 'QCF00012.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'车间名称';
EXEC ERP9AddLanguage @ModuleID, 'QCF00012.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機器';
EXEC ERP9AddLanguage @ModuleID, 'QCF00012.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'姓名';
EXEC ERP9AddLanguage @ModuleID, 'QCF00012.MachineName', @FormID, @LanguageValue, @Language;

