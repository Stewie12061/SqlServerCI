------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2140 - CRM 
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000)
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thuc thi truy van
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @Language = 'vi-VN';
SET @ModuleID = 'SO';
SET @FormID = 'SOF2140';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Danh mục phương án kinh doanh';
EXEC ERP9AddLanguage @ModuleID, 'SOF2140.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2140.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2140.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2140.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2140.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'SOF2140.CuratorName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủ đầu tư';
EXEC ERP9AddLanguage @ModuleID, 'SOF2140.InvestorName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng thầu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2140.GeneralContractorName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2140.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'SOF2140.CuratorID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủ đầu tư';
EXEC ERP9AddLanguage @ModuleID, 'SOF2140.InvestorID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng thầu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2140.GeneralContractorID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2140.Status' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2140.StatusName' , @FormID, @LanguageValue, @Language;