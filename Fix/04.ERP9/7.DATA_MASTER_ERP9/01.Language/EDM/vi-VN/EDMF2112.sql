-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2112- EDM
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
SET @FormID = 'EDMF2112';

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2112.Attach.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2112.Notes.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem thông tin tổng khung chương trình';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2112.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2112.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2112.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chương trình';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2112.ProgramID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chương trình';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2112.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2112.TermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2112.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2112.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2112.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2112.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2112.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2112.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2112.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2112.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2112.FromVoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2112.ToVoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2112.MonthName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủ đề';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2112.Topic', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hoạt động';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2112.ActivityTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung hoạt động';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2112.ActivityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin tổng khung chương trình';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2112.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin tổng quan khung chương trình';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2112.EDMT2111Detail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết khung chương trình';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2112.EDMT2112Detail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2112.Lich_su', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2112.MonthID', @FormID, @LanguageValue, @Language;



