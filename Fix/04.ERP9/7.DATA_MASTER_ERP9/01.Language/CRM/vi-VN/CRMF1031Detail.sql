-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1031Detail- CRM
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
SET @FormID = 'CRMF1031Detail';

SET @LanguageValue = N'Mã APK';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1031Detail.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1031Detail.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã APK nhóm nhận email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1031Detail.APKGroupReceiverEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhóm nhận email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1031Detail.GroupReceiverID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã APK phiếu nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1031Detail.RelatedToID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã người nhận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1031Detail.ReceiverID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên người nhận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1031Detail.ReceiverName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1031Detail.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1031Detail.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1031Detail.Mobile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1031Detail.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1031Detail.RelatedToTypeID_REL', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảng nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1031Detail.RelTableID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại đối tượng liên quan';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1031Detail.RelatedToTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xưng hô';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1031Detail.Prefix', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ và tên đệm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1031Detail.FirstName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1031Detail.LastName', @FormID, @LanguageValue, @Language;

