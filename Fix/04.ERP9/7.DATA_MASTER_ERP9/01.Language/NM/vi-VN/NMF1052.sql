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
SET @FormID = 'NMF1052';

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'NMF1052.DivisionID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã món ăn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1052.DishID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Tên món ăn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1052.DishName', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã loại món ăn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1052.DishTypeID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'NMF1052.IsCommon', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'NMF1052.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'NMF1052.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguyên liệu';
EXEC ERP9AddLanguage @ModuleID, 'NMF1052.MaterialsID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'NMF1052.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối lượng';
EXEC ERP9AddLanguage @ModuleID, 'NMF1052.Mass', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối lượng QĐ';
EXEC ERP9AddLanguage @ModuleID, 'NMF1052.ConvertedMass', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'NMF1052.CreateUserID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'NMF1052.CreateDate', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'NMF1052.LastModifyUserID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'NMF1052.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem chi tiết món ăn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1052.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin món ăn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1052.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết món ăn';
EXEC ERP9AddLanguage @ModuleID, 'NMF1052.Detail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'NMF1052.Lich_su', @FormID, @LanguageValue, @Language;

