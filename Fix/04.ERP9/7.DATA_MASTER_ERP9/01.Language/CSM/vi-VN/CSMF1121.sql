-----------------------------------------------------------------------------------------------------
                                            -- Script tạo ngôn ngữ CSMF1121- CSM
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
                                            SET @FormID = 'CSMF1121';


SET @LanguageValue = N'Cập nhật DepotBilling';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1121.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1121.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1121.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hãng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1121.FirmID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1121.ProductType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Model';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1121.ModelID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã DepotBilling ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1121.DepotBillingID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên DepotBilling';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1121.DepotBillingName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1121.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1121.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1121.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1121.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1121.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1121.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1121.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hãng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1121.FirmName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật DepotBilling';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1121.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1121.FirmID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1121.FirmName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1121.ProductType.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1121.ProductTypeName.CB', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1121.ModelID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1121.ModelName.CB', @FormID, @LanguageValue, @Language;


