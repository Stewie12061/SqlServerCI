DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
@Name NVARCHAR(4000),
@LanguageValue nvarchar(500)
SET @Language = 'vi-VN'
SET @ModuleID = 'PO'
SET @FormID = 'SOF3016'

If not exists(select top 1 1 from [dbo].[A00001] where  [ID] = 'GetPathTemplate')
begin
SET @Name = N'Chọn Template báo cáo'
insert into A00001(ID,Deleted,LanguageID,Name,Module,FormID)values('GetPathTemplate',0,@Language,@Name,@ModuleID,@FormID)
end
ELSE
BEGIN
SET @LanguageValue = N'Chọn Template báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'SOF3016.GetPathTemplate' , @FormID, @LanguageValue, @Language;
END 

SET @LanguageValue = N'Báo cáo chi tiết tình hình nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF3016.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF3016.Ana01Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF3016.OrderDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF3016.DivisionID' , @FormID, @LanguageValue, @Language;
