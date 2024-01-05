------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2000 - CRM 
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000)
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thuc thi truy van
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2000';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'CRMF2000-Hỗ trợ online';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.CRMF2000Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID Khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.AccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người liên hệ';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.ContactName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID người liên hệ';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.ContactID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.AccountName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.btnContact' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.btnObject' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.btnSaleOrder' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CUỘC GỌI ĐẾN';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.CallFrom' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin cuộc gọi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.CallInformation' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CUỘC GỌI ĐI';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.CallTo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công nợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.BtnViewDebts' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử cuộc gọi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.BtnViewHistory' , @FormID, @LanguageValue, @Language;

-------------- 21/09/2021 - Hoài Bảo: Cập nhật ngôn ngữ Lịch sử đơn hàng -> Đơn hàng --------------
SET @LanguageValue = N'Đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.BtnViewOrder' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bàn phím ảo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.Keyboard' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhập số gọi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.TextNumber' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thêm nhanh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.QuickAdd' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mở rộng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.Extend' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.O04ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhãn hiệu 01';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.Description02' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhãn hiệu 02';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.Description03' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhãn hiệu 03';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.Description04' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhãn hiệu 04';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.Description05' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đăng ký cuộc gọi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.Register' , @FormID, @LanguageValue, @Language;

-------------- 21/09/2021 - Hoài Bảo: Bổ sung ngôn ngữ cho màn hình gọi điện --------------
SET @LanguageValue = N'Đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.btnLead' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Yêu cầu hỗ trợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.btnSupportRequired' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Yêu cầu dịch vụ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.btnServiceRequest' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức năng gọi theo danh sách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.CallByList' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đang online';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.isOnline' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đang offline';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2000.isOffline' , @FormID, @LanguageValue, @Language;