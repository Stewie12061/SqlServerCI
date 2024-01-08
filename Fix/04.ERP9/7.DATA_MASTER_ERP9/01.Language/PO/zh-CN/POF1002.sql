﻿-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF1002- PO
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
SET @Language = 'zh-CN' 
SET @ModuleID = 'PO';
SET @FormID = 'POF1002';

SET @LanguageValue = N'查看收貨計劃步驟明細';
EXEC ERP9AddLanguage @ModuleID, 'POF1002.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF1002.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'POF1002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'計劃步驟代碼';
EXEC ERP9AddLanguage @ModuleID, 'POF1002.PlanID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'計劃步驟名稱';
EXEC ERP9AddLanguage @ModuleID, 'POF1002.PlanName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
EXEC ERP9AddLanguage @ModuleID, 'POF1002.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'POF1002.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'POF1002.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'POF1002.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'POF1002.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'POF1002.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'POF1002.LastModifyDate', @FormID, @LanguageValue, @Language;

