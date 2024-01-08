-----------------------------------------------------------------------------------------------------
                                            -- Script tạo ngôn ngữ CSMF2001- CSM
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
                                            SET @FormID = 'CSMF2001';

											

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức gửi hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.TransferTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.TransferUnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số AWB';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.AWBNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian gửi hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.TransferTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng máy';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trọng lượng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.Weight', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số kiện hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.Package', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đại lý';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.DispatchReceiveID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Serial';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.SerialNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số IMEI';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.IMEINo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.ContactNameSend', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.PhoneNumberSend', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.EmailSend', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sold to';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.SlodToSend', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ship to ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.ShipToSend', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.AddressSend', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.AddressReceive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.ContactNameReceive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.PhoneNumberReceive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.EmailReceive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sold to';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.SoldToReceive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ship to';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.ShipToReceive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật đơn hàng giao nhận';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đại lý';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.DispatchSendName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đại lý';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.DispatchReceiveName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.StoreSendName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.StoreReceiveName', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Thông tin bên giao';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.Group1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin bên nhận';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.Group2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.Description.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đã tạo PSC';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2001.IsPSC', @FormID, @LanguageValue, @Language;



