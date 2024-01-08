-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CSMF2004- CSM
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
SET @ModuleID = 'CSM';
SET @FormID = 'CSMF2004';

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2004.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2004.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SoldTo';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2004.SoldTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ShipTo';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2004.ShipTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn dữ liệu';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2004.Title', @FormID, @LanguageValue, @Language;

