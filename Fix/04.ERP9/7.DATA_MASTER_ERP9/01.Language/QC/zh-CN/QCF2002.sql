-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2002- QC
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
SET @ModuleID = 'QC';
SET @FormID = 'QCF2002';

SET @LanguageValue = N'產品品質檢驗表';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文件類型';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'會計日期';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'借款合約';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'期';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'年';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'轉移';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'轉移';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.ShiftName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'程式碼';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'姓名';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'進行測量的人';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.EmployeeID01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'测量人';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.EmployeeName01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品質量測試儀';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.EmployeeID02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品質量測試儀';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.EmployeeName02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機械師 ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.EmployeeID03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機械師';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.EmployeeName03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'倉庫子代碼';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.EmployeeID04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'仓库助理';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.EmployeeName04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'包裝人員';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.EmployeeID05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'包裝人員';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.EmployeeName05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'製片人';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.EmployeeID06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'監製製作人';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.EmployeeName06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.EmployeeID07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'檢查人';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.EmployeeName07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備考 1';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.Notes01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備考 2';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.Notes02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備考 3';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.Notes03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工廠';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'车间名称';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.InheritSOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.InheritPOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.InheritProductRes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.InheritTable', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.InheritVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.InheritCheckOutPut', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.InheritProgressInventory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品名稱（客戶）';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.Ana04Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.StatusSS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通過率%';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.PassRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'失敗百分比';
EXEC ERP9AddLanguage @ModuleID, 'QCF2002.FailRate', @FormID, @LanguageValue, @Language;

