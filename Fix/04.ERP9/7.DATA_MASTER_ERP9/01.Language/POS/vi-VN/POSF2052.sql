-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF2052- POS
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
SET @FormID = 'POSF2052';

/*
--Lấy Query nhanh
SELECT 'SET @LanguageValue = N''_''; EXEC ERP9AddLanguage @ModuleID, '''+IDLanguage+''' , @FormID, @LanguageValue, @Language;' FROM dbo.sysLanguage WHERE ScreenID =N'POSF2051'
*/


SET @LanguageValue = N'Xem thông tin phiếu yêu cầu dịch vụ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa phiếu xuất'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.btnInheritedExport' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày giao máy'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.DeliveryDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu xuất kho'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.ExportVoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiện tượng hư'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.FailureStatus' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu yêu cầu dịch vụ'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.InheritVoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu yêu cầu dịch vụ'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.IsInheritVoucher' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiện trạng máy'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.MachineStatus' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khách hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.MemberID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khách hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.MemberName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày mua máy'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.PurchaseDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Serial/ Số IMEL1/ Số IMEL2'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.SerialNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.StatusID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày dịch vụ'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số dịch vụ'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu bảo hành'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.WarrantyCard' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người nhận bảo hành'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.WarrantyRecipientID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng thực tế'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.ActualQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền thực tế'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.Amount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảo hành'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.IsWarranty' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền báo giá'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.QuotationAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng báo giá'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.QuotationQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng trả'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.ReturnQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Linh kiện thay thế/ Dịch vụ '; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.ServiceID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Linh kiện thay thế/ Dịch vụ '; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.ServiceName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng tạm ứng'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.SuggestQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DVT'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.UnitID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DVT'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.UnitName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá'; 
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.UnitPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.TabInfo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.TabInfo1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin linh kiện thay thế/ dịch vụ';
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.TabInfo2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.TabCRMT00002' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.TabCRMT90031' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.TabCRMT00003' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'POSF2052.Description' , @FormID, @LanguageValue, @Language;