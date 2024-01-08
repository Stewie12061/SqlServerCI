
DECLARE @ModuleID VARCHAR(10)
DECLARE @KeyID VARCHAR(100)
DECLARE @FormID VARCHAR(200)
DECLARE @Text NVARCHAR(4000)
DECLARE @Language VARCHAR(10)
DECLARE @CustomName NVARCHAR(4000)

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.Title'
SET @FormID = N'QCF1001'
SET @Text = N'Cập nhật tiêu chuẩn'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.APK'
SET @FormID = N'QCF1001'
SET @Text = N''
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.DivisionID'
SET @FormID = N'QCF1001'
SET @Text = N'Đơn vị'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.StandardID'
SET @FormID = N'QCF1001'
SET @Text = N'Mã tiêu chuẩn'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.StandardName'
SET @FormID = N'QCF1001'
SET @Text = N'Tên tiêu chuẩn'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.StandardNameE'
SET @FormID = N'QCF1001'
SET @Text = N'Tên tiêu chuẩn (ENG)'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.UnitID'
SET @FormID = N'QCF1001'
SET @Text = N'Đơn vị tính'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.Description'
SET @FormID = N'QCF1001'
SET @Text = N'Diễn giải'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.Disabled'
SET @FormID = N'QCF1001'
SET @Text = N'Không hiển thị'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.IsCommon'
SET @FormID = N'QCF1001'
SET @Text = N'Dùng chung'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.IsDefault'
SET @FormID = N'QCF1001'
SET @Text = N'Mặc định trường'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.IsVisible'
SET @FormID = N'QCF1001'
SET @Text = N'Mặc định giá trị'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.TypeID'
SET @FormID = N'QCF1001'
SET @Text = N'Loại tiêu chuẩn'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.TypeName'
SET @FormID = N'QCF1001'
SET @Text = N'Tên loại tiêu chuẩn'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.CalculateType'
SET @FormID = N'QCF1001'
SET @Text = N'Loại công thức'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.ParentID'
SET @FormID = N'QCF1001'
SET @Text = N'Tiêu chuẩn cha'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.DataType'
SET @FormID = N'QCF1001'
SET @Text = N'Loại dữ liệu'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.CreateDate'
SET @FormID = N'QCF1001'
SET @Text = N''
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.CreateUserID'
SET @FormID = N'QCF1001'
SET @Text = N''
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.LastModifyUserID'
SET @FormID = N'QCF1001'
SET @Text = N''
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.LastModifyDate'
SET @FormID = N'QCF1001'
SET @Text = N''
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.UnitID.CB'
SET @FormID = N'QCF1001'
SET @Text = N'Mã đơn vị tính'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.UnitName.CB'
SET @FormID = N'QCF1001'
SET @Text = N'Tên đơn vị tính '
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.DataTypeID.CB'
SET @FormID = N'QCF1001'
SET @Text = N'Mã'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.DataTypeName.CB'
SET @FormID = N'QCF1001'
SET @Text = N'Tên'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.TypeID.CB'
SET @FormID = N'QCF1001'
SET @Text = N'Mã loại'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.TypeName.CB'
SET @FormID = N'QCF1001'
SET @Text = N'Tên loại'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.StandardID.CB'
SET @FormID = N'QCF1001'
SET @Text = N'Mã loại'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.StandardName.CB'
SET @FormID = N'QCF1001'
SET @Text = N'Tên loại'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.Title'
SET @FormID = N'QCF1001'
SET @Text = N'Cập nhật Tiêu chuẩn'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.APK'
SET @FormID = N'QCF1001'
SET @Text = N''
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.DivisionID'
SET @FormID = N'QCF1001'
SET @Text = N'Division'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.StandardID'
SET @FormID = N'QCF1001'
SET @Text = N'Standard ID'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.StandardName'
SET @FormID = N'QCF1001'
SET @Text = N'Standard name'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.StandardNameE'
SET @FormID = N'QCF1001'
SET @Text = N'Standard name (Eng)'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.UnitID'
SET @FormID = N'QCF1001'
SET @Text = N'Unit ID'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.Description'
SET @FormID = N'QCF1001'
SET @Text = N'Description'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.Disabled'
SET @FormID = N'QCF1001'
SET @Text = N'Disabled'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.IsCommon'
SET @FormID = N'QCF1001'
SET @Text = N'IsCommon'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.IsDefault'
SET @FormID = N'QCF1001'
SET @Text = N'IsDefault'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.IsVisible'
SET @FormID = N'QCF1001'
SET @Text = N'IsVisible'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.TypeID'
SET @FormID = N'QCF1001'
SET @Text = N'Standard type'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.TypeID'
SET @FormID = N'QCF1001'
SET @Text = N'Standard type'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.ParentID'
SET @FormID = N'QCF1001'
SET @Text = N'Owner'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.Datatype'
SET @FormID = N'QCF1001'
SET @Text = N'Datatype'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.CreateDate'
SET @FormID = N'QCF1001'
SET @Text = N''
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.CreateUserID'
SET @FormID = N'QCF1001'
SET @Text = N''
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.LastModifyUserID'
SET @FormID = N'QCF1001'
SET @Text = N''
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.LastModifyDate'
SET @FormID = N'QCF1001'
SET @Text = N''
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.UnitID.CB'
SET @FormID = N'QCF1001'
SET @Text = N'Code'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.UnitName.CB'
SET @FormID = N'QCF1001'
SET @Text = N'Name'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.TypeID.CB'
SET @FormID = N'QCF1001'
SET @Text = N'Code'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.TypeName.CB'
SET @FormID = N'QCF1001'
SET @Text = N'Name'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.StandardID.CB'
SET @FormID = N'QCF1001'
SET @Text = N'Code'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.StandardName.CB'
SET @FormID = N'QCF1001'
SET @Text = N'Name'
SET @Language = N'en-EN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.Specification'
SET @FormID = N'QCF1001'
SET @Text = N'Thông số kỹ thuật'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.PhaseID'
SET @FormID = N'QCF1001'
SET @Text = N'Công đoạn'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.Recipe'
SET @FormID = N'QCF1001'
SET @Text = N'Công thức'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.SpecificationID.CB'
SET @FormID = N'QCF1001'
SET @Text = N'Mã thông số'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.SpecificationName.CB'
SET @FormID = N'QCF1001'
SET @Text = N'Tên thông số'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.PhaseNameSetting.CB'
SET @FormID = N'QCF1001'
SET @Text = N'Mã công đoạn'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.PhaseIDSetting.CB'
SET @FormID = N'QCF1001'
SET @Text = N'Tên công đoạn'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.PhaseIDSetting.CB'
SET @FormID = N'QCF1001'
SET @Text = N'Tên công đoạn'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.DeclareSO'
SET @FormID = N'QCF1001'
SET @Text = N'Khai báo công thức'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.DataTypeID.CB'
SET @FormID = N'QCF1001'
SET @Text = N'Mã loại'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.DataTypeName.CB'
SET @FormID = N'QCF1001'
SET @Text = N'Tên loại'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.DisplayName'
SET @FormID = N'QCF1001'
SET @Text = N'Tên hiển thị'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.UsingMaterialID'
SET @FormID = N'QCF1001'
SET @Text = N'Sử dụng nguyên vật liệu'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;

-- Đình Hòa [04/06/2021] - Thêm ngôn ngữ
SET @ModuleID = N'QC'
SET @KeyID = N'QCF1001.TypeSpreadsheetID'
SET @FormID = N'QCF1001'
SET @Text = N'Loại tiêu chuẩn bảng tính giá'
SET @Language = N'vi-VN'
SET @CustomName = NULL
EXEC ERP9AddLanguage @ModuleID, @KeyID, @FormID, @Text, @Language, @CustomName;