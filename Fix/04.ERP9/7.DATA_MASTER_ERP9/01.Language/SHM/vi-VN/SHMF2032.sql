-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SHMF2032- SHM
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
SET @FormID = 'SHMF2032';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã cổ đông';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.FromObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SL trước khi chuyển';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.BeforeFromQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SL sau khi chuyển';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.AfterFromQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.ToObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SL trước khi chuyển';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.BeforeToQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SL sau khi chuyển';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.AfterToQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phí giao dịch';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.TransferFree', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.TotalQuantityTransfered', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.TotalAmountTransfered', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên cổ đông chuyển';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.FromObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.ShareTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên cổ đông nhận';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.ToObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.IsTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem thông tin chuyển nhượng cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.ShareTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.ShareTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.ShareTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng chuyển nhượng';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.QuantityTransfered', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị chuyển nhượng';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.AmountTransfered', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chuyển nhượng cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết chuyển nhượng cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.Detail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.History', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cổ đông chuyển';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.Group1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng nhận';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2032.Group2', @FormID, @LanguageValue, @Language;

