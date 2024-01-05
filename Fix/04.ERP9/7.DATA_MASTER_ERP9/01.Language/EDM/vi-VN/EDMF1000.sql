
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
SET @ModuleID = 'EDM';
SET @FormID = 'EDMF1000';

SET @LanguageValue = N'Danh mục khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1000.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1000.Don_vi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cấp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1000.Cap' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1000.Ma_khoi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1000.Ten_khoi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1000.Ghi_chu' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1000.Dung_chung' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1000.Khong_hien_thi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1000.LevelID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1000.LevelName.CB' , @FormID, @LanguageValue, @Language;


--select * from A00001 where ID like'%EDMF1000%'

--delete from A00001 where ID like'%EDMF1000%'

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