-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2062- PO
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
SET @FormID = 'POF2062';

SET @LanguageValue = N'查看出貨集裝箱訂購明細';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'借款合約';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'票據創建日期';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'關閉貨物';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.PackedTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'船舶出發日期';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.DepartureDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'船舶到達日期';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.ArrivalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'港口';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.PortName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.ClosingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'接收者';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.Forwarder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'船運商';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.ShipBrand', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'集裝箱數量';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.ContQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯人';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.DatePeriodPOF2060', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.DivisionIDPOF2060', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.ShipBrandPOF2060', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.PortNamePOF2060', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.VoucherNoPOF2060', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2062.DeleteFlag', @FormID, @LanguageValue, @Language;

