-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2144- M
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
SET @ModuleID = 'M';
SET @FormID = 'MF2144';

SET @LanguageValue = N'生產訂單之選擇';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'類型代碼';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'天';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.OrderDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.SOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯人';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'物品種類';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訂單狀態';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.ClassifyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.Ana01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.Ana02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.Ana03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.Ana05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交貨日期';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.ShipDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶程式碼';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.IsPeriod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.IsPlan', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.IsInheritSO', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.IsInheritBOM', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'追隨者';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2144.PeriodID', @FormID, @LanguageValue, @Language;

