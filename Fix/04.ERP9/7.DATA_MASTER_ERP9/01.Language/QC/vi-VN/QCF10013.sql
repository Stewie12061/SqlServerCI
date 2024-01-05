
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF10006
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
DECLARE @KeyID VARCHAR(100)
DECLARE @Text NVARCHAR(4000)
DECLARE @CustomName NVARCHAR(4000)

SET @FormID = N'QCF10013'
SET @Language = N'vi-VN'
SET @ModuleID = N'QC'

SET @LanguageValue = N'Chọn mặt hàng in tem';
 EXEC ERP9AddLanguage @ModuleID, 'QCF10013.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
 EXEC ERP9AddLanguage @ModuleID, 'QCF10013.APK' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
 EXEC ERP9AddLanguage @ModuleID, 'QCF10013.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'QCF10013.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số batch - Mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'QCF10013.BatchInventory' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'QCF10013.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu';
 EXEC ERP9AddLanguage @ModuleID, 'QCF10013.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày';
 EXEC ERP9AddLanguage @ModuleID, 'QCF10013.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ca';
 EXEC ERP9AddLanguage @ModuleID, 'QCF10013.ShiftName' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Máy';
 EXEC ERP9AddLanguage @ModuleID, 'QCF10013.MachineName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số batch';
 EXEC ERP9AddLanguage @ModuleID, 'QCF10013.BatchNo' , @FormID, @LanguageValue, @Language;

GO