
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2051 
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
SET @ModuleID = 'QC';
SET @FormID = 'QCF2051';

SET @LanguageValue = N'Thông tin chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.TabQCT20101', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.VoucherType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.VoucherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày lập';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.ManufacturingDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ca sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Máy sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân xưởng';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân xưởng';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu đầu ca';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.Voucher_QCT2000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xóa';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.ShiftVoucherNo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày lập';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.ShiftVoucherDate.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã CA';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.ShiftID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên CA';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.ShiftName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã máy';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.MachineID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên máy';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.MachineName.CB', @FormID, @LanguageValue, @Language;

-- QCT20101 -----------------------------

SET @LanguageValue = N'Mã phiếu nhập đầu CA';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.APKShift', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.APKInventory', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã phiếu';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.APKMaster', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Số phiếu nhập đầu ca';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.ShiftVoucherID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Ngày sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.ShiftVoucherDate', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.InventoryID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên hàng hóa';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.InventoryName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Số lô';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.SourceNo', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Số batch';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.BatchNo', @FormID, @LanguageValue, @Language;

EXEC ERP9AddLanguage @ModuleID, 'QCF2051.MaterialID', @FormID, N'Mã NVL' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.MaterialName', @FormID, N'Tên NVL' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.Description', @FormID, N'Ghi chú' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.QCT2001Description', @FormID, N'Ghi chú NVL' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.BatchID', @FormID, N'Số bacth' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.MaterialID.CB', @FormID, N'Mã NVL' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.MaterialName.CB', @FormID, N'Tên NVL' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.InventoryID.CB', @FormID, N'Mã mặt hàng' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.InventoryName.CB', @FormID, N'Tên mặt hàng' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.BatchNo.CB', @FormID, N'Số bacth' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.SourceNo.CB', @FormID, N'Số lô' , @Language;

SET @LanguageValue = N'Trưởng máy';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.FullName01.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'NV QC';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.FullName02.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Thợ máy';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.FullName03.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Phụ kho';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.FullName04.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Đóng gói';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.FullName05.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Giám sát sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.FullName06.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu nguyên vật liệu chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.Title', @FormID, @LanguageValue, @Language;

