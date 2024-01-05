-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ TF2001- CI
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
SET @ModuleID = 'CI';
SET @FormID = 'TF2001';

SET @LanguageValue = N'Cập nhật ngân sách';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại ngân sách';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.BudgetType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kỳ ngân sách';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Month', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Year', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban/Trường';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.VoucherTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày lập ngân sách';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày duyệt';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.ApprovalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền nguyên tệ';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.OriginalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.ConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana01Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana02Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana03Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana04Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana05Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana06ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana06Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana07ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana07Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana08ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana08Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana09ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana09Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana10ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.Ana10Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiền NT được duyệt';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.ApprovalOAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiền QĐ được duyệt';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.ApprovalCAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú của người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.ApprovalAccountNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.BudgetTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày duyệt';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.ApprovalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 01';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.ApprovePerson01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 02';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.ApprovePerson02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.CurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.CurrencyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.AnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.AnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.DepartmentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.DepartmentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.ApprovePerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày duyệt';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.ApprovalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngân sách Thu/Chi';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.BudgetKindID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngân sách Thu/Chi';
EXEC ERP9AddLanguage @ModuleID, 'TF2001.BudgetKindName', @FormID, @LanguageValue, @Language;