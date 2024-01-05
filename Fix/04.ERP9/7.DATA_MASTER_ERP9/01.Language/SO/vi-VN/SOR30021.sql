
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOR30021 - SO
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
SET @FormID = 'SOR30021';

SET @LanguageValue = N'Báo cáo chi tiết thống kê mặt hàng theo đơn hàng bán';
EXEC ERP9AddLanguage @ModuleID, 'SOR30021.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOR30021.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm phân tích';
EXEC ERP9AddLanguage @ModuleID, 'SOR30021.GroupID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOR30021.CurrencyID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR30021.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOR30021.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOR30021.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOR30021.CurrencyID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'SOR30021.CurrencyName.CB' , @FormID, @LanguageValue, @Language;