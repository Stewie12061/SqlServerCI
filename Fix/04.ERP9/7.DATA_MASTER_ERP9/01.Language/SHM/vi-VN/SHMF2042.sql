

DECLARE
@ModuleID VARCHAR(5),
@FormID VARCHAR(50),
@Language VARCHAR(10),
@LanguageValue NVARCHAR(4000),
@LanguageCustomValue NVARCHAR(4000)

SET @Language = 'vi-VN'; 
SET @ModuleID = 'SHM';
SET @FormID = 'SHMF2042';
------------------------------------------------------------------------------------


SET @LanguageValue = N'Mã cổ đông';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2042.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2042.TabSHMF2042' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết chia cổ tức';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2042.XemChiTietChiCoTuc' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem chi tiết chia cổ tức';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2042.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2042.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2042.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2042.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chốt';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2042.LockDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2042.TotalHoldQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng tiền cổ tức';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2042.TotalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mệnh giá';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2042.FaceValue' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cổ tức/Cổ phần';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2042.DividendPerShare' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2042.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên cổ đông';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2042.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số cổ phần sở hữu';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2042.HoldQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cổ tức phải trả';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2042.AmountPayable' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2042.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2042.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2042.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2042.LastModifyDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cổ tức còn phải trả';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2042.AmountRemainning' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cổ tức đã trả';
EXEC ERP9AddLanguage @ModuleID, 'SHMF2042.AmountPaid' , @FormID, @LanguageValue, @Language;



