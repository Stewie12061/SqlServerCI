-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2133- OO
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
SET @ModuleID = 'OO';
SET @FormID = 'OOF2133';

SET @LanguageValue = N'Đánh giá công việc hàng loạt';
EXEC ERP9AddLanguage @ModuleID, 'OOF2133.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điểm số đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'OOF2133.Mark', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ý kiến người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'OOF2133.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N' Trạng thái đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'OOF2133.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ chối hoàn thành';
EXEC ERP9AddLanguage @ModuleID, 'OOF2133.Reject', @FormID, @LanguageValue, @Language;

