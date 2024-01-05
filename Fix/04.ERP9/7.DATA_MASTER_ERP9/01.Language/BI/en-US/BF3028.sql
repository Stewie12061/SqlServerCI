
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BF3028- OO
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
SET @FormID = 'BF3028';

SET @LanguageValue = N'Branch expense comparison report for multiple periods';
EXEC ERP9AddLanguage @ModuleID, 'BF3028.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report ID';
EXEC ERP9AddLanguage @ModuleID, 'BF3028.ReportID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report Name';
EXEC ERP9AddLanguage @ModuleID, 'BF3028.ReportName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'BF3028.ReportTitle' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'BF3028.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report';
EXEC ERP9AddLanguage @ModuleID, 'BF3028.GroupTitle1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Filtering criteria';
EXEC ERP9AddLanguage @ModuleID, 'BF3028.GroupTitle2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From Value';
EXEC ERP9AddLanguage @ModuleID, 'BF3028.FromValue' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To Value';
EXEC ERP9AddLanguage @ModuleID, 'BF3028.ToValue' , @FormID, @LanguageValue, @Language;

