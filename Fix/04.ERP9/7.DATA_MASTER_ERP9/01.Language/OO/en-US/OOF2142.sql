-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2142- OO
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
SET @FormID = 'OOF2142';

SET @LanguageValue = N'Project cost norm view';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Levels';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.Levels', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quotation';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.QuotationID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CostGroup';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.CostGroup', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CostGroupDetail';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.CostGroupDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Money';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.Money', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'AnaDepartmentID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.AnaDepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CostGroupName';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.CostGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CostGroupDetailName';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.CostGroupDetailName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';					 
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.LichSu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project norm information';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.ThongTinDinhMucDuAn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Detailed information on project norms';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.ThongTinChiTietDinhMucDuAn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual Money';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.ActualMoney', @FormID, @LanguageValue, @Language;
