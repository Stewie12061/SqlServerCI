-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CSMF2055- CSM
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
SET @FormID = 'CSMF2055';

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2055.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2055.TimeReceive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2055.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ASP xác nhận đã nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2055.Title', @FormID, @LanguageValue, @Language;

