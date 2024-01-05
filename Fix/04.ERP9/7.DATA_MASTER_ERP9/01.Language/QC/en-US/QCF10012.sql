
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

SET @FormID = N'QCF10012'
SET @Language = N'en-US'
SET @ModuleID = N'QC'

SET @LanguageValue = N'Chọn mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'QCF10012.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
 EXEC ERP9AddLanguage @ModuleID, 'QCF10012.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'QCF10012.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị tính';
 EXEC ERP9AddLanguage @ModuleID, 'QCF10012.UnitID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'QCF10012.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đơn vị tính';
 EXEC ERP9AddLanguage @ModuleID, 'QCF10012.UnitName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
 EXEC ERP9AddLanguage @ModuleID, 'QCF10012.Disabled' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
 EXEC ERP9AddLanguage @ModuleID, 'QCF10012.IsCommon' , @FormID, @LanguageValue, @Language;

GO