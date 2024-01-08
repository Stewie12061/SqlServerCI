DECLARE @ScreenID NVARCHAR(MAX)
DECLARE @ColumnName NVARCHAR(MAX)
DECLARE @IDLanguage NVARCHAR(MAX)
DECLARE @ModuleID VARCHAR(10)
DECLARE @KeyID VARCHAR(100)
DECLARE @FormID VARCHAR(200)
DECLARE @Text NVARCHAR(4000)
DECLARE @Language VARCHAR(10)
DECLARE @CustomName NVARCHAR(4000)

SET @ScreenID = N'QCF2009'

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2009.InventoryID'
SET @FormID = N'QCF2009_QCT2001'
SET @Text = N'Mã mặt hàng'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2009.InventoryName'
SET @FormID = N'QCF2009_QCT2001'
SET @Text = N'Tên mặt hàng'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2009.UnitID'
SET @FormID = N'QCF2009_QCT2001'
SET @Text = N'Đơn vị tính'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2009.QuantityQC'
SET @FormID = N'QCF2009_QCT2001'
SET @Text = N'Số lượng đạt'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2009.QuantityUnQC'
SET @FormID = N'QCF2009_QCT2001'
SET @Text = N'Số lượng không đạt'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2009.PONumber'
SET @FormID = N'QCF2009_QCT2001'
SET @Text = N'Số PO'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;