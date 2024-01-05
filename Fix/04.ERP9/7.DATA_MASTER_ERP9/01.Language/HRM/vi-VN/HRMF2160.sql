-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2160- HRM
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


SET @Language = 'vi-VN';
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2160'

SET @LanguageValue  = N'Danh sách huê hồng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kỳ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.Period',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hợp đồng/Hóa đơn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số Tiền Thanh Toán (Chưa VAT)'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.PayAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền tính huê hồng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.Amount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lead chưa tham gia Firm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.BonusRate01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lead đã tham gia'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.BonusRate02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sale'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.BonusRate03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Coach'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.BonusRate04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thành Tiền'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.RevenueAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tháng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.TranMonth',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Năm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2160.TranYear',  @FormID, @LanguageValue, @Language;
