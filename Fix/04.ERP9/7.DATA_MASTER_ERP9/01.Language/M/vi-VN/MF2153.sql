-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2153- M
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
SET @ModuleID = 'M';
SET @FormID = 'MF2153';

SET @LanguageValue = N'Chọn Bom Version';
EXEC ERP9AddLanguage @ModuleID, 'MF2153.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2153.NodeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2153.NodeName ', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Version';
EXEC ERP9AddLanguage @ModuleID, 'MF2153.Version', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2153.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2153.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'MF2153.Description', @FormID, @LanguageValue, @Language;
