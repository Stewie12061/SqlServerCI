-- CREATE BY Lê Hoàng ON 29/10/2020
-- MODIFIED BY Lê Hoàng ON 02/11/2020
-- MODIFIED BY Tấn Lộc ON 28/07/2021 - Bổ sung thêm trường hợp đặc biệt CodeMaster = CRMT00000033 người dùng được khai báo dữ liệu ngầm tại màn hình SF0010 - thiết lập dữ liệu ngầm
-- MODIFIED BY Hoài Bảo ON 29/07/2021 - Thay thế  dùng cột CodeMasterName để insert cột CategoryName.
									  -- Do đang sử dụng DISTINCT để lấy dữ liệu từ các bảng XXT0099 để insert vào bảng ST0020, Nếu bổ sung thêm DISTINCT CodeMasterName thì xảy ra trường hợp CodeMaster trùng mà CodeMasterName không trùng
									  -- => Khi insert sẽ bị trùng key vì cột CodeMaster của bảng ST0020 đang được chọn làm khóa chính  => Nên tách ra xử lý insert trước rồi update lại CodeMasterName
-- Thêm dữ liệu vào bảng Master Module S ST0020

DECLARE @ASOFTBEM VARCHAR(MAX) = '' 		
DECLARE @ASOFTCI VARCHAR(MAX) = ''  		
DECLARE @ASOFTCRM VARCHAR(MAX) = '' 		
DECLARE @ASOFTEDM VARCHAR(MAX) = '' 		
DECLARE @ASOFTHRM VARCHAR(MAX) = '' 		
DECLARE @ASOFTKPI VARCHAR(MAX) = '' 		
DECLARE @ASOFTM VARCHAR(MAX) = '' 			
DECLARE @ASOFTOO VARCHAR(MAX) = '' 		
DECLARE @ASOFTOP VARCHAR(MAX) = '' 		
DECLARE @ASOFTPOS VARCHAR(MAX) = '' 		
DECLARE @ASOFTS VARCHAR(MAX) = '' 			
DECLARE @ASOFTT VARCHAR(MAX) = '' 			
DECLARE @ASOFTQC VARCHAR(MAX) = '' 		
DECLARE @sSQL NVARCHAR(MAX) = '' 			
DECLARE @CodeMasterCRM NVARCHAR(MAX) = ''

DECLARE @ASOFTBEMUpdate VARCHAR(MAX) = ''
DECLARE @ASOFTCIUpdate VARCHAR(MAX) = ''
DECLARE @ASOFTCRMUpdate VARCHAR(MAX) = ''
DECLARE @ASOFTEDMUpdate VARCHAR(MAX) = ''
DECLARE @ASOFTHRMUpdate VARCHAR(MAX) = ''
DECLARE @ASOFTKPIUpdate VARCHAR(MAX) = ''
DECLARE @ASOFTMUpdate VARCHAR(MAX) = ''
DECLARE @ASOFTOOUpdate VARCHAR(MAX) = ''
DECLARE @ASOFTOPUpdate VARCHAR(MAX) = ''
DECLARE @ASOFTPOSUpdate VARCHAR(MAX) = ''
DECLARE @ASOFTSUpdate VARCHAR(MAX) = ''
DECLARE @ASOFTTUpdate VARCHAR(MAX) = ''
DECLARE @ASOFTQCUpdate VARCHAR(MAX) = ''
DECLARE @sSQLUpdate NVARCHAR(MAX) = ''

IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'BEMT0099' AND xtype = 'U')
BEGIN
	-- Insert
	SET @ASOFTBEM = 'SELECT DISTINCT CodeMaster, N''ASOFTBEM'' AS ModuleID, CodeMaster AS CategoryName FROM BEMT0099
	'
	-- Update
	SET @ASOFTBEMUpdate = 'SELECT DISTINCT CodeMaster, N''ASOFTBEM'' AS ModuleID, (CASE WHEN ISNULL(CodeMasterName, '''') != '''' THEN CodeMasterName ELSE CodeMaster END) AS CategoryName FROM BEMT0099
	'
END
------------------
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CIT0099' AND xtype = 'U')
BEGIN
	-- Insert
	SET @ASOFTCI = 'SELECT DISTINCT CodeMaster, N''ASOFTCI'' AS ModuleID, CodeMaster AS CategoryName FROM CIT0099
	'
	-- Update
	SET @ASOFTCIUpdate = 'SELECT DISTINCT CodeMaster, N''ASOFTCI'' AS ModuleID, (CASE WHEN ISNULL(CodeMasterName, '''') != '''' THEN CodeMasterName ELSE CodeMaster END) AS CategoryName FROM CIT0099
	'
END
------------------
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'CRMT0099' AND xtype = 'U')
BEGIN
	-- Insert
	SET @ASOFTCRM = 'SELECT DISTINCT CodeMaster, N''ASOFTCRM'' AS ModuleID, CodeMaster AS CategoryName FROM CRMT0099
	'
	-- Xử lý trường hợp đặc biệt, Người dùng được quyền khai báo dữ liệu ngầm cho CodeMaster [CRMT00000033]
	SET @CodeMasterCRM = N'SELECT DISTINCT N''CRMT00000033'' AS CodeMaster, N''ASOFTCRM'' AS ModuleID, N''Dữ liệu ngầm mục tiêu màn hình chiến dịch Marketing'' AS CategoryName
	'
	-- Update
	SET @ASOFTCRMUpdate = 'SELECT DISTINCT CodeMaster, N''ASOFTCRM'' AS ModuleID, (CASE WHEN ISNULL(CodeMasterName, '''') != '''' THEN CodeMasterName ELSE CodeMaster END) AS CategoryName FROM CRMT0099
	'

END
------------------
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'EDMT0099' AND xtype = 'U')
BEGIN
	-- Insert
	SET @ASOFTEDM = 'SELECT DISTINCT CodeMaster, N''ASOFTEDM'' AS ModuleID, CodeMaster AS CategoryName FROM EDMT0099
	'
	-- Update
	SET @ASOFTEDMUpdate = 'SELECT DISTINCT CodeMaster, N''ASOFTEDM'' AS ModuleID, (CASE WHEN ISNULL(CodeMasterName, '''') != '''' THEN CodeMasterName ELSE CodeMaster END) AS CategoryName FROM EDMT0099
	'
END
------------------
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'HT0099' AND xtype = 'U')
BEGIN
	-- Insert
	SET @ASOFTHRM = 'SELECT DISTINCT CodeMaster, N''ASOFTHRM'' AS ModuleID, CodeMaster AS CategoryName FROM HT0099
	'
	-- Update
	SET @ASOFTHRMUpdate = 'SELECT DISTINCT CodeMaster, N''ASOFTHRM'' AS ModuleID, (CASE WHEN ISNULL(CodeMasterName, '''') != '''' THEN CodeMasterName ELSE CodeMaster END) AS CategoryName FROM HT0099
	'
END
------------------
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'KPIT0099' AND xtype = 'U')
BEGIN
	-- Insert
	SET @ASOFTKPI = 'SELECT DISTINCT CodeMaster, N''ASOFTKPI'' AS ModuleID, CodeMaster AS CategoryName FROM KPIT0099
	'
	-- Update
	SET @ASOFTKPIUpdate = 'SELECT DISTINCT CodeMaster, N''ASOFTKPI'' AS ModuleID, (CASE WHEN ISNULL(CodeMasterName, '''') != '''' THEN CodeMasterName ELSE CodeMaster END) AS CategoryName FROM KPIT0099
	'
END
------------------
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'MT0099' AND xtype = 'U')
BEGIN
	-- Insert
	SET @ASOFTM = 'SELECT DISTINCT CodeMaster, N''ASOFTM'' AS ModuleID, CodeMaster AS CategoryName FROM MT0099
	'
	-- Update
	SET @ASOFTMUpdate = 'SELECT DISTINCT CodeMaster, N''ASOFTM'' AS ModuleID, (CASE WHEN ISNULL(CodeMasterName, '''') != '''' THEN CodeMasterName ELSE CodeMaster END) AS CategoryName FROM MT0099
	'
END
------------------
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OOT0099' AND xtype = 'U')
BEGIN
	-- Insert
	SET @ASOFTOO = 'SELECT DISTINCT CodeMaster, N''ASOFTOO'' AS ModuleID, CodeMaster AS CategoryName FROM OOT0099
	'
	-- Update
	SET @ASOFTOOUpdate = 'SELECT DISTINCT CodeMaster, N''ASOFTOO'' AS ModuleID, (CASE WHEN ISNULL(CodeMasterName, '''') != '''' THEN CodeMasterName ELSE CodeMaster END) AS CategoryName FROM OOT0099
	'
END
------------------
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'OT0099' AND xtype = 'U')
BEGIN
	-- Insert
	SET @ASOFTOP = 'SELECT DISTINCT CodeMaster, N''ASOFTOP'' AS ModuleID, CodeMaster AS CategoryName FROM OT0099
	'
	-- Update
	SET @ASOFTOPUpdate = 'SELECT DISTINCT CodeMaster, N''ASOFTOP'' AS ModuleID, (CASE WHEN ISNULL(CodeMasterName, '''') != '''' THEN CodeMasterName ELSE CodeMaster END) AS CategoryName FROM OT0099
	'
END
------------------
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'POST0099' AND xtype = 'U')
BEGIN
	-- Insert
	SET @ASOFTPOS = 'SELECT DISTINCT CodeMaster, N''ASOFTPOS'' AS ModuleID, CodeMaster AS CategoryName FROM POST0099
	'
	-- Update
	SET @ASOFTPOSUpdate = 'SELECT DISTINCT CodeMaster, N''ASOFTPOS'' AS ModuleID, (CASE WHEN ISNULL(CodeMasterName, '''') != '''' THEN CodeMasterName ELSE CodeMaster END) AS CategoryName FROM POST0099
	'
END
------------------
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'ST0099' AND xtype = 'U')
BEGIN
	-- Insert
	SET @ASOFTS = 'SELECT DISTINCT CodeMaster, N''ASOFTS'' AS ModuleID, CodeMaster AS CategoryName FROM ST0099
	'
	-- Update
	SET @ASOFTSUpdate = 'SELECT DISTINCT CodeMaster, N''ASOFTS'' AS ModuleID, (CASE WHEN ISNULL(CodeMasterName, '''') != '''' THEN CodeMasterName ELSE CodeMaster END) AS CategoryName FROM ST0099
	'
END
------------------
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'AT0099' AND xtype = 'U')
BEGIN
	-- Insert
	SET @ASOFTT = 'SELECT DISTINCT CodeMaster, N''ASOFTT'' AS ModuleID, CodeMaster AS CategoryName FROM AT0099
	'
	-- Update
	SET @ASOFTTUpdate = 'SELECT DISTINCT CodeMaster, N''ASOFTT'' AS ModuleID, (CASE WHEN ISNULL(CodeMasterName, '''') != '''' THEN CodeMasterName ELSE CodeMaster END) AS CategoryName FROM AT0099
	'
END
------------------
IF EXISTS (SELECT TOP 1 1 FROM sysobjects WHERE [name] = 'QCT0099' AND xtype = 'U')
BEGIN
	-- Insert
	SET @ASOFTQC = 'SELECT DISTINCT CodeMaster, N''ASOFTQC'' AS ModuleID, CodeMaster AS CategoryName FROM QCT0099
	'
	-- Update
	SET @ASOFTQCUpdate = 'SELECT DISTINCT CodeMaster, N''ASOFTQC'' AS ModuleID, (CASE WHEN ISNULL(CodeMasterName, '''') != '''' THEN CodeMasterName ELSE CodeMaster END) AS CategoryName FROM QCT0099
	'
END

-- Xử lý phần insert dữ liệu
SET @sSQL = '
INSERT INTO ST0020 ([CodeMaster], [ModuleID], [CategoryName])
SELECT A.* FROM 
( '
+ @ASOFTS + CASE WHEN ISNULL(@ASOFTBEM,'') <> '' THEN ' UNION ' ELSE ' ' END
+ @ASOFTBEM + CASE WHEN ISNULL(@ASOFTCI,'') <> '' THEN ' UNION ' ELSE ' ' END
+ @ASOFTCI + CASE WHEN ISNULL(@ASOFTCRM,'') <> '' THEN ' UNION ' ELSE ' ' END
+ @ASOFTCRM + CASE WHEN ISNULL(@ASOFTEDM,'') <> '' THEN ' UNION ' ELSE ' ' END
+ @ASOFTEDM + CASE WHEN ISNULL(@ASOFTHRM,'') <> '' THEN ' UNION ' ELSE ' ' END
+ @ASOFTHRM + CASE WHEN ISNULL(@ASOFTKPI,'') <> '' THEN ' UNION ' ELSE ' ' END
+ @ASOFTKPI + CASE WHEN ISNULL(@ASOFTM,'') <> '' THEN ' UNION ' ELSE ' ' END
+ @ASOFTM + CASE WHEN ISNULL(@ASOFTOO,'') <> '' THEN ' UNION ' ELSE ' ' END
+ @ASOFTOO + CASE WHEN ISNULL(@ASOFTOP,'') <> '' THEN ' UNION ' ELSE ' ' END
+ @ASOFTOP + CASE WHEN ISNULL(@ASOFTPOS,'') <> '' THEN ' UNION ' ELSE ' ' END
+ @ASOFTPOS + CASE WHEN ISNULL(@ASOFTT,'') <> '' THEN ' UNION ' ELSE ' ' END
+ @ASOFTT + CASE WHEN ISNULL(@ASOFTQC,'') <> '' THEN ' UNION ' ELSE ' ' END
+ @ASOFTQC + CASE WHEN ISNULL(@CodeMasterCRM,'') <> '' THEN ' UNION ' ELSE ' ' END
+ @CodeMasterCRM + 
' ) A
LEFT JOIN ST0020 WITH (NOLOCK) ON ST0020.CodeMaster = A.CodeMaster AND ST0020.ModuleID = A.ModuleID
WHERE ST0020.CodeMaster IS NULL AND ST0020.ModuleID IS NULL
'
-- Update lại CategoryName bảng ST0020 dựa theo CodeMasterName
SET @sSQLUpdate = '
UPDATE ST0020
SET [CategoryName] = A.CategoryName  FROM  
( '
+ @ASOFTSUpdate + CASE WHEN ISNULL(@ASOFTBEMUpdate,'') <> '' THEN ' UNION ' ELSE ' ' END
+ @ASOFTBEMUpdate + CASE WHEN ISNULL(@ASOFTCIUpdate,'') <> '' THEN ' UNION ' ELSE ' ' END
+ @ASOFTCIUpdate + CASE WHEN ISNULL(@ASOFTCRMUpdate,'') <> '' THEN ' UNION ' ELSE ' ' END
+ @ASOFTCRMUpdate + CASE WHEN ISNULL(@ASOFTEDMUpdate,'') <> '' THEN ' UNION ' ELSE ' ' END
+ @ASOFTEDMUpdate + CASE WHEN ISNULL(@ASOFTHRMUpdate,'') <> '' THEN ' UNION ' ELSE ' ' END
+ @ASOFTHRMUpdate + CASE WHEN ISNULL(@ASOFTKPIUpdate,'') <> '' THEN ' UNION ' ELSE ' ' END
+ @ASOFTKPIUpdate + CASE WHEN ISNULL(@ASOFTMUpdate,'') <> '' THEN ' UNION ' ELSE ' ' END
+ @ASOFTMUpdate + CASE WHEN ISNULL(@ASOFTOOUpdate,'') <> '' THEN ' UNION ' ELSE ' ' END
+ @ASOFTOOUpdate + CASE WHEN ISNULL(@ASOFTOPUpdate,'') <> '' THEN ' UNION ' ELSE ' ' END
+ @ASOFTOPUpdate + CASE WHEN ISNULL(@ASOFTPOSUpdate,'') <> '' THEN ' UNION ' ELSE ' ' END
+ @ASOFTPOSUpdate + CASE WHEN ISNULL(@ASOFTTUpdate,'') <> '' THEN ' UNION ' ELSE ' ' END
+ @ASOFTTUpdate + CASE WHEN ISNULL(@ASOFTQCUpdate,'') <> '' THEN ' UNION ' ELSE ' ' END
+ @ASOFTQCUpdate + CASE WHEN ISNULL(@CodeMasterCRM,'') <> '' THEN ' UNION ' ELSE ' ' END
+ @CodeMasterCRM + 
' ) A WHERE ST0020.CodeMaster = A.CodeMaster AND ST0020.ModuleID = A.ModuleID
'

EXEC(@sSQL)
PRINT @sSQL

EXEC(@sSQLUpdate)
PRINT @sSQLUpdate