-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SHMF2031- SHM
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
SET @FormID = 'SHMF2031';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã cổ đông';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.FromObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SL trước khi chuyển';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.BeforeFromQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SL sau khi chuyển';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.AfterFromQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.ToObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SL trước khi chuyển';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.BeforeToQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SL sau khi chuyển';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.AfterToQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phí giao dịch';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.TransferFree', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.TotalQuantityTransfered', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.TotalAmountTransfered', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên cổ đông chuyển';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.FromObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.ShareTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên cổ đông nhận';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.ToObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.IsTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật chuyển nhượng cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.ShareTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.ShareTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.ShareTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng chuyển nhượng';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.QuantityTransfered', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị chuyển nhượng';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.AmountTransfered', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chuyển nhượng cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết chuyển nhượng cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.Detail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.History', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cổ đông chuyển';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.Group1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng nhận';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.Group2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.ObjectID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.ObjectName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2031.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

