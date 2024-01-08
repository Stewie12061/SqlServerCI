
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
SET @Language = 'en-US' 
SET @ModuleID = 'EDM';
SET @FormID = 'EDMF1002';

SET @LanguageValue = N'View grade information';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1002.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1002.Don_vi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Level';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1002.Cap' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Grade code';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1002.Ma_khoi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Grade name';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1002.Ten_khoi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1002.Ghi_chu' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1002.Dung_chung' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1002.Khong_hien_thi' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1002.Nguoi_tao' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create Date';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1002.Ngay_tao' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1002.Nguoi_sua' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1002.Ngay_sua' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Grade information';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1002.Info' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1002.Lich_su' , @FormID, @LanguageValue, @Language;

--SET @LanguageValue = N'Cập nhật tình trạng lỗi';
--EXEC ERP9AddLanguage @ModuleID, 'CSMF1001.Title' , @FormID, @LanguageValue, @Language;

--SET @LanguageValue = N'Mã tình trạng';
--EXEC ERP9AddLanguage @ModuleID, 'CSMF1001.StatusErrorID' , @FormID, @LanguageValue, @Language;

--SET @LanguageValue = N'Tên tình trạng';
--EXEC ERP9AddLanguage @ModuleID, 'CSMF1001.StatusErrorName' , @FormID, @LanguageValue, @Language;

--SET @LanguageValue = N'Dùng chung';
--EXEC ERP9AddLanguage @ModuleID, 'CSMF1001.IsCommon' , @FormID, @LanguageValue, @Language;

--SET @LanguageValue = N'Không hiển thị';
--EXEC ERP9AddLanguage @ModuleID, 'CSMF1001.Disabled' , @FormID, @LanguageValue, @Language;

--SET @LanguageValue = N'Ghi chú';
--EXEC ERP9AddLanguage @ModuleID, 'CSMF1001.Notes' , @FormID, @LanguageValue, @Language;


--SET @LanguageValue = N'Hãng';
--EXEC ERP9AddLanguage @ModuleID, 'CSMF1001.FirmID' , @FormID, @LanguageValue, @Language;