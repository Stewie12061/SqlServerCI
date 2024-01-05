DECLARE @ScreenID NVARCHAR(MAX)
DECLARE @ColumnName NVARCHAR(MAX)
DECLARE @IDLanguage NVARCHAR(MAX)
DECLARE @ModuleID VARCHAR(10)
DECLARE @KeyID VARCHAR(100)
DECLARE @FormID VARCHAR(200)
DECLARE @Text NVARCHAR(4000)
DECLARE @Language VARCHAR(10)
DECLARE @CustomName NVARCHAR(4000)

SET @ScreenID = N'QCF2011'


SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.Title'
SET @FormID = N'QCF2011'
SET @Text = N'Ghi nhận số lượng thành phẩm'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.APK'
SET @FormID = N'QCF2011'
SET @Text = N''
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.DivisionID'
SET @FormID = N'QCF2011'
SET @Text = N'Đơn vị'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.VoucherTypeID'
SET @FormID = N'QCF2011'
SET @Text = N'Loại chứng từ'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.Voucher_QCT2000'
SET @FormID = N'QCF2011'
SET @Text = N'Phiếu nhập đầu ca'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.VoucherNo'
SET @FormID = N'QCF2011'
SET @Text = N'Số chứng từ'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.VoucherDate'
SET @FormID = N'QCF2011'
SET @Text = N'Ngày chứng từ'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.TranMonth'
SET @FormID = N'QCF2011'
SET @Text = N'Tháng chứng từ'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.TranYear'
SET @FormID = N'QCF2011'
SET @Text = N'Năm chứng từ'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.ManufacturingDate'
SET @FormID = N'QCF2011'
SET @Text = N'Ngày sản xuất'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.ShiftID'
SET @FormID = N'QCF2011'
SET @Text = N'Ca sản xuất'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.ShiftName'
SET @FormID = N'QCF2011'
SET @Text = N'Ca sản xuất'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.MachineID'
SET @FormID = N'QCF2011'
SET @Text = N'Máy sản xuất'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.MachineName'
SET @FormID = N'QCF2011'
SET @Text = N'Máy sản xuất'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.DepartmentID'
SET @FormID = N'QCF2011'
SET @Text = N'Phân xưởng'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.DepartmentName'
SET @FormID = N'QCF2011'
SET @Text = N'Phân xưởng'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.Notes'
SET @FormID = N'QCF2011'
SET @Text = N'Ghi chú'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.GrossWeight'
SET @FormID = N'QCF2011'
SET @Text = N'Khối lượng cả bì'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.NetWeight'
SET @FormID = N'QCF2011'
SET @Text = N'Khối lượng tịnh'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.VoucherTypeID.CB'
SET @FormID = N'QCF2011'
SET @Text = N'Mã số'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.VoucherTypeName.CB'
SET @FormID = N'QCF2011'
SET @Text = N'Tên'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.ShiftID.CB'
SET @FormID = N'QCF2011'
SET @Text = N'Mã số'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.ShiftName.CB'
SET @FormID = N'QCF2011'
SET @Text = N'Tên'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.MachineID.CB'
SET @FormID = N'QCF2011'
SET @Text = N'Mã số'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.MachineName.CB'
SET @FormID = N'QCF2011'
SET @Text = N'Tên'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.VoucherNo.CB'
SET @FormID = N'QCF2011'
SET @Text = N'Mã phiếu'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.VoucherDate.CB'
SET @FormID = N'QCF2011'
SET @Text = N'Ngày'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.InventoryID.CB'
SET @FormID = N'QCF2011'
SET @Text = N'Mã hàng'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.InventoryName.CB'
SET @FormID = N'QCF2011'
SET @Text = N'Tên hàng'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.BatchNo.CB'
SET @FormID = N'QCF2011'
SET @Text = N'Số batch'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.DeleteFlg'
SET @FormID = N'QCF2011'
SET @Text = N''
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.CreateDate'
SET @FormID = N'QCF2011'
SET @Text = N'Ngày tạo'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.CreateUserID'
SET @FormID = N'QCF2011'
SET @Text = N'Người tạo'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.LastModifyUserID'
SET @FormID = N'QCF2011'
SET @Text = N'Người sửa'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.LastModifyDate'
SET @FormID = N'QCF2011'
SET @Text = N'Ngày sửa'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.InventoryID'
SET @FormID = N'QCF2011'
SET @Text = N'Mã thành phẩm'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.InventoryName'
SET @FormID = N'QCF2011'
SET @Text = N'Tên thành phẩm'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.BatchNo'
SET @FormID = N'QCF2011'
SET @Text = N'Số Batch'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.Machine'
SET @FormID = N'QCF2011'
SET @Text = N'Máy'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.AutoScale'
SET @FormID = N'QCF2011'
SET @Text = N'Cân tự động'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.Choose'
SET @FormID = N'QCF2011'
SET @Text = N'Chọn'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.OtherUnitID'
SET @FormID = N'QCF2011'
SET @Text = N'ĐVT khác'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2011.OtherQuantity'
SET @FormID = N'QCF2011'
SET @Text = N'SL ĐVT khác'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

