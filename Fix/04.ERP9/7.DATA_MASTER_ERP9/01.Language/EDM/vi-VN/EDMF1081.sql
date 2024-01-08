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
SET @ModuleID = 'EDM';
SET @FormID = 'EDMF1081';

SET @LanguageValue = N'Cập nhật Feeling';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1081.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã Feeling';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1081.FeelingID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Tên Feeling';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1081.FeelingName', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1081.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1081.IsCommon', @FormID, @LanguageValue, @Language;

