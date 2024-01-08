DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------
SET @Language = 'vi-VN';
SET @ModuleID = 'OO';
SET @FormID = 'OOF2301'
---------------------------------------------------------------
SET @LanguageValue  = N'Khai báo đăng ký thông tin dự án'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'※ Loại hình Xưởng 厂房类型'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.WorkshopType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điện tử 电子'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.Electronic',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công nghệ 化工'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.Technology',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Y dược 医药'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.Pharmacy',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công nghiệp nhân lực nhẹ  人力轻工业'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.LightManpowerIndustry',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công nghiệp máy móc nhẹ 机械化轻工业'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.LightMachineryIndustry',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công nghiệp nặng như rèn, cắt và hàn  锻造切割焊接等重工业'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.HeavyIndustry',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại khác 其他'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.OthersWorkshopType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.OthersWorkshopTypeText',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'※ Giai đoạn thi công 施工阶段'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.ConstructionPeriod',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xây mới 新建'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.NewConstruction',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dự án cải tạo 改造项目'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.RenovationProject',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xây mới đang trong giai đoạn thi công, tiến độ lắp đặt chuyên nghiệp >50% 
     新建尚未吊顶但其他安装专业进度＞50%'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.ProfessionalNewConstruction',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'※ Giai đoạn thiết kế 设计阶段'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.StageDesign',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ban đầu 初设'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.Initial',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vào sâu 深化'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.DeepInto',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cuối cùng 最终'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.Final',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'※ Phạm vi thiết kế (bao gồm) 设计范围（包含)'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.DesignScope',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điều hòa 空调'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.AirCondition',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu công suất lạnh 制冷需求'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.CoolingDemand',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.CoolingDemandText',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu công suất nóng 制热需求'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.HeatingDemand',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.HeatingDemandText',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Có nhiều thiết bị phát nhiệt , lượng phát nhiệt có đánh dấu trong bản vẽ 有较多发热设备，发热量在图纸中有标注'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.HeatingDevice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Có nhiều thiết bị phát nhiệt , lượng phát nhiệt là'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.HeatingDeviceKW',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.HeatingDeviceKWText',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'有较多发热设备，发热量为'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.HeatingDeviceKWTextKr',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Gió mới , gió tươi 新风'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.NewWind',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiêu chuẩn thấp 较低标准'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.LowStandards',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiêu chuẩn cao 较高标准'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.HighStandards',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khác: dựa trên tiêu chuẩn thông gió tính toán'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.OthersNewWind',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.VentilationStandards',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.PersonnelStandards',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.PersonnelDensity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.VentilationStandardsKr',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.PersonnelStandardsKr',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.PersonnelDensityKr',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Gió thải 排风'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.WasteWind',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xác định phương án gió thải , chuyển giao cho GREE ( bao gồm bản vẽ hoặc tài liệu) 已确定排风方案，并转交至GREE（包括图纸或说明文件）'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.Determined',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mô tả chi tiết: '
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.DetailDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.DetailDescriptionText',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'详细说明： '
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.DetailDescriptionKr',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.DetailDescriptionTextKr',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương án gió thải cần thiết kế bởi GREE 排风方案需GREE设计'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.WasteWindPlan',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Độ sạch 洁净度'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.Cleanness',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Độ sạch trong bản vẽ có mô tả 洁净度在图纸上有说明'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.DescribedCleanliness',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mô tả riêng biệt:'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.SeparateDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.SeparateDescriptionText',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'分别说明:'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.SeparateDescriptionKr',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.SeparateDescriptionTextKr',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Độ ẩm 湿度'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.Humidity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phạm vi thiết kế với các yêu cầu về độ ẩm đã được thông báo cho GREE 湿度要求在我提供的图纸上有说明'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.HumidityRequirement',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quy trình công nghệ sản xuất của tôi tại'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.TechnologicalProcess',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.TechnologicalProcessText',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.TechnologicalProcessTextKr',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'※ Công nghệ làm mát 工艺冷却'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.CoolingTechnology',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'※ Loại công nghệ làm mát 工艺冷却类型'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.CoolingTechnologyType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thiết bị sản xuất hạ nhiệt  生产设备降温'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.CoolingProduction',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công nghệ sản xuất yêu cầu nhiệt độ thấp  生产工艺需求低温'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.ProductionRequired',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'※ Môi trường làm mát yêu cầu 要求冷却介质'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.CoolingEnvironment',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'※ Tính toán công suất làm mát 冷量计算'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.CoolingCapacity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'※Thông số môi trường làm mát 冷却介质参数'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.EnvironmentalParameters',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'※ Bổ sung bản vẽ 图纸补充'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.AdditionalDrawingBoard',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nước 水'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.Water',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cồn thấp  低碳醇'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.LowAlcohol',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.LowAlcoholType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.Concentration',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dầu đông lạnh 冷冻油'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.FrozenOil',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.FrozenOilText',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khác 其他'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.OtherEnvironment',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.OtherEnvironmentText',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu công suất làm mát được đánh dấu trên bản vẽ 冷量要求在图纸上有标注'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.PowerRequirement',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thiết bị hoặc công nghệ sản xuất của tôi có nhu cầu vẫn chắc về công suất lạnh. Tham khảo (bảng tên thiết bị hoặc quy trình công nghệ đơn vị thiết kế cung cấp) là'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.EquipmentNeeds',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.EquipmentNeedsText',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.EquipmentNeedsTextKr',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mô tả từng máy một 逐台说明 '
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.OwnDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.OwnDescriptionText',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thiết bị / quy trình sản xuất của tôi có sự kiểm soát thông số nghiêm ngặt. Cần thiết kế nhiệt độ làm mát ra vào công nghệ/ thiết bị là'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.StrictParameters',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.CoolingTemperature1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.CoolingTemperature2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.TrafficRequest',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.Pressure',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.CoolingTemperature1Kr',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.CoolingTemperature2Kr',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.TrafficRequestKr',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.PressureKr',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'※Loại cơ cấu duy trì 维护结构类型'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.MaintenanceStructureType',  @FormID, @LanguageValue, @Language

SET @LanguageValue  = N'Gạch aac hoặc gạch chưng áp  240mm ~ 500mm, bê tông hoặc các vật liệu tương tự. 240mm~500mm加气砖、混凝土或类似材料'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.Brick240500',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Gạch aac hoặc gạch chưng áp bê, tông hoặc các vật liệu tương tự trong phạm vi 240mm 240mm以内加气砖、混凝土或类似材料'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.Brick240',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tấm composite chịu lực'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.CompositePlate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.Bearing',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.PlateType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.BearingKr',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.PlateTypeKr',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'※ Tường cách nhiệt bên ngoài 外墙保温'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.InsulatedWall',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Có cách nhiệt'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.Insulation',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.InsulationText',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.InsulationTextKr',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'không cách nhiệt 无保温'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.NonInsulation',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'※ Loại trần 吊顶类型'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.CeilingType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'không có trần 无吊顶'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.NonCeiling',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tấm Thạch cao, tấm nhẹ, tấm canxi silicat hoặc tấm nhôm, v.v. 
      石膏板、轻质板材、硅钙板或铝板等'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.Plasterboard',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khác 其他'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.OtherCeiling',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.OtherCeilingText',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'※ Chiều cao trần 吊顶高度'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.CeilingHeight',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'thông thường  3±0.3m      一般3±0.3米'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.NormalHeight',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Rất cao'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.HighHeight',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.HighHeightText',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.HighHeightTextKr',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'※Yêu cầu thiết kế chống cháy nổ 设计防爆要求'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.FireProtection',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu chống cháy nổ cho toàn bộ nhà máy '
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.WholeFactory',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.WholeFactoryText',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu chống cháy nổ bên trong xưởng'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.InsideWorkshop',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.InsideWorkshopText',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu chống cháy nổ tại địa phương '
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.Locally',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.LocallyText',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'※ Chiều cao tòa nhà và chiều cao tầng 建筑高度及层高'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.BuildingHeight',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bản vẽ có mô tả   图纸有说明'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.DrawDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bản vẽ không có mô tả, theo thiết kế kiến trúc thông thường    
     图纸无说明，按一般建筑设计'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.DrawNonDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thiết kế theo yêu cầu: chiều cao tòa nhà'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.RequestDesign',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.DesignBuildingHeight',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.DesignFloorHeight',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.DesignBuildingHeightKr',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.DesignFloorHeightKr',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mong muốn của khách hàng 客户意愿'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.CustomerWishes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại thiết bị được khách ưa chuộng 客户倾向的设备类型'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.PreferredDeviceType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.PreferredDeviceTypeText',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế hoạch dự kiến vị trí lắp đặt trong phòng máy 机房预计划安装位置'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.InstallationLocationPlan',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.InstallationLocationPlanText',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dự tính thời hạn sử dụng 预计划使用年限'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.EstimatedShelfLife',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.EstimatedShelfLifeText',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Có bất kỳ kế hoạch hoặc bản vẽ nào được cung cấp bởi các nhà sản xuất khác không 有无其他厂家提供的方案或设计图纸'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.OtherManufacturers',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.OtherManufacturersText',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khách hàng yêu cầu kiểm soát đặc biệt đối với hệ thống điều hòa không khí 客户对空调系统的特殊控制需求'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.SpecialControl',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.SpecialControlText',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Các mô tả đặc biệt khác 其他特殊说明'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.OtherSpecialDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N''
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.OtherSpecialDescriptionText',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chú ý 注'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.Attention',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'※ Thông tin đăng ký  登记信息'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.RegisterDetail',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'NV Thiết kế 设计员'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.EmployeeCreate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã dự án 项目编码'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.ProjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'NVKD 销售员'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.SalesmanRegister',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bộ phận 部门'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.SectionRegister',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày đăng ký 登记日期'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.RegisterDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày hoàn thành 完成时间'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.RegisterPlanEndDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'※ Thông tin khách hàng 客户信息'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.ObjectDetail',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên khách hàng 客户名称'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.OjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điện thoại liên hệ 联系电话'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.ObjectPhoneNumber',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên CĐT 业主'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.InvestorName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhà thầu 承包商名称'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.ContactorObject',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người nhận báo giá 询价人'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.QuotePriceMan',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ 职务'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.ObjectDutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'※ Thông tin dự án 项目信息'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.ProjectDetai',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên dự án 项目名称'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.ProjectName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại dự án 项目类型'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.ProjectType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ dư án 项目地址'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.ProjectAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người liên hệ 联系人'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.ContactorProject',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ 职务'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.ProjectDutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điện thoại 电话'
EXEC ERP9AddLanguage @ModuleID, 'OOF2301.ProjectPhoneNumber',  @FormID, @LanguageValue, @Language;

