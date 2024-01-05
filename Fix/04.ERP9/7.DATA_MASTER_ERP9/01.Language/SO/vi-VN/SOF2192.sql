-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2192- SO
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
SET @ModuleID = 'SO';
SET @FormID = 'SOF2192';

SET @LanguageValue = N'Xem chi tiết phiếu quản lý bảo hành sửa chữa';
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.Master.GR' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.Detail.GR' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.Attacth.GR' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2192.VoucherTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số xe'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.CarNumber' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đối tượng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.ObjectType' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ 2'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.Address2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số seri';
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.SeriNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.Phone' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lô hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.SourceNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.MVoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho xuất';
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.ExWareHouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.Quantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dài';
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.Long' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rộng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.Weight' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cao';
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.High' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Màu sắc';
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.Color' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời hạn bảo hành';
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.WarrantyPeriod' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng hàng hóa';
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.ItemCondition' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhập mã QR';
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.ChooseQRCode' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lệnh sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.ProductionOrder' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SOF2192.StatusID',  @FormID, @LanguageValue, @Language;
