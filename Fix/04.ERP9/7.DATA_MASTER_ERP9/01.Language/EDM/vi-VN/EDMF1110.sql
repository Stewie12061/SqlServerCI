-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF1110- EDM
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
SET @FormID = 'EDMF1110';

SET @LanguageValue = N'Cập nhật đưa đón';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1110.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1110.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1110.PromotionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1110.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoản mục phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1110.ReceiptTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điểm đến';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1110.ArrivedPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điểm đón';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1110.PickupPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đưa đón';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1110.ShuttleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1110.StudentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1110.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1110.btnStudentList', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1110.ReceiptTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoản thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1110.ReceiptTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1110.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1110.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1110.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1110.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1110.PromotionID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1110.PromotionName.CB', @FormID, @LanguageValue, @Language;
