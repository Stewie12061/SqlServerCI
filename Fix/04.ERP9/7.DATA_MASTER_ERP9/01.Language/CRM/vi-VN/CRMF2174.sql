-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2174 - CRM
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
SET @FormID = 'CRMF2174';

SET @LanguageValue = N'Điều phối nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2174.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu yêu cầu dịch vụ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2174.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên bảo hành';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2174.GuaranteeEmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên sửa chữa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2174.RepairEmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2174.DeliveryEmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2174.DeliveryEmployeeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2174.DeliveryEmployeeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2174.GuaranteeEmployeeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2174.GuaranteeEmployeeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2174.RepairEmployeeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên'; 
EXEC ERP9AddLanguage @ModuleID, 'CRMF2174.RepairEmployeeName.CB' , @FormID, @LanguageValue, @Language;