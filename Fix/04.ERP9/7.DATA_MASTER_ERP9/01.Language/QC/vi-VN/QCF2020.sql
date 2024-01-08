-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2020 
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
SET @FormID = 'QCF2020';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.VoucherType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày lập';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ca sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Máy sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân xưởng';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xóa';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh sách xử lý lỗi thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã số';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.MachineID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.MachineName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã số';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.ShiftID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.ShiftName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã số';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.DepartmentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'QCF2020.DepartmentName.CB', @FormID, @LanguageValue, @Language;
