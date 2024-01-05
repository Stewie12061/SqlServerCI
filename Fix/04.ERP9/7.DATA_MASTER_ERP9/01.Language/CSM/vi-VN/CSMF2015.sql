-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CSMF2010- CSM
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
SET @Language = 'vi-VN' 
SET @ModuleID = 'CSM';
SET @FormID = 'CSMF2015';

SET @LanguageValue = N'Cập nhật linh kiện sửa chữa';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2015.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Linh kiện';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2015.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Comptia Code';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2015.ComptiaCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Comptia Modifier';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2015.ComptiaModifier', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Serial KGB';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2015.SerialKBG', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số IMEI KGB';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2015.IMEIKBG', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Serial KBB';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2015.SerialKBB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số IMEI KBB';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2015.IMEIKBB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Return Order Number KBB';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2015.ReturnOrderKBB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2015.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sử dụng linh kiện ký gửi';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2015.IsConsignment', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái xuất hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2015.ConfirmStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày xác nhận';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2015.ConfirmDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lý do từ chối xuất hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2015.RejectReason', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trả linh kiện (DOA)';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2015.IsDOA', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Symptom Code';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2015.SymptomCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Symptom Code';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2015.SymptomCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Symptom Modifier';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2015.SymptomModifier', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày xác nhận';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2015.DOADate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Return Order Number DOA';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2015.ReturnOrderDOA', @FormID, @LanguageValue, @Language;

