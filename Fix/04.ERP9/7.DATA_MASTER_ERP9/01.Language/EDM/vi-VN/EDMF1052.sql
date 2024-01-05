-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF1052- EDM
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
SET @FormID = 'EDMF1052';

SET @LanguageValue = N'Cập nhật loại hình thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1052.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1052.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1052.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1052.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1052.ReceiptTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hình thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1052.ReceiptTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1052.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1052.TypeOfFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1052.Business', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1052.StudentStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1052.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bắt buộc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1052.IsObligatory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảo lưu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1052.IsReserve', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chuyển nhượng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1052.IsTransfer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1052.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1052.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1052.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1052.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoản thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1052.AnaRevenueID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1052.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoản thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1052.AnaRevenueName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1052.AnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoản thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1052.AnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1052.AccountID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1052.AccountName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1052.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1052.Description.CB', @FormID, @LanguageValue, @Language;



