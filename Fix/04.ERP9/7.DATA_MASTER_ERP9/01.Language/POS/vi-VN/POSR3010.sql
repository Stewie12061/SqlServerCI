------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MTF0070 - MT
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
SET @ModuleID = 'POS';
SET @FormID = 'POSR3010';


SET @LanguageValue = N'BẢNG ĐỐI CHIẾU DOANH THU BÁN VỚI THU TIỀN VÀ CÔNG NỢ';
EXEC ERP9AddLanguage @ModuleID, 'POSR3010.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POSR3010.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSR3010.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSR3010.FromMemberID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSR3010.ToMemberID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSR3010.MemberID' , @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;