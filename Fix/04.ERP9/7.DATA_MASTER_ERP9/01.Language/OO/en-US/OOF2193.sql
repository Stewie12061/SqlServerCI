-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2193- OO
-- [Đình Hòa] [25/02/2021] - Bổ sung ngôn ngữ
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
SET @Language = 'en-US' 
SET @ModuleID = 'OO';
SET @FormID = 'OOF2193';

SET @LanguageValue = N'Choose Milestone';
EXEC ERP9AddLanguage @ModuleID, 'OOF2193.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MilestoneID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2193.MilestoneID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Milestone Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2193.MilestoneName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority';
EXEC ERP9AddLanguage @ModuleID, 'OOF2193.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2193.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time Request';
EXEC ERP9AddLanguage @ModuleID, 'OOF2193.TimeRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Deadline Request';
EXEC ERP9AddLanguage @ModuleID, 'OOF2193.DeadlineRequest', @FormID, @LanguageValue, @Language;
