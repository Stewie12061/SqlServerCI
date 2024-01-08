-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF2010- S
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
SET @ModuleID = 'S';
SET @FormID = 'SF2010';

------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Quản lý Pipeline';
EXEC ERP9AddLanguage @ModuleID, 'SF2010.Title' , @FormID, @LanguageValue, @Language;
------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Mã PipeLine';
EXEC ERP9AddLanguage @ModuleID, 'SF2010.PipeLineID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên PipeLine';
EXEC ERP9AddLanguage @ModuleID, 'SF2010.PipeLineName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng Thái';
EXEC ERP9AddLanguage @ModuleID, 'SF2010.StatusID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'SF2010.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sự kiện kích hoạt';
EXEC ERP9AddLanguage @ModuleID, 'SF2010.ConditionTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sự kiện kích hoạt';
EXEC ERP9AddLanguage @ModuleID, 'SF2010.ConditionTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng tham chiếu';
EXEC ERP9AddLanguage @ModuleID, 'SF2010.RefObject' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng tham chiếu';
EXEC ERP9AddLanguage @ModuleID, 'SF2010.RefObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng đích';
EXEC ERP9AddLanguage @ModuleID, 'SF2010.DestObject' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SF2010.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã/Tên Pipeline';
EXEC ERP9AddLanguage @ModuleID, 'SF2010.SearchIDName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SF2010.OperationStatusID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SF2010.OperationStatusName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SF2010.ObjectID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'SF2010.RefObjectName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SF2010.ConditionActiveID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sự kiện kịch hoạt';
EXEC ERP9AddLanguage @ModuleID, 'SF2010.ConditionActiveName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SF2010.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SF2010.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hành động kích hoạt';
EXEC ERP9AddLanguage @ModuleID, 'SF2010.ActionActive' , @FormID, @LanguageValue, @Language;