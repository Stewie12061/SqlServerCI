-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CSMF2050- CSM
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
SET @FormID = 'CSMF2050';

SET @LanguageValue = N'Biên bản trả hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2050.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2050.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số biên bản';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2050.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2050.SendUnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số AWB';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2050.AWBNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2050.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2050.TimeReceive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tham chiếu';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2050.DispatchID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bên nhận';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2050.ReceiveID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2050.FromReceiveDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'đến';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2050.ToReceiveDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Serial';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2050.SerialNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số IMEI';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2050.IMEINo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày trả máy';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2050.FromSendDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'đến';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2050.ToSendDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2050.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2050.SendUnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2050.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2050.Description.CB', @FormID, @LanguageValue, @Language;

