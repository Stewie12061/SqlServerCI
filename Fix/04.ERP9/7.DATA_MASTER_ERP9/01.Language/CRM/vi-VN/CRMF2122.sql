-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2122- CRM
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
SET @FormID = 'CRMF2122';

SET @LanguageValue = N'Chi tiết license';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phiếu đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.RequestLicenseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phiếu đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.RequestLicenseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã số thuế';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người ĐDPL';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.NameofLegalRepresentative', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.Position', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.ContractName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số người sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.NumberOfUsers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số đơn vị/Chi nhánh sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.NumberOfUnitsBranchesUsed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hóa đơn điện tử';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.ElectronicBill', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.Fax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Website';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.Website', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian hết hạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.DeadlineTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Có thời hạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.IsDeadlineTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không có thời hạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.NoDeadline', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.LichSu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Profile';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.Profile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết phiếu license';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.ThongTinChiTietPhieuDeNghiCapLicense', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiên bản';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2122.InformationVersionName', @FormID, @LanguageValue, @Language;