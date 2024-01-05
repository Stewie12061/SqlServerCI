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
SET @FormID = 'CSMF2010';

SET @LanguageValue = N'Phiếu sửa chữa';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2010.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2010.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2010.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tham chiếu';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2010.DispatchID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2010.ProductID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số serial';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2010.SerialNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số IMEI';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2010.IMEINumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2010.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái bảo hành';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2010.WarrantyStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2010.TechEmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên QC';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2010.QCEmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2010.StatusID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2010.StatusName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2010.WarrantyStatusID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2010.WarrantyStatusName.CB', @FormID, @LanguageValue, @Language;
