-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SHMF2011- SHM
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
SET @ModuleID = 'SHM';
SET @FormID = 'SHMF2011';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã cổ đông';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm cổ đông';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.ShareHolderCategoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cấp';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.ContactIssueDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi cấp';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.ContactIssueBy', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số CMND';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.IdentificationNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh xưng';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.ContactPrefix', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số cổ phần sở hữu';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.TotalShare', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên cổ đông';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã số thuế';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.Contactor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.Phonenumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.ShareTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức ưu đãi';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.PreferentialDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều kiện chuyển nhượng';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.TransferCondition', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mệnh giá';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số cổ phần sở hữu';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.IncrementQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng Mệnh giá';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.ShareAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật số cổ đông';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.ShareHolderCategoryID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.ShareHolderCategoryName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.ShareTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.ShareTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin số cổ đông';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2012.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết số cổ đông';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2012.Detail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2012.History', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.RefVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày giao dịch';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2011.TransactionDate', @FormID, @LanguageValue, @Language;

