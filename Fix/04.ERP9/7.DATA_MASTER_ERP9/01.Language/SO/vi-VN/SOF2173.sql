-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2173- SO
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
SET @ModuleID = 'SO';
SET @FormID = 'SOF2173';

SET @LanguageValue = N'Chọn đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2173.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2173.OrderNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khách hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2173.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khách hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2173.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2173.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2173.Quantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tuyến'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2173.Route' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2173.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã vận chuyển'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2173.Transport' , @FormID, @LanguageValue, @Language;



