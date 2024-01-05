-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF1832- M
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
SET @FormID = 'MF1832';

SET @LanguageValue = N'Xem chi tiết nguyên vật liệu thay thế';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhóm';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.GroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại nguyên liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nguyên liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.MaterialID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nguyên liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhóm';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.MaterialGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nguyên liệu thay thế';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nguyên liệu thay thế';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.InventoryUnit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hệ số thay thế';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.CoValues', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh sách nguyên liệu thay thế';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.ChiTietNguyenVatLieuThayThe', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm nguyên vật liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.NguyenVatLieuThayThe', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.IsCommon', @FormID, @LanguageValue, @Language;