-----------------------------------------------------------------------------------------------------
                                            -- Script tạo ngôn ngữ CSMF2003- CSM
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
                                            SET @FormID = 'CSMF2003';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2003.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2003.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2003.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tham chiếu';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2003.DispatchID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Serial';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2003.SerialNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số IMEI';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2003.IMEINo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2003.CustomerGroup', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã thiết bị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2003.ProductID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2003.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2003.PhoneNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2003.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2003.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái GSX';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2003.GSXStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2003.IsPSCName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật chi tiết đơn hàng giao nhận';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2003.Title', @FormID, @LanguageValue, @Language;

