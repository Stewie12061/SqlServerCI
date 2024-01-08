------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2010 - CRM 
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
SET @Language = 'ja-JP';
SET @ModuleID = 'SO';
SET @FormID = 'SOF2010';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Danh sách đơn hàng bán nhà phân phối';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2010.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2010.VoucherNo' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Ngày đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2010.OrderDate' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Diễn giải';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2010.Notes' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Loại chứng từ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2010.VoucherTypeID' , @FormID, @LanguageValue, @Language

  SET @LanguageValue = N'Tình trạng đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2010.OrderStatus' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Mã Khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2010.ObjectID' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2010.ObjectName' , @FormID, @LanguageValue, @Language;

