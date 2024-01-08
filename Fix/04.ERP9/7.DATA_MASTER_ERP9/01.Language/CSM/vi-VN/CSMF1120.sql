-----------------------------------------------------------------------------------------------------
                                            -- Script tạo ngôn ngữ CSMF1120- CSM
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
                                            SET @FormID = 'CSMF1120';

SET @LanguageValue = N'Danh mục DepotBilling';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1120.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1120.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1120.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hãng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1120.FirmID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1120.ProductType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã Model';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1120.ModelID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã Depot Billing';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1120.DepotBillingID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên Depot Billing';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1120.DepotBillingName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1120.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1120.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh mục Depot Billing';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1120.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hãng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1120.FirmID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hãng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1120.FirmName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1120.ProductType.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1120.ProductTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã Model';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1120.ModelID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên Model';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1120.ModelName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1120.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1120.Description.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1120.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hãng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1120.FirmName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1120.ProductTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Model';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1120.ModelName', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Hãng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1120.FirmID1120', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1120.ProductType1120', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Model';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1120.ModelID1120', @FormID, @LanguageValue, @Language;

