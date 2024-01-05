declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'Vi-VN'

SET @FormID = 'CRMF2022'

SET @LanguageValue = N'Xem chi tiết phiếu điều phối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.Title' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Chi tiết phiếu điều phối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.TabDetail' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.VoucherNo' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.VoucherDate' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.VATObjectName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.Address' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tuyến giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.RouteName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'NV giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.DeliveryEmployeeName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Trạng thái điều phối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.DeliveryStatusName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Người lập phiếu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.EmployeeName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Số đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.SVoucherNo' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.Description' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.CreateUserID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.CreateDate' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.LastModifyUserID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2022.LastModifyDate' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Thông tin điều phối';
EXEC ERP9AddLanguage @ModuleID, 'GR.ThongTinDieuPhoi' , @FormID, @LanguageValue, @Language;