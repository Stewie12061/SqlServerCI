DECLARE @ScreenID NVARCHAR(MAX)
DECLARE @ColumnName NVARCHAR(MAX)
DECLARE @IDLanguage NVARCHAR(MAX)
DECLARE @ModuleID VARCHAR(10)
DECLARE @KeyID VARCHAR(100)
DECLARE @FormID VARCHAR(200)
DECLARE @Text NVARCHAR(4000)
DECLARE @Language VARCHAR(10)
DECLARE @CustomName NVARCHAR(4000)

SET @ScreenID = N'QCF10009'

SET @ModuleID = N'QC'
SET @KeyID = N'QCF10009.Title'
SET @FormID = N'QCF10009'
SET @Text = N'Chọn phiếu nhập đầu ca'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF10009.APK'
SET @FormID = N'QCF10009'
SET @Text = N''
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF10009.DivisionID'
SET @FormID = N'QCF10009'
SET @Text = N'Đơn vị'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF10009.VoucherNo'
SET @FormID = N'QCF10009'
SET @Text = N'Số phiếu'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF10009.VoucherDate'
SET @FormID = N'QCF10009'
SET @Text = N'Ngày lập phiếu'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF10009.ShiftID'
SET @FormID = N'QCF10009'
SET @Text = N'Ca làm việc'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF10009.ShiftName'
SET @FormID = N'QCF10009'
SET @Text = N'Ca làm việc'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF10009.MachineID'
SET @FormID = N'QCF10009'
SET @Text = N'Mã máy'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF10009.MachineName'
SET @FormID = N'QCF10009'
SET @Text = N'Máy'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF10009.DepartmentID'
SET @FormID = N'QCF10009'
SET @Text = N'Phân xưởng'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF10009.DepartmentName'
SET @FormID = N'QCF10009'
SET @Text = N'Phân xưởng'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF10009.Employee01'
SET @FormID = N'QCF10009'
SET @Text = N'Trưởng máy'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF10009.Employee02'
SET @FormID = N'QCF10009'
SET @Text = N'Nhân viên QC'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF10009.Employee03'
SET @FormID = N'QCF10009'
SET @Text = N'Thợ máy'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF10009.Employee04'
SET @FormID = N'QCF10009'
SET @Text = N'Phụ kho'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF10009.Employee05'
SET @FormID = N'QCF10009'
SET @Text = N'Công nhân đóng gói'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF10009.Employee06'
SET @FormID = N'QCF10009'
SET @Text = N'Giám sát sản xuất'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF10009.Description'
SET @FormID = N'QCF10009'
SET @Text = N'Diễn giải'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF10009.InventoryID'
SET @FormID = N'QCF10009'
SET @Text = N'Mã mặt hàng'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF10009.InventoryName'
SET @FormID = N'QCF10009'
SET @Text = N'Tên mặt hàng'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF10009.BatchNo'
SET @FormID = N'QCF10009'
SET @Text = N'Số batch'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;
