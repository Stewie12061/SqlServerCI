-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CSMF2030- CSM
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
SET @FormID = 'CSMF2030';

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2030.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2030.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tham chiếu';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2030.DispatchID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Serial';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2030.SerialNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số IMEI';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2030.IMEINo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2030.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian điều phối';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2030.TimeControl', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái điều phối';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2030.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người điều phối';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2030.EmployeeControlName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều phối kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2030.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2030.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2030.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2030.Description.CB', @FormID, @LanguageValue, @Language;