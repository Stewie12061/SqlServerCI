-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2171- CRM
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
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2171';

/*
--Lấy Query nhanh
SELECT 'SET @LanguageValue = N''_''; EXEC ERP9AddLanguage @ModuleID, '''+IDLanguage+''' , @FormID, @LanguageValue, @Language;' FROM dbo.sysLanguage WHERE ScreenID =N'CRMF2171'
*/

SET @LanguageValue = N'Người nhận bảo hành';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.WarrantyRecipientName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật yêu cầu dịch vụ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa phiếu xuất'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.btnInheritedExport' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày giao máy'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.DeliveryDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu xuất kho'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.ExportVoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiện tượng hư'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.FailureStatus' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu yêu cầu dịch vụ'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.InheritVoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu yêu cầu dịch vụ'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.IsInheritVoucher' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiện trạng máy'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.MachineStatus' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khách hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.MemberID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khách hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.MemberName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày mua máy'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.PurchaseDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Serial/ Số IMEL1/ Số IMEL2'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.SerialNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.StatusID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày dịch vụ'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số dịch vụ'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu bảo hành'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.WarrantyCard' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người nhận bảo hành'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.WarrantyRecipientID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng thực tế'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.ActualQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền thực tế'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.Amount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảo hành'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.IsWarranty' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền báo giá'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.QuotationAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng báo giá'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.QuotationQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng trả'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.ReturnQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Linh kiện thay thế/ Dịch vụ '; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.ServiceID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Linh kiện thay thế/ Dịch vụ '; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.ServiceName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng tạm ứng'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.SuggestQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DVT'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.UnitID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DVT'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.UnitName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.UnitPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.WarrantyRecipientID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người nhận bảo hành';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.WarrantyRecipientName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.StatusID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.StatusName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tại cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.StoreID1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tại khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.StoreID2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảo hành';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.GuaranteeID1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sửa chữa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.GuaranteeID2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn linh kiện';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.btnchooseServices' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.IsInheritVoucher' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2171.Description' , @FormID, @LanguageValue, @Language;