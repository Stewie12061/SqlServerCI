-----------------------------------------------------------------------------------------------------
-- Script tạo message - S
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(5),
@FormID VARCHAR(50),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),
@LanguageCustomValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT

/*
 - Tieng Viet: en-US 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'en-US'; 
SET @ModuleID = 'S';
SET @FormID = 'SF1051';

--------------------------------- Modified by Tấn Thành on 29/08/2020 ---------------------------------------
--SET @LanguageValue = N'Update Role';
SET @LanguageValue = N'Update Data Permission Setting';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF1051.Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;
-------------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Role ID';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF1051.RoleID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Role name';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF1051.RoleName' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Role parent';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF1051.ParentRoleID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Default permission';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF1051.IsDefualtRoleID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Role';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF1051.Role' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Data permission';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF1051.DataRole' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Data type';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF1051.DataID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Read permission';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF1051.TypeID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Fill Role';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF1051.FillRoleType' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'ID';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF1051.FillRoleType.CB' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Permission Type';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF1051.FillRoleName.CB' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'ID';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF1051.ParentRoleID.CB' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Role Name';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF1051.ParentRoleName.CB' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Module';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF1051.ModuleID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;
