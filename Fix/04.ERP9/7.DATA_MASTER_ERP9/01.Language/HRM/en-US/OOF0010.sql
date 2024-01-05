
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF0010- OO
-- [Đình Hòa] [26/02/2021] - Bổ sung ngôn ngữ
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
SET @Language = 'en-US' 
SET @ModuleID = 'HRM';
SET @FormID = 'OOF0010';

SET @LanguageValue = N'Set up a business review';
EXEC ERP9AddLanguage @ModuleID, 'OOF0010.OOF0010Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Application for leave';
EXEC ERP9AddLanguage @ModuleID, 'OOF0010.OOF0010Tab01Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Application for overtime';
EXEC ERP9AddLanguage @ModuleID, 'OOF0010.OOF0010Tab02Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Application to go out';
EXEC ERP9AddLanguage @ModuleID, 'OOF0010.OOF0010Tab03Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Application for additional card swipe';
EXEC ERP9AddLanguage @ModuleID, 'OOF0010.OOF0010Tab04Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift table';
EXEC ERP9AddLanguage @ModuleID, 'OOF0010.OOF0010Tab05Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Application for shift change';
EXEC ERP9AddLanguage @ModuleID, 'OOF0010.OOF0010Tab06Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Temporary Transfer';
EXEC ERP9AddLanguage @ModuleID, 'OOF0010.OOF0010Tab07Title' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Approval level';
EXEC ERP9AddLanguage @ModuleID, 'OOF0010.DXP' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approval level';
EXEC ERP9AddLanguage @ModuleID, 'OOF0010.DXLTG' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approval level';
EXEC ERP9AddLanguage @ModuleID, 'OOF0010.DXRN' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approval level';
EXEC ERP9AddLanguage @ModuleID, 'OOF0010.DXBSQT' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approval level';
EXEC ERP9AddLanguage @ModuleID, 'OOF0010.BPC' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approval level';
EXEC ERP9AddLanguage @ModuleID, 'OOF0010.DXDC' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approval level';
EXEC ERP9AddLanguage @ModuleID, 'OOF0010.DCTT' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher Type ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF0010.VoucherTypeID1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher Type ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF0010.VoucherTypeID2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher Type ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF0010.VoucherTypeID3' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher Type ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF0010.VoucherTypeID4' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher Type ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF0010.VoucherTypeID5' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher Type ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF0010.VoucherTypeID6' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher Type ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF0010.VoucherTypeID7' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sub Leve';
EXEC ERP9AddLanguage @ModuleID, 'OOF0010.SubLevel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Duty Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF0010.DutyName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Permision';
EXEC ERP9AddLanguage @ModuleID, 'OOF0010.IsPermision' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Absent Type';
EXEC ERP9AddLanguage @ModuleID, 'OOF0010.AbsentTypeID' , @FormID, @LanguageValue, @Language;
