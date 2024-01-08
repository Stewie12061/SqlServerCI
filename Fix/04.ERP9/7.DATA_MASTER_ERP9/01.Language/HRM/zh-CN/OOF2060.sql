-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2060- HRM
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
SET @ModuleID = 'HRM';
SET @FormID = 'OOF2060';

SET @LanguageValue = N'例外處理';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'進出';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.IOName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'已創建不加班申請單';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.IsApproved', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'從小時';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.BeginTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'到時';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.EndTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'轉移';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'員工程式碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'全名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'堵塞';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'階段';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'天';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'異常類型判斷';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.JugdeUnusualTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'異常類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.UnusualTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'实际';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.Fact', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'例外處理';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.Method', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'{0:00}次状態';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.HandleMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'处理';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.Execute', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'堵塞';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'階段';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地位';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'自從';
EXEC ERP9AddLanguage @ModuleID, 'OOF2060.FromDate', @FormID, @LanguageValue, @Language;

