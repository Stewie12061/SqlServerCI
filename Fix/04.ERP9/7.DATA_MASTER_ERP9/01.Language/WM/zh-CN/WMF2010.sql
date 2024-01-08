
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2010- WM
------------------------------------------------------------------------------------------------------
go
delete A00001 where formid = 'wmf2010'
go

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
SET @ModuleID = 'WM';
SET @FormID = 'WMF2010';

SET @LanguageValue = N'庫存余額清單';
EXEC ERP9AddLanguage @ModuleID, 'WMF2010.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'WMF2010.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'借款合約';
EXEC ERP9AddLanguage @ModuleID, 'WMF2010.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'會計日期';
EXEC ERP9AddLanguage @ModuleID, 'WMF2010.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'到達'
EXEC ERP9AddLanguage @ModuleID, 'WMF2010.ToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'聯絡電話姓名';
EXEC ERP9AddLanguage @ModuleID, 'WMF2010.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'进入仓库';
EXEC ERP9AddLanguage @ModuleID, 'WMF2010.WarehouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'依序號/IMEI 管理';
EXEC ERP9AddLanguage @ModuleID, 'WMF2010.IsSerialized' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'WMF2010.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'聯絡電話姓名';
EXEC ERP9AddLanguage @ModuleID, 'WMF2010.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'进入仓库';
EXEC ERP9AddLanguage @ModuleID, 'WMF2010.WarehouseName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'處理人姓名';
EXEC ERP9AddLanguage @ModuleID, 'WMF2010.EmployeeName' , @FormID, @LanguageValue, @Language;


