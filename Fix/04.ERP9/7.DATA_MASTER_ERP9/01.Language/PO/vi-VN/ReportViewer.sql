
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ ReportView- OO
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
 - Tieng Anh: vi-VN 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'vi-VN' 
SET @ModuleID = 'PO';
SET @FormID = 'ReportView';

SET @LanguageValue = N'Mã loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.CurrencyID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.CurrencyName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.OrderStatus.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.Description.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'ReportView.ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên'
EXEC ERP9AddLanguage @ModuleID, 'ReportView.Description.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'ReportView.Code.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.OrderStatusName.CB' , @FormID, @LanguageValue, @Language;

