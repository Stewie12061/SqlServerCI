-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2000- EDM
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
SET @ModuleID = 'EDM';
SET @FormID = 'EDMF2000';

SET @LanguageValue = N'Key';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.DivisionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'School';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.SchoolID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'School';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.SchoolName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parent code';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.ParentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parent name';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.ParentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.Telephone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Student name';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Birthday';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.StudentDateBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sex';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.Sex', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Result';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.ResultID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.DateFrom', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.DateTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Information';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.Information', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Consulting information voucher';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2000.Title' , @FormID, @LanguageValue, @Language;

