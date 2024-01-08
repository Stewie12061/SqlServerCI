-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF1091- EDM
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
SET @FormID = 'EDMF1091';

SET @LanguageValue = N'Cập nhật biểu phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã biểu phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.FeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên biểu phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.FeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.SchoolYearID ', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoản thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.ReceiptTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.FeeTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiền phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'1 chiều';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.AmountOfOneWay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'2 chiều';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.AmountOfTwoWay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.AmountOfDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'1 tháng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.AmountOfOneMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'6 tháng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.AmountOfSixMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'9 tháng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.AmountOfNineMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.AmountOfYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.AnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.AnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.GradeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.GradeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.ReceiptTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoản thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.ReceiptTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.FeeTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại dữ liệu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.Description.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.SchoolYearID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.DateFrom.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.DateTo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.TabEDMT1091', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Học thử';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.TabEDMT1092', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hoạt động ngoại khóa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.TabEDMT1093', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đưa đón';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.TabEDMT1094', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giữ ngoài giờ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.TabEDMT1095', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.GradeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1091.GradeName.CB', @FormID, @LanguageValue, @Language;
