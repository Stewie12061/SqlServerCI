-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SHMF2030- SHM
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
SET @FormID = 'SHMF2030';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cổ đông chuyển';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.FromObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SL trước khi chuyển';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.BeforeFromQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SL sau khi chuyển';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.AfterFromQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cổ đông nhận';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.ToObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã cổ đông nhận';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.ToObjectID_Search', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SL trước khi chuyển';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.BeforeToQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SL sau khi chuyển';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.AfterToQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phí giao dịch';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.TransferFree', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.TotalQuantityTransfered', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.TotalAmountTransfered', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên cổ đông chuyển';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.FromObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên cổ đông nhận';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.ToObjectName_Search', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.ShareTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên cổ đông nhận';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.ToObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.IsTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh sách chuyển nhượng cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.ShareTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.ShareTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.ShareTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng chuyển nhượng';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.QuantityTransfered', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị chuyển nhượng';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.AmountTransfered', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chuyển nhượng cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết chuyển nhượng cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.Detail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.History', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.ObjectID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.ObjectName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã cổ đông chuyển';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2030.FromObjectIDSearch', @FormID, @LanguageValue, @Language;
