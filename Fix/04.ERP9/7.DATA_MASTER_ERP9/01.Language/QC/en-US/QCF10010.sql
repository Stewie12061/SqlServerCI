﻿
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF10010
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
DECLARE @KeyID VARCHAR(100)
DECLARE @Text NVARCHAR(4000)
DECLARE @CustomName NVARCHAR(4000)

SET @ModuleID = N'QC'
SET @KeyID = N'QCF10010.Title'
SET @FormID = N'QCF10010'
SET @Text = N'Danh mục Tiêu chuẩn'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF10010.StandardID'
SET @FormID = N'QCF10010'
SET @Text = N'Mã tiêu chuẩn'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF10010.StandardName'
SET @FormID = N'QCF10010'
SET @Text = N'Tên tiêu chuẩn'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF10010.StandardNameE'
SET @FormID = N'QCF10010'
SET @Text = N'Tên tiêu chuẩn E'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF10010.UnitName'
SET @FormID = N'QCF10010'
SET @Text = N'Đơn vị tính'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF10010.TypeName'
SET @FormID = N'QCF10010'
SET @Text = N'Loại tiêu chuẩn'
SET @Language = N'en-US'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;


GO