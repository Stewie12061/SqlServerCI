-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2000- EDM
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
SET @ModuleID = 'EDM';
SET @FormID = 'EDMF2000';

SET @LanguageValue = N'Khoá';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.DivisionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tư vấn';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tư vấn';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.SchoolID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.SchoolName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phụ huynh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.ParentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phụ huynh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.ParentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết quả tư vấn';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.ResultName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.Telephone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ nhà';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sinh Phụ huynh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.ParentDateBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sinh Học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.StudentDateBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giới tính';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.Sex', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết quả tư vấn';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.ResultID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.DateFrom', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.DateTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.Information', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu thông tin tư vấn';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tư vấn';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.lblVoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.Status' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin phiếu tư vấn';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.Report' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.StudentID' , @FormID, @LanguageValue, @Language;