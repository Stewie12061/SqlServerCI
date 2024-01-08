-----------------------------------------------------------------------------------------------------
                                            -- Script tạo ngôn ngữ CSMF1131- CSM
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
                                            SET @FormID = 'CSMF1131';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1131.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1131.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hãng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1131.FirmID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã Reimbursement Part';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1131.ReimbursementID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên Reimbursement Part';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1131.ReimbursementName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1131.Price', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1131.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1131.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1131.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1131.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1131.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1131.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1131.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật Reimbursement Part';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1131.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1131.FirmID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1131.FirmName.CB', @FormID, @LanguageValue, @Language;

