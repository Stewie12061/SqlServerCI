-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF2051- POS
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
SET @ModuleID = 'POS';
SET @FormID = 'POSF2051';

/*
--Lấy Query nhanh
SELECT 'SET @LanguageValue = N''_''; EXEC ERP9AddLanguage @ModuleID, '''+IDLanguage+''' , @FormID, @LanguageValue, @Language;' FROM dbo.sysLanguage WHERE ScreenID =N'POSF2051'
*/

SET @LanguageValue = N'Người nhận bảo hành';
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.WarrantyRecipientName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu yêu cầu dịch vụ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa phiếu xuất'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.btnInheritedExport' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày giao máy'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.DeliveryDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu xuất kho'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.ExportVoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiện tượng hư'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.FailureStatus' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu yêu cầu dịch vụ'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.InheritVoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu yêu cầu dịch vụ'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.IsInheritVoucher' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiện trạng máy'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.MachineStatus' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khách hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.MemberID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khách hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.MemberName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày mua máy'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.PurchaseDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Serial/ Số IMEL1/ Số IMEL2'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.SerialNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.StatusID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày dịch vụ'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số dịch vụ'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu bảo hành'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.WarrantyCard' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người nhận bảo hành'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.WarrantyRecipientID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng thực tế'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.ActualQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền thực tế'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.Amount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảo hành'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.IsWarranty' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền báo giá'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.QuotationAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng báo giá'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.QuotationQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng trả'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.ReturnQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Linh kiện thay thế/ Dịch vụ '; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.ServiceID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Linh kiện thay thế/ Dịch vụ '; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.ServiceName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng tạm ứng'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.SuggestQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DVT'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.UnitID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DVT'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.UnitName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.UnitPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.WarrantyRecipientID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người nhận bảo hành';
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.WarrantyRecipientName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.StatusID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.StatusName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tại cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.StoreID1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tại khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.StoreID2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảo hành';
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.GuaranteeID1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sửa chữa';
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.GuaranteeID2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn linh kiện';
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.btnchooseServices' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa';
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.IsInheritVoucher' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'POSF2051.Description' , @FormID, @LanguageValue, @Language;