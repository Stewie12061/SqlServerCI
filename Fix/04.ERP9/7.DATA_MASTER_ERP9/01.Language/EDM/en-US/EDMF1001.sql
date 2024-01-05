
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
SET @FormID = 'EDMF1001';

SET @LanguageValue = N'Update grade';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1001.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1001.Don_vi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Level';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1001.Cap' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Grade code';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1001.Ma_khoi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Grade name';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1001.Ten_khoi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1001.Ghi_chu' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is common';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1001.Dung_chung' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1001.Khong_hien_thi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1001.LevelID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1001.LevelName.CB' , @FormID, @LanguageValue, @Language;

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