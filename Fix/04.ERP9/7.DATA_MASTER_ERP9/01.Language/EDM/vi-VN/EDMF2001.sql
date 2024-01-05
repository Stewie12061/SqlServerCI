
-- Script tạo ngôn ngữ EDMF2001- EDM
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
SET @FormID = 'EDMF2001';

SET @LanguageValue = N'Khoá';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.DivisionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tư vấn';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tư vấn';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.SchoolID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.SchoolName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa nguồn đầu mối ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.IsInheritClue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.ParentDateBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phụ huynh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.ParentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phụ huynh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.ParentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xưng hô';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.Prefix', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.Telephone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ nhà';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.StudentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.StudentDateBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giới tính';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.Sex', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết quả tư vấn';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.ResultID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.DateFrom', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.DateTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.Information', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nam';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.Male', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nữ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.Female', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật phiếu thông tin tư vấn';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nam';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.Male' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nữ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.Female' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giới tính';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.lblGender' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.Status' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.lblOldCustomer' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mới';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.New' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cũ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.Old' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân loại 1';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.CB_S1_ParentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân loại 2';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.CB_S2_ParentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân loại 3';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.CB_S3_ParentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân loại 1';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.CB_S1_StudentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân loại 2';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.CB_S2_StudentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân loại 3';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.CB_S3_StudentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ông';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.Mr' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bà';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.Mrs' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa điều chuyển học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.IsInheritTransfer' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày nhập học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.AdmissionDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.FeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoản thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.ReceiptTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.FeeTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.UnitName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương thức đóng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.PaymentMethodName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.UnitPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đóng CSVC 2 lần';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.IsCSVC' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.Quantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.SumAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.PromotionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền KM';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.AmountPromotion' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng tiền sau KM';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.AmountTotalPromotion' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.ReceiptTypeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoản thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.ReceiptTypeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin Phiếu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.VoucherGroup' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ huynh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.ParentGroup' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.StudentGroup' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2001.btnChoosePromotion' , @FormID, @LanguageValue, @Language;