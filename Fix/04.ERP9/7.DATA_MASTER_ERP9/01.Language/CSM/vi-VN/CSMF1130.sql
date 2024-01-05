-----------------------------------------------------------------------------------------------------
                                            -- Script tạo ngôn ngữ CSMF1130- CSM
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
                                            SET @FormID = 'CSMF1130';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1130.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1130.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hãng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1130.FirmID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã Reimbursement Part';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1130.ReimbursementID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên Reimbursement Part';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1130.ReimbursementName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1130.Price', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1130.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1130.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1130.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1130.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1130.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1130.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1130.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh mục Reimbursement Part';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1130.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1130.FirmID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1130.FirmName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1130.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1130.Description.CB', @FormID, @LanguageValue, @Language;

