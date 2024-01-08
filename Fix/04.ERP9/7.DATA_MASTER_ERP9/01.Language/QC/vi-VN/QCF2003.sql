DECLARE @ScreenID NVARCHAR(MAX)
DECLARE @ColumnName NVARCHAR(MAX)
DECLARE @IDLanguage NVARCHAR(MAX)
DECLARE @ModuleID VARCHAR(10)
DECLARE @KeyID VARCHAR(100)
DECLARE @FormID VARCHAR(200)
DECLARE @Text NVARCHAR(4000)
DECLARE @Language VARCHAR(10)
DECLARE @CustomName NVARCHAR(4000)

SET @ScreenID = N'QCF2003'

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2003.Title'
SET @FormID = N'QCF2003'
SET @Text = N'Chọn Mẫu in'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2003.IsPrint'
SET @FormID = N'QCF2003'
SET @Text = N'Mẫu in'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2003.IsPrint.CB'
SET @FormID = N'QCF2003'
SET @Text = N'Mã mẫu in'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2003.Description.CB'
SET @FormID = N'QCF2003'
SET @Text = N'Tên mẫu in'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;


SET @ModuleID = N'QC'
SET @KeyID = N'QCF2003.InventoryID'
SET @FormID = N'QCF2003'
SET @Text = N'Mặt hàng'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2003.InventoryID.CB'
SET @FormID = N'QCF2003'
SET @Text = N'Mã'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2003.InventoryName.CB'
SET @FormID = N'QCF2003'
SET @Text = N'Tên'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;
