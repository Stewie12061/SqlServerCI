﻿
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HF0405- OO
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
SET @FormID = 'CSMF1060';

------- phần master
SET @LanguageValue = N'Danh mục loại dịch vụ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1060.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1060.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại dịch vụ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1060.ServiceTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại dịch vụ ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1060.ServiceTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1060.IsCommon' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1060.Disabled' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1060.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1060.ID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1060.Description.CB' , @FormID, @LanguageValue, @Language;