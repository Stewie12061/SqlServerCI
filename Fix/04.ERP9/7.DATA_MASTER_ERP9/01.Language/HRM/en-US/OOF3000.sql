
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF3000- OO
-- [Đình Hòa] [26/02/2021] - Bổ sung ngôn ngữ
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
SET @ModuleID = 'HRM';
SET @FormID = 'OOF3000';

SET @LanguageValue = N'Report';
EXEC ERP9AddLanguage @ModuleID, 'OOF3000.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Human Resource Management';
EXEC ERP9AddLanguage @ModuleID, 'AsoftOO.GRP_QuanLyNhanSu' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Commission Management';
EXEC ERP9AddLanguage @ModuleID, 'AsoftOO.GRP_QuanTriNhanSu' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Training';
EXEC ERP9AddLanguage @ModuleID, 'AsoftOO.GRP_Training' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruiting';
EXEC ERP9AddLanguage @ModuleID, 'AsoftOO.GRP_Recruiting' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluate';
EXEC ERP9AddLanguage @ModuleID, 'AsoftHRM.GRP_BaoCaoKPI' , @FormID, @LanguageValue, @Language;