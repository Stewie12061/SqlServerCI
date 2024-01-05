-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2100- OO
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
SET @FormID = 'OOF2100';

SET @LanguageValue = N'List of projects/task groups';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.ProjectType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project sample';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.ProjectSampleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Checking date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.CheckingDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Leader';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.LeaderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.ContractID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Related type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.FromDateToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Leader';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.LeaderName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.ContractName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.ProjectDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.OpportunityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mark';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.Mark', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes by assessor ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reject';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.Reject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount Factor KHCU';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.DiscountFactorKHCU', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount Factor NC';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.DiscountFactorNC', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount Factor KHCU service';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.DiscountFactorKHCUService', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.DivisionID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division name';						 
EXEC ERP9AddLanguage @ModuleID, 'OOF2100.DivisionName.CB', @FormID, @LanguageValue, @Language;
