
DECLARE
@ModuleID VARCHAR(5),
@FormID VARCHAR(50),
@Language VARCHAR(10),
@LanguageValue NVARCHAR(4000),
@LanguageCustomValue NVARCHAR(4000)

SET @Language = 'vi-VN'; 
SET @ModuleID = 'SHM';
SET @FormID = 'SHMF2041';

--------------------------------------------------------------------------------------------

SET @LanguageValue = N'Mệnh giá';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2041.FaceValue' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cổ tức/Cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2041.DividendPerShare' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2041.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật chia cổ tức';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2041.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số cổ phần sở hữu';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2041.HoldQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cổ tức phải trả';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2041.AmountPayable' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã cổ đông';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2041.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên cổ đông';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2041.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cổ tức đã trả';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2041.AmountPaid' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cổ tức còn phải trả';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2041.AmountRemainning' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2041.VoucherTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2041.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2041.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chốt';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2041.LockDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2041.TotalHoldQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng tiền cổ tức';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2041.TotalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2041.VoucherTypeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2041.VoucherTypeName.CB' , @FormID, @LanguageValue, @Language;