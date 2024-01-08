-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SHMF2022- SHM
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
SET @FormID = 'SHMF2022';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.Tranmonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đợt phát hành';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.SHPublishPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã cổ đông';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm cổ đông';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.ShareHolderCategoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.IsPersonal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh xưng';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.ContactPrefix', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số CMND';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.IdentificationNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cấp';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.ContactIssueDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi cấp';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.ContactIssueBy', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng được mua';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.TotalQuantityBuyable', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng đăng ký';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.TotalQuantityRegistered', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng được duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.TotalQuantityApproved', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.TotalAmountBought', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã cổ đông';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã số thuế';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.Contactor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.PhoneNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm cổ đông';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.ShareHolderCategoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày phát hành';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.SHPublishPeriodDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem thông tin đăng ký mua cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.ShareHolderCategoryID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.ShareHolderCategoryName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.SHPublishPeriodID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.SHPublishPeriodName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.ShareTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.ShareTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin đăng ký mua cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết đăng ký cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.Detail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.History', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.ShareTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.ShareTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá phát hành';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SL được mua';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.QuantityBuyable', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SL đăng ký';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.QuantityRegistered', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SL được duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.QuantityApproved', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2022.AmountBought', @FormID, @LanguageValue, @Language;

