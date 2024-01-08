-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2293- OO
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
SET @FormID = 'OOF2293';

SET @LanguageValue = N'Chọn chỉ tiêu/target';
EXEC ERP9AddLanguage @ModuleID, 'OOF2293.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chỉ tiêu/target';
EXEC ERP9AddLanguage @ModuleID, 'OOF2293.TargetTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chỉ tiêu/target';
EXEC ERP9AddLanguage @ModuleID, 'OOF2293.TargetTaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2293.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời điểm bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2293.BeginDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hạn hoàn thành';
EXEC ERP9AddLanguage @ModuleID, 'OOF2293.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người giao';
EXEC ERP9AddLanguage @ModuleID, 'OOF2293.RequestUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2293.AssignedUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2293.StatusName', @FormID, @LanguageValue, @Language;
