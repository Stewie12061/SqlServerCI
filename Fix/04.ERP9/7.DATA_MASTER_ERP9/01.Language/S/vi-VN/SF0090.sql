-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF0090- S
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
SET @ModuleID = 'S';
SET @FormID = 'SF0090';

SET @LanguageValue = N'Bàn giao công việc';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.ModuleID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.ModuleName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.BusinessID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.BusinessName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người bàn giao';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.HandoverName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người nhận bàn giao';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.ReceiverName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái công việc';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.TaskStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái vấn đề';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.IssueStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.ListBusiness', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái milestone';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.MilestoneStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.ModuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.LeadStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.OpportunityStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.CampaignStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.RequestStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.BusinessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.BusinessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.StatusName', @FormID, @LanguageValue, @Language;
