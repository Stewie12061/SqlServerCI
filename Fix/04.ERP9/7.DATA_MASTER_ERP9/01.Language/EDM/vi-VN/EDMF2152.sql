-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ 
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
SET @ModuleID = 'EDM';
SET @FormID = 'EDMF2152';

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.Attach.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.Notes.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số bảo lưu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.ReserveID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bảo lưu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.ReserveDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.ProposerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.SchoolName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.ClassName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời hạn bảo lưu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.ReservePeriod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lý do';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.Reason', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem thông tin bảo lưu thời gian học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin bảo lưu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.Lich_su', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.SchoolYearID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.DateFrom.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.DateTo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.SchoolYearID', @FormID, @LanguageValue, @Language;



SET @LanguageValue = N'Khoản phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.ReceiptTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương thức đóng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.PaymentMethodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền đã thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.AmountReceived', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền được bảo lưu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.AmountReserve', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền được bảo lưu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.TotalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tháng được bảo lưu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.MonthReserve', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Phí bảo lưu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.Detail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chuyển nhượng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.Assign', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Số tiền bảo lưu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.AmountTransfer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chuyển nhượng tháng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.IsTransferMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chuyển nhượng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2152.IsTransfer', @FormID, @LanguageValue, @Language;


