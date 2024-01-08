-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF2032- KPI
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
SET @FormID = 'KPIF2032';

SET @LanguageValue = N'Chi tiết hệ số lương mềm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bảng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.TableID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉ lệ hoàn thành (%)';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.CompletionRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hệ số lương mềm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.SoftwageCoefficient', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bảng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.TableName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hệ số tính lương mềm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.HeSoTinhLuongMem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết hệ số tính lương mềm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.ChiTietHeSoTinhLuongMem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi Chú';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch Sử';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.LichSu', @FormID, @LanguageValue, @Language;

