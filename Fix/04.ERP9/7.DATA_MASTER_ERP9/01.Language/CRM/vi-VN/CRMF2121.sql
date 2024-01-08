-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2121- CRM
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
SET @FormID = 'CRMF2121';

SET @LanguageValue = N'Cập nhật license';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phiếu đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.RequestLicenseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phiếu đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.RequestLicenseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã số thuế';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người ĐDPL';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.NameofLegalRepresentative', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Position', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.ContractName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số người sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.NumberOfUsers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số đơn vị/Chi nhánh sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.NumberOfUnitsBranchesUsed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hóa đơn điện tử';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.ElectronicBill', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Fax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Website';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Website', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian hết hạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.DeadlineTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian hết hạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.IsDeadlineTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không có thời hạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.NoDeadline', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.ChooseContract', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiếng Nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Jananese', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiếng Hoa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Chinese', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chỉ xem báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.ReportViewOnly', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SME 2022';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.SME', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cloud Server';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.CloudServer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiên bản';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.InformationVersion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Server';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Server', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người dùng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.InformationUser', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Port';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Port', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mật khẩu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Password', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tùy chọn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Option', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngôn ngữ/Báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2121.Language/Report', @FormID, @LanguageValue, @Language;

