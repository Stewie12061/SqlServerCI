-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2023- PO
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
SET @ModuleID = 'PO';
SET @FormID = 'POF2023';

SET @LanguageValue = N'Xem chi tiết kế hoạch mua hàng dự trữ';
EXEC ERP9AddLanguage @ModuleID, 'POF2023.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2023.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐVT';
EXEC ERP9AddLanguage @ModuleID, 'POF2023.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng bán trung bình';
EXEC ERP9AddLanguage @ModuleID, 'POF2023.AVGQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng đặt mua';
EXEC ERP9AddLanguage @ModuleID, 'POF2023.OrderQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày nhận hàng dự kiến';
EXEC ERP9AddLanguage @ModuleID, 'POF2023.ExpectDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'POF2023.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT 01';
EXEC ERP9AddLanguage @ModuleID, 'POF2023.Ana01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT 02';
EXEC ERP9AddLanguage @ModuleID, 'POF2023.Ana02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT 03';
EXEC ERP9AddLanguage @ModuleID, 'POF2023.Ana03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT 04';
EXEC ERP9AddLanguage @ModuleID, 'POF2023.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT 05';
EXEC ERP9AddLanguage @ModuleID, 'POF2023.Ana05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT 06';
EXEC ERP9AddLanguage @ModuleID, 'POF2023.Ana06ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT 07';
EXEC ERP9AddLanguage @ModuleID, 'POF2023.Ana07ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT 08';
EXEC ERP9AddLanguage @ModuleID, 'POF2023.Ana08ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT 09';
EXEC ERP9AddLanguage @ModuleID, 'POF2023.Ana09ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT 10';
EXEC ERP9AddLanguage @ModuleID, 'POF2023.Ana10ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2023.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhà cung cấp';
EXEC ERP9AddLanguage @ModuleID, 'POF2023.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'POF2023.GroupInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'POF2023.GroupDetail', @FormID, @LanguageValue, @Language;