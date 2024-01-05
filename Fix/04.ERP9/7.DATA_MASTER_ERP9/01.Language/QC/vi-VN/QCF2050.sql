
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2050 
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
SET @FormID = 'QCF2050';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.VoucherType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.VoucherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày lập';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ca sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Máy sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân xưởng';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân xưởng';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xóa';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.ShiftVoucherNo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày lập';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.ShiftVoucherDate.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.ShiftID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CA';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.ShiftName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.MachineID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Máy';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.MachineName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.DepartmentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân xưởng';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.DepartmentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trưởng máy';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.FullName01.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'NV QC';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.FullName02.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thợ máy';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.FullName03.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ kho';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.FullName04.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đóng gói';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.FullName05.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giám sát sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.FullName06.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh sách phiếu nguyên vật liệu';
EXEC ERP9AddLanguage @ModuleID, 'QCF2050.Title', @FormID, @LanguageValue, @Language;

