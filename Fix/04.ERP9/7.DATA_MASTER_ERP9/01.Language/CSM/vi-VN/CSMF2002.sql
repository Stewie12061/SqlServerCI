-----------------------------------------------------------------------------------------------------
                                            -- Script tạo ngôn ngữ CSMF2002- CSM
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
                                            SET @FormID = 'CSMF2002';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức gửi hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.TransferTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.TransferUnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số AWB';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.AWBNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian gửi hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.TransferTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng máy';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trọng lượng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.Weight', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số kiện hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.Package', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đại lý';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.DispatchReceiveName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đại lý';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.DispatchSendName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.StoreReceiveName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.StoreSendName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Serial';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.SerialNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số IMEI';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.IMEINo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.ContactNameSend', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.PhoneNumberSend', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.EmailSend', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sold to';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.SlodToSend', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ship to ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.ShipToSend', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.AddressSend', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.AddressReceive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.ContactNameReceive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.PhoneNumberReceive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.EmailReceive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sold to';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.SoldToReceive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ship to';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.ShipToReceive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem thông tin đơn hàng giao nhận';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.Title', @FormID, @LanguageValue, @Language;



SET @LanguageValue = N'Đơn vị vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.TransferUnitName ', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đại lý';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.DispatchSendName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đại lý';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.DispatchReceiveName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.StoreSendName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.StoreReceiveName', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Thông tin bên giao';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.Group1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin bên nhận';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.Group2', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Thông tin đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.GroupCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xác nhận đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.GroupCheckOrder', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Thông tin chi tiết lỗi check GSX';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.GroupErrGSX', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.GroupDetail', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.GroupAttach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.GroupNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.GroupHistory', @FormID, @LanguageValue, @Language;



SET @LanguageValue = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.Status', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Trọng lượng thực tế';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.ActWeight', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng thực tế';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.ActQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số kiện hàng thực tế';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.ActPackage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.TimeReceive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.ActNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức gửi hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.TransferTypeName', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2002.LastModifyDate', @FormID, @LanguageValue, @Language;


