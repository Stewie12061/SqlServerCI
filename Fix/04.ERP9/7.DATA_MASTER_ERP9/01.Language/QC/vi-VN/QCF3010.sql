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

SET @FormID = 'QCF3010';
EXEC ERP9AddLanguage @ModuleID, 'QCF3010.Title', @FormID, N'Báo cáo kiểm tra thông số tiêu chuẩn sản phẩm', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3010.DivisionID', @FormID, N'Đơn vị', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3010.ToDate', @FormID, N'Đến ngày', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3010.FromDate', @FormID, N'Từ ngày', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3010.Standard', @FormID, N'Tiêu chuẩn', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3010.Object', @FormID, N'Khách hàng', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3010.Inventory', @FormID, N'Mặt hàng', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3010.Phase', @FormID, N'Công đoạn', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3010.AssessType', @FormID, N'Loại đánh giá', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3010.Assess', @FormID, N'Đánh giá', @Language;


