-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF30001- OO
-- [Đình Hòa] [25/02/2021] - Bổ sung ngôn ngữ
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
SET @FormID = 'OOF30001';

SET @LanguageValue = N'REPORT';
EXEC ERP9AddLanguage @ModuleID, 'OOF30001.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project Management/Work Task';
EXEC ERP9AddLanguage @ModuleID, 'AsoftOO.GRP_BaoCao_OO', @FormID, @LanguageValue, @Language;
