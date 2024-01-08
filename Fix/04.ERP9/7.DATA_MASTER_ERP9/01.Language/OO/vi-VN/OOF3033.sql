-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF3032- OO
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
SET @ModuleID = 'OO';
SET @FormID = 'OOF3033';

SET @LanguageValue = N'Báo cáo quản lý văn bản';
EXEC ERP9AddLanguage @ModuleID, 'OOF3033.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'ReportFilterOOF3033.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công văn';
EXEC ERP9AddLanguage @ModuleID, 'ReportFilterOOF3033.DocumentMode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại văn bản';
EXEC ERP9AddLanguage @ModuleID, 'ReportFilterOOF3033.DocumentTypeID', @FormID, @LanguageValue, @Language;
