-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF3032- OO
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
SET @ModuleID = 'OO';
SET @FormID = 'OOF3032';

SET @LanguageValue = N'Detailed task report by employee';
EXEC ERP9AddLanguage @ModuleID, 'OOF3032.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF3032.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'OOF3032.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ToDate';
EXEC ERP9AddLanguage @ModuleID, 'OOF3032.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'FromDate';
EXEC ERP9AddLanguage @ModuleID, 'OOF3032.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF3032.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division code';
EXEC ERP9AddLanguage @ModuleID, 'OOF3032.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print Data';
EXEC ERP9AddLanguage @ModuleID, 'OOF3032.PrintData', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Problem Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF3032.StatusIS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Support request status';
EXEC ERP9AddLanguage @ModuleID, 'OOF3032.StatusHD', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Milestone Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF3032.StatusMT', @FormID, @LanguageValue, @Language;

