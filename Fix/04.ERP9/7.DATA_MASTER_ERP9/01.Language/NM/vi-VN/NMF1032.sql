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
SET @FormID = 'NMF1032';

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'NMF1032.DivisionID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã định mức';
EXEC ERP9AddLanguage @ModuleID, 'NMF1032.QuotaNutritionID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Tên định mức';
EXEC ERP9AddLanguage @ModuleID, 'NMF1032.QuotaNutritionName', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã loại món ăn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1032.DishTypeID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'NMF1032.IsCommon', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'NMF1032.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'NMF1032.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'NMF1032.MenuTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'NMF1032.MenuTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem chi tiết định mức dinh dưỡng';
EXEC ERP9AddLanguage @ModuleID, 'NMF1032.Title', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Thành phần dinh dưỡng';
EXEC ERP9AddLanguage @ModuleID, 'NMF1032.SystemName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định mức chuẩn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1032.QuotaStandard', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ lệ đạt thấp nhất (%)';
EXEC ERP9AddLanguage @ModuleID, 'NMF1032.MinRatio', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ lệ đạt cao nhất (%)';
EXEC ERP9AddLanguage @ModuleID, 'NMF1032.MaxRatio', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'NMF1032.CreateUserID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'NMF1032.CreateDate', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'NMF1032.LastModifyUserID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'NMF1032.LastModifyDate', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Thông tin chi tiết định mức dinh dưỡng';
EXEC ERP9AddLanguage @ModuleID, 'NMF1032.Detail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'NMF1032.Lich_su', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm thực đơn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1032.MenuTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'NMF1032.Info', @FormID, @LanguageValue, @Language;
