
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
SET @FormID = 'HRMF2035';

SET @LanguageValue = N'Chọn ứng viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2035.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã ứng viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2035.CandidateID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên ứng viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2035.CandidateName' , @FormID, @LanguageValue, @Language;