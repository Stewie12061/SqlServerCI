-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2141- OO
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
SET @FormID = 'OOF2141';

SET @LanguageValue = N'Project cost norm declaration';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Levels';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.Levels', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quotation';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.QuotationID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost Group';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.CostGroup', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost Group Detail';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.CostGroupDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Money';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.Money', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ana DepartmentID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.AnaDepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost Group Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.CostGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost Group Detail Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.CostGroupDetailName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expenditure Group Code';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.CostGroupID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Spending Group Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.CostGroupName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Detailed Codes Of Spending Groups';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.CostGroupDetailID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Detailed Name Of Expenditure Group';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.CostGroupDetailName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quotation ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.QuotationNo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quotation Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual Money';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.ActualMoney', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ana Department Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.AnaDepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ana DepartmentID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.AnaDepartmentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ana Department Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2141.AnaDepartmentName.CB', @FormID, @LanguageValue, @Language;

