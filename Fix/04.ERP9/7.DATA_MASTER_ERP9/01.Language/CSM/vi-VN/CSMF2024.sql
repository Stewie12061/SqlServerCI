-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CSMF2024- CSM
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
SET @FormID = 'CSMF2024';

SET @LanguageValue = N'Cập nhật QC';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2024.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu sửa chữa';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2024.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tham chiếu';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2024.DispatchID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái phiếu';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2024.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên QC';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2024.QCEmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạn thái QC';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2024.QCStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian QC nhận';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2024.QCReceiveDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết quả QC';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2024.QCResult', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2024.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kiểm tra';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2024.DataID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung kiểm tra';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2024.DataName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết quả QC lần 1';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2024.Result01Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết quả QC lần 2';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2024.Result02Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2024.Description.CB', @FormID, @LanguageValue, @Language;

