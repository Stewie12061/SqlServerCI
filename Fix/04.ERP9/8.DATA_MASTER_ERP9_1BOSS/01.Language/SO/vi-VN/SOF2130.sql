------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2130 - CRM 
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
SET @FormID = 'SOF2130';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Danh mục báo giá kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2130.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2130.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2130.VouCherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2130.VouCherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người báo giá';
EXEC ERP9AddLanguage @ModuleID, 'SOF2130.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2130.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng phiếu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2130.OrderStatus' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SOF2130.Description' , @FormID, @LanguageValue, @Language;

