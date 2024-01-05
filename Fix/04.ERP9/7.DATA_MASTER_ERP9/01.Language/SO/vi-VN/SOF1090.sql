------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF1090 - SO
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
SET @FormID = 'SOF1090';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Danh mục kế hoạch doanh số (Sell Out)';
EXEC ERP9AddLanguage @ModuleID, 'SOF1090.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF1090.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'SOF1090.TargetsID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'SOF1090.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'SOF1090.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SOF1090.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF1090.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm';
EXEC ERP9AddLanguage @ModuleID, 'SOF1090.CreateUserID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Tên khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF1090.ObjectName', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOF1090.EmployeeName', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF1090.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm';
EXEC ERP9AddLanguage @ModuleID, 'SOF1090.Year', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Doanh số';
EXEC ERP9AddLanguage @ModuleID, 'SOF1090.SalesYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đã lập kế hoạch';
EXEC ERP9AddLanguage @ModuleID, 'SOF1090.IsPlanned', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF1090.ObjectID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF1090.ObjectName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF1090.AnaUserID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF1090.AnaUserName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'SOF1090.UserName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF1090.StatusSS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ý kiến người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF1090.ApprovalNotes', @FormID, @LanguageValue, @Language;
