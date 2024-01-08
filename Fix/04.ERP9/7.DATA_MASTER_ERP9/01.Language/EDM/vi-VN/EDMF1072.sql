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
SET @FormID = 'EDMF1072';

SET @LanguageValue = N'Xem chi tiết điều tra tâm lý';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1072.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1072.DivisionID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Loại điều tra tâm lý';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1072.PsychologizeType', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã điều tra tâm lý';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1072.PsychologizeID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Tên điều tra tâm lý';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1072.PsychologizeName', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Điều tra tâm lý cha';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1072.PsychologizeGroup', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1072.IsCommon', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1072.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số thứ tự';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1072.Orders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin điều tra tâm lý';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1072.Master.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1072.Attacth.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1072.Notes.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1072.History.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại điều tra tâm lý';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1072.PsychologizeTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1072.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1072.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1072.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1072.LastModifyDate', @FormID, @LanguageValue, @Language;

