-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SHMF2020- SHM
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
SET @FormID = 'SHMF2020';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.Tranmonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đợt phát hành';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.SHPublishPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã cổ đông';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm cổ đông';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.ShareHolderCategoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.IsPersonal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh xưng';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.ContactPrefix', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số CMND';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.IdentificationNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cấp';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.ContactIssueDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi cấp';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.ContactIssueBy', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng được mua';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.TotalQuantityBuyable', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng đăng ký';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.TotalQuantityRegistered', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng được duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.TotalQuantityApproved', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.TotalAmountBought', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên cổ đông';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã số thuế';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.Contactor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.PhoneNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm cổ đông';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.ShareHolderCategoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày phát hành';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.SHPublishPeriodDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh sách đăng ký mua cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.ShareHolderCategoryID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.ShareHolderCategoryName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.SHPublishPeriodID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.SHPublishPeriodName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2021.ShareTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2021.ShareTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin đăng ký mua cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết đăng ký cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.Detail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đợt phát hành';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.SHPublishPeriodID2020', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên cổ đông';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2020.ObjectName2020', @FormID, @LanguageValue, @Language;


