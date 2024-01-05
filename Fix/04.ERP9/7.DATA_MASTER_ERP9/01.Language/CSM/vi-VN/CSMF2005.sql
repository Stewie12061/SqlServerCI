-----------------------------------------------------------------------------------------------------
                                            -- Script tạo ngôn ngữ CSMF2005- CSM
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
                                            SET @FormID = 'CSMF2005';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2005.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2005.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2005.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức gửi hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2005.ActTransferTypeID ', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2005.TransferUnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2005.TimeReceive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số AWB';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2005.ActAWBNo ', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng thực tế';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2005.ActQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trọng lượng thực tế';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2005.ActWeight', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số kiện hàng thực tế';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2005.ActPackage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2005.ActNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2005.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2005.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2005.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2005.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị vận chuyển';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2005.ActTransferUnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xác nhận đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2005.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2005.StatusID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2005.StatusName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2005.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2005.Description.CB', @FormID, @LanguageValue, @Language;


