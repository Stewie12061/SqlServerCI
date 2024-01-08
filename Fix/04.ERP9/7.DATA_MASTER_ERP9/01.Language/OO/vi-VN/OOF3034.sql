-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF3034- OO
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
SET @FormID = 'OOF3034';

SET @LanguageValue = N'Báo cáo Tình hình công việc theo nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'OOF3034.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF3034.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'OOF3034.AssignedToUserID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Dữ liệu in';
EXEC ERP9AddLanguage @ModuleID, 'OOF3034.PrintData', @FormID, @LanguageValue, @Language;



