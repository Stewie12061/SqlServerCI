
-----------------------------------------------------------------------------------------------------
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
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF1052';

SET @LanguageValue = N'Xem chi tiết khóa đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lĩnh vực đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.TrainingFieldID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã lĩnh vực';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.TrainingFieldID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên lĩnh vực';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.TrainingFieldName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khóa đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.TrainingCourseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.TrainingType' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.TrainingType' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hình thức';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.TrainingType.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hình thức';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.TrainingTypeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.Disabled' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lĩnh vực đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.TrainingFieldName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.TrainingTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tác đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.IsCommon' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tác đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin khóa đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.TabThongTinKhoaDaoTao' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.TabCRMT00003' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.LastModifyDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.StatusID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.TabCRMT00001' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1052.TabCRMT00002' , @FormID, @LanguageValue, @Language;