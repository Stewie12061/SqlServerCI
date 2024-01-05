-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2172- CRM
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
SET @FormID = 'CRMF2172';

/*
--Lấy Query nhanh
SELECT 'SET @LanguageValue = N''_''; EXEC ERP9AddLanguage @ModuleID, '''+IDLanguage+''' , @FormID, @LanguageValue, @Language;' FROM dbo.sysLanguage WHERE ScreenID =N'POSF2051'
*/


SET @LanguageValue = N'Xem thông tin chi tiết yêu cầu dịch vụ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa phiếu xuất'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.btnInheritedExport' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày giao máy'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.DeliveryDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu xuất kho'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.ExportVoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiện tượng hư'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.FailureStatus' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu yêu cầu dịch vụ'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.InheritVoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu yêu cầu dịch vụ'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.IsInheritVoucher' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiện trạng máy'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.MachineStatus' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khách hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.MemberID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khách hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.MemberName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày mua máy'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.PurchaseDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Serial/ Số IMEL1/ Số IMEL2'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.SerialNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.StatusID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày dịch vụ'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số dịch vụ'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu bảo hành'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.WarrantyCard' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người nhận bảo hành'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.WarrantyRecipientID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng thực tế'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.ActualQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền thực tế'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.Amount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảo hành'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.IsWarranty' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền báo giá'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.QuotationAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng báo giá'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.QuotationQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng trả'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.ReturnQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Linh kiện thay thế/ Dịch vụ '; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.ServiceID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Linh kiện thay thế/ Dịch vụ '; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.ServiceName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng tạm ứng'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.SuggestQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DVT'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.UnitID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DVT'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.UnitName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.UnitPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.TabInfo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.TabInfo1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin linh kiện thay thế/ dịch vụ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.TabInfo2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.TabCRMT00002' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.TabCRMT90031' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.TabCRMT00003' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2172.Description' , @FormID, @LanguageValue, @Language;