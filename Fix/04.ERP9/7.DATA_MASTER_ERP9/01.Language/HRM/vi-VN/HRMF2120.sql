-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1032- OO
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


SET @Language = 'vi-VN';
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2120'

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.TrainingType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Danh mục ghi nhận kết quả'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hình thức đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.TrainingTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.TrainingTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hình thức đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.TrainingType.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lĩnh vực đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.TrainingFieldID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên lĩnh vực đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.TrainingFieldName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lĩnh vực đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.TrainingFieldName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ghi nhận kết quả/lịch DT'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.SearchTxt',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã lĩnh vực đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.TrainingFieldID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.AssignedToUserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.TrainingScheduleName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đề xuất kiến nghị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.Description1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.Description2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đối tượng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.ObjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.TrainingScheduleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đánh giá chung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.ResultTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đánh giá chung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.ResultTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.AssignedToUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ghi nhận kết quả'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.TrainingResultID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã Đánh Giá'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.ResultTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên Đánh Giá'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2120.ResultTypeName.CB',  @FormID, @LanguageValue, @Language;

