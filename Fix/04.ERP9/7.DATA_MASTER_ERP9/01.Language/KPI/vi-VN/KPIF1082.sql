-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF1082- KPI
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
SET @FormID = 'KPIF1082';

SET @LanguageValue = N'Chi tiết quy định thưởng KPI';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ kỳ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.EffectiveDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉ lệ hoàn thành (%)';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.CompletionRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mức thưởng (VND)';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.BonusLevelsKPIs', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến kỳ';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.ExpirationDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bảng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.TableName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quy định thưởng KPIs';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.QuyDinhThuongKPIs', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết quy định thưởng KPIs';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.ChiTietQuyDinhThuongKPIs', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi Chú';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch Sử';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.LichSu', @FormID, @LanguageValue, @Language;
