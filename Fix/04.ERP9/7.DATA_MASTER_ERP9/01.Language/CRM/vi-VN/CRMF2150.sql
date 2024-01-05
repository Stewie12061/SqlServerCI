-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2150- OO
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
SET @FormID = 'CRMF2150';

SET @LanguageValue = N'Danh mục lịch sử cuộc gọi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày gọi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.CallDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số gọi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.Source', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số nhận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.Destination', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời lượng cuộc gọi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.Duration', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng đài';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.DID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại cuộc gọi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.TypeOfCall', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Máy nhánh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.Extend', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái cuộc gọi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.RequestStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tải ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.Download', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nghe';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.Play', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.Add', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Máy nhánh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.ExtendName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Yêu cầu hỗ trợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.RequestSupportID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Yêu cầu hỗ trợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.RequestSupportName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái cuộc gọi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại cuộc gọi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.TypeOfCallName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đầu mối/Liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.ContactOrLead', @FormID, @LanguageValue, @Language;