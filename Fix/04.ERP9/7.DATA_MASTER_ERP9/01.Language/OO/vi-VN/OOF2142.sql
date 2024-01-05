-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2142- OO
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
SET @ModuleID = 'OO';
SET @FormID = 'OOF2142';

SET @LanguageValue = N'Xem chi tiết định mức chi phí dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm chi';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.CostGroup', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết nhóm chi';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.CostGroupDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.Money', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ Phận';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.AnaDepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ Phận';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.AnaDepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm chi';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.CostGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết nhóm chi';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.CostGroupDetailName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch Sử';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.LichSu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính Kèm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin định mức dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.ThongTinDinhMucDuAn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết định mức dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.ThongTinChiTietDinhMucDuAn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền thực tế';
EXEC ERP9AddLanguage @ModuleID, 'OOF2142.ActualMoney', @FormID, @LanguageValue, @Language;