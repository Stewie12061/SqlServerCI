﻿-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2170- POS
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
SET @FormID = 'CRMF2170';

/*
--Lấy Query nhanh
SELECT 'SET @LanguageValue = N''_''; EXEC ERP9AddLanguage @ModuleID, '''+IDLanguage+''' , @FormID, @LanguageValue, @Language;' FROM dbo.sysLanguage WHERE ScreenID =N'POSF2051'
*/

SET @LanguageValue = N'Danh mục yêu cầu dịch vụ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa phiếu xuất'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.btnInheritedExport' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày giao máy'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.DeliveryDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu xuất kho'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.ExportVoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiện tượng hư'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.FailureStatus' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu yêu cầu dịch vụ'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.InheritVoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảo hành'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.IsGuarantee' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu yêu cầu dịch vụ'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.IsInheritVoucher' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiện trạng máy'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.MachineStatus' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khách hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.MemberID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khách hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.MemberName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày mua máy'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.PurchaseDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Serial/ Số IMEL1/ Số IMEL2'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.SerialNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.StatusID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày dịch vụ'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số dịch vụ'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu bảo hành'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.WarrantyCard' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người nhận bảo hành'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.WarrantyRecipientID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.StatusID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.StatusName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ khách hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'NV bảo hành'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.GuaranteeEmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'NV sửa chữa'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.RepairEmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'NV giao hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.DeliveryEmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng tiền'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.TotalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu in yêu cầu dịch vụ'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2170.CRMR2170Title' , @FormID, @LanguageValue, @Language;