-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ 
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
SET @FormID = 'EDMF2132';

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.Attach.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.Notes.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem thông tin đăng ký dịch vụ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.SchoolName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hình thu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.ReceiptTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chí phí/học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.Cost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại dịch vụ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.ServiceTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.StudentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.ClassName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hai chiều';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.RoundTrip', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điểm đón';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.PickupPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điểm trả';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.ArrivedPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Có dùng bữa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.IsEat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin đăng ký dịch vụ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.Lich_su', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'In';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.Report', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết hoạt động ngoại khóa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.DetailExtracurricularActivity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết đăng ký đưa đón';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.Shuttle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết giữ ngoài giờ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.OverTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chương trình học tháng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết chương trình học tháng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.Detail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.Lich_su', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.TermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'<b>Thông báo:</b> Tham gia chương trình {0} cho các em lớp {1} tại {2}. Ngày tổ chức {3}';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.Label01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'<b>Với ý nghĩa: {0}</b>';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.Label02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'<b>Chi phí:</b> Quý phụ huynh chi trả {0} đ/1 em.';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.Label03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'<b>Thời gian đăng ký:</b> Từ ngày <b>{0}</b> đến hạn ngày <b>{1}</b>';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.Label04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'<b>Tôi tên:</b> {0}';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.Label05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'<b>Số điện thoại:</b> {0}';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.Label06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'<b>Phụ huynh em</b>: {0}';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.Label07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'<b>Tôi đọc và đồng ý cho em được tham gia chương trình</b>';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.Label08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày ...... Tháng ...... Năm ......';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.Label09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'<b>Quy định:</b> Vì lý do công ty phải tổ chức có sự chuẩn bị và làm việc với đối tác, nên chỉ đăng ký trong khoản thời gian nêu trên.';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.Label10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ huynh đăng ký sau ngày quy định, vui lòng không đăng ký thêm. Đã đăng ký nhưng không tham gia vui lòng báo trước ngày kết thúc đăng ký <b>{0}</b>.';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.Label11', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'<b>{0}</b> rất trân trọng cảm ơn sự hợp tác của Quý phụ huynh.';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.Label12', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu đăng ký chương trình';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.TitleProgramRegisting', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.PromotionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.AmountPromotion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền sau khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.AmountTotalPromotion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại giữ trẻ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.TypeKeepName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hoạt động';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.ExtracurricularActivity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.SchoolYearID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.MonthID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa điểm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2132.Place', @FormID, @LanguageValue, @Language;