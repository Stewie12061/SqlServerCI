-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2050 
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
SET @ModuleID = 'QC';

SET @FormID = 'QCF3009';
EXEC ERP9AddLanguage @ModuleID, 'QCF3009.Title', @FormID, N'Báo cáo theo dõi chất lượng sản phẩm', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3009.DivisionID', @FormID, N'Đơn vị', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3009.ToDate', @FormID, N'Đến ngày', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3009.FromDate', @FormID, N'Từ ngày', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3009.Department', @FormID, N'Bộ phận', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3009.Object', @FormID, N'Khách hàng', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3009.Inventory', @FormID, N'Mặt hàng', @Language;
