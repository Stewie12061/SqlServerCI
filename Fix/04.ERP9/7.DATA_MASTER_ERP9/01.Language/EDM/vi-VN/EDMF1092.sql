-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF1092- EDM
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
SET @FormID = 'EDMF1092';

SET @LanguageValue = N'Thông tin chi tiết biểu phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã biểu phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.FeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên biểu phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.FeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.SchoolYearID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.Master.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.Detail.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.History.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.Notes.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.Attacth.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoản thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.ReceiptTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiền phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.Detail1.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Học thử';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.Detail2.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hoạt động ngoại khóa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.Detail3.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đưa đón';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.Detail4.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giữ ngoài giờ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.Detail5.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoản thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.ReceiptTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.FeeTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiền phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'1 chiều';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.AmountOfOneWay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'2 chiều';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.AmountOfTwoWay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.AmountOfDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'1 tháng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.AmountOfOneMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'6 tháng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.AmountOfSixMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'9 tháng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.AmountOfNineMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1092.AmountOfYear', @FormID, @LanguageValue, @Language;