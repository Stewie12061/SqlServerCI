-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2106- CRM
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
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF9005';

SET @LanguageValue = N'Người thực hiện';
EXEC ERP9AddLanguage @ModuleID, '.TitleCRMFCRMF9005.AssignedListUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.EventEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.EventStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.EventStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên sự kiện';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.EventSubject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa điểm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.Location', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại đối tượng liên quan';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại đối tượng liên quan';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.RelatedToTypeID_REL', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật sự kiện';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sự kiện';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.Type1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hoạt động';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.TypeActive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.AssignedListUserID', @FormID, @LanguageValue, @Language;