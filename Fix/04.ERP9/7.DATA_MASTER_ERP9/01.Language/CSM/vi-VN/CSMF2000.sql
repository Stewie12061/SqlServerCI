-----------------------------------------------------------------------------------------------------
                                            -- Script tạo ngôn ngữ CSMF2000- CSM
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
                                            SET @FormID = 'CSMF2000';

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2000.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2000.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2000.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2000.TransferUnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số AWB';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2000.AWBNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Serial';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2000.SerialNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số IMEI';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2000.IMEINo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái GSX';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2000.GSXStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2000.TransferUnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn hàng giao nhận';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2000.Title', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Bên gửi';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2000.SenderName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tham chiếu';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2000.DispatchID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bên gửi';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2000.DispatchSendID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2000.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2000.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đã tạo PSC';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2000.IsPSC', @FormID, @LanguageValue, @Language;
