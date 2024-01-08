IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP8131]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP8131]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Xử lý Import hồ sơ lương
---- Create on 03/10/2013 by Bảo Anh
---- Modified on 13/03/2015 by Lê Thị Hạnh: Bổ sung convert dữ liệu, nếu hồ sơ đã có thì cập nhật[Lỗi convert varchar to numeric], 
------------------------------------------>> Với APSG thì cập nhật hệ số và các thông tin nếu nhập vào
---- Modified on 01/11/2015 by Bảo Anh: Xử lý cập nhật UPDATE hồ sơ lương cho Tiên Tiến như APSG
---- Modified on 18/11/2015 by Bảo Anh: Sửa lỗi import sai các hệ số lương
---- Modified on 30/05/2016 by Bảo Anh: Xử lý cập nhật UPDATE hồ sơ lương cho Secoin như Tiên Tiến và APSG
---- Modified on 29/11/2016 by Phương Thảo: Bổ sung import 150 hệ số
---- Modified on 12/01/2017 by Bảo Thy: Bổ sung import 25 ghi chú
---- Modified on 05/03/2019 by Kim Thư: Tạo khóa chính cho table #Data và #Keys có nối với @@SPID để tránh trùng khóa chính khi nhiều user sử dụng
---- Modified on 22/01/2021 by Huỳnh Thử: Xử lý cập nhật UPDATE hồ sơ lương cho NQH như Secoin, Tiến và APSG
---- Modified on 22/01/2021 by Huỳnh Thử: Xử lý cập nhật UPDATE hồ sơ lương đưa vào chuẩn
---- Modified on 25/01/2022 by Nhật Thanh: Tăng chiều dài khi sinh khóa

CREATE PROCEDURE [DBO].[AP8131]
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@ImportTemplateID AS NVARCHAR(50),
	@XML AS XML
) 
AS
DECLARE @cCURSOR AS CURSOR,
		@sSQL AS VARCHAR(1000),
		@FieldName1 AS NVARCHAR(4000) = '',
		@FieldName2 AS NVARCHAR(4000) = ''
		
DECLARE @ColID AS NVARCHAR(50), 
		@ColSQLDataType AS NVARCHAR(50)
		
CREATE TABLE #Data
(
	APK UNIQUEIDENTIFIER DEFAULT(NEWID()),
	Row INT NOT NULL,
	Orders INT,
	EmpFileID NVARCHAR(50) NULL,
	ImportMessage NVARCHAR(500) DEFAULT ('')--,
	--CONSTRAINT [PK_#Data] PRIMARY KEY CLUSTERED 
	--(
	--	Row ASC
	--) ON [PRIMARY]	
)

CREATE TABLE #Keys
(
	Row INT NOT NULL,
	Orders INT,
	EmpFileID NVARCHAR(50)--,
	--CONSTRAINT [PK_#Keys] PRIMARY KEY CLUSTERED 
	--(
	--	Row ASC
	--) ON [PRIMARY]	
)

-- Tạo khóa chính cho table #Data và #Keys
DECLARE @Keys_PK VARCHAR(50), @Data_PK VARCHAR(50),
		@SQL NVARCHAR(MAX);
SET @Data_PK='PK_#Data_' + LTRIM(@@SPID);
SET @Keys_PK='PK_#Keys_' + LTRIM(@@SPID);

--add constraint 
SET @SQL = 'ALTER TABLE #Data ADD CONSTRAINT ' + @Data_PK+ ' PRIMARY KEY(Row)
			ALTER TABLE #Keys ADD CONSTRAINT ' + @Keys_PK+ ' PRIMARY KEY(Row)'

EXEC(@SQL)

SET @cCURSOR = CURSOR STATIC FOR
	SELECT		TLD.ColID,
				BTL.ColSQLDataType
	FROM		A01065 TL
	INNER JOIN	A01066 TLD
			ON	TL.ImportTemplateID = TLD.ImportTemplateID
	INNER JOIN	A00065 BTL
			ON	BTL.ImportTransTypeID = TL.ImportTransTypeID AND BTL.ColID = TLD.ColID
	WHERE		TL.ImportTemplateID = @ImportTemplateID
	ORDER BY	TLD.OrderNum

OPEN @cCURSOR									
-- Tạo cấu trúc bảng tạm
FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType	
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @sSQL = 'ALTER TABLE #Data ADD ' + @ColID + ' ' + @ColSQLDataType + CASE WHEN @ColSQLDataType LIKE '%char%' THEN ' COLLATE SQL_Latin1_General_CP1_CI_AS' ELSE '' END + ' NULL'
---	PRINT @sSQL
	EXEC (@sSQL)
	FETCH NEXT FROM @cCURSOR INTO @ColID, @ColSQLDataType
END

SELECT	X.Data.query('Row').value('.', 'INT') AS Row,
		X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
		X.Data.query('Period').value('.', 'VARCHAR(10)') AS Period,
		X.Data.query('DepartmentID').value('.', 'NVARCHAR(50)') AS DepartmentID,
		(CASE WHEN X.Data.query('TeamID').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('TeamID').value('.', 'NVARCHAR(50)') END) AS TeamID,
		X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,
		(CASE WHEN X.Data.query('TaxObjectID').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('TaxObjectID').value('.', 'NVARCHAR(50)') END) AS TaxObjectID,
		(CASE WHEN X.Data.query('BaseSalary').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('BaseSalary').value('.', 'DECIMAL(28,8)') END) AS BaseSalary,
		(CASE WHEN X.Data.query('InsuranceSalary').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('InsuranceSalary').value('.', 'DECIMAL(28,8)') END) AS InsuranceSalary,
		(CASE WHEN X.Data.query('Salary01').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Salary01').value('.', 'DECIMAL(28,8)') END) AS Salary01,
		(CASE WHEN X.Data.query('Salary02').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Salary02').value('.', 'DECIMAL(28,8)') END) AS Salary02,
		(CASE WHEN X.Data.query('Salary03').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Salary03').value('.', 'DECIMAL(28,8)') END) AS Salary03,
		(CASE WHEN X.Data.query('SalaryCoefficient').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('SalaryCoefficient').value('.', 'DECIMAL(28,8)') END) AS SalaryCoefficient,
		(CASE WHEN X.Data.query('DutyCoefficient').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('DutyCoefficient').value('.', 'DECIMAL(28,8)') END) AS DutyCoefficient,
		(CASE WHEN X.Data.query('TimeCoefficient').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('TimeCoefficient').value('.', 'DECIMAL(28,8)') END) AS TimeCoefficient,
		(CASE WHEN X.Data.query('C01').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C01').value('.', 'DECIMAL(28,8)') END) AS C01,
		(CASE WHEN X.Data.query('C02').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C02').value('.', 'DECIMAL(28,8)') END) AS C02,
		(CASE WHEN X.Data.query('C03').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C03').value('.', 'DECIMAL(28,8)') END) AS C03,
		(CASE WHEN X.Data.query('C04').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C04').value('.', 'DECIMAL(28,8)') END) AS C04,
		(CASE WHEN X.Data.query('C05').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C05').value('.', 'DECIMAL(28,8)') END) AS C05,
		(CASE WHEN X.Data.query('C06').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C06').value('.', 'DECIMAL(28,8)') END) AS C06,
		(CASE WHEN X.Data.query('C07').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C07').value('.', 'DECIMAL(28,8)') END) AS C07,
		(CASE WHEN X.Data.query('C08').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C08').value('.', 'DECIMAL(28,8)') END) AS C08,
		(CASE WHEN X.Data.query('C09').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C09').value('.', 'DECIMAL(28,8)') END) AS C09,
		(CASE WHEN X.Data.query('C10').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C10').value('.', 'DECIMAL(28,8)') END) AS C10,
		(CASE WHEN X.Data.query('C11').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C11').value('.', 'DECIMAL(28,8)') END) AS C11,
		(CASE WHEN X.Data.query('C12').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C12').value('.', 'DECIMAL(28,8)') END) AS C12,
		(CASE WHEN X.Data.query('C13').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C13').value('.', 'DECIMAL(28,8)') END) AS C13,
		(CASE WHEN X.Data.query('C14').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C14').value('.', 'DECIMAL(28,8)') END) AS C14,
		(CASE WHEN X.Data.query('C15').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C15').value('.', 'DECIMAL(28,8)') END) AS C15,
		(CASE WHEN X.Data.query('C16').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C16').value('.', 'DECIMAL(28,8)') END) AS C16,
		(CASE WHEN X.Data.query('C17').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C17').value('.', 'DECIMAL(28,8)') END) AS C17,
		(CASE WHEN X.Data.query('C18').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C18').value('.', 'DECIMAL(28,8)') END) AS C18,
		(CASE WHEN X.Data.query('C19').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C19').value('.', 'DECIMAL(28,8)') END) AS C19,
		(CASE WHEN X.Data.query('C20').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C20').value('.', 'DECIMAL(28,8)') END) AS C20,
		(CASE WHEN X.Data.query('C21').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C21').value('.', 'DECIMAL(28,8)') END) AS C21,
		(CASE WHEN X.Data.query('C22').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C22').value('.', 'DECIMAL(28,8)') END) AS C22,
		(CASE WHEN X.Data.query('C23').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C23').value('.', 'DECIMAL(28,8)') END) AS C23,
		(CASE WHEN X.Data.query('C24').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C24').value('.', 'DECIMAL(28,8)') END) AS C24,
		(CASE WHEN X.Data.query('C25').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C25').value('.', 'DECIMAL(28,8)') END) AS C25,
		(CASE WHEN X.Data.query('IsJobWage').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('IsJobWage').value('.', 'DECIMAL(28,8)') END) AS IsJobWage,
		(CASE WHEN X.Data.query('IsPiecework').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('IsPiecework').value('.', 'DECIMAL(28,8)') END) AS IsPiecework,
		(CASE WHEN X.Data.query('C26').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C26').value('.', 'DECIMAL(28,8)') END) AS C26,
		(CASE WHEN X.Data.query('C27').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C27').value('.', 'DECIMAL(28,8)') END) AS C27,
		(CASE WHEN X.Data.query('C28').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C28').value('.', 'DECIMAL(28,8)') END) AS C28,
		(CASE WHEN X.Data.query('C29').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C29').value('.', 'DECIMAL(28,8)') END) AS C29,
		(CASE WHEN X.Data.query('C30').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C30').value('.', 'DECIMAL(28,8)') END) AS C30,
		(CASE WHEN X.Data.query('C31').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C31').value('.', 'DECIMAL(28,8)') END) AS C31,
		(CASE WHEN X.Data.query('C32').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C32').value('.', 'DECIMAL(28,8)') END) AS C32,
		(CASE WHEN X.Data.query('C33').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C33').value('.', 'DECIMAL(28,8)') END) AS C33,
		(CASE WHEN X.Data.query('C34').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C34').value('.', 'DECIMAL(28,8)') END) AS C34,
		(CASE WHEN X.Data.query('C35').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C35').value('.', 'DECIMAL(28,8)') END) AS C35,
		(CASE WHEN X.Data.query('C36').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C36').value('.', 'DECIMAL(28,8)') END) AS C36,
		(CASE WHEN X.Data.query('C37').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C37').value('.', 'DECIMAL(28,8)') END) AS C37,
		(CASE WHEN X.Data.query('C38').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C38').value('.', 'DECIMAL(28,8)') END) AS C38,
		(CASE WHEN X.Data.query('C39').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C39').value('.', 'DECIMAL(28,8)') END) AS C39,
		(CASE WHEN X.Data.query('C40').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C40').value('.', 'DECIMAL(28,8)') END) AS C40,
		(CASE WHEN X.Data.query('C41').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C41').value('.', 'DECIMAL(28,8)') END) AS C41,
		(CASE WHEN X.Data.query('C42').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C42').value('.', 'DECIMAL(28,8)') END) AS C42,
		(CASE WHEN X.Data.query('C43').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C43').value('.', 'DECIMAL(28,8)') END) AS C43,
		(CASE WHEN X.Data.query('C44').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C44').value('.', 'DECIMAL(28,8)') END) AS C44,
		(CASE WHEN X.Data.query('C45').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C45').value('.', 'DECIMAL(28,8)') END) AS C45,
		(CASE WHEN X.Data.query('C46').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C46').value('.', 'DECIMAL(28,8)') END) AS C46,
		(CASE WHEN X.Data.query('C47').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C47').value('.', 'DECIMAL(28,8)') END) AS C47,
		(CASE WHEN X.Data.query('C48').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C48').value('.', 'DECIMAL(28,8)') END) AS C48,
		(CASE WHEN X.Data.query('C49').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C49').value('.', 'DECIMAL(28,8)') END) AS C49,
		(CASE WHEN X.Data.query('C50').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C50').value('.', 'DECIMAL(28,8)') END) AS C50,
		(CASE WHEN X.Data.query('C51').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C51').value('.', 'DECIMAL(28,8)') END) AS C51,
		(CASE WHEN X.Data.query('C52').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C52').value('.', 'DECIMAL(28,8)') END) AS C52,
		(CASE WHEN X.Data.query('C53').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C53').value('.', 'DECIMAL(28,8)') END) AS C53,
		(CASE WHEN X.Data.query('C54').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C54').value('.', 'DECIMAL(28,8)') END) AS C54,
		(CASE WHEN X.Data.query('C55').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C55').value('.', 'DECIMAL(28,8)') END) AS C55,
		(CASE WHEN X.Data.query('C56').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C56').value('.', 'DECIMAL(28,8)') END) AS C56,
		(CASE WHEN X.Data.query('C57').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C57').value('.', 'DECIMAL(28,8)') END) AS C57,
		(CASE WHEN X.Data.query('C58').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C58').value('.', 'DECIMAL(28,8)') END) AS C58,
		(CASE WHEN X.Data.query('C59').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C59').value('.', 'DECIMAL(28,8)') END) AS C59,
		(CASE WHEN X.Data.query('C60').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C60').value('.', 'DECIMAL(28,8)') END) AS C60,
		(CASE WHEN X.Data.query('C61').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C61').value('.', 'DECIMAL(28,8)') END) AS C61,
		(CASE WHEN X.Data.query('C62').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C62').value('.', 'DECIMAL(28,8)') END) AS C62,
		(CASE WHEN X.Data.query('C63').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C63').value('.', 'DECIMAL(28,8)') END) AS C63,
		(CASE WHEN X.Data.query('C64').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C64').value('.', 'DECIMAL(28,8)') END) AS C64,
		(CASE WHEN X.Data.query('C65').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C65').value('.', 'DECIMAL(28,8)') END) AS C65,
		(CASE WHEN X.Data.query('C66').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C66').value('.', 'DECIMAL(28,8)') END) AS C66,
		(CASE WHEN X.Data.query('C67').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C67').value('.', 'DECIMAL(28,8)') END) AS C67,
		(CASE WHEN X.Data.query('C68').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C68').value('.', 'DECIMAL(28,8)') END) AS C68,
		(CASE WHEN X.Data.query('C69').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C69').value('.', 'DECIMAL(28,8)') END) AS C69,
		(CASE WHEN X.Data.query('C70').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C70').value('.', 'DECIMAL(28,8)') END) AS C70,
		(CASE WHEN X.Data.query('C71').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C71').value('.', 'DECIMAL(28,8)') END) AS C71,
		(CASE WHEN X.Data.query('C72').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C72').value('.', 'DECIMAL(28,8)') END) AS C72,
		(CASE WHEN X.Data.query('C73').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C73').value('.', 'DECIMAL(28,8)') END) AS C73,
		(CASE WHEN X.Data.query('C74').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C74').value('.', 'DECIMAL(28,8)') END) AS C74,
		(CASE WHEN X.Data.query('C75').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C75').value('.', 'DECIMAL(28,8)') END) AS C75,
		(CASE WHEN X.Data.query('C76').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C76').value('.', 'DECIMAL(28,8)') END) AS C76,
		(CASE WHEN X.Data.query('C77').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C77').value('.', 'DECIMAL(28,8)') END) AS C77,
		(CASE WHEN X.Data.query('C78').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C78').value('.', 'DECIMAL(28,8)') END) AS C78,
		(CASE WHEN X.Data.query('C79').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C79').value('.', 'DECIMAL(28,8)') END) AS C79,
		(CASE WHEN X.Data.query('C80').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C80').value('.', 'DECIMAL(28,8)') END) AS C80,
		(CASE WHEN X.Data.query('C81').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C81').value('.', 'DECIMAL(28,8)') END) AS C81,
		(CASE WHEN X.Data.query('C82').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C82').value('.', 'DECIMAL(28,8)') END) AS C82,
		(CASE WHEN X.Data.query('C83').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C83').value('.', 'DECIMAL(28,8)') END) AS C83,
		(CASE WHEN X.Data.query('C84').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C84').value('.', 'DECIMAL(28,8)') END) AS C84,
		(CASE WHEN X.Data.query('C85').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C85').value('.', 'DECIMAL(28,8)') END) AS C85,
		(CASE WHEN X.Data.query('C86').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C86').value('.', 'DECIMAL(28,8)') END) AS C86,
		(CASE WHEN X.Data.query('C87').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C87').value('.', 'DECIMAL(28,8)') END) AS C87,
		(CASE WHEN X.Data.query('C88').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C88').value('.', 'DECIMAL(28,8)') END) AS C88,
		(CASE WHEN X.Data.query('C89').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C89').value('.', 'DECIMAL(28,8)') END) AS C89,
		(CASE WHEN X.Data.query('C90').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C90').value('.', 'DECIMAL(28,8)') END) AS C90,
		(CASE WHEN X.Data.query('C91').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C91').value('.', 'DECIMAL(28,8)') END) AS C91,
		(CASE WHEN X.Data.query('C92').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C92').value('.', 'DECIMAL(28,8)') END) AS C92,
		(CASE WHEN X.Data.query('C93').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C93').value('.', 'DECIMAL(28,8)') END) AS C93,
		(CASE WHEN X.Data.query('C94').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C94').value('.', 'DECIMAL(28,8)') END) AS C94,
		(CASE WHEN X.Data.query('C95').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C95').value('.', 'DECIMAL(28,8)') END) AS C95,
		(CASE WHEN X.Data.query('C96').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C96').value('.', 'DECIMAL(28,8)') END) AS C96,
		(CASE WHEN X.Data.query('C97').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C97').value('.', 'DECIMAL(28,8)') END) AS C97,
		(CASE WHEN X.Data.query('C98').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C98').value('.', 'DECIMAL(28,8)') END) AS C98,
		(CASE WHEN X.Data.query('C99').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C99').value('.', 'DECIMAL(28,8)') END) AS C99,
		(CASE WHEN X.Data.query('C100').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C100').value('.', 'DECIMAL(28,8)') END) AS C100,
		(CASE WHEN X.Data.query('C101').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C101').value('.', 'DECIMAL(28,8)') END) AS C101,
		(CASE WHEN X.Data.query('C102').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C102').value('.', 'DECIMAL(28,8)') END) AS C102,
		(CASE WHEN X.Data.query('C103').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C103').value('.', 'DECIMAL(28,8)') END) AS C103,
		(CASE WHEN X.Data.query('C104').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C104').value('.', 'DECIMAL(28,8)') END) AS C104,
		(CASE WHEN X.Data.query('C105').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C105').value('.', 'DECIMAL(28,8)') END) AS C105,
		(CASE WHEN X.Data.query('C106').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C106').value('.', 'DECIMAL(28,8)') END) AS C106,
		(CASE WHEN X.Data.query('C107').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C107').value('.', 'DECIMAL(28,8)') END) AS C107,
		(CASE WHEN X.Data.query('C108').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C108').value('.', 'DECIMAL(28,8)') END) AS C108,
		(CASE WHEN X.Data.query('C109').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C109').value('.', 'DECIMAL(28,8)') END) AS C109,
		(CASE WHEN X.Data.query('C110').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C110').value('.', 'DECIMAL(28,8)') END) AS C110,
		(CASE WHEN X.Data.query('C111').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C111').value('.', 'DECIMAL(28,8)') END) AS C111,
		(CASE WHEN X.Data.query('C112').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C112').value('.', 'DECIMAL(28,8)') END) AS C112,
		(CASE WHEN X.Data.query('C113').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C113').value('.', 'DECIMAL(28,8)') END) AS C113,
		(CASE WHEN X.Data.query('C114').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C114').value('.', 'DECIMAL(28,8)') END) AS C114,
		(CASE WHEN X.Data.query('C115').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C115').value('.', 'DECIMAL(28,8)') END) AS C115,
		(CASE WHEN X.Data.query('C116').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C116').value('.', 'DECIMAL(28,8)') END) AS C116,
		(CASE WHEN X.Data.query('C117').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C117').value('.', 'DECIMAL(28,8)') END) AS C117,
		(CASE WHEN X.Data.query('C118').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C118').value('.', 'DECIMAL(28,8)') END) AS C118,
		(CASE WHEN X.Data.query('C119').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C119').value('.', 'DECIMAL(28,8)') END) AS C119,
		(CASE WHEN X.Data.query('C120').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C120').value('.', 'DECIMAL(28,8)') END) AS C120,
		(CASE WHEN X.Data.query('C121').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C121').value('.', 'DECIMAL(28,8)') END) AS C121,
		(CASE WHEN X.Data.query('C122').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C122').value('.', 'DECIMAL(28,8)') END) AS C122,
		(CASE WHEN X.Data.query('C123').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C123').value('.', 'DECIMAL(28,8)') END) AS C123,
		(CASE WHEN X.Data.query('C124').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C124').value('.', 'DECIMAL(28,8)') END) AS C124,
		(CASE WHEN X.Data.query('C125').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C125').value('.', 'DECIMAL(28,8)') END) AS C125,
		(CASE WHEN X.Data.query('C126').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C126').value('.', 'DECIMAL(28,8)') END) AS C126,
		(CASE WHEN X.Data.query('C127').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C127').value('.', 'DECIMAL(28,8)') END) AS C127,
		(CASE WHEN X.Data.query('C128').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C128').value('.', 'DECIMAL(28,8)') END) AS C128,
		(CASE WHEN X.Data.query('C129').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C129').value('.', 'DECIMAL(28,8)') END) AS C129,
		(CASE WHEN X.Data.query('C130').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C130').value('.', 'DECIMAL(28,8)') END) AS C130,
		(CASE WHEN X.Data.query('C131').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C131').value('.', 'DECIMAL(28,8)') END) AS C131,
		(CASE WHEN X.Data.query('C132').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C132').value('.', 'DECIMAL(28,8)') END) AS C132,
		(CASE WHEN X.Data.query('C133').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C133').value('.', 'DECIMAL(28,8)') END) AS C133,
		(CASE WHEN X.Data.query('C134').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C134').value('.', 'DECIMAL(28,8)') END) AS C134,
		(CASE WHEN X.Data.query('C135').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C135').value('.', 'DECIMAL(28,8)') END) AS C135,
		(CASE WHEN X.Data.query('C136').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C136').value('.', 'DECIMAL(28,8)') END) AS C136,
		(CASE WHEN X.Data.query('C137').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C137').value('.', 'DECIMAL(28,8)') END) AS C137,
		(CASE WHEN X.Data.query('C138').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C138').value('.', 'DECIMAL(28,8)') END) AS C138,
		(CASE WHEN X.Data.query('C139').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C139').value('.', 'DECIMAL(28,8)') END) AS C139,
		(CASE WHEN X.Data.query('C140').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C140').value('.', 'DECIMAL(28,8)') END) AS C140,
		(CASE WHEN X.Data.query('C141').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C141').value('.', 'DECIMAL(28,8)') END) AS C141,
		(CASE WHEN X.Data.query('C142').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C142').value('.', 'DECIMAL(28,8)') END) AS C142,
		(CASE WHEN X.Data.query('C143').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C143').value('.', 'DECIMAL(28,8)') END) AS C143,
		(CASE WHEN X.Data.query('C144').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C144').value('.', 'DECIMAL(28,8)') END) AS C144,
		(CASE WHEN X.Data.query('C145').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C145').value('.', 'DECIMAL(28,8)') END) AS C145,
		(CASE WHEN X.Data.query('C146').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C146').value('.', 'DECIMAL(28,8)') END) AS C146,
		(CASE WHEN X.Data.query('C147').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C147').value('.', 'DECIMAL(28,8)') END) AS C147,
		(CASE WHEN X.Data.query('C148').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C148').value('.', 'DECIMAL(28,8)') END) AS C148,
		(CASE WHEN X.Data.query('C149').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C149').value('.', 'DECIMAL(28,8)') END) AS C149,
		(CASE WHEN X.Data.query('C150').value('.', 'VARCHAR(50)') = '' THEN NULL ELSE X.Data.query('C150').value('.', 'DECIMAL(28,8)') END) AS C150,		
		IDENTITY(int, 1, 1) AS OrderNo,
		(CASE WHEN X.Data.query('Notes01').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Notes01').value('.', 'NVARCHAR(50)') END) AS Notes01,
		(CASE WHEN X.Data.query('Notes02').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Notes02').value('.', 'NVARCHAR(50)') END) AS Notes02,
		(CASE WHEN X.Data.query('Notes03').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Notes03').value('.', 'NVARCHAR(50)') END) AS Notes03,
		(CASE WHEN X.Data.query('Notes04').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Notes04').value('.', 'NVARCHAR(50)') END) AS Notes04,
		(CASE WHEN X.Data.query('Notes05').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Notes05').value('.', 'NVARCHAR(50)') END) AS Notes05,
		(CASE WHEN X.Data.query('Notes06').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Notes06').value('.', 'NVARCHAR(50)') END) AS Notes06,
		(CASE WHEN X.Data.query('Notes07').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Notes07').value('.', 'NVARCHAR(50)') END) AS Notes07,
		(CASE WHEN X.Data.query('Notes08').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Notes08').value('.', 'NVARCHAR(50)') END) AS Notes08,
		(CASE WHEN X.Data.query('Notes09').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Notes09').value('.', 'NVARCHAR(50)') END) AS Notes09,
		(CASE WHEN X.Data.query('Notes10').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Notes10').value('.', 'NVARCHAR(50)') END) AS Notes10,
		(CASE WHEN X.Data.query('Notes11').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Notes11').value('.', 'NVARCHAR(50)') END) AS Notes11,
		(CASE WHEN X.Data.query('Notes12').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Notes12').value('.', 'NVARCHAR(50)') END) AS Notes12,
		(CASE WHEN X.Data.query('Notes13').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Notes13').value('.', 'NVARCHAR(50)') END) AS Notes13,
		(CASE WHEN X.Data.query('Notes14').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Notes14').value('.', 'NVARCHAR(50)') END) AS Notes14,
		(CASE WHEN X.Data.query('Notes15').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Notes15').value('.', 'NVARCHAR(50)') END) AS Notes15,
		(CASE WHEN X.Data.query('Notes16').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Notes16').value('.', 'NVARCHAR(50)') END) AS Notes16,
		(CASE WHEN X.Data.query('Notes17').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Notes17').value('.', 'NVARCHAR(50)') END) AS Notes17,
		(CASE WHEN X.Data.query('Notes18').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Notes18').value('.', 'NVARCHAR(50)') END) AS Notes18,
		(CASE WHEN X.Data.query('Notes19').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Notes19').value('.', 'NVARCHAR(50)') END) AS Notes19,
		(CASE WHEN X.Data.query('Notes20').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Notes20').value('.', 'NVARCHAR(50)') END) AS Notes20,
		(CASE WHEN X.Data.query('Notes21').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Notes21').value('.', 'NVARCHAR(50)') END) AS Notes21,
		(CASE WHEN X.Data.query('Notes22').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Notes22').value('.', 'NVARCHAR(50)') END) AS Notes22,
		(CASE WHEN X.Data.query('Notes23').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Notes23').value('.', 'NVARCHAR(50)') END) AS Notes23,
		(CASE WHEN X.Data.query('Notes24').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Notes24').value('.', 'NVARCHAR(50)') END) AS Notes24,
		(CASE WHEN X.Data.query('Notes25').value('.', 'NVARCHAR(50)') = '' THEN NULL ELSE X.Data.query('Notes25').value('.', 'NVARCHAR(50)') END) AS Notes25
INTO	#AP8131		
FROM	@XML.nodes('//Data') AS X (Data)

INSERT INTO #Data (		
		Row,
		DivisionID,		
		Period,
		DepartmentID,
		TeamID,
		EmployeeID,
		TaxObjectID,
		BaseSalary,
		InsuranceSalary,
		Salary01,
		Salary02,
		Salary03,
		SalaryCoefficient,
		DutyCoefficient,
		TimeCoefficient,
		C01,
		C02,
		C03,
		C04,
		C05,
		C06,
		C07,
		C08,
		C09,
		C10,
		C11,
		C12,
		C13,
		C14,
		C15,
		C16,
		C17,
		C18,
		C19,
		C20,
		C21,
		C22,
		C23,
		C24,
		C25,
		IsJobWage,
		IsPiecework,
		C26,
		C27,
		C28,
		C29,
		C30,
		C31,
		C32,
		C33,
		C34,
		C35,
		C36,
		C37,
		C38,
		C39,
		C40,
		C41,
		C42,
		C43,
		C44,
		C45,
		C46,
		C47,
		C48,
		C49,
		C50,
		C51,
		C52,
		C53,
		C54,
		C55,
		C56,
		C57,
		C58,
		C59,
		C60,
		C61,
		C62,
		C63,
		C64,
		C65,
		C66,
		C67,
		C68,
		C69,
		C70,
		C71,
		C72,
		C73,
		C74,
		C75,
		C76,
		C77,
		C78,
		C79,
		C80,
		C81,
		C82,
		C83,
		C84,
		C85,
		C86,
		C87,
		C88,
		C89,
		C90,
		C91,
		C92,
		C93,
		C94,
		C95,
		C96,
		C97,
		C98,
		C99,
		C100,
		C101,
		C102,
		C103,
		C104,
		C105,
		C106,
		C107,
		C108,
		C109,
		C110,
		C111,
		C112,
		C113,
		C114,
		C115,
		C116,
		C117,
		C118,
		C119,
		C120,
		C121,
		C122,
		C123,
		C124,
		C125,
		C126,
		C127,
		C128,
		C129,
		C130,
		C131,
		C132,
		C133,
		C134,
		C135,
		C136,
		C137,
		C138,
		C139,
		C140,
		C141,
		C142,
		C143,
		C144,
		C145,
		C146,
		C147,
		C148,
		C149,
		C150,
		Orders,
		Notes01,
		Notes02,
		Notes03,
		Notes04,
		Notes05,
		Notes06,
		Notes07,
		Notes08,
		Notes09,
		Notes10,
		Notes11,
		Notes12,
		Notes13,
		Notes14,
		Notes15,
		Notes16,
		Notes17,
		Notes18,
		Notes19,
		Notes20,
		Notes21,
		Notes22,
		Notes23,
		Notes24,
		Notes25
		)
SELECT *
FROM #AP8131
ht2400
--SELECT * FROM #AP8131
--SELECT * FROM #Data
---- Kiểm tra check code mặc định
EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID

---- Kiểm tra dữ liệu không đồng nhất tại phần master
---EXEC AP8100 @UserID = @UserID, @ImportTemplateID = @ImportTemplateID, @CheckCode = 'CheckIdenticalValues', @Module = 'ASOFT-WM', @ColID = 'VoucherNo', @Param1 = 'VoucherNo,VoucherDate,RefNo01,RefNo02,ObjectID,WareHouseID,InventoryTypeID,EmployeeID,Description'

--- Xử lý làm tròn dữ liệu vì nhập trên Excel có thể sai
UPDATE		DT
SET			BaseSalary = ROUND(DT.BaseSalary,A.OriginalDecimals ),
			InsuranceSalary = ROUND(DT.InsuranceSalary,A.OriginalDecimals),	
			Salary01 = ROUND(DT.Salary01,A.CoefficientDecimals),
			Salary02 = ROUND(DT.Salary02,A.CoefficientDecimals),
			Salary03 = ROUND(DT.Salary03,A.CoefficientDecimals),
			SalaryCoefficient = ROUND(DT.SalaryCoefficient,A.CoefficientDecimals),
			DutyCoefficient = ROUND(DT.DutyCoefficient,A.CoefficientDecimals),
			TimeCoefficient = ROUND(DT.TimeCoefficient,A.CoefficientDecimals),
			C01 = ROUND(DT.C01,A.CoefficientDecimals),
			C02 = ROUND(DT.C02,A.CoefficientDecimals),
			C03 = ROUND(DT.C03,A.CoefficientDecimals),
			C04 = ROUND(DT.C04,A.CoefficientDecimals),
			C05 = ROUND(DT.C05,A.CoefficientDecimals),
			C06 = ROUND(DT.C06,A.CoefficientDecimals),
			C07 = ROUND(DT.C07,A.CoefficientDecimals),
			C08 = ROUND(DT.C08,A.CoefficientDecimals),
			C09 = ROUND(DT.C09,A.CoefficientDecimals),
			C10 = ROUND(DT.C10,A.CoefficientDecimals),
			C11 = ROUND(DT.C11,A.CoefficientDecimals),
			C12 = ROUND(DT.C12,A.CoefficientDecimals),
			C13 = ROUND(DT.C13,A.CoefficientDecimals),
			C14 = ROUND(DT.C14,A.CoefficientDecimals),
			C15 = ROUND(DT.C15,A.CoefficientDecimals),
			C16 = ROUND(DT.C16,A.CoefficientDecimals),
			C17 = ROUND(DT.C17,A.CoefficientDecimals),
			C18 = ROUND(DT.C18,A.CoefficientDecimals),
			C19 = ROUND(DT.C19,A.CoefficientDecimals),
			C20 = ROUND(DT.C20,A.CoefficientDecimals),
			C21 = ROUND(DT.C21,A.CoefficientDecimals),
			C22 = ROUND(DT.C22,A.CoefficientDecimals),
			C23 = ROUND(DT.C23,A.CoefficientDecimals),
			C24 = ROUND(DT.C24,A.CoefficientDecimals),
			C25 = ROUND(DT.C25,A.CoefficientDecimals),
			C26 = ROUND(DT.C26,A.CoefficientDecimals),
			C27 = ROUND(DT.C27,A.CoefficientDecimals),
			C28 = ROUND(DT.C28,A.CoefficientDecimals),
			C29 = ROUND(DT.C29,A.CoefficientDecimals),
			C30 = ROUND(DT.C30,A.CoefficientDecimals),
			C31 = ROUND(DT.C31,A.CoefficientDecimals),
			C32 = ROUND(DT.C32,A.CoefficientDecimals),
			C33 = ROUND(DT.C33,A.CoefficientDecimals),
			C34 = ROUND(DT.C34,A.CoefficientDecimals),
			C35 = ROUND(DT.C35,A.CoefficientDecimals),
			C36 = ROUND(DT.C36,A.CoefficientDecimals),
			C37 = ROUND(DT.C37,A.CoefficientDecimals),
			C38 = ROUND(DT.C38,A.CoefficientDecimals),
			C39 = ROUND(DT.C39,A.CoefficientDecimals),
			C40 = ROUND(DT.C40,A.CoefficientDecimals),
			C41 = ROUND(DT.C41,A.CoefficientDecimals),
			C42 = ROUND(DT.C42,A.CoefficientDecimals),
			C43 = ROUND(DT.C43,A.CoefficientDecimals),
			C44 = ROUND(DT.C44,A.CoefficientDecimals),
			C45 = ROUND(DT.C45,A.CoefficientDecimals),
			C46 = ROUND(DT.C46,A.CoefficientDecimals),
			C47 = ROUND(DT.C47,A.CoefficientDecimals),
			C48 = ROUND(DT.C48,A.CoefficientDecimals),
			C49 = ROUND(DT.C49,A.CoefficientDecimals),
			C50 = ROUND(DT.C50,A.CoefficientDecimals),
			C51 = ROUND(DT.C51,A.CoefficientDecimals),
			C52 = ROUND(DT.C52,A.CoefficientDecimals),
			C53 = ROUND(DT.C53,A.CoefficientDecimals),
			C54 = ROUND(DT.C54,A.CoefficientDecimals),
			C55 = ROUND(DT.C55,A.CoefficientDecimals),
			C56 = ROUND(DT.C56,A.CoefficientDecimals),
			C57 = ROUND(DT.C57,A.CoefficientDecimals),
			C58 = ROUND(DT.C58,A.CoefficientDecimals),
			C59 = ROUND(DT.C59,A.CoefficientDecimals),
			C60 = ROUND(DT.C60,A.CoefficientDecimals),
			C61 = ROUND(DT.C61,A.CoefficientDecimals),
			C62 = ROUND(DT.C62,A.CoefficientDecimals),
			C63 = ROUND(DT.C63,A.CoefficientDecimals),
			C64 = ROUND(DT.C64,A.CoefficientDecimals),
			C65 = ROUND(DT.C65,A.CoefficientDecimals),
			C66 = ROUND(DT.C66,A.CoefficientDecimals),
			C67 = ROUND(DT.C67,A.CoefficientDecimals),
			C68 = ROUND(DT.C68,A.CoefficientDecimals),
			C69 = ROUND(DT.C69,A.CoefficientDecimals),
			C70 = ROUND(DT.C70,A.CoefficientDecimals),
			C71 = ROUND(DT.C71,A.CoefficientDecimals),
			C72 = ROUND(DT.C72,A.CoefficientDecimals),
			C73 = ROUND(DT.C73,A.CoefficientDecimals),
			C74 = ROUND(DT.C74,A.CoefficientDecimals),
			C75 = ROUND(DT.C75,A.CoefficientDecimals),
			C76 = ROUND(DT.C76,A.CoefficientDecimals),
			C77 = ROUND(DT.C77,A.CoefficientDecimals),
			C78 = ROUND(DT.C78,A.CoefficientDecimals),
			C79 = ROUND(DT.C79,A.CoefficientDecimals),
			C80 = ROUND(DT.C80,A.CoefficientDecimals),
			C81 = ROUND(DT.C81,A.CoefficientDecimals),
			C82 = ROUND(DT.C82,A.CoefficientDecimals),
			C83 = ROUND(DT.C83,A.CoefficientDecimals),
			C84 = ROUND(DT.C84,A.CoefficientDecimals),
			C85 = ROUND(DT.C85,A.CoefficientDecimals),
			C86 = ROUND(DT.C86,A.CoefficientDecimals),
			C87 = ROUND(DT.C87,A.CoefficientDecimals),
			C88 = ROUND(DT.C88,A.CoefficientDecimals),
			C89 = ROUND(DT.C89,A.CoefficientDecimals),
			C90 = ROUND(DT.C90,A.CoefficientDecimals),
			C91 = ROUND(DT.C91,A.CoefficientDecimals),
			C92 = ROUND(DT.C92,A.CoefficientDecimals),
			C93 = ROUND(DT.C93,A.CoefficientDecimals),
			C94 = ROUND(DT.C94,A.CoefficientDecimals),
			C95 = ROUND(DT.C95,A.CoefficientDecimals),
			C96 = ROUND(DT.C96,A.CoefficientDecimals),
			C97 = ROUND(DT.C97,A.CoefficientDecimals),
			C98 = ROUND(DT.C98,A.CoefficientDecimals),
			C99 = ROUND(DT.C99,A.CoefficientDecimals),
			C100 = ROUND(DT.C100,A.CoefficientDecimals),
			C101 = ROUND(DT.C101,A.CoefficientDecimals),
			C102 = ROUND(DT.C102,A.CoefficientDecimals),
			C103 = ROUND(DT.C103,A.CoefficientDecimals),
			C104 = ROUND(DT.C104,A.CoefficientDecimals),
			C105 = ROUND(DT.C105,A.CoefficientDecimals),
			C106 = ROUND(DT.C106,A.CoefficientDecimals),
			C107 = ROUND(DT.C107,A.CoefficientDecimals),
			C108 = ROUND(DT.C108,A.CoefficientDecimals),
			C109 = ROUND(DT.C109,A.CoefficientDecimals),
			C110 = ROUND(DT.C110,A.CoefficientDecimals),
			C111 = ROUND(DT.C111,A.CoefficientDecimals),
			C112 = ROUND(DT.C112,A.CoefficientDecimals),
			C113 = ROUND(DT.C113,A.CoefficientDecimals),
			C114 = ROUND(DT.C114,A.CoefficientDecimals),
			C115 = ROUND(DT.C115,A.CoefficientDecimals),
			C116 = ROUND(DT.C116,A.CoefficientDecimals),
			C117 = ROUND(DT.C117,A.CoefficientDecimals),
			C118 = ROUND(DT.C118,A.CoefficientDecimals),
			C119 = ROUND(DT.C119,A.CoefficientDecimals),
			C120 = ROUND(DT.C120,A.CoefficientDecimals),
			C121 = ROUND(DT.C121,A.CoefficientDecimals),
			C122 = ROUND(DT.C122,A.CoefficientDecimals),
			C123 = ROUND(DT.C123,A.CoefficientDecimals),
			C124 = ROUND(DT.C124,A.CoefficientDecimals),
			C125 = ROUND(DT.C125,A.CoefficientDecimals),
			C126 = ROUND(DT.C126,A.CoefficientDecimals),
			C127 = ROUND(DT.C127,A.CoefficientDecimals),
			C128 = ROUND(DT.C128,A.CoefficientDecimals),
			C129 = ROUND(DT.C129,A.CoefficientDecimals),
			C130 = ROUND(DT.C130,A.CoefficientDecimals),
			C131 = ROUND(DT.C131,A.CoefficientDecimals),
			C132 = ROUND(DT.C132,A.CoefficientDecimals),
			C133 = ROUND(DT.C133,A.CoefficientDecimals),
			C134 = ROUND(DT.C134,A.CoefficientDecimals),
			C135 = ROUND(DT.C135,A.CoefficientDecimals),
			C136 = ROUND(DT.C136,A.CoefficientDecimals),
			C137 = ROUND(DT.C137,A.CoefficientDecimals),
			C138 = ROUND(DT.C138,A.CoefficientDecimals),
			C139 = ROUND(DT.C139,A.CoefficientDecimals),
			C140 = ROUND(DT.C140,A.CoefficientDecimals),
			C141 = ROUND(DT.C141,A.CoefficientDecimals),
			C142 = ROUND(DT.C142,A.CoefficientDecimals),
			C143 = ROUND(DT.C143,A.CoefficientDecimals),
			C144 = ROUND(DT.C144,A.CoefficientDecimals),
			C145 = ROUND(DT.C145,A.CoefficientDecimals),
			C146 = ROUND(DT.C146,A.CoefficientDecimals),
			C147 = ROUND(DT.C147,A.CoefficientDecimals),
			C148 = ROUND(DT.C148,A.CoefficientDecimals),
			C149 = ROUND(DT.C149,A.CoefficientDecimals),
			C150 = ROUND(DT.C150,A.CoefficientDecimals)
FROM		#Data DT
LEFT JOIN	HT0000 A ON A.DivisionID = DT.DivisionID			

--- Xử lý lại TeamID: Nếu không nhập thì lấy giá trị theo HS nhân viên
UPDATE #Data
SET		#Data.TeamID = HT1400.TeamID
FROM	#Data
INNER JOIN HT1400 ON #Data.EmployeeID = HT1400.EmployeeID
WHERE Isnull(#Data.TeamID,'') = ''

-- Nếu có lỗi thì không cần sinh khóa và không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT

-- Sinh khóa
DECLARE @cKey AS CURSOR
DECLARE @Row AS INT,
		@Orders AS INT,
		@Period AS NVARCHAR(50),
		@EmpFileID AS NVARCHAR(50),
		@TranMonth Int,
		@TranYear Int,
		@EmployeeID NVARCHAR(50),
		@sSQL1 NVARCHAR(4000),
		@sSQL2 NVARCHAR(4000)

DECLARE	@sSQL001 Nvarchar(4000) = '',
		@TableHT2400 Varchar(50) = '',		
		@sTranMonth Varchar(2)

SET @TranMonth = (SELECT TOP 1 LEFT(LTRIM(RTRIM(Period)), 2) FROM #Data)
SET @TranYear = (SELECT TOP 1 RIGHT(LTRIM(RTRIM(Period)), 4) FROM #Data)

SELECT @sTranMonth = CASE WHEN @TranMonth >9 THEN Convert(Varchar(2),@TranMonth) ELSE '0'+Convert(Varchar(1),@TranMonth) END

IF EXISTS (SELECT TOP 1 1 FROM AT0001 WHERE IsSplitTable = 1)	
BEGIN
	SET  @TableHT2400 = 'HT2400M'+@sTranMonth+Convert(Varchar(4),@TranYear)
END
ELSE
BEGIN
	SET  @TableHT2400 = 'HT2400'
END

--SET @Orders = 0

SET @cKey = CURSOR FOR
	SELECT	Row, Period, EmployeeID, Orders
	FROM	#Data
		
OPEN @cKey
FETCH NEXT FROM @cKey INTO @Row, @Period, @EmployeeID, @Orders
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @sSQL001 = '
	DECLARE @EmpFileID Varchar(50) = ''''
	-- Bổ sung điều kiện, nếu hồ sơ nhân viên đã có trong kỳ thì lấy HT2400.EmpFileID
	IF EXISTS (SELECT TOP 1 1
			   FROM '+@TableHT2400+'
			   WHERE DivisionID = '''+@DivisionID+''' AND TranMonth = '+STR(@TranMonth)+'
                     AND TranYear = '+STR(@TranYear)+' AND EmployeeID = '''+@EmployeeID+''')
	BEGIN
		SET @EmpFileID = (SELECT TOP 1 EmpFileID  
						  FROM '+@TableHT2400+'
			              WHERE DivisionID = '''+@DivisionID+''' AND TranMonth = '+STR(@TranMonth)+'
                                AND TranYear = '+STR(@TranYear)+' AND EmployeeID = '''+@EmployeeID+''')		
	END
	ELSE
	BEGIN
		EXEC AP0002 @DivisionID = '''+@DivisionID+''', @NewKey = @EmpFileID OUTPUT, @TableName = ''HT2400'', @StringKey1 = ''HS'', @StringKey2 = '+STR(@TranMonth)+', @StringKey3 = '+STR(@TranYear)+', @OutputLen = 25		
	END
	INSERT INTO #Keys (Row, Orders, EmpFileID) VALUES ('+STR(@Row)+', '+STR(@Orders)+', @EmpFileID)	
	
	'		
	 --print @sSQL001
	exec (@sSQL001)
	FETCH NEXT FROM @cKey INTO @Row, @Period, @EmployeeID, @Orders
END	
CLOSE @cKey

-- Cập nhật khóa
UPDATE		DT
SET			Orders = K.Orders,
			DT.EmpFileID = K.EmpFileID			
FROM		#Data DT
INNER JOIN	#Keys K
		ON	K.Row = DT.Row

--drop constraint 
SET @SQL = 'IF EXISTS (SELECT TOP 1 1 FROM tempdb.sys.sysobjects WHERE [name] = ''#Keys'' AND xtype = ''U'')
			BEGIN
				IF EXISTS (SELECT TOP 1 1 FROM tempdb.sys.sysobjects WHERE [name] = '''+@Keys_PK+''' AND xtype = ''PK'')
					ALTER TABLE #Keys DROP CONSTRAINT ' + @Keys_PK +'
			END
			IF EXISTS (SELECT TOP 1 1 FROM tempdb.sys.sysobjects WHERE [name] = ''#Data'' AND xtype = ''U'')
			BEGIN
				IF EXISTS (SELECT TOP 1 1 FROM tempdb.sys.sysobjects WHERE [name] = '''+@Data_PK+''' AND xtype = ''PK'')
					ALTER TABLE #Keys DROP CONSTRAINT ' + @Data_PK +'
			END
			'
EXEC(@SQL)

-- Nếu có lỗi thì không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT


DECLARE @Cur CURSOR,
		@FieldName Varchar(50),
		@CustomerName INT 

SET @CustomerName = (SELECT TOP 1 CustomerName FROM CustomerIndex)

-- Neu da ton tai thi update
BEGIN
	SET @sSQL001 = '
	UPDATE HT24 
	SET EmployeeID = DT.EmployeeID,
		DepartmentID = CASE WHEN ISNULL(DT.DepartmentID,'''') = '''' THEN HT24.DepartmentID ELSE DT.DepartmentID END,
		TeamID = CASE WHEN ISNULL(DT.TeamID,'''') = '''' THEN HT24.TeamID ELSE DT.TeamID END,
		TaxObjectID = CASE WHEN ISNULL(DT.TaxObjectID,'''') = '''' THEN HT24.TaxObjectID ELSE DT.TaxObjectID END,
		Orders = DT.Orders,
		SalaryCoefficient = CASE WHEN DT.SalaryCoefficient IS NULL THEN HT24.SalaryCoefficient 
							     WHEN DT.SalaryCoefficient = 0     THEN 0 ELSE DT.SalaryCoefficient END,
		TimeCoefficient = CASE WHEN ISNULL(DT.TimeCoefficient,0) = 0 THEN HT24.TimeCoefficient 
							     WHEN DT.TimeCoefficient = 0       THEN 0 ELSE DT.TimeCoefficient END,
		DutyCoefficient = CASE WHEN DT.DutyCoefficient IS NULL THEN HT24.DutyCoefficient 
								 WHEN DT.DutyCoefficient = 0       THEN 0 ELSE DT.DutyCoefficient END,
		Salary01 = CASE WHEN DT.Salary01 IS NULL THEN HT24.Salary01 
								 WHEN DT.Salary01 = 0 THEN 0 ELSE DT.Salary01 END,
		Salary02 = CASE WHEN DT.Salary02 IS NULL THEN HT24.Salary02 
								 WHEN DT.Salary02 = 0 THEN 0 ELSE DT.Salary02 END,
		Salary03 = CASE WHEN DT.Salary03 IS NULL THEN HT24.Salary03 
								 WHEN DT.Salary03 = 0 THEN 0 ELSE DT.Salary03 END,
		BaseSalary = CASE WHEN DT.BaseSalary IS NULL THEN HT24.BaseSalary 
								 WHEN DT.BaseSalary = 0 THEN 0 ELSE DT.BaseSalary END,
		InsuranceSalary = CASE WHEN ISNULL(DT.InsuranceSalary,0) = 0 THEN HT24.InsuranceSalary ELSE DT.InsuranceSalary END,
		LastModifyDate = GETDATE(),
		LastmodifyUserID = '''+@UserID+''',
		Notes01 = ISNULL(DT.Notes01,''''),
		Notes02 = ISNULL(DT.Notes02,''''),
		Notes03 = ISNULL(DT.Notes03,''''),
		Notes04 = ISNULL(DT.Notes04,''''),
		Notes05 = ISNULL(DT.Notes05,''''),
		Notes06 = ISNULL(DT.Notes06,''''),
		Notes07 = ISNULL(DT.Notes07,''''),
		Notes08 = ISNULL(DT.Notes08,''''),
		Notes09 = ISNULL(DT.Notes09,''''),
		Notes10 = ISNULL(DT.Notes10,''''),
		Notes11 = ISNULL(DT.Notes11,''''),
		Notes12 = ISNULL(DT.Notes12,''''),
		Notes13 = ISNULL(DT.Notes13,''''),
		Notes14 = ISNULL(DT.Notes14,''''),
		Notes15 = ISNULL(DT.Notes15,''''),
		Notes16 = ISNULL(DT.Notes16,''''),
		Notes17 = ISNULL(DT.Notes17,''''),
		Notes18 = ISNULL(DT.Notes18,''''),
		Notes19 = ISNULL(DT.Notes19,''''),
		Notes20 = ISNULL(DT.Notes20,''''),
		Notes21 = ISNULL(DT.Notes21,''''),
		Notes22 = ISNULL(DT.Notes22,''''),
		Notes23 = ISNULL(DT.Notes23,''''),
		Notes24 = ISNULL(DT.Notes24,''''),
		Notes25 = ISNULL(DT.Notes25,'''')
	FROM '+@TableHT2400+' HT24 
	INNER JOIN #Data DT ON HT24.DivisionID = DT.DivisionID AND HT24.EmpFileID = DT.EmpFileID
	WHERE EXISTS (SELECT TOP 1 1 FROM #Data WHERE HT24.EmpFileID = #Data.EmpFileID)
	'
	exec(@sSQL001)

	SET @Cur = CURSOR SCROLL KEYSET FOR
	SELECT	FieldName
	FROM	HT0003
	WHERE	DivisionID = @DivisionID AND IsUsed = 1 
			AND CONVERT(Int,stuff(CoefficientID,1,1,'')) <= 25
	ORDER BY CONVERT(Int,stuff(CoefficientID,1,1,''))
	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @FieldName
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
			SET @sSQL1 = N'
			UPDATE HT24 
			SET '+@FieldName+' = 
			CASE WHEN DT.'+@FieldName+' IS NULL THEN HT24.'+@FieldName+' 
				 WHEN  DT.'+@FieldName+' = 0	THEN 0 ELSE DT.'+@FieldName+' END

			FROM '+@TableHT2400+' HT24 
			INNER JOIN #Data DT ON HT24.DivisionID = DT.DivisionID AND HT24.EmpFileID = DT.EmpFileID
			WHERE EXISTS (SELECT TOP 1 1 FROM #Data WHERE HT24.EmpFileID = #Data.EmpFileID)
			'
			--print @sSQL1
			EXEC (@sSQL1)
	FETCH NEXT FROM @Cur INTO @FieldName
	END
	CLOSE @Cur		
			
	SET @Cur = CURSOR SCROLL KEYSET FOR
	SELECT	FieldName
	FROM	HT0003
	WHERE	DivisionID = @DivisionID AND IsUsed = 1 
			AND CONVERT(Int,stuff(CoefficientID,1,1,'')) > 25
	ORDER BY CONVERT(Int,stuff(CoefficientID,1,1,''))
	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @FieldName
	WHILE @@FETCH_STATUS = 0
	BEGIN
		
			SET @sSQL2 = N'
			UPDATE HT24 
			SET '+@FieldName+' = CASE WHEN ISNULL(DT.'+@FieldName+',0) = 0 THEN HT24.'+@FieldName+' ELSE DT.'+@FieldName+' END
			FROM HT2499 HT24 
			INNER JOIN #Data DT ON HT24.DivisionID = DT.DivisionID AND HT24.EmpFileID = DT.EmpFileID
			WHERE EXISTS (SELECT TOP 1 1 FROM #Data WHERE HT24.EmpFileID = #Data.EmpFileID)
			'
			--print @sSQL2
			EXEC (@sSQL2)
	FETCH NEXT FROM @Cur INTO @FieldName
	END
	CLOSE @Cur	
END

-- set @sSQL1 = ''
--- Neu chua ton tai thi Insert
UPDATE HT0003
SET	@FieldName1 = @FieldName1 + CASE WHEN IsUsed = 1 THEN ', ' + FieldName ELSE '' END
FROM HT0003
WHERE	DivisionID = @DivisionID AND IsUsed = 1 
			AND CONVERT(Int,stuff(CoefficientID,1,1,'')) <= 25

UPDATE HT0003
SET	@FieldName2 = @FieldName2 + CASE WHEN IsUsed = 1 THEN ', ' + FieldName ELSE '' END
FROM HT0003
WHERE	DivisionID = @DivisionID AND IsUsed = 1 
			AND CONVERT(Int,stuff(CoefficientID,1,1,'')) > 25

-- select * from HT0003
--select @FieldName1, @FieldName2

set @sSQL1 = N'
INSERT INTO '+@TableHT2400+' (DivisionID, EmpFileID, EmployeeID, DepartmentID, TranMonth, TranYear, TeamID, TaxObjectID,
			Orders, SalaryCoefficient, TimeCoefficient, DutyCoefficient, Salary01, Salary02, Salary03, 
			BaseSalary, InsuranceSalary, IsJobWage, IsPiecework, 
			EmployeeStatus,	CreateUserID, CreateDate, LastModifyUserID,	LastModifyDate,
			Notes01, Notes02, Notes03, Notes04, Notes05, Notes06, Notes07, Notes08, Notes09, Notes10,
			Notes11, Notes12, Notes13, Notes14, Notes15, Notes16, Notes17, Notes18, Notes19, Notes20,
			Notes21, Notes22, Notes23, Notes24, Notes25
			'+@FieldName1+'
			)
SELECT	DivisionID, EmpFileID, EmployeeID, DepartmentID, LEFT(Period,2), RIGHT(Period,4), TeamID, TaxObjectID,
		Orders, SalaryCoefficient, TimeCoefficient, DutyCoefficient, Salary01, Salary02, Salary03, 
		BaseSalary, InsuranceSalary, IsJobWage, IsPiecework,
		1, '''+@UserID+''', GETDATE(), '''+@UserID+''', GETDATE(),
		Notes01, Notes02, Notes03, Notes04, Notes05, Notes06, Notes07, Notes08, Notes09, Notes10,
		Notes11, Notes12, Notes13, Notes14, Notes15, Notes16, Notes17, Notes18, Notes19, Notes20,
		Notes21, Notes22, Notes23, Notes24, Notes25
		'+@FieldName1+'
FROM	#Data
WHERE NOT EXISTS (SELECT TOP 1 1 FROM '+@TableHT2400+' HT24 WHERE HT24.EmpFileID = #Data.EmpFileID)
'
--print @sSQL1
EXEC (@sSQL1)

set @sSQL2 = N'
INSERT INTO HT2499(DivisionID, EmpFileID, EmployeeID, TranMonth, TranYear,	CreateUserID, CreateDate, LastModifyUserID,	LastModifyDate '+@FieldName2+'
			)
SELECT	DivisionID, EmpFileID, EmployeeID, LEFT(Period,2), RIGHT(Period,4), '''+@UserID+''', GETDATE(), '''+@UserID+''', GETDATE()
		'+@FieldName2+'
FROM	#Data
WHERE NOT EXISTS (SELECT TOP 1 1 FROM HT2499 HT24 WHERE HT24.EmpFileID = #Data.EmpFileID)
'
--print @sSQL2
EXEC (@sSQL2)


LB_RESULT:
SELECT * FROM #Data



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

