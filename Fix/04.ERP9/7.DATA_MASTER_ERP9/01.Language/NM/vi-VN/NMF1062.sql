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
SET @FormID = 'NMF1062';

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'NMF1062.DivisionID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã bữa ăn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1062.MealID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Tên bữa ăn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1062.MealName', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'NMF1062.IsCommon', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'NMF1062.Disabled', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'NMF1062.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem chi tiết bữa ăn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1062.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'NMF1062.CreateUserID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'NMF1062.CreateDate', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'NMF1062.LastModifyUserID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'NMF1062.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin bữa ăn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1062.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'NMF1062.Lich_su', @FormID, @LanguageValue, @Language;

