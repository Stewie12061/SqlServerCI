-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF1822- M
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
SET @ModuleID = 'M';
SET @FormID = 'MF1822';

SET @LanguageValue = N'Xem chi tiết nguồn lực sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nguồn lực';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.ResourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nguồn lực';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.ResourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiệu suất';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.Efficiency', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiệu suất';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.LinedUpTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian thiết lập';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.SettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian đợi';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.WaittingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian di chuyển';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.TransferTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian tối thiêu';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.MinTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian tối đa';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.MaxTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin nguồn lực sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.ThongTinNguonLucSanXuat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại nguồn lực';
EXEC ERP9AddLanguage @ModuleID, 'MF1822.ResourceTypeID', @FormID, @LanguageValue, @Language;