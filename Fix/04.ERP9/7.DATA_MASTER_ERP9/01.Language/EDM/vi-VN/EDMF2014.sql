-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2014- EDM
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
SET @FormID = 'EDMF2014';

SET @LanguageValue = N'Mã học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2014.StudentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2014.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đặc điểm tâm lý';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2014.Tab0', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cách giáo dục trẻ của phụ huynh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2014.Tab1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật điều tra tâm lý học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2014.Title', @FormID, @LanguageValue, @Language;


