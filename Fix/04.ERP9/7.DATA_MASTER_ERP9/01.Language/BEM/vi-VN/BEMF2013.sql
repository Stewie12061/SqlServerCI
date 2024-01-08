-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ BEMF2013 - BEM
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),

------------------------------------------------------------------------------------------------------
-- Tham số gen tự động
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT

------------------------------------------------------------------------------------------------------
-- Gán giá trị tham số và thực thi truy vấn
------------------------------------------------------------------------------------------------------
/*
    - Tiếng Việt: vi-VN 
    - Tiếng Anh: en-US 
    - Tiếng Nhật: ja-JP
    - Tiếng Trung: zh-CN
*/

SET @Language = 'vi-VN' 
SET @ModuleID = 'BEM';
SET @FormID = 'BEMF2013';

SET @LanguageValue = N'Số tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.Contents', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.CostAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT Chi phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.CostAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tháng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT chi phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.DepartmentAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MPT Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.DepartmentAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.FeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.FeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hành trình';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.Journeys', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền ban đầu';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.OriginalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền còn lại';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.RemainingAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa phiếu đề nghị công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng ngày';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.TotalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng chi phí';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.TotalFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.TypeBSTrip', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.TypeBSTripID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.TypeBSTripID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.TypeBSTripName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi công tác';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.WorkPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'BEMF2013.ConvertedAmount', @FormID, @LanguageValue, @Language;
