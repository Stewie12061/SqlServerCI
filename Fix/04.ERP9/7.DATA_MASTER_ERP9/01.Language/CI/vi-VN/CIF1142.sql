------------------------------------------------------------------------------------------------------
-- Script t?o ngôn ng? CIF1142 
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
SET @FormID = 'CIF1142';
------------------------------------------------------------------------------------------------------
--- Title
-----------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Xem chi tiết kho hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.Title' , @FormID, @LanguageValue, @Language;

--- TAB
-----------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.DivisionID' , @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Mã kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.WareHouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.WareHouseName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thủ kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.FullName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho tạm';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.IsTemp' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.IsCommon' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.Disabled' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.CreateUserID' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.CreateDate' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.LastModifyDate' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem chi tiết kho hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.Title' , @FormID, @LanguageValue, @Language;

--- TAB
-----------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.DivisionID' , @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Mã kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.WareHouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.WareHouseName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thủ kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.FullName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho tạm';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.IsTemp' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.IsCommon' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.Disabled' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.CreateUserID' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.CreateDate' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.LastModifyDate' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.LastModifyUserID' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Thông tin kho hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.ThongTinKhoHang' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.StatusID' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'CIF1142.Description' , @FormID, @LanguageValue, @Language;


------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;