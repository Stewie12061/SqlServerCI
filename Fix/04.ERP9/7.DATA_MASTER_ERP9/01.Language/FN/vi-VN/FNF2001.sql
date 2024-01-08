-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ FNF2001- FN
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
SET @FormID = 'FNF2001';

SET @LanguageValue = N'Cập nhật kế hoạch thu chi';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày lập kế hoạch';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày lập kế hoạch';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.Voucher01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người lập kế hoạch';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.PayMentTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày dự kiến thu chi';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.PayMentPlanDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.Descriptions', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mức độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày duyệt';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ApprovalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người lập kế hoạch';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải của người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ApprovalDescriptions', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.JobName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền nguyên tệ';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.OriginalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú của người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã định mức';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.NormID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng thụ hưởng';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ObjectBeneficiaryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng đề xuất';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ObjectProposalID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền nguyện tệ được duyệt';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ApprovalOriginalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền quy đổi được duyệt';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ApprovalConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.StatusDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng đề xuất';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ObjectProposalName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng thụ hưởng';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ObjectBeneficiaryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã định mức';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.NormName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa dự án';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.InheritProject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ApprovePerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại thu/Chi';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.TransactionType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.PayMentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.EmployeeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.EmployeeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.Description.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.PriorityID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.PriorityName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tiền tệ';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.CurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.CurrencyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.PaymentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.PaymentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền nguyên tệ được duyệt';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ApprovalOAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền quy đổi được duyệt';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ApprovalCAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi chú của người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị chuyển tiền';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ObjectTransferName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phó tổng giám đốc phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ReponsibleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng giá trị hợp đồng chi đã ký/dự kiến ký';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ContractAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lũy kế chi';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.Accumulated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Còn phải chi';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ExtantPayment', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉnh/Bộ ngành';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ProvinceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến hạn/Quá hạn';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.OverdueID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian quá hạn';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.OverdueDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian có hồ sơ';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.TimeHaveFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng hồ sơ';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.StatusFileID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị đối tượng được duyệt';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.AmountApproval', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự toán chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.AmountEstimation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.AnaID.Auto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.AnaName.Auto', @FormID, @LanguageValue, @Language;

EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ApprovePerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại thu/Chi';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.TransactionType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.PayMentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.EmployeeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.EmployeeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.Description.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.PriorityID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.PriorityName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tiền tệ';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.CurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.CurrencyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.PaymentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.PaymentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền nguyên tệ được duyệt';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ApprovalOAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền quy đổi được duyệt';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ApprovalCAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi chú của người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị chuyển tiền';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ObjectTransferName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phó tổng giám đốc phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ReponsibleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng giá trị hợp đồng chi đã ký/dự kiến ký';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ContractAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lũy kế chi';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.Accumulated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Còn phải chi';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ExtantPayment', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉnh/Bộ ngành';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ProvinceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến hạn/Quá hạn';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.OverdueID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian quá hạn';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.OverdueDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian có hồ sơ';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.TimeHaveFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng hồ sơ';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.StatusFileID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị đối tượng được duyệt';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.AmountApproval', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự toán chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.AmountEstimation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa từ mua hàng';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.InheritPurchare', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa từ quản lý vay';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.InheritFNF2005', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa từ công nợ kế toán';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.InheritFNF2006', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa kế hoạch thu chi phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.InheritFNF2007', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại (Tổng hợp/Phòng ban)';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TGĐ/PTGĐ Ủy quyền duyệt';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.Delegacy', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tuần';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.WeekNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'PTGĐ duyệt (số tiền)';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.AmountApprovalBOD', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải cơ sở duyệt của đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ApprovalDes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án đã hết công nợ với CĐT';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.TCKTDebt', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án đã hết hạn và chưa được gia hạn tại thời điểm cần chi';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.TCKTExpired', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DA có giải ngân tạm ứng trong kỳ';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.TCKTDisbursement', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chung nhiều dự án';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.TCKTGeneral', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảo lãnh TT';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.TCKTGuarantee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TCKT Duyệt (số tiền)';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.TCKTAmountApproval', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải cơ sở duyệt/chưa duyệt (TCKT)';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.TCKTApprovalDes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chi';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.PaymentDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền chi nguyên tệ';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.POAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền chi quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.PCAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ObjectID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ObjectName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.NormID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.NormName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.AnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.AnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng hồ sơ';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.StatusFileName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến hạn/Quá hạn';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.OverdueName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian có hồ sơ';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.DateHaveFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đợt chi';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.BtnFNF2008', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.AnaID.Auto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.AnaName.Auto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ObjectID.Auto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.ObjectName.Auto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.EmployeeID.Auto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'FNF2001.EmployeeName.Auto', @FormID, @LanguageValue, @Language;