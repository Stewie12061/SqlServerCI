-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2061- PO
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
SET @ModuleID = 'PO';
SET @FormID = 'POF2061';

SET @LanguageValue = N'更新出貨集裝箱訂貨';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'借款合約';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'票據創建日期';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'關閉貨物';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.PackedTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'船舶出發日期';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.DepartureDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'船舶到達日期';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.ArrivalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'港口';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.PortName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.ClosingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'接收者';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.Forwarder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'船運商';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.ShipBrand', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'集裝箱數量';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.ContQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯人';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.DatePeriodPOF2060', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.DivisionIDPOF2060', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.ShipBrandPOF2060', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.PortNamePOF2060', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.VoucherNoPOF2060', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2061.DeleteFlag', @FormID, @LanguageValue, @Language;

