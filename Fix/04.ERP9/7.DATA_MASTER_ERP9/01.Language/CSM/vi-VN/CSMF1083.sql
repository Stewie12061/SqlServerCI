-----------------------------------------------------------------------------------------------------
                                            -- Script tạo ngôn ngữ CSMF1083- CSM
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
                                            SET @FormID = 'CSMF1083';

SET @LanguageValue = N'Mã Model';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1083.ModelID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại Checklist';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1083.CheckListType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1083.CheckListID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1083.CheckListName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'STT Hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1083.DisplayOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật Checklist QC theo Model';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1083.Title', @FormID, @LanguageValue, @Language;

