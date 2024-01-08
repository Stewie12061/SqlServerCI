﻿------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF9001 - CRM 
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000)
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thuc thi truy van
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF9001';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Chọn mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF9001.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF9001.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF9001.InventoryID' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Mã đơn vị tính';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF9001.UnitID' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Tên mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF9001.InventoryName' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Tên đơn vị tính';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF9001.UnitName' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Không hiển thị';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF9001.Disabled' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Dùng chung';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF9001.IsCommon' , @FormID, @LanguageValue, @Language;








