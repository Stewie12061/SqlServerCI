-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2002- EDM
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
SET @FormID = 'EDMF2002';

SET @LanguageValue = N'Key';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.DivisionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'School';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.SchoolID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'School';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.SchoolName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parent code';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.ParentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Parent name';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.ParentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.Telephone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Student name';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Birthday';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.StudentDateBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sex';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.Sex', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sex';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.SexName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Result';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.ResultID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.DateFrom', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.DateTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Information';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.Information', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.LastModifyDate', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Consulting information';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.Lich_su', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'View consulting information';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'View Consulting information voucher';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.Title' , @FormID, @LanguageValue, @Language;

