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

SET @FormID = 'QCF3011';
EXEC ERP9AddLanguage @ModuleID, 'QCF3011.Title', @FormID, N'Báo cáo đánh giá và nguyên nhân lỗi ghi nhận', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3011.DivisionID', @FormID, N'Đơn vị', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3011.ToDate', @FormID, N'Đến ngày', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3011.FromDate', @FormID, N'Từ ngày', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3011.Machine', @FormID, N'Máy', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3011.Object', @FormID, N'Khách hàng', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3011.Inventory', @FormID, N'Mặt hàng', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3011.Assess', @FormID, N'Đánh giá', @Language;


