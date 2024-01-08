-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF1822- M
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
SET @ModuleID = 'M';
SET @FormID = 'MF1822';

SET @LanguageValue = N'Production resource view';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đóng góp';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.ResourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Resource name';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.ResourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Efficiency';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.Efficiency', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Editor';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Describe';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Efficiency';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.LinedUpTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Setup time';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.SettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Waiting time';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.WaittingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Travel time';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.TransferTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Min time';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.MinTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Maximum time';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.MaxTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Resource type';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.ResourceTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production resource information';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.ThongTinNguonLucSanXuat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.StatusID', @FormID, @LanguageValue, @Language;
