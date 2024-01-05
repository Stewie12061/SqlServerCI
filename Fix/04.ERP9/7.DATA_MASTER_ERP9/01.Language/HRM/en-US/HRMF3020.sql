
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF3020- HRM
-- [Đình Hòa] [26/02/2021] - Bổ sung ngôn ngữ
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
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF3020';

/*
--Lấy Query nhanh
declare @ScreenID varchar(20) =N'HRMF3020'
SELECT 'SET @LanguageValue = N''_''; EXEC ERP9AddLanguage @ModuleID, '''+IDLanguage+''' , @FormID, @LanguageValue, @Language;' FROM AS_ADMIN_NEWTOYO.dbo.sysLanguage WHERE ScreenID =@ScreenID

*/
SET @LanguageValue = N'Department'; 
EXEC ERP9AddLanguage @ModuleID, 'HRMF3020.DepartmentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division'; 
EXEC ERP9AddLanguage @ModuleID, 'HRMF3020.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report form'; 
EXEC ERP9AddLanguage @ModuleID, 'HRMF3020.ReportID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report Name'; 
EXEC ERP9AddLanguage @ModuleID, 'HRMF3020.ReportName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'lbTimeName'; 
EXEC ERP9AddLanguage @ModuleID, 'HRMF3020.DateCaption' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee Name'; 
EXEC ERP9AddLanguage @ModuleID, 'HRMF3020.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation kit'; 
EXEC ERP9AddLanguage @ModuleID, 'HRMF3020.EvaluationSetID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title'; 
EXEC ERP9AddLanguage @ModuleID, 'HRMF3020.ReportTitle' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Target Group'; 
EXEC ERP9AddLanguage @ModuleID, 'HRMF3020.TargetsGroupID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Targets'; 
EXEC ERP9AddLanguage @ModuleID, 'HRMF3020.TargetsID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'KPI performance report'; 
EXEC ERP9AddLanguage @ModuleID, 'HRMF3020.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From {0} To {1}';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3020.FromToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Filtering criteria';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3020.GroupFilter' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3020.GroupReport' , @FormID, @LanguageValue, @Language;


SET @FormID = 'ReportView';

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.EvaluationSetID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.EvaluationSetName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation Phase';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.EvaluationPhaseName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From Date';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.FromDate.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To Date';
EXEC ERP9AddLanguage @ModuleID, 'ReportView.ToDate.CB' , @FormID, @LanguageValue, @Language;