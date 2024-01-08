-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2111- M
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
SET @FormID = 'MF2111';

SET @LanguageValue = N'Cập nhật cấu trúc sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2111.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại cấu trúc';
EXEC ERP9AddLanguage @ModuleID, 'MF2111.NodeTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã cấu trúc';
EXEC ERP9AddLanguage @ModuleID, 'MF2111.NodeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên cấu trúc';
EXEC ERP9AddLanguage @ModuleID, 'MF2111.NodeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'MF2111.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quy cách';
EXEC ERP9AddLanguage @ModuleID, 'MF2111.StandardID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quy cách';
EXEC ERP9AddLanguage @ModuleID, 'MF2111.StandardName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'MF2111.DisplayMember', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Đặc tính kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'MF2111.Specification', @FormID, @LanguageValue, @Language;