-----------------------------------------------------------------------------------------------------
-- Script tạo message - MT
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(5),
@FormID VARCHAR(50),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),
@LanguageCustomValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT

/*
 - Tieng Viet: vi-VN 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'en-US'; 
SET @ModuleID = 'MT';
SET @FormID = 'MTF1030';

SET @LanguageValue = N'Disabled';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1030.Disabled' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Division ID';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1030.DivisionID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Common';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1030.IsCommon' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Stop reason Lists';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1030.MTF1030_Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Update Stop reason';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1030.MTF1031_Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Stop Reason Details';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1030.MTF1032_GroupMasterTitle' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Show Stop Reason Details';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1030.MTF1032_Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Notes';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1030.Notes' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Reason ID';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1030.StopReasonID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Reason Name';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF1030.StopReasonName' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;
