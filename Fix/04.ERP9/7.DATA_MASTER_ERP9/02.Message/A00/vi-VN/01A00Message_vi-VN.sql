DECLARE @ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
@MessageValue NVARCHAR(400),
------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT
------------------------------------------------------------------------------------------------------
-- Set value và Execute query
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP
- Tieng Trung: zh-CN
*/
SET @Language = 'vi-VN'
SET @ModuleID = '00'

SET @MessageValue=N'Thời gian bắt đầu và kết thúc không thuộc khoản thời gian áp dụng' 
EXEC ERP9AddMessage @ModuleID,'00ML000201', @MessageValue, @Language; 

SET @MessageValue=N'{0} vừa ghi chú cho {1} {2}'
EXEC ERP9AddMessage @ModuleID,'00ML000220', @MessageValue, @Language;

SET @MessageValue=N'Bạn vừa được gán theo dõi {0} {1}'
EXEC ERP9AddMessage @ModuleID,'00ML000221', @MessageValue, @Language;

SET @Language = 'vi-VN'
SET @ModuleID = 'EDM'

SET @MessageValue=N'Khoản thời gian từ ngày, đến ngày đã được tạo. Vui lòng thiết lập thời gian khác.' 
EXEC ERP9AddMessage @ModuleID,'EDMFML000009', @MessageValue, @Language;