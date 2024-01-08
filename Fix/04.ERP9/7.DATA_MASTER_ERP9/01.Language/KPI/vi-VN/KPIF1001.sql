DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF1001'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật xếp loại'
EXEC ERP9AddLanguage @ModuleID, 'KPIF1001.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1001.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ điểm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1001.FromScore',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến điểm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1001.ToScore',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xếp loại';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1001.Classification',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ lệ thưởng';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1001.BonusRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1001.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1001.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1001.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1001.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1001.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1001.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1001.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1001.KPIF1002.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1001.KPIF1002.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1001.KPIF1002.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin xếp loại';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1001.KPIF1002.ThongTinXepLoai',  @FormID, @LanguageValue, @Language;


