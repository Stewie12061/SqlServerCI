
DECLARE @ModuleID VARCHAR(10)
DECLARE @KeyID VARCHAR(100)
DECLARE @FormID VARCHAR(200)
DECLARE @Text NVARCHAR(4000)
DECLARE @Language VARCHAR(10)
DECLARE @CustomName NVARCHAR(4000)

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.Title'
SET @FormID = N'QCF1002'
SET @Text = N'Thông tin chi tiết Tiêu chuẩn'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.APK'
SET @FormID = N'QCF1002'
SET @Text = N''
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.DivisionID'
SET @FormID = N'QCF1002'
SET @Text = N'Đơn vị'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.StandardID'
SET @FormID = N'QCF1002'
SET @Text = N'Mã tiêu chuẩn'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.StandardName'
SET @FormID = N'QCF1002'
SET @Text = N'Tên tiêu chuẩn'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.StandardNameE'
SET @FormID = N'QCF1002'
SET @Text = N'Tên tiêu chuẩn (English)'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.StatusID'
SET @FormID = N'QCF1002'
SET @Text = N'Trạng thái'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.UnitID'
SET @FormID = N'QCF1002'
SET @Text = N'Đơn vị tính'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.Description'
SET @FormID = N'QCF1002'
SET @Text = N'Diễn giải'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.Disabled'
SET @FormID = N'QCF1002'
SET @Text = N'Không hiển thị'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.IsCommon'
SET @FormID = N'QCF1002'
SET @Text = N'Dùng chung'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.IsDefault'
SET @FormID = N'QCF1002'
SET @Text = N'Mặc định trường'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.IsVisible'
SET @FormID = N'QCF1002'
SET @Text = N'Mặc định giá trị'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.TypeID'
SET @FormID = N'QCF1002'
SET @Text = N'Loại tiêu chuẩn'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.TypeName'
SET @FormID = N'QCF1002'
SET @Text = N'Tên loại tiêu chuẩn'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.CalculateType'
SET @FormID = N'QCF1002'
SET @Text = N'Loại công thức'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.ParentID'
SET @FormID = N'QCF1002'
SET @Text = N'Tiêu chuẩn cha'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.DataType'
SET @FormID = N'QCF1002'
SET @Text = N'Loại dữ liệu'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.CreateDate'
SET @FormID = N'QCF1002'
SET @Text = N'Ngày tạo'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.CreateUserID'
SET @FormID = N'QCF1002'
SET @Text = N'Người tạo'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.LastModifyUserID'
SET @FormID = N'QCF1002'
SET @Text = N'Người sửa'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.LastModifyDate'
SET @FormID = N'QCF1002'
SET @Text = N'Ngày sửa'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.Info'
SET @FormID = N'QCF1002'
SET @Text = N'Thông tin Tiêu chuẩn'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.History'
SET @FormID = N'QCF1002'
SET @Text = N'Lịch sử'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.Title'
SET @FormID = N'QCF1002'
SET @Text = N'Thông tin chi tiết Tiêu chuẩn'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.APK'
SET @FormID = N'QCF1002'
SET @Text = N''
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.DivisionID'
SET @FormID = N'QCF1002'
SET @Text = N'Division'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.StandardID'
SET @FormID = N'QCF1002'
SET @Text = N'Standard ID'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.StandardName'
SET @FormID = N'QCF1002'
SET @Text = N'Standard name'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.StandardNameE'
SET @FormID = N'QCF1002'
SET @Text = N'Standard name (Eng)'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.UnitID'
SET @FormID = N'QCF1002'
SET @Text = N'Unit ID'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.Description'
SET @FormID = N'QCF1002'
SET @Text = N'Description'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.Disabled'
SET @FormID = N'QCF1002'
SET @Text = N'Disabled'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.IsCommon'
SET @FormID = N'QCF1002'
SET @Text = N'IsCommon'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.IsDefault'
SET @FormID = N'QCF1002'
SET @Text = N'IsDefault'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.IsVisible'
SET @FormID = N'QCF1002'
SET @Text = N'IsVisible'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.TypeID'
SET @FormID = N'QCF1002'
SET @Text = N'Standard type'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.TypeID'
SET @FormID = N'QCF1002'
SET @Text = N'Standard type'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.ParentID'
SET @FormID = N'QCF1002'
SET @Text = N'Owner'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.Datatype'
SET @FormID = N'QCF1002'
SET @Text = N'Datatype'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.CreateDate'
SET @FormID = N'QCF1002'
SET @Text = N''
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.CreateUserID'
SET @FormID = N'QCF1002'
SET @Text = N''
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.LastModifyUserID'
SET @FormID = N'QCF1002'
SET @Text = N''
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.LastModifyDate'
SET @FormID = N'QCF1002'
SET @Text = N''
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.Info'
SET @FormID = N'QCF1002'
SET @Text = N'Info'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'00'
SET @KeyID = N'QCF1002.History'
SET @FormID = N'QCF1002'
SET @Text = N'History'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.SpecificationName'
SET @FormID = N'QCF1002'
SET @Text = N'Thông số kỹ thuật'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.Recipe'
SET @FormID = N'QCF1002'
SET @Text = N'Công thức'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.PhaseName'
SET @FormID = N'QCF1002'
SET @Text = N'Công đoạn'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1002.DataTypeName'
SET @FormID = N'QCF1002'
SET @Text = N'Loại dữ liệu'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;
