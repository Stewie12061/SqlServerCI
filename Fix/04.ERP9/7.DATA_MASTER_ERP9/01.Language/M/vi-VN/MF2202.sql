-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2202- M
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
SET @FormID = 'MF2202';

SET @LanguageValue = N'Xem chi tiết sắp xếp cont';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Container';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.Container', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thể tích';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.CBM', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'PO';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.InheritVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi nhánh';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.Branch', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.CountryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quy cách';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.StandardName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quy cách';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.StandardID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.CountryID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.CountryName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin sắp xếp cont';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.SapXepCont', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết sắp xếp cont';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.ChiTietSapXepCont', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.StatusID', @FormID, @LanguageValue, @Language

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.Notes', @FormID, @LanguageValue, @Language