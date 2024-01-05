------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF1013 - S
-----------------------------------------------------------------------------------------------------
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
SET @ModuleID = 'S';
SET @FormID = 'SF1011';

----------------------------- 20/08/2020 - Modified by Tấn Thành--------------------------------------
SET @LanguageValue = N'Group user';
EXEC ERP9AddLanguage @ModuleID, 'SF1011.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Group ID';
EXEC ERP9AddLanguage @ModuleID, 'SF1011.GroupID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Group name';
EXEC ERP9AddLanguage @ModuleID, 'SF1011.GroupName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Role Default';
EXEC ERP9AddLanguage @ModuleID, 'SF1011.RoleDefaultID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SF1011.ParentRoleID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'SF1011.ParentRoleName.CB' , @FormID, @LanguageValue, @Language;