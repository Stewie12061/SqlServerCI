------------------------------------------------------------------------------------------------------
-- Script t?o ngôn ng? CIF1132 
-----------------------------------------------------------------------------------------------------
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF1132';
------------------------------------------------------------------------------------------------------
--- Title
-----------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Xem chi tiết loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.Title' , @FormID, @LanguageValue, @Language;

--- TAB
-----------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.DivisionID' , @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Mã loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.InventoryTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.InventoryTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại mặt hàng (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.InventoryTypeNameE' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.IsCommon' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.Disabled' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.CreateUserID' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.CreateDate' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.LastModifyDate' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.LastModifyUserID' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Thông tin loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.ThongTinLoaiMatHang' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.StatusID' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CIF1132.Description' , @FormID, @LanguageValue, @Language;
------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;