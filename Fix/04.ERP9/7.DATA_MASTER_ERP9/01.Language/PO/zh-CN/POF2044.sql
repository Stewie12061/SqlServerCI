-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2044- PO
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
SET @FormID = 'POF2044';

SET @LanguageValue = N'供應商報價之繼承';
EXEC ERP9AddLanguage @ModuleID, 'POF2044.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2044.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'借款合約';
EXEC ERP9AddLanguage @ModuleID, 'POF2044.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'要求日期';
EXEC ERP9AddLanguage @ModuleID, 'POF2044.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'截止日期';
EXEC ERP9AddLanguage @ModuleID, 'POF2044.OverDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2044.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'供應商';
EXEC ERP9AddLanguage @ModuleID, 'POF2044.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2044.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編制人';
EXEC ERP9AddLanguage @ModuleID, 'POF2044.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'POF2044.Description', @FormID, @LanguageValue, @Language;

