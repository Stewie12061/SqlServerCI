-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ FNF2000- FN
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
SET @ModuleID = 'FN';
SET @FormID = 'FNF2000';

SET @LanguageValue = N'Kế hoạch thu chi';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày lập kế hoạch';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày lập kế hoạch';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.Voucher01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người lập kế hoạch';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.PayMentTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày dự kiến thu chi';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.PayMentPlanDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.Descriptions', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mức độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày duyệt';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.ApprovalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.DeleteFlag', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.DateSearch', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.Ana01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.Ana02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.Ana03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.Ana05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.Ana06ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.Ana07ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.Ana08ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.Ana09ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.Ana10ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng đề xuất';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.ObjectProposalID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mức độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.ApprovalDescriptions', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.Description.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.PriorityID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.PriorityName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.EmployeeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.EmployeeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.ObjectID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.ObjectName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.AnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'FNF2000.AnaName.CB', @FormID, @LanguageValue, @Language;

