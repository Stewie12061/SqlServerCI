
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2272 - WM
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
SET @ModuleID = 'WM';
SET @FormID = 'WMF2272';

SET @LanguageValue = N'Xem chi tiết kết chuyển số dư cuối kỳ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2272.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin kết chuyển số dư cuối kỳ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2272.ThongTinKetChuyen' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết kết chuyển số dư cuối kỳ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2272.ThongTinChiTietKetChuyen' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'WMF2272.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF2272.WareHouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kỳ kế toán';
EXEC ERP9AddLanguage @ModuleID, 'WMF2272.PeriodID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'WMF2272.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'WMF2272.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'WMF2272.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'WMF2272.LastModifyDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'WMF2272.StatusID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'WMF2272.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2272.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2272.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'WMF2272.InventoryAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tồn đầu kỳ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2272.BeginQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tồn cuối kỳ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2272.EndQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng nợ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2272.DebitQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'WMF2272.CreditQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng ghi nợ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2272.InDebitQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng tín dụng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2272.InCreditQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tồn đầu kỳ (thành tiền)';
EXEC ERP9AddLanguage @ModuleID, 'WMF2272.BeginAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tồn cuối kỳ (thành tiền)';
EXEC ERP9AddLanguage @ModuleID, 'WMF2272.EndAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số dư nợ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2272.DebitAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số dư có';
EXEC ERP9AddLanguage @ModuleID, 'WMF2272.CreditAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền ghi nợ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2272.InDebitAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền ghi có';
EXEC ERP9AddLanguage @ModuleID, 'WMF2272.InCreditAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'WMF2272.UnitPrice' , @FormID, @LanguageValue, @Language;