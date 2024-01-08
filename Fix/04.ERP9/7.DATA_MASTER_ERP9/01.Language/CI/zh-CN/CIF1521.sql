-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1521- CI
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF1521';

SET @LanguageValue = N'根據狀況促銷活動之更新';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'促銷代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.PromoteID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'自從';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'迄今';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析程式碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.OID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'促銷名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.PromoteName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不要使用累積的折扣錢包';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.IsDiscountWallet', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.IsEnd', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'瀏覽狀態';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.StatusSS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'審核人之備註';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1521.InheritID', @FormID, @LanguageValue, @Language;

