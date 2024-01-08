-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2009- SO
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
SET @ModuleID = 'WM';
SET @FormID = 'WMF2009';

SET @LanguageValue = N'Kế thừa Phiếu bảo hành sửa chữa';
EXEC ERP9AddLanguage @ModuleID, 'WMF2009.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị'; 
EXEC ERP9AddLanguage @ModuleID, 'WMF2009.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2009.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2009.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại';
 EXEC ERP9AddLanguage @ModuleID, 'WMF2009.VoucherTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số xe'; 
EXEC ERP9AddLanguage @ModuleID, 'WMF2009.CarNumber' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đối tượng'; 
EXEC ERP9AddLanguage @ModuleID, 'WMF2009.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng'; 
EXEC ERP9AddLanguage @ModuleID, 'WMF2009.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'WMF2009.ObjectType' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ'; 
EXEC ERP9AddLanguage @ModuleID, 'WMF2009.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ đối tượng bảo hành'; 
EXEC ERP9AddLanguage @ModuleID, 'WMF2009.Address2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'WMF2009.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số seri';
EXEC ERP9AddLanguage @ModuleID, 'WMF2009.SeriNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'WMF2009.Phone' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lô hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2009.SourceNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'WMF2009.MVoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho xuất';
EXEC ERP9AddLanguage @ModuleID, 'WMF2009.ExWareHouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2009.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2009.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2009.Quantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dài';
EXEC ERP9AddLanguage @ModuleID, 'WMF2009.S01ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rộng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2009.S02ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cao';
EXEC ERP9AddLanguage @ModuleID, 'WMF2009.S03ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Màu sắc';
EXEC ERP9AddLanguage @ModuleID, 'WMF2009.S04ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời hạn bảo hành';
EXEC ERP9AddLanguage @ModuleID, 'WMF2009.WarrantyPeriod' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng hàng hóa';
EXEC ERP9AddLanguage @ModuleID, 'WMF2009.ItemCondition' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhập mã QR';
EXEC ERP9AddLanguage @ModuleID, 'WMF2009.ChooseQRCode' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lệnh sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'WMF2009.ProductionOrder' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'WMF2009.UnitID' , @FormID, @LanguageValue, @Language;