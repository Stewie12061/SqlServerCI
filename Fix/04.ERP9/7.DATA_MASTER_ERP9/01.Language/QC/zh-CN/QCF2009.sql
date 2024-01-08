-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2009- QC
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
SET @FormID = 'QCF2009';

SET @LanguageValue = N'傳承產品品質檢驗單';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文件類型';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'會計日期';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'借款合約';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'期';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'年';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'轉移';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'轉移';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.ShiftName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'程式碼';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'姓名';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'测量人';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.EmployeeID01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'测量人';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.EmployeeName01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品質量測試儀';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.EmployeeID02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品質量測試儀';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.EmployeeName02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機械師';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.EmployeeID03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機械師';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.EmployeeName03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'仓库助理';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.EmployeeID04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'仓库助理';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.EmployeeName04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'包裝人員';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.EmployeeID05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'包裝人員';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.EmployeeName05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'監製製作人';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.EmployeeID06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'監製製作人';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.EmployeeName06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.EmployeeID07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'檢查人';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.EmployeeName07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備考 1';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.Notes01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備考 2';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.Notes02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備考 3';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.Notes03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工廠';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'车间名称';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.InheritSOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.InheritPOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.InheritProductRes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.InheritTable', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品品質檢驗卡原件';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.InheritVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.InheritCheckOutPut', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.InheritProgressInventory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品名稱（客戶）';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.Ana04Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'瀏覽狀態';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.StatusSS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'瀏覽狀態';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.PassRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2009.FailRate', @FormID, @LanguageValue, @Language;

