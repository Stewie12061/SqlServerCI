-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2151- M
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
SET @ModuleID = 'M';
SET @FormID = 'MF2151';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'借款合約';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'會計日期';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'物質日';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.SuppliesDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請人';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'{0:00}次状態';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'投票狀態';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'生產資訊之繼承';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.InheritSOT2080', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'生產訂單的繼承';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.InheritOT2001', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.Levels', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'聯絡電話姓名';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'審核人之備註';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'預留倉庫';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.WareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.FromToDate', @FormID, @LanguageValue, @Language;

