-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF0000- QC
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
SET @Language = 'en-US' 
SET @ModuleID = 'QC';
SET @FormID = 'QCF0000';

SET @LanguageValue  = N'System Settings'
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Code'
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Name'
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type CT Quality slip at the beginning of shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.VoucherFirstShift', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type CT Quantity recording slip';
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.VoucherQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CT type Operating parameters';
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.VoucherOperateParam', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type CT Specifications';
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.VoucherTechniqueParam', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type CT Material tracking';
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.VoucherMaterial', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type CT Handling defective goods';
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.VoucherDefective', @FormID, @LanguageValue, @Language;

