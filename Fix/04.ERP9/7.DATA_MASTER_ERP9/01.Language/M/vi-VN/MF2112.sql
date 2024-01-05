-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2112- M
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
SET @FormID = 'MF2112';

SET @LanguageValue = N'Xem chi tiết cấu trúc sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại cấu trúc';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.NodeTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã cấu trúc';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.NodeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên cấu trúc';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.NodeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin cấu trúc sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.ThongTinCauTrucSanPham', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết cấu trúc sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.ThongTinChiTietCauTrucSanPham', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại cấu trúc';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.DisplayMember', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đặc tính kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.Specification', @FormID, @LanguageValue, @Language;