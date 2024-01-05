﻿-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2250- OO
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
SET @ModuleID = 'OO';
SET @FormID = 'OOF2352';

SET @LanguageValue = N'Xem chi tiết Văn bản đi';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Văn bản số';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.DocumentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giả';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.DocumentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.DocumentTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.DocumentTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái ký';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.SignedStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái ký';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.SignedStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày nhận';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.ReceivedDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi nhận';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.ReceivedPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày gửi';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.SentDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi gửi';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.SentPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày ký';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.DocumentSignDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời hạn xử lý';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.OutOfDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trích yếu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.Summary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người có thẩm quyền chỉ đạo giải quyết';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.DecidedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người có thẩm quyền chỉ đạo giải quyết';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.DecidedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi lưu bản cứng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.HardStoreDepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi lưu bản cứng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.HardStoreDepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi phát hành';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.PublishPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Văn bản nội bộ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.IsInternal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Văn bản nội bộ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.InternalDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bước';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.Steps', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã người dùng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.FollowerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên người dùng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.FollowerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sử dụng ký số';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.UseESign', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin Văn bản';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.ThongTinVanBan', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin Duyệt/Ký';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.ChiTietVanBan', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2352.DinhKem', @FormID, @LanguageValue, @Language;