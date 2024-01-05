-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2282- WM
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
SET @ModuleID = N'WM'
SET @FormID = 'WMF2282'

SET @LanguageValue = N'Cập nhật nhập kho mã vạch';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2282.Title', @FormID, @LanguageValue, @Language; 

SET @LanguageValue = N'Thông tin chi tiết phiếu nhập kho mã vạch';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2282.ThongTinChiTietNhapKhoMaVach', @FormID, @LanguageValue, @Language; 

SET @LanguageValue = N'Thông tin chi tiết mã vạch';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2282.ThongTinChiTietMaVach', @FormID, @LanguageValue, @Language; 


SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2282.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2282.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2282.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2282.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2282.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Seri';
EXEC ERP9AddLanguage @ModuleID, 'WMF2282.SeriNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2282.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2282.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho nhập';
EXEC ERP9AddLanguage @ModuleID, 'WMF2282.WareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kho nhập';
EXEC ERP9AddLanguage @ModuleID, 'WMF2282.WareHouseID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên kho nhập';
EXEC ERP9AddLanguage @ModuleID, 'WMF2282.WareHouseName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'WMF2282.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2282.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2282.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'WMF2282.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2282.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'WMF2282.Notes', @FormID, @LanguageValue, @Language;
