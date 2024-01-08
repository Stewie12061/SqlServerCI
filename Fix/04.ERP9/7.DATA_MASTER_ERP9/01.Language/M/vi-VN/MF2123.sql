-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2123- M
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
SET @FormID = 'MF2123';

SET @LanguageValue = N'Chọn cấu trúc sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2123.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại cấu trúc';
EXEC ERP9AddLanguage @ModuleID, 'MF2123.NodeTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã cấu trúc';
EXEC ERP9AddLanguage @ModuleID, 'MF2123.NodeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên cấu trúc';
EXEC ERP9AddLanguage @ModuleID, 'MF2123.NodeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'MF2123.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'MF2123.DisplayMember', @FormID, @LanguageValue, @Language;

