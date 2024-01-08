-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2000- QC
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
SET @FormID = 'QCF2000';

SET @LanguageValue = N'產品品質檢驗表';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文件類型';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'會計日期';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'借款合約';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'期';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'年';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'轉移';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'轉移';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.ShiftName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'程式碼';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'姓名';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'测量人';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.EmployeeID01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'测量人';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.EmployeeName01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品質量測試儀';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.EmployeeID02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品質量測試儀';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.EmployeeName02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機械師';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.EmployeeID03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機械師';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.EmployeeName03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'仓库助理';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.EmployeeID04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'仓库助理';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.EmployeeName04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'包裝人員';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.EmployeeID05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'包裝人員';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.EmployeeName05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'監製製作人';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.EmployeeID06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'監製製作人';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.EmployeeName06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.EmployeeID07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'檢查人';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.EmployeeName07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備考 1';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.Notes01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備考 2';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.Notes02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備考 3';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.Notes03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創立日期';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最後修改日期';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最後修改用戶';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工廠';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'车间名称';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.InheritSOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.InheritPOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.InheritProductRes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.InheritTable', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.InheritVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.InheritCheckOutPut', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.InheritProgressInventory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品名稱（客戶）';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.Ana04Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'瀏覽狀態';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.StatusSS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'瀏覽狀態';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.PassRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2000.FailRate', @FormID, @LanguageValue, @Language;

