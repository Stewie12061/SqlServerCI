-----------------------------------------------------------------------------------------------------
                                            -- Script tạo ngôn ngữ CSMF1101- CSM
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
                                            SET @FormID = 'CSMF1101';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1101.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hãng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1101.FirmID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hãng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1101.FirmName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sử dụng API';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1101.IsUseAPI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1101.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Link API';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1101.APILink', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại API';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1101.APITypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1101.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1101.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1101.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1101.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1101.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1101.LastModifyDate', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Cập nhật hãng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1101.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1101.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1101.Description.CB', @FormID, @LanguageValue, @Language;

