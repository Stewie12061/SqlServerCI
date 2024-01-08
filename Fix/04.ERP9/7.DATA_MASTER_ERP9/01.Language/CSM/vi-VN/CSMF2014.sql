-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CSMF2014- CSM
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
SET @FormID = 'CSMF2014';

SET @LanguageValue = N'Cập nhật thông tin vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2014.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên ASP';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2014.ASPName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số PSC';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2014.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tham chiếu';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2014.DispatchID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Model';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2014.ModelName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Serial';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2014.SerialNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số IMEI';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2014.IMEINumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2014.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2014.GSXStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2014.NotesSubject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2014.ShipperID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số AWB';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2014.AWBNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2014.ObjectID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2014.ObjectName.CB', @FormID, @LanguageValue, @Language;

