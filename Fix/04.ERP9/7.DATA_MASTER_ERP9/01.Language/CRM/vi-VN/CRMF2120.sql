-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2120- CRM
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
SET @FormID = 'CRMF2120';

SET @LanguageValue = N'Danh mục license';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phiếu đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.RequestLicenseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phiếu đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.RequestLicenseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã số thuế';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người ĐDPL';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.NameofLegalRepresentative', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.Position', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.ContractName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số người sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.NumberOfUsers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số đơn vị/Chi nhánh sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.NumberOfUnitsBranchesUsed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hóa đơn điện tử';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.ElectronicBill', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.Fax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Website';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.Website', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian hết hạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.DeadlineTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Có thời hạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.IsDeadlineTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không có thời hạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.NoDeadline', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên máy';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2120.ComputerName', @FormID, @LanguageValue, @Language;

