-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CSMF0001- OO
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


SET @Language = 'vi-VN';
SET @ModuleID = 'CSM';
SET @FormID = 'CSMF0001'

SET @LanguageValue  = N'Thiết lập hệ thống CSM'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Danh mục hãng'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.FirmAnalyst',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Danh mục model'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.ModelAnalyst',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Danh mục loại sản phẩm'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.ProductTypeAnalyst',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên QC'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.QCID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái chi tiết'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.ReasonID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên trạng thái chi tiết'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.ReasonName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên kỹ thuật'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.TechnicalID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian tự động check GSX ( phút )'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.TimeCheck',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số ngày hết hạn check GSX'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Danh mục hình thức VC'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.TransportTypeAnalyst',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.TypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.TypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại CT báo giá'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.VoucherBG',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại CT phiếu sửa chữa'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.VoucherPSC',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại CT đơn hàng nhận'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.VoucherReceive',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại CT đơn hàng giao'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.VoucherSend',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chứng từ'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.VoucherTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.VoucherTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng cung cấp dịch vụ, sửa chữa'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thiết lập tự động kiểm tra trạng thái trên GSX'
EXEC ERP9AddLanguage @ModuleID, 'CSMF0001.AutoSetting',  @FormID, @LanguageValue, @Language;
