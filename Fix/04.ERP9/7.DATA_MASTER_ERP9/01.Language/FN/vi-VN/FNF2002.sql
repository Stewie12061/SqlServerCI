-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ FNF2002- FN
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
SET @FormID = 'FNF2002';

SET @LanguageValue = N'Chi tiết kế hoạch thu chi';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người lập kế hoạch';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày lập kế hoạch';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.Descriptions', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ giá';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại thu chi';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.TransactionType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày dự kiến thu chi';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.PayMentPlanDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.PayMentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mức độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải của người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.ApprovalDescriptions', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết kế hoạch thu chi';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.TabDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin kế hoạch thu chi';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.TabInfor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người lập kế hoạch';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử điều chỉnh kế hoạch thu chi';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.TabLichsudieuchinhkehoachthuchi', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lần điều chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.ModifyNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày điều chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người điều chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.LastModifyUserID1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.LastModifyDate1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.JobName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền nguyên tệ';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.OriginalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.ConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền nguyên tệ được duyệt';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.ApprovalOAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền quy đổi được duyệt';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.ApprovalCAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái detail';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.StatusDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị chuyển tiền';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.ObjectTransferName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng thụ hưởng';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.ObjectBeneficiaryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã định mức';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.NormName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phó tổng giám đốc phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.ReponsibleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị đề xuất chi';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.ObjectProposalName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng giá trị hợp đồng chi đã ký/dự kiến ký';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.ContractAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lũy kế chi';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.Accumulated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Còn phải chi';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.ExtantPayment', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉnh/Bộ ngành';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.ProvinceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến hạn/Quá hạn';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.OverdueID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian quá hạn';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.OverdueDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian có hồ sơ';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.TimeHaveFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng hồ sơ';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.StatusFileID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị đối tượng được duyệt';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.AmountApproval', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự toán chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.AmountEstimation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại (Tổng hợp/Phòng ban)';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TGĐ/PTGĐ Ủy quyền duyệt';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.Delegacy', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tuần';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.WeekNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'PTGĐ duyệt (số tiền)';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.AmountApprovalBOD', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải cơ sở duyệt của đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.ApprovalDes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án đã hết công nợ với CĐT';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.TCKTDebt', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án đã hết hạn và chưa được gia hạn tại thời điểm cần chi';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.TCKTExpired', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DA có giải ngân tạm ứng trong kỳ';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.TCKTDisbursement', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chung nhiều dự án';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.TCKTGeneral', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảo lãnh TT';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.TCKTGuarantee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TCKT Duyệt (số tiền)';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.TCKTAmountApproval', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải cơ sở duyệt/chưa duyệt (TCKT)';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.TCKTApprovalDes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chi';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.PaymentDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền chi quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.POAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền chi nguyên tệ';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.PCAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng hồ sơ';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.StatusFileName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến hạn/Quá hạn';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.OverdueName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian có hồ sơ';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.DateHaveFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đợt chi';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.BtnFNF2008', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin đợt chi (KHTC tổng hợp)';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.Tabthongtindotchi', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguồn vốn';
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.Ana10Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái của người duyệt'
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.Status'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú của người duyệt'
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.ApprovalNotes'  ,@FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày duyệt của người'
EXEC ERP9AddLanguage @ModuleID, 'FNF2002.ApprovalDate'  ,@FormID, @LanguageValue, @Language;
