declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'vi-VN'

SET @FormID = 'CRMF3000'
SET @LanguageValue = N'Đầu mối - cơ hội - khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'AsoftCRM.BaoCaoThongKe' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Báo cáo biểu đồ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3000.Title' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tỷ lệ chuyển đổi';
EXEC ERP9AddLanguage @ModuleID, 'AsoftCRM.TyLeChuyenDoi' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Báo giá';
EXEC ERP9AddLanguage @ModuleID, 'AsoftCRM.BaoGia' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Doanh số';
EXEC ERP9AddLanguage @ModuleID, 'AsoftCRM.DoanhSo' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'AsoftCRM.Donhang' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Marketing';
EXEC ERP9AddLanguage @ModuleID, 'AsoftCRM.BaoCaoKhac' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chăm sóc khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'AsoftCRM.Chamsockhachhang' , @FormID, @LanguageValue, @Language;

