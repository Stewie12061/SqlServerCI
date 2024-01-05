-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2202- EDM
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
SET @FormID = 'EDMF2202';

SET @LanguageValue = N'Chi tiết thay đổi mức đóng phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.StudentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.btnStudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hiệu lực';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.ImlementationDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.SchoolYearID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.ClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.ClassName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoản phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.ReceiptTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương thức đóng hiện tại';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.CurrentPaymentMethodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền hiện tại';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.AmountOld', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương thức đóng mới';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.PaymentMethodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền thực tế';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.SumAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.PromotionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.AmountPromotion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền sau khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.AmountTotalPromotion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền phải thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.AmountReceived', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.OldFeeName ', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu phí mới';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.NewFeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.DivisionID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.DivisionName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.GradeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.GradeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.ClassID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.ClassName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.SchoolYearID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.DateFrom.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.DateTo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.ReceiptTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoản thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.ReceiptTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đóng phí CSVC 2 lần';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.IsCSVC', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đóng mới hoàn toàn';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.IsNew', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoản phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.ReceiptTypeNamePTTTV', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thay đổi mức phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.Detail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.Attach.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.Notes.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.Lich_su', @FormID, @LanguageValue, @Language

SET @LanguageValue = N'Khoản phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2202.ReceiptTypeNamePTTTV', @FormID, @LanguageValue, @Language;
