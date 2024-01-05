-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF2020- KPI
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
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF2020';

SET @LanguageValue = N'Danh mục bảng quy chuẩn (Up-Down) đánh giá KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương cứng thực tế';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.FixedSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương mềm dự kiến';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.EffectiveSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.TargetSales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hệ số chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.TargetSalesRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'GH Đỏ (%)';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.RedLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'GH cảnh báo (%)';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.WarningLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ kỳ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.EffectDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến kỳ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.ExpiryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảng hệ số lương mềm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.TableID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảng quy định giờ công vi phạm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.TableViolatedID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bảng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.TableID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bảng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.TableName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bảng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2020.TableViolatedID.CB', @FormID, @LanguageValue, @Language;
