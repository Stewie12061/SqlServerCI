-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CSMF2052- CSM
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
SET @FormID = 'CSMF2052';

SET @LanguageValue = N'Xem thông tin biên bản trả hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số biên bản';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày trả hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức trả hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.SendTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.SendUnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số AWB';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.AWBNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian trả hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.SendTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng máy';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trọng lượng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.Weight', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số kiện hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.Package', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đại lý';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.DispatchSendID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.StoreSendID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đại lý';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.DispatchReceiveID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.StoreReceiveID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.TimeReceive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người xác nhận';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.ConfirmUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tham chiếu';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.DispatchID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bên nhận';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.ReceiveID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.FromReceiveDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'đến';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.ToReceiveDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Serial';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.SerialNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số IMEI';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.IMEINo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày trả máy';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.FromSendDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'đến';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.ToSendDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.ReceiveName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.SendUnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đại lý';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.DispatchSendName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.StoreSendName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.AddressSend', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.ContactorSend', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.TelSend', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.EmailSend', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sold To';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.SoldToSend', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ship To';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.ShipToSend', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đại lý';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.DispatchReceiveName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.StoreReceiveName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.AddressReceive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.ContactorReceive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.TelReceive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.EmailReceive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sold To';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.SoldToReceive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ship To';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.ShipToReceive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.SendTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.SenderName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.SenderAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.SenderContact', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.SenderTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.SenderEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.ReceiveAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.ReceiveContact', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.ReceiveTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.ReceiveEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin bên giao';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.Group1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin bên nhận';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.Group2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người xác nhận';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.ConfirmUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.GroupCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.GroupDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xác nhận biên bản trả hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.GroupCheckOrderReturn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.GroupAttach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.GroupNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.GroupHistory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu tham chiếu';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.DispatchID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.ProductID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.ProductName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số IMEI mới';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.IMEINoNew', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số IMEI';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.IMEINo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Serial mới';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.SerialNoNew', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Serial';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.SerialNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin lỗi';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.ErrorInformation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.CustomerGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái xác nhận';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2052.Notes', @FormID, @LanguageValue, @Language;

