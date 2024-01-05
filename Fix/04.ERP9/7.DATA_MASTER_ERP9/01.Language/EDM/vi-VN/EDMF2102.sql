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
SET @FormID = 'EDMF2102';

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2102.Attach.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2102.Notes.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2102.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã lịch học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2102.DailyScheduleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày lịch học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2102.DateSchedule', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2102.TermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2102.SchoolName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2102.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2102.ClassName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2102.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ giờ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2102.FromHour', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến giờ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2102.ToHour', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ 2';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2102.Monday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ 3';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2102.Tuesday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ 4';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2102.Wednesday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ 5';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2102.Thursday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ 6';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2102.Friday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ 7';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2102.Saturday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2102.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2102.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2102.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2102.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2102.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2102.Detail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2102.Lich_su', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem thông tin thời khóa biểu năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2102.Title', @FormID, @LanguageValue, @Language;

