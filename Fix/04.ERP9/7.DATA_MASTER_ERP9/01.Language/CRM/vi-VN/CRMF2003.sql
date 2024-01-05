------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2003 - CRM 
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
SET @FormID = 'CRMF2003';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'CRMF2003-Lịch sử cuộc gọi';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2003.CRMF2003Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn số line';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2003.Phone' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số gọi đến';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2003.Source' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Số gọi đi';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2003.Destination' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Tình trạng';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2003.Status' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Thời gian';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2003.Duration' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Ngày';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2003.Start' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Download';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2003.Download' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Từ ngày';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2003.FromDate' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Đến ngày';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2003.ToDate' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Mã khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2003.AccountID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Tên khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2003.AccountName' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Địa chỉ';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2003.Address' , @FormID, @LanguageValue, @Language;

 -----Status

  SET @LanguageValue = N'Tiếp nhận cuộc gọi';
 EXEC ERP9AddLanguage @ModuleID, 'NORMAL_CLEARING' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Hủy cuộc gọi';
 EXEC ERP9AddLanguage @ModuleID, 'ORIGINATOR_CANCEL' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Chuyển tiếp cuộc gọi';
 EXEC ERP9AddLanguage @ModuleID, 'BLIND_TRANSFER' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Người khác trả lời hoặc ngắt cuộc gọi';
 EXEC ERP9AddLanguage @ModuleID, 'LOSE_RACE' , @FormID, @LanguageValue, @Language;
 
  SET @LanguageValue = N'Cuộc gọi nhỡ';
 EXEC ERP9AddLanguage @ModuleID, 'NO_ANSWER' , @FormID, @LanguageValue, @Language;
 
  SET @LanguageValue = N'Gọi sai số';
 EXEC ERP9AddLanguage @ModuleID, 'NO_USER_RESPONSE' , @FormID, @LanguageValue, @Language;
 
  SET @LanguageValue = N'Số gọi không chính xác';
 EXEC ERP9AddLanguage @ModuleID, 'NO_ROUTE_DESTINATION' , @FormID, @LanguageValue, @Language;
 
  SET @LanguageValue = N'Đã đăng xuất, không kết nối được';
 EXEC ERP9AddLanguage @ModuleID, 'SUBSCRIBER_ABSENT' , @FormID, @LanguageValue, @Language;
 
  SET @LanguageValue = N'Lỗi lết nối mạng hoặc kết nối quá lâu';
 EXEC ERP9AddLanguage @ModuleID, 'NORMAL_TEMPORARY_FAILURE' , @FormID, @LanguageValue, @Language;
 
  SET @LanguageValue = N'Chuyển tiếp cuộc gọi';
 EXEC ERP9AddLanguage @ModuleID, 'ATTENDED_TRANSFER' , @FormID, @LanguageValue, @Language;
 
  SET @LanguageValue = N'Tạm thời chặn không muốn tiếp nhận cuộc gọi';
 EXEC ERP9AddLanguage @ModuleID, 'PICKED_OFF' , @FormID, @LanguageValue, @Language;
 
  SET @LanguageValue = N'Số máy bận';
 EXEC ERP9AddLanguage @ModuleID, 'USER_BUSY' , @FormID, @LanguageValue, @Language
 
  SET @LanguageValue = N'Cuộc gọi bị từ chối';
 EXEC ERP9AddLanguage @ModuleID, 'CALL_REJECTED' , @FormID, @LanguageValue, @Language;
 
  SET @LanguageValue = N'Số gọi không đúng format';
 EXEC ERP9AddLanguage @ModuleID, 'INVALID_NUMBER_FORMAT' , @FormID, @LanguageValue, @Language
 
  SET @LanguageValue = N'Lỗi kết nối mạng';
 EXEC ERP9AddLanguage @ModuleID, 'NETWORK_OUT_OF_ORDER' , @FormID, @LanguageValue, @Language;
 
  SET @LanguageValue = N'Số gọi không hoạt động';
 EXEC ERP9AddLanguage @ModuleID, 'DESTINATION_OUT_OF_ORDER' , @FormID, @LanguageValue, @Language

  SET @LanguageValue = N'Ngắt kết nối';
 EXEC ERP9AddLanguage @ModuleID, 'MANAGER_REQUEST' , @FormID, @LanguageValue, @Language;
 
  SET @LanguageValue = N'Người dùng không đăng ký';
 EXEC ERP9AddLanguage @ModuleID, 'USER_NOT_REGISTERED' , @FormID, @LanguageValue, @Language;







