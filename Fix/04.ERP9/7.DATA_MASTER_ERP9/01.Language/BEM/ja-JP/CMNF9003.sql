-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CMNF9003- BEM
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
SET @FormID = 'CMNF9003';

SET @LanguageValue = N'住所';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9003.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署コード';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9003.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部署名';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9003.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'メールアドレス';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9003.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'従業員コード';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9003.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'従業員名前';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9003.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電話番号';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9003.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'従業員選択';
EXEC ERP9AddLanguage @ModuleID, 'CMNF9003.Title', @FormID, @LanguageValue, @Language;
