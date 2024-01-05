--delete  A00001 where FormID  =N'QCF2061'

-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2061 
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
SET @FormID = 'QCF2061';

DECLARE @KeyID VARCHAR(100)
DECLARE @Text NVARCHAR(4000)
DECLARE @CustomName NVARCHAR(4000)

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.Title'
SET @FormID = N'QCF2061'
SET @Text = N'Màn hình thống kê'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.DivisionID'
SET @FormID = N'QCF2061'
SET @Text = N'Đơn vị'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.FromDate'
SET @FormID = N'QCF2061'
SET @Text = N'Từ ngày'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.ToDate'
SET @FormID = N'QCF2061'
SET @Text = N'Đến ngày'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.ShiftID'
SET @FormID = N'QCF2061'
SET @Text = N'Ca'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.MachineID'
SET @FormID = N'QCF2061'
SET @Text = N'Máy'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.Status'
SET @FormID = N'QCF2061'
SET @Text = N'Trạng thái'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.InventoryID'
SET @FormID = N'QCF2061'
SET @Text = N'Hàng hóa'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.BatchNo'
SET @FormID = N'QCF2061'
SET @Text = N'Số Batch'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.StandardParent'
SET @FormID = N'QCF2061'
SET @Text = N'Loại tiêu chuẩn'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.Standard'
SET @FormID = N'QCF2061'
SET @Text = N'Tiêu chuẩn'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.TabQCT2071'
SET @FormID = N'QCF2061'
SET @Text = N'Quản lý chất lượng'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.TabQCT2072'
SET @FormID = N'QCF2061'
SET @Text = N'Thông số NVL'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.TabQCT2073'
SET @FormID = N'QCF2061'
SET @Text = N'Xử lý hàng lỗi'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.Date_Tab1'
SET @FormID = N'QCF2061'
SET @Text = N'Ngày'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.ShiftName_Tab1'
SET @FormID = N'QCF2061'
SET @Text = N'Ca'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.MachineName_Tab1'
SET @FormID = N'QCF2061'
SET @Text = N'Máy'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.InventoryID_Tab1'
SET @FormID = N'QCF2061'
SET @Text = N'Mã sản phẩm'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.InventoryName_Tab1'
SET @FormID = N'QCF2061'
SET @Text = N'Tên sản phẩm'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.BatchNo_Tab1'
SET @FormID = N'QCF2061'
SET @Text = N'Số Batch'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.UnitName_Tab1'
SET @FormID = N'QCF2061'
SET @Text = N'ĐVT'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.GrossWeight_Tab1'
SET @FormID = N'QCF2061'
SET @Text = N'KL cả bì'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.NetWeight_Tab1'
SET @FormID = N'QCF2061'
SET @Text = N'KL tịnh'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.Notes01_Tab1'
SET @FormID = N'QCF2061'
SET @Text = N'Ghi chú 01'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.Notes02_Tab1'
SET @FormID = N'QCF2061'
SET @Text = N'Ghi chú 02'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.Notes03_Tab1'
SET @FormID = N'QCF2061'
SET @Text = N'Ghi chú 03'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.Status_Tab1'
SET @FormID = N'QCF2061'
SET @Text = N'Tình trạng'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.Date_Tab2'
SET @FormID = N'QCF2061'
SET @Text = N'Ngày nhập thông số NVL'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.ShiftName_Tab2'
SET @FormID = N'QCF2061'
SET @Text = N'Ca'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.Time_Tab2'
SET @FormID = N'QCF2061'
SET @Text = N'Thời gian'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.MachineName_Tab2'
SET @FormID = N'QCF2061'
SET @Text = N'Máy'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.InventoryName_Tab2'
SET @FormID = N'QCF2061'
SET @Text = N'Mã sản phẩm'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.BatchNo_Tab2'
SET @FormID = N'QCF2061'
SET @Text = N'Số batch'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.MaterialID_Tab2'
SET @FormID = N'QCF2061'
SET @Text = N'Mã NVL'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.MaterialName_Tab2'
SET @FormID = N'QCF2061'
SET @Text = N'Tên NVL'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.BatchNo2050_Tab2'
SET @FormID = N'QCF2061'
SET @Text = N'Số batch NVL'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.UnitName_Tab2'
SET @FormID = N'QCF2061'
SET @Text = N'Đơn vị NVL'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.Time2050_Tab2'
SET @FormID = N'QCF2061'
SET @Text = N'Giờ nhập thông số NVL'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.Date_Tab3'
SET @FormID = N'QCF2061'
SET @Text = N'Ngày'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.InventoryName_Tab3'
SET @FormID = N'QCF2061'
SET @Text = N'Mã sản phẩm'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.BatchNo_Tab3'
SET @FormID = N'QCF2061'
SET @Text = N'Mã batch'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.Description_Tab3'
SET @FormID = N'QCF2061'
SET @Text = N'Nguyên nhân xử lý trước'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.Method_Tab3'
SET @FormID = N'QCF2061'
SET @Text = N'Phương pháp xử lý'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.NewInventoryName_Tab3'
SET @FormID = N'QCF2061'
SET @Text = N'Mã sản phẩm mới'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.NewBatchNo_Tab3'
SET @FormID = N'QCF2061'
SET @Text = N'Số Batch mới'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF2061.Notes_Tab3'
SET @FormID = N'QCF2061'
SET @Text = N'Kết luận sau xử lý'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

GO