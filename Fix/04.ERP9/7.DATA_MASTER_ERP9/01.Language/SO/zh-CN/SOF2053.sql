-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2053- SO
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
SET @ModuleID = 'SO';
SET @FormID = 'SOF2053';

SET @LanguageValue = N'員工程式碼';
EXEC ERP9AddLanguage @ModuleID, 'SOF2053.SaleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'員工姓名';
EXEC ERP9AddLanguage @ModuleID, 'SOF2053.SaleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'年初限定';
EXEC ERP9AddLanguage @ModuleID, 'SOF2053.Beginning', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'授予的限額';
EXEC ERP9AddLanguage @ModuleID, 'SOF2053.GrantedQuota', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'預付的費用';
EXEC ERP9AddLanguage @ModuleID, 'SOF2053.AdvanceCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'待客費用';
EXEC ERP9AddLanguage @ModuleID, 'SOF2053.RefundedCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'剩餘限額';
EXEC ERP9AddLanguage @ModuleID, 'SOF2053.RemainingQuota', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2053.RowNum', @FormID, @LanguageValue, @Language;

