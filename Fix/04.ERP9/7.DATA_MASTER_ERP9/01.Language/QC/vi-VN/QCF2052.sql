--delete  A00001 where FormID  =N'QCF2052'

-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2052 
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
SET @FormID = 'QCF2052';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.VoucherType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.VoucherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày lập';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân xưởng';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân xưởng';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ca sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Máy sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu đầu ca';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.QCT2000VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.QCT2000VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số batch';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.BatchID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xóa';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.LastModifyDate', @FormID, @LanguageValue, @Language;

EXEC ERP9AddLanguage @ModuleID, 'QCF2052.NodeTypeName', @FormID, N'Loại đối tượng' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.NodeID', @FormID, N'Mã đối tượng' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.NodeName', @FormID, N'Tên đối tượng' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.Description', @FormID, N'Ghi chú' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.QCT2001Description', @FormID, N'Ghi chú NVL' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.UnitID', @FormID, N'Đơn vị tính' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.StandardValue', @FormID, N'Giá trị' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.Info', @FormID, N'Thông tin phiếu nhập nguyên vật liệu' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.Detail', @FormID, N'Thông tin chi tiết' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.Title', @FormID, N'Chi tiết phiếu nguyên vật liệu' , @Language;

