-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF30001- OO
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
SET @Language = 'vi-VN' 
SET @ModuleID = 'OO';
SET @FormID = 'OOF30001';

SET @LanguageValue = N'Báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'OOF30001.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quản lý dự án/nhóm công việc';
EXEC ERP9AddLanguage @ModuleID, 'AsoftOO.GRP_BaoCao_OO', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quản lý công việc';
EXEC ERP9AddLanguage @ModuleID, 'AsoftOO.GRP_BaoCao_OO_CV', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quản lý dự án';
EXEC ERP9AddLanguage @ModuleID, 'AsoftOO.GRP_BaoCao_OO_DA', @FormID, @LanguageValue, @Language;