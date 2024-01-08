-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2101- OO
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
SET @ModuleID = 'OO';
SET @FormID = 'OOF2101';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'項目代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'項目名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ProjectType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'項目模板';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ProjectSampleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'開始日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'結束日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'驗收日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.CheckingDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'項目負責人';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.LeaderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合同';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ContractID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'相關類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新人';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新日';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.FromDateToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'項目負責人';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.LeaderName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合同';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ContractName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'解釋';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.ProjectDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.OpportunityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分數';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.Mark', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'審批人意見';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'拒絕完成';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.Reject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'折扣係數 KHCU';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.DiscountFactorKHCU', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'折扣係數 NC';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.DiscountFactorNC', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'KHCU 服務的折扣係數';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.DiscountFactorKHCUService', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2101.EmployeeName', @FormID, @LanguageValue, @Language;

