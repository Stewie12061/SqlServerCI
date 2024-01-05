-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF3032- OO
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
SET @FormID = 'OOF3032';

SET @LanguageValue = N'Báo cáo chi tiết công việc theo nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'OOF3032.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF3032.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'OOF3032.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'OOF3032.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'OOF3032.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF3032.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF3032.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dữ liệu in';
EXEC ERP9AddLanguage @ModuleID, 'OOF3032.PrintData', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái vấn đề';
EXEC ERP9AddLanguage @ModuleID, 'OOF3032.StatusIS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái yêu cầu hỗ trợ';
EXEC ERP9AddLanguage @ModuleID, 'OOF3032.StatusHD', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái milestone';
EXEC ERP9AddLanguage @ModuleID, 'OOF3032.StatusMT', @FormID, @LanguageValue, @Language;

