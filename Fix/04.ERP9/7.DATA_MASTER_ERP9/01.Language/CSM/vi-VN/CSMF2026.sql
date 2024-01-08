-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CSMF2026- CSM
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
SET @FormID = 'CSMF2026';

SET @LanguageValue = N'Cập nhật thông tin chi tiết lỗi GSX';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2026.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tham chiếu';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2026.DispatchID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã thiết bị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2026.ProductID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải thiết bị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2026.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Serial';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2026.SerialNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số IMEI';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2026.IMEINo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lý do lỗi';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2026.ErrorReason', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian ghi nhận lỗi';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2026.ErrorDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'EscalationID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2026.EscalationID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian báo cáo Escalation';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2026.EscalationDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian kết thúc Escalation';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2026.EscalationEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2026.Notes', @FormID, @LanguageValue, @Language;


