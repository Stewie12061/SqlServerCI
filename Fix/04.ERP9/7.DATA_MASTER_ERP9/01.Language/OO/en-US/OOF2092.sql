-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2092- OO
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
SET @FormID = 'OOF2092';

SET @LanguageValue = N'Inform name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.InformName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notification Details';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.InformID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Effective Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.EffectDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inform Type';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.InformType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.InformDivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Epiry Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.ExpiryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.IsExpiryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Information details';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.XemChiTietThongBao', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Information content';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.NoiDungThongBao', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2092.Description', @FormID, @LanguageValue, @Language;
