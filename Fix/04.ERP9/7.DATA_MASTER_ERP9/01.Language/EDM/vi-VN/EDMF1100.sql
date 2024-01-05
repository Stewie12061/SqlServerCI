-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF1100- EDM
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
SET @FormID = 'EDMF1100';

SET @LanguageValue = N'Danh sách khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1100.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1100.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1100.PromotionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1100.PromotionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày áp dụng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1100.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1100.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1100.PromotionType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoản thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1100.ReceiptTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1100.Value', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoản thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1100.ReceiptTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng còn lại';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1100.RemainQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1100.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1100.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1100.ReceiptTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoản thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1100.ReceiptTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hình thức';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1100.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1100.Description.CB', @FormID, @LanguageValue, @Language;