
DECLARE
@ModuleID VARCHAR(5),
@FormID VARCHAR(50),
@Language VARCHAR(10),
@LanguageValue NVARCHAR(4000),
@LanguageCustomValue NVARCHAR(4000)

SET @Language = 'vi-VN'; 
SET @ModuleID = 'SHM';
SET @FormID = 'SHMF2040';

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2040.DivisionID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2040.VoucherNo' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2040.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delete Flg';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2040.DeleteFlg' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cổ tức/Cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2040.DividendPerShare' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mệnh giá';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2040.FaceValue' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng tiền cổ tức';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2040.TotalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2040.TotalHoldQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chốt';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2040.LockDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2040.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh sách chia cổ tức';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2040.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2040.VoucherTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã cổ đông';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2040.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên cổ đông';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2040.ObjectName' , @FormID, @LanguageValue, @Language;