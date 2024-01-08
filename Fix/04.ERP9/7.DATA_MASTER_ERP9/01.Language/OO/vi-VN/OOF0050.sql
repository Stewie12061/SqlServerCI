-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF0050 - OO
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10)

/*
 - Tieng Viet: vi-VN
 - Tieng Anh: en-US
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @ModuleID = 'OO';
SET @FormID = 'OOF0050';
SET @Language = 'vi-VN';


EXEC ERP9AddLanguage @ModuleID, N'OOF0050.Title', @FormID, N'Thiết lập đánh giá', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.TargetsGroupName', @FormID, N'Nhóm chỉ tiêu', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.AssessDepartmentName', @FormID, N'Phòng ban đánh giá', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.AssessUserName1', @FormID, N'Người đánh giá 1', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.AssessUserName2', @FormID, N'Người đánh giá 2', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.AssessOrder', @FormID, N'Thứ tự đánh giá', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.NoDefault', @FormID, N'Không lấy mặc định', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.NoDisplay', @FormID, N'Không hiển thị', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.DefaultScore', @FormID, N'Điểm mặc định', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.AssessRequired', @FormID, N'Bắt buộc đánh giá', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.TargetsGroupID.CB', @FormID, N'Mã nhóm chỉ tiêu', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.TargetsGroupName.CB', @FormID, N'Tên nhóm chỉ tiêu', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.DepartmentID.CB', @FormID, N'Mã phòng ban', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.DepartmentName.CB', @FormID, N'Tên phòng ban', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.AssessUserTypeID.CB', @FormID, N'Mã người đánh giá', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.AssessUserTypeName.CB', @FormID, N'Tên người đánh giá', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.EmployeeID.CB', @FormID, N'Mã nhân viên', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.EmployeeName.CB', @FormID, N'Tên nhân viên', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.ObjectID.CB', @FormID, N'Mã đối tượng', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.ObjectName.CB', @FormID, N'Tên đối tượng', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.ObjectID', @FormID, N'Loại đối tượng', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.TargetsGroupID', @FormID, N'Nhóm chỉ tiêu', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF0050.NotUseAssess', @FormID, N'Không sử dụng đánh giá', @Language;

