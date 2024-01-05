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
SET @ModuleID = 'NM';
SET @FormID = 'NMF1031';

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'NMF1031.DivisionID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã định mức';
EXEC ERP9AddLanguage @ModuleID, 'NMF1031.QuotaNutritionID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Tên định mức';
EXEC ERP9AddLanguage @ModuleID, 'NMF1031.QuotaNutritionName', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã loại món ăn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1031.DishTypeID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'NMF1031.IsCommon', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'NMF1031.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'NMF1031.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'NMF1031.MenuTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'NMF1031.MenuTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định mức dinh dưỡng';
EXEC ERP9AddLanguage @ModuleID, 'NMF1031.Title', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Thành phần dinh dưỡng';
EXEC ERP9AddLanguage @ModuleID, 'NMF1031.SystemName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định mức chuẩn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1031.QuotaStandard', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ lệ đạt thấp nhất (%)';
EXEC ERP9AddLanguage @ModuleID, 'NMF1031.MinRatio', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ lệ đạt cao nhất (%)';
EXEC ERP9AddLanguage @ModuleID, 'NMF1031.MaxRatio', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm thực đơn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1031.MenuTypeID', @FormID, @LanguageValue, @Language;

