-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2022 
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
SET @FormID = 'QCF2022';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.VoucherType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày lập';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.ShiftVoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu đầu CA';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Máy';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân xưởng';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xóa';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã CA';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.ShiftID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CA';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.ShiftName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã máy';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.MachineID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên máy';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.MachineName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phiếu nhập đầu ca';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.RefAPKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu nhập đầu ca';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.APKMasterCB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phiếu chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.RefAPKDetail', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.APKDetailCB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên hàng';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.InventoryName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Số lô';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.SourceNo', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Số batch';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.BatchNo', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Nguyên nhân';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.Description', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã phương pháp xử lý';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.Method', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên phương pháp xử lý';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.MethodName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã chuyển';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.NewInventoryID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên chuyển';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.NewInventoryName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Batch chuyển';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.NewBatchID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã NVL tiêu hao';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.MaterialID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Số lượng mới';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.NewQuantity', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên NVL';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.MaterialName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Đơn vị tính mã NVL';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.MaterialUnitID', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Số lượng tiêu hao';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.MaterialQuantity', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.Notes01', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Ghi chú 1';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.Notes02', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Ghi chú 2';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.Notes03', @FormID, @LanguageValue, @Language;


--Combo Detail
SET @LanguageValue = N'Số phiếu';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.ShiftVoucherNo.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Ngày lập phiếu';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.ShiftVoucherDate.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'CA';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.ShiftName.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên máy';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.MachineName.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Số lô';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.SourceNo.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Số batch';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.BatchNo.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.ID.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Diễn gải';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.Description.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.InventoryID.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên hàng';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.InventoryName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.UnitID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin phiếu xử lý hàng lỗi';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.Detail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh sách xử lý lỗi thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương thức xử lý';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.MethodName', @FormID, @LanguageValue, @Language;