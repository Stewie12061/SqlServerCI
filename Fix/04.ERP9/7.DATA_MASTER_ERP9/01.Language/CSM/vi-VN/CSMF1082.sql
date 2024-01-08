-----------------------------------------------------------------------------------------------------
                                            -- Script tạo ngôn ngữ CSMF1082- CSM
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
                                            SET @FormID = 'CSMF1082';

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1082.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã Model';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1082.ModelID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên Model';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1082.ModelName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hãng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1082.FirmID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hãng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1082.FirmName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1082.ProductType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1082.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1082.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1082.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1082.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1082.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1082.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin Model';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1082.ModelInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CheckListQC theo Model';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1082.ChecklistQC', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'STT Hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1082.DisplayOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1082.CheckListID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1082.CheckListName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem thông tin Model';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1082.Title', @FormID, @LanguageValue, @Language;
