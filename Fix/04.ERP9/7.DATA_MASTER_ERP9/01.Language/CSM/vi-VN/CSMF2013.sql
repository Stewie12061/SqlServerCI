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
SET @FormID = 'CSMF2013';

SET @LanguageValue = N'Hãng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.FirmID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu sửa chữa';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tham chiếu';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.DispatchID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Model';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.Model1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số serial';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.SerialNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số IMEI';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.IMEINumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lỗi (SymptomCode)';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.SymptomCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không restore';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.IsNonRestore', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian nhận máy';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.ReceiveDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết quả External VMI';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.ExternalVMI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.Restore01Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết quả';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.Restore01Result', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.Restore02Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết quả';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.Restore02Result', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.Employee01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.Employee02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.EmployeeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.EmployeeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kiểm tra VMI';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.GroupCheckVMI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Restore lần 1';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.GroupRestore01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Restore lần 2';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2013.GroupRestore02', @FormID, @LanguageValue, @Language;
