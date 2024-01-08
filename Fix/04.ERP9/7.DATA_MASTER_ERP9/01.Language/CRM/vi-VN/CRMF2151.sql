-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2151- OO
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
SET @FormID = 'CRMF2151';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày gọi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.CallDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số gọi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.Source', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số nhận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.Destination', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời lượng cuộc gọi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.Duration', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng đài';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.DID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.TypeOfCall', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.Extend', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.RequestStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tải ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.Download', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nghe';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.Play', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.Add', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Máy nhánh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.ExtendName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.RequestSupportID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Yêu cầu hỗ trợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.RequestSupportName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái cuộc gọi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại cuộc gọi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.TypeOfCallName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.APKContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.APKAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.APKSupportRequiredID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đầu mối/Liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.ContactOrLead', @FormID, @LanguageValue, @Language;