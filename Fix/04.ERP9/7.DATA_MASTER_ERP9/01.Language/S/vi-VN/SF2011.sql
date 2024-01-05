------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF2011 - S
-- Người tạo: Tấn Thành - 24/09/2020
-----------------------------------------------------------------------------------------------------
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
SET @ModuleID = 'S';
SET @FormID = 'SF2011';
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Cập nhật PipeLine';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.Title' , @FormID, @LanguageValue, @Language;
------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Mã PipeLine';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.PipeLineID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên PipeLine';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.PipeLineName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng Thái';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.StatusID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sự kiện kích hoạt';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.RefObject' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hành động';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.Action' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hành động';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ActionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hành động';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ActionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Url';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.PopupUrl' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.UpdateAction' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.Disabled' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.OperationStatusID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.OperationStatusName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kích hoạt';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionActiveID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sự kiện kích hoạt';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionActiveName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ObjectID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.RefObjectName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hành động';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ActionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hành động';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ActionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều kiện 01';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.Operation01' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều kiện 02';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.Operation02' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều kiện 03';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.Operation03' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều kiện 04';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.Operation04' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều kiện 05';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.Operation05' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều kiện 06';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.Operation06' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều kiện 07';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.Operation07' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều kiện 08';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.Operation08' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều kiện 09';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.Operation09' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều kiện 10';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.Operation10' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị 01';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionValue01' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị 02';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionValue02' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị 03';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionValue03' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị 04';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionValue04' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị 05';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionValue05' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị 06';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionValue06' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị 07';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionValue07' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị 08';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionValue08' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị 09';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionValue09' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị 10';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionValue10' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng 01';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionObject01' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng 02';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionObject02' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng 03';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionObject03' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng 04';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionObject04' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng 05';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionObject05' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng 06';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionObject06' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng 07';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionObject07' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng 08';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionObject08' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng 09';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionObject09' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng 10';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ConditionObject10' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hành động kích hoạt';
EXEC ERP9AddLanguage @ModuleID, 'SF2011.ActionActive' , @FormID, @LanguageValue, @Language;