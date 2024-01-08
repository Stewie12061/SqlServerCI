--delete  A00001 where FormID  =N'QCF2052'

-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2052 
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
SET @ModuleID = 'QC';
SET @FormID = 'QCF2052';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.VoucherType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.VoucherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Workshop';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Workshop';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product quality voucher';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.QCT2000VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Manufacturing date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.QCT2000VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch no';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.BatchID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TranMonth';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TranYear';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DeleteFlg';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.LastModifyDate', @FormID, @LanguageValue, @Language;

EXEC ERP9AddLanguage @ModuleID, 'QCF2052.NodeTypeName', @FormID, N'Object type' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.NodeID', @FormID, N'Object ID' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.NodeName', @FormID, N'Object name' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.Description', @FormID, N'Description' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.QCT2001Description', @FormID, N'Material note' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.UnitID', @FormID, N'Unit' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.StandardValue', @FormID, N'Standard value' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.Info', @FormID, N'Material import slip info' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.Detail', @FormID, N'Material import slip detail' , @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF2052.Title', @FormID, N'Material import slip detail' , @Language;
