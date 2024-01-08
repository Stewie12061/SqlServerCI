-----------------------------------------------------------------------------------------------------
                                            -- Script tạo ngôn ngữ CSMF1103- CSM
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
                                            SET @FormID = 'CSMF1103';


SET @LanguageValue = N'Số TT Hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1103.DisplayOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1103.DataID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại CheckList';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1103.CheckListType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1103.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1103.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1103.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1103.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1103.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1103.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hãng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1103.FirmID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hãng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1103.FirmName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1103.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1103.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại CheckList';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1103.CheckListTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật dữ liệu theo hãng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1103.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1103.CheckListType.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1103.CheckListTypeName.CB', @FormID, @LanguageValue, @Language;

