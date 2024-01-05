-----------------------------------------------------------------------------------------------------
                                            -- Script tạo ngôn ngữ CSMF1132- CSM
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
                                            SET @FormID = 'CSMF1132';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1132.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1132.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1132.FirmID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã Reimbursement Part';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1132.ReimbursementID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên Reimbursement Name';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1132.ReimbursementName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1132.Price', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1132.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1132.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1132.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1132.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1132.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1132.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1132.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hãng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1132.FirmName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem thông tin Reimbursement Name';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1132.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin Reimbursement Parts';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1132.ReimbursementPartsInfo', @FormID, @LanguageValue, @Language;

