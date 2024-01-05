
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ ReportView- OO
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
SET @Language = 'ja-JP' 
SET @ModuleID = 'BEM';
SET @FormID = 'ReportView';

SET @LanguageValue = N'国籍コード';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.CountryID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'国籍名';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.CountryName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部コード';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.DepartmentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部名';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.DepartmentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'種類コード';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.ProposalTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'種類名';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.ProposalTypeName.CB', @FormID, @LanguageValue, @Language;
