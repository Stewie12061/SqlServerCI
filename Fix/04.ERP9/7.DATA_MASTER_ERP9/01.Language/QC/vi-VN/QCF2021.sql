-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2021 
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
SET @FormID = 'QCF2021';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.VoucherType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày lập';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.ShiftVoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ca sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Máy sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân xưởng';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xóa';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã CA';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.ShiftID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CA';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.ShiftName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.DepartmentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.DepartmentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã máy';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.MachineID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên máy';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.MachineName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phiếu nhập đầu ca';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.RefAPKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu nhập đầu ca';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.APKMasterCB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phiếu chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.RefAPKDetail', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.APKDetailCB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên hàng';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.InventoryName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Số lô';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.SourceNo', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Số batch';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.BatchNo', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Nguyên nhân';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.Description', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã phương pháp xử lý';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.Method', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Phương pháp xử lý';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.MethodName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã chuyển';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.NewInventoryID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên chuyển';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.NewInventoryName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Số lượng mới';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.NewQuantity', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Batch chuyển';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.NewBatchID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã NVL tiêu hao';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.MaterialID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên NVL';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.MaterialName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Đơn vị tính mã NVL';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.MaterialUnitID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Số lượng tiêu hao';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.MaterialQuantity', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.Notes01', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Ghi chú 1';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.Notes02', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Ghi chú 2';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.Notes03', @FormID, @LanguageValue, @Language;


--Combo Detail
SET @LanguageValue = N'Số phiếu';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.ShiftVoucherNo.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Ngày lập phiếu';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.ShiftVoucherDate.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'CA';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.ShiftName.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên máy';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.MachineName.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Số lô';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.SourceNo.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Số batch';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.BatchNo.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.ID.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Diễn gải';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.Description.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.InventoryID.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên hàng';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.InventoryName.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.UnitID.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên phương pháp xử lý';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.MethodName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Danh sách xử lý lỗi thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'QCF2021.Title', @FormID, @LanguageValue, @Language;


