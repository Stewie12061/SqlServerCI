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
SET @FormID = 'NMF1042';

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'NMF1042.DivisionID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã loại món ăn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1042.DishTypeID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Tên loại món ăn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1042.DishTypeName', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'NMF1042.IsCommon', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'NMF1042.Disabled', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'NMF1042.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem chi tiết loại món ăn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1042.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'NMF1042.CreateUserID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'NMF1042.CreateDate', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'NMF1042.LastModifyUserID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'NMF1042.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin loại món ăn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1042.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'NMF1042.Lich_su', @FormID, @LanguageValue, @Language;

