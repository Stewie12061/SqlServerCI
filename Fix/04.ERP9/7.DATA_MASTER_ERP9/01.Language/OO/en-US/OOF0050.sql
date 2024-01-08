-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF0050 - OO
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10)

/*
 - Tieng Viet: vi-VN
 - Tieng Anh: en-US
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @ModuleID = 'OO';
SET @FormID = 'OOF0050';
SET @Language = 'en-US';


EXEC ERP9AddLanguage @ModuleID, N'OOF0050.Title', @FormID, N'Setting task assess', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.TargetsGroupName', @FormID, N'Target group', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.AssessDepartmentName', @FormID, N'Assess department', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.AssessUserName1', @FormID, N'Assess user 1', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.AssessUserName2', @FormID, N'Assess user 1', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.AssessOrder', @FormID, N'Assess order', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.NoDefault', @FormID, N'Do not get default', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.NoDisplay', @FormID, N'Do not display', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.DefaultScore', @FormID, N'Default score', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.AssessRequired', @FormID, N'Assess required', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.TargetsGroupID.CB', @FormID, N'Targets Group ID', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.TargetsGroupName.CB', @FormID, N'Targets Group Name', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.DepartmentID.CB', @FormID, N'Department ID', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.DepartmentName.CB', @FormID, N'Department Name', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.AssessUserTypeID.CB', @FormID, N'Assess User Type ID', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.AssessUserTypeName.CB', @FormID, N'Assess User Type Name', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.EmployeeID.CB', @FormID, N'Employee ID', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.EmployeeName.CB', @FormID, N'Employee Name', @Language;
-- [Đình Hòa] [26/02/2021] - Bổ sung ngôn ngữ
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.ObjectID.CB', @FormID, N'ID', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.ObjectName.CB', @FormID, N'Name', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.ObjectID', @FormID, N'Object Type', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.TargetsGroupID', @FormID, N'Targets Group', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.NotUseAssess', @FormID, N'Not Use Assess', @Language;
