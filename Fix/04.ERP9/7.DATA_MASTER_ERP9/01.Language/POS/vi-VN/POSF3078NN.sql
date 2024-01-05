------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MTF0070 - MT
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
SET @ModuleID = 'POS';
SET @FormID = 'POSF3078NN';


SET @LanguageValue = N'Báo cáo hoa hồng nhân viên theo điểm';
EXEC ERP9AddLanguage @ModuleID, 'POSF3078.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POSF3078NN.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF3078NN.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF3078NN.FromEmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF3078NN.ToEmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF3078NN.FromInventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF3078NN.ToInventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF3078NN.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF3078NN.InventoryID' , @FormID, @LanguageValue, @Language;
