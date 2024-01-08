-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF0060- OO
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
SET @FormID = 'OOF0060';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0060.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作 CT 類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF0060.VoucherTask', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0060.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0060.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0060.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0060.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0060.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'問題CT 類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF0060.VoucherIssues', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作時間的小數';
EXEC ERP9AddLanguage @ModuleID, 'OOF0060.TaskHourDecimal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'里程碑管理CT的類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF0060.VoucherMilestone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'發布管理 CT 類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF0060.VoucherRelease', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'管理設備放置的 CT 類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF0060.VoucherBooking', @FormID, @LanguageValue, @Language;

