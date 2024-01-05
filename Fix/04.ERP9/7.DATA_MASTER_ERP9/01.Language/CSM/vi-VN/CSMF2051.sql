-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CSMF2051- CSM
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
SET @ModuleID = 'CSM';
SET @FormID = 'CSMF2051';

SET @LanguageValue = N'Cập nhật biên bản trả hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số biên bản';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày trả hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức trả hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.SendTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.SendUnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số AWB';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.AWBNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian trả hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.SendTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng máy';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trọng lượng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.Weight', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số kiện hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.Package', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đại lý';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.DispatchSendID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.StoreSendID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đại lý';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.DispatchReceiveID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.StoreReceiveID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.TimeReceive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tham chiếu';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.DispatchID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bên nhận';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.ReceiveID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.FromReceiveDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'đến';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.ToReceiveDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Serial';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.SerialNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số IMEI';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.IMEINo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày trả máy';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.FromSendDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'đến';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.ToSendDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.SendUnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đại lý';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.DispatchSendName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.StoreSendName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.AddressSend', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.ContactorSend', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.TelSend', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.EmailSend', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sold To';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.SoldToSend', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ship To';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.ShipToSend', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đại lý';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.DispatchReceiveName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.StoreReceiveName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.AddressReceive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.ContactorReceive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.TelReceive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.EmailReceive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sold To';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.SoldToReceive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ship To';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.ShipToReceive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.SendTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.Description.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin bên giao';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.Group1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin bên nhận';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2051.Group2', @FormID, @LanguageValue, @Language;

