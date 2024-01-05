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
SET @ModuleID = 'AP'

SET @MessageValue = N'Bạn đã lưu thành công số chứng từ {0}.';
EXEC ERP9AddMessage @ModuleID, 'APFML000027' , @MessageValue, @Language;

SET @MessageValue = N'Mặt hàng chứa số seri {0} không chứa trong đơn hàng bán. Vui lòng nhập số seri khác!';
EXEC ERP9AddMessage @ModuleID, 'APFML000029' , @MessageValue, @Language;

IF NOT EXISTS(SELECT * FROM dbo.A00002 WHERE LanguageID = N'00ML000039')
BEGIN
	SET @MessageValue = N'Bạn phải nhập vào {0}.';
	EXEC ERP9AddMessage @ModuleID, '00ML000039' , @MessageValue, @Language;
END

IF NOT EXISTS(SELECT * FROM dbo.A00002 WHERE LanguageID = N'00ML000053')
BEGIN
	SET @MessageValue = N'{0} đã tồn tại. Vui lòng nhập mã khác!';
	EXEC ERP9AddMessage @ModuleID, '00ML000053' , @MessageValue, @Language;
END

IF NOT EXISTS(SELECT * FROM dbo.A00002 WHERE LanguageID = N'APFML000080')
BEGIN
	SET @MessageValue = N'Số seri không có trong đơn hàng mua. Vui lòng nhập số seri khác!';
	EXEC ERP9AddMessage @ModuleID, 'APFML000080' , @MessageValue, @Language;
END

IF NOT EXISTS(SELECT * FROM dbo.A00002 WHERE LanguageID = N'APFML000081')
BEGIN
	SET @MessageValue = N'Mặt hàng {0} có số lượng vượt quá yêu cầu [{1}] của đơn hàng mua.';
	EXEC ERP9AddMessage @ModuleID, 'APFML000081' , @MessageValue, @Language;
END