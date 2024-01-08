-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1521- CI
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF1521';

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Promotional code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.PromoteID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Since';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.OID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Promotion name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.PromoteName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Do not use the accumulated discount wallet';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.IsDiscountWallet', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.IsEnd', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Browsing status';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.StatusSS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approved comments';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approver level';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approver level';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Legacy price list code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.InheritID', @FormID, @LanguageValue, @Language;

