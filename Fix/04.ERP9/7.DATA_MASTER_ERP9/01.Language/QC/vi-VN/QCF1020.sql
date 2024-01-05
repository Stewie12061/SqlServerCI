
DECLARE @ModuleID VARCHAR(10)
DECLARE @KeyID VARCHAR(100)
DECLARE @FormID VARCHAR(200)
DECLARE @Text NVARCHAR(4000)
DECLARE @Language VARCHAR(10)
DECLARE @CustomName NVARCHAR(4000)

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1020.Title'
SET @FormID = N'QCF1020'
SET @Text = N'Danh mục định nghĩa tiêu chuẩn'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'00'
SET @KeyID = N'A00.ItemQC_List_QCF1020'
SET @FormID = N'A00'
SET @Text = N'Định nghĩa tiêu chuẩn'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1020.APK'
SET @FormID = N'QCF1020'
SET @Text = N''
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1020.DivisionID'
SET @FormID = N'QCF1020'
SET @Text = N'Đơn vị'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1020.InventoryID'
SET @FormID = N'QCF1020'
SET @Text = N'Mã mặt hàng'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1020.Notes'
SET @FormID = N'QCF1020'
SET @Text = N'Ghi chú'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1020.Notes01'
SET @FormID = N'QCF1020'
SET @Text = N'Ghi chú 01'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1020.Notes02'
SET @FormID = N'QCF1020'
SET @Text = N'Mark'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1020.Notes03'
SET @FormID = N'QCF1020'
SET @Text = N'RevNo'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1020.Disabled'
SET @FormID = N'QCF1020'
SET @Text = N'Không hiển thị'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1020.IsCommon'
SET @FormID = N'QCF1020'
SET @Text = N'Dùng chung'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1020.CreateDate'
SET @FormID = N'QCF1020'
SET @Text = N'Ngày tạo'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1020.CreateUserID'
SET @FormID = N'QCF1020'
SET @Text = N'Người tạo'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1020.LastModifyUserID'
SET @FormID = N'QCF1020'
SET @Text = N'Người sửa'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1020.LastModifyDate'
SET @FormID = N'QCF1020'
SET @Text = N'Ngày sửa'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1020.InventoryIDSearch'
SET @FormID = N'QCF1020'
SET @Text = N'Mặt hàng'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1020.InventoryID.CB'
SET @FormID = N'QCF1020'
SET @Text = N'Mã mặt hàng'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1020.InventoryName.CB'
SET @FormID = N'QCF1020'
SET @Text = N'Tên mặt hàng'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1020.Title'
SET @FormID = N'QCF1020'
SET @Text = N'Định nghĩa tiêu chuẩn'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'00'
SET @KeyID = N'A00.ItemQC_List_QCF1020'
SET @FormID = N'A00'
SET @Text = N'Định nghĩa tiêu chuẩn'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1020.APK'
SET @FormID = N'QCF1020'
SET @Text = N''
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1020.DivisionID'
SET @FormID = N'QCF1020'
SET @Text = N'Division'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1020.InventoryID'
SET @FormID = N'QCF1020'
SET @Text = N'Inventory ID'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1020.Notes'
SET @FormID = N'QCF1020'
SET @Text = N'Notes'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1020.Notes01'
SET @FormID = N'QCF1020'
SET @Text = N'Notes 01'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1020.Notes02'
SET @FormID = N'QCF1020'
SET @Text = N'Notes 02'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1020.Notes03'
SET @FormID = N'QCF1020'
SET @Text = N'Notes 03'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1020.Disabled'
SET @FormID = N'QCF1020'
SET @Text = N'Disabled'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1020.IsCommon'
SET @FormID = N'QCF1020'
SET @Text = N'IsCommon'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1020.CreateDate'
SET @FormID = N'QCF1020'
SET @Text = N''
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1020.CreateUserID'
SET @FormID = N'QCF1020'
SET @Text = N''
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1020.LastModifyUserID'
SET @FormID = N'QCF1020'
SET @Text = N''
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1020.LastModifyDate'
SET @FormID = N'QCF1020'
SET @Text = N''
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1020.InventoryName'
SET @FormID = N'QCF1020'
SET @Text = N'Tên mặt hàng'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

