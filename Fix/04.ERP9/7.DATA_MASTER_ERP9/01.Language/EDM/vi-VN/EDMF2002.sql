-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2002- EDM
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
SET @FormID = 'EDMF2002';

SET @LanguageValue = N'Khoá';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.DivisionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tư vấn';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tư vấn';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.SchoolID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.SchoolName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa nguồn đầu mối ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.IsInheritClue', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã phụ huynh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.ParentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phụ huynh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.ParentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.Telephone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ nhà';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.StudentDateBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.ParentDateBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giới tính';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.Sex', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giới tính';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.SexName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết quả tư vấn';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.ResultID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết quả tư vấn';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.ResultName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.DateFrom', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.DateTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.Information', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nam';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.Male', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nữ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.Female', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin phiếu tư vấn';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.Lich_su', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem thông tin phiếu tư vấn';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xưng hô';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.Prefix', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.StudentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.OldCustomer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.Notes.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.Attach.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.Detail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoản thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.ReceiptTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.FeeTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.UnitName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương thức đóng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.PaymentMethodName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.UnitPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đóng CSVC 2 lần';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.IsCSVC' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.Quantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.SumAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.PromotionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền KM';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.AmountPromotion' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng tiền sau KM';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.AmountTotalPromotion' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.FeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày nhập học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2002.AdmissionDate' , @FormID, @LanguageValue, @Language;