-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2210- OO
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
SET @FormID = 'OOF2210';

SET @LanguageValue = N'Danh mục release';
EXEC ERP9AddLanguage @ModuleID, 'OOF2210.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2210.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã release';
EXEC ERP9AddLanguage @ModuleID, 'OOF2210.ReleaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên release';
EXEC ERP9AddLanguage @ModuleID, 'OOF2210.ReleaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại release';
EXEC ERP9AddLanguage @ModuleID, 'OOF2210.TypeOfRelease', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2210.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2210.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Milestone';
EXEC ERP9AddLanguage @ModuleID, 'OOF2210.MilestoneID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Milestone';
EXEC ERP9AddLanguage @ModuleID, 'OOF2210.MilestoneName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2210.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2210.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Release Version';
EXEC ERP9AddLanguage @ModuleID, 'OOF2210.ReleaseVersion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2210.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2210.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2210.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2210.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2210.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2210.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2210.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2210.CreateUserID2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2210.CreateDate2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2210.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2210.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2210.ProjectID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2210.ProjectName.CB', @FormID, @LanguageValue, @Language;

