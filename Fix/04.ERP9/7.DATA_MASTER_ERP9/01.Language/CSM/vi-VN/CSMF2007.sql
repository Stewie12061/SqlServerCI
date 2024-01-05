-----------------------------------------------------------------------------------------------------
                                            -- Script tạo ngôn ngữ CSMF2007- CSM
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
                                            SET @FormID = 'CSMF2007';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2007.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tham chiếu';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2007.DispatchID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2007.ProductID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Serial';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2007.SerialNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sô IMEI';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2007.IMEINumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2007.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái xác nhận GSX';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2007.GSXStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xác nhận GSX';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2007.Title', @FormID, @LanguageValue, @Language;

