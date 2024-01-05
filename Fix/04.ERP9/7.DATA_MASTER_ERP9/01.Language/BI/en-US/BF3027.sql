
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BF3027- OO
-- [Đình Hòa] [26/02/2021] - Bổ sung ngôn ngữ
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
SET @ModuleID = 'BI';
SET @FormID = 'BF3027';

SET @LanguageValue = N'Branch profit and loss report for multiple periods';
EXEC ERP9AddLanguage @ModuleID, 'BF3027.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report ID';
EXEC ERP9AddLanguage @ModuleID, 'BF3027.ReportID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report Name';
EXEC ERP9AddLanguage @ModuleID, 'BF3027.ReportName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'BF3027.ReportTitle' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'BF3027.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report';
EXEC ERP9AddLanguage @ModuleID, 'BF3027.GroupTitle1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Filtering criteria';
EXEC ERP9AddLanguage @ModuleID, 'BF3027.GroupTitle2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From Value';
EXEC ERP9AddLanguage @ModuleID, 'BF3027.FromValue' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To Value';
EXEC ERP9AddLanguage @ModuleID, 'BF3027.ToValue' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ReportID';
EXEC ERP9AddLanguage @ModuleID, 'BF3027.ReportBF3027' , @FormID, @LanguageValue, @Language;