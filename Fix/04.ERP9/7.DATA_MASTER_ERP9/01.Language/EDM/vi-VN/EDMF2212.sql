-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2212- EDM
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
SET @FormID = 'EDMF2212';

SET @LanguageValue = N'Thiết lập mức đóng phí đầu năm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.StudentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.btnStudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.SchoolYearID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.ClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.ClassName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoản phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.ReceiptTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương thức đóng hiện tại';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.CurrentPaymentMethodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền hiện tại';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.AmountOld', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương thức đóng mới';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.PaymentMethodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền thực tế';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.SumAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.PromotionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.AmountPromotion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền sau khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.AmountTotalPromotion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.FeeName ', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu phí mới';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.FeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.DivisionID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.DivisionName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.GradeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.GradeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.ClassID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.ClassName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.SchoolYearID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.DateFrom.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.DateTo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.ReceiptTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoản thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.ReceiptTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đóng phí CSVC 2 lần';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.IsCSVC', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin thiết lập phí đầu năm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Các khoản phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.Detail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.Attach.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.Notes.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2212.Lich_su', @FormID, @LanguageValue, @Language;
