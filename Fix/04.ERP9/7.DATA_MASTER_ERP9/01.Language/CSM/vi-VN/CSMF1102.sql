-----------------------------------------------------------------------------------------------------
                                            -- Script tạo ngôn ngữ CSMF1102- CSM
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
                                            SET @FormID = 'CSMF1102';

										

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1102.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hãng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1102.FirmID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hãng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1102.FirmName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sử dụng API';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1102.IsUseAPI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1102.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Link API';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1102.APILink', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại API';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1102.APITypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1102.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1102.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1102.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1102.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1102.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1102.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem thông tin danh mục hãng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1102.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin hãng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1102.ChecklistInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin dữ liệu theo hãng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1102.DataFirmInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại CheckList';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1102.CheckListType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1102.CheckListTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem chi tiết hãng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1102.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin hãng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1102.FirmInfo', @FormID, @LanguageValue, @Language;



