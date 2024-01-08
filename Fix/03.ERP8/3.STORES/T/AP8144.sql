IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP8144]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP8144]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Xử lý Import chấm công theo Thang
---- Created on 16/09/2015 Thanh Thinh
---- Modified by Bảo Thy on 04/07/2016: Bỏ kiểm tra hệ số công
---- Modified by Phương Thảo on 19/07/2016:Lấy dữ liệu phòng ban từ hồ sơ lương
---- Modified on 05/03/2019 by Kim Thư: Tạo khóa chính cho table #Data có nối với @@SPID để tránh trùng khóa chính khi nhiều user sử dụng
---- Modified on 01/09/2020 by Huỳnh Thử: Merge Code: MEKIO và MTE: Kiểm Tra hệ số công


CREATE PROCEDURE [DBO].[AP8144]
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@ImportTemplateID AS NVARCHAR(50),
	@XML AS XML
) 
AS

		
DECLARE @TranMonth INT,
		@TranYear INT,
		@CustomerName INT 
select @CustomerName = CustomerName FROM dbo.CustomerIndex
CREATE TABLE #Data
(
	APK UNIQUEIDENTIFIER DEFAULT(NEWID()),
	Row INT NOT NULL,
	Orders INT,
	ImportMessage NVARCHAR(500) DEFAULT ('')--,
	--CONSTRAINT [PK_#Data] PRIMARY KEY CLUSTERED 
	--(
	--	Row ASC
	--) ON [PRIMARY]	
)

-- Tạo khóa chính cho table #Data và #Keys
DECLARE @Data_PK VARCHAR(50),
		@SQL1 NVARCHAR(MAX);
SET @Data_PK='PK_#Data_' + LTRIM(@@SPID);

--add constraint 
SET @SQL1 = 'ALTER TABLE #Data ADD CONSTRAINT ' + @Data_PK+ ' PRIMARY KEY(Row)'					

EXEC(@SQL1)


declare 
@SQL nvarchar(MAX)

 SELECT	 @SQL =	STUFF((		SELECT'ALTER TABLE #Data ADD ' + TLD.ColID + ' ' +  BTL.ColSQLDataType + 
							CASE WHEN BTL.ColSQLDataType LIKE '%char%' 
									THEN ' COLLATE SQL_Latin1_General_CP1_CI_AS' 
									ELSE '' END + ' NULL '
						FROM A01065 TL
						INNER JOIN	A01066 TLD
							ON	TL.ImportTemplateID = TLD.ImportTemplateID
						INNER JOIN	A00065 BTL
							ON	BTL.ImportTransTypeID = TL.ImportTransTypeID AND BTL.ColID = TLD.ColID
						WHERE	TL.ImportTemplateID = @ImportTemplateID		
						FOR XML PATH('')),1,0,'')  
EXEC(@SQL)

INSERT INTO #Data ([Row],DivisionID,Period, PeriodID,EmployeeID,AbsentTypeID,AbsentAmount)
SELECT	X.Data.query('Row').value('.', 'INT') AS Row,
		X.Data.query('DivisionID').value('.', 'NVARCHAR(50)') AS DivisionID,
		X.Data.query('Period').value('.', 'VARCHAR(10)') AS Period,
		X.Data.query('PeriodID').value('.', 'VARCHAR(50)') AS PeriodID,
		X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,		
		X.Data.query('AbsentTypeID').value('.', 'VARCHAR(50)') AS AbsentTypeID,
		X.Data.query('AbsentAmount').value('.', 'DECIMAL(28,3)') AS AbsentAmount	
FROM	@XML.nodes('//Data') AS X (Data)

---- Kiểm tra check code mặc định
EXEC AP8105 @ImportTemplateID = @ImportTemplateID, @UserID = @UserID
		
SET @TranMonth = CAST ((SELECT TOP 1 LEFT(Period, 2) FROM #Data) AS INT)
SET @TranYear = CAST ((SELECT TOP 1 RIGHT(Period, 4) FROM #Data) AS INT)

-- Kiểm Tra Lỗi Nhân viên không lập hò sơ lương
UPDATE		DT
SET			DT.ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + 'ASML000099 {0}=''A'''
FROM		#Data DT
LEFT JOIN HT2400 HT24 
	ON HT24.DivisionID = DT.DivisionID AND HT24.EmployeeID = DT.EmployeeID 
		AND HT24.TranMonth = @TranMonth
		AND HT24.TranYear = @TranYear
WHERE 	HT24.DivisionID IS NULL


IF(@CustomerName = 50 OR @CustomerName = 115 OR @CustomerName = 57) -- Mekio và Mte và Angel
BEGIN
	-- Kiểm Tra hệ số công
	UPDATE		DT
	SET			DT.ImportMessage = ImportMessage + CASE WHEN ImportMessage <> '' THEN '\n' ELSE '' END + 'ASML000100 {0}=''E'''
	FROM		#Data DT
	INNER JOIN HT1013 HT13 
		ON HT13.DivisionID = DT.DivisionID 
			AND HT13.AbsentTypeID = DT.AbsentTypeID 
			AND HT13.ConvertUnit < DT.AbsentAmount

END 
			
-- Nếu có lỗi thì không đẩy dữ liệu vào
IF EXISTS(SELECT TOP 1 1 FROM #Data WHERE ImportMessage <> '')
	GOTO LB_RESULT

--- Xử lý làm tròn dữ liệu vì nhập trên Excel có thể sai
UPDATE		DT
SET			AbsentAmount = ROUND(AbsentAmount, 2)
FROM		#Data DT

--drop constraint 
SET @SQL1 = 'IF EXISTS (SELECT TOP 1 1 FROM tempdb.sys.sysobjects WHERE [name] = ''#Data'' AND xtype = ''U'')
			BEGIN
				IF EXISTS (SELECT TOP 1 1 FROM tempdb.sys.sysobjects WHERE [name] = '''+@Data_PK+''' AND xtype = ''PK'')
					ALTER TABLE #Keys DROP CONSTRAINT ' + @Data_PK +'
			END
			'
EXEC(@SQL1)
						
--- UPDATE DU LIEU 
	UPDATE HT24
	SET HT24.AbsentAmount = TNS.AbsentAmount,
		HT24.LastModifyUserID = @UserID,
		HT24.LastModifyDate = GETDATE()
	FROM HT2402 HT24
	INNER JOIN #DATA TNS
		ON HT24.DIVISIONID = TNS.DIVISIONID AND HT24.EmployeeID = TNS.EmployeeID
				AND HT24.AbsentTypeID = TNS.AbsentTypeID
				AND HT24.TranMonth = @TranMonth AND HT24.TranYear= @TranYear
				AND HT24.PERIODID = TNS.PeriodID
	
--- INSERT DU LIEU
	INSERT INTO HT2402(DivisionID, EmployeeID, TranMonth, TranYear, DepartmentID,TeamID, AbsentTypeID, AbsentAmount, PeriodID, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
	SELECT	TNS.DivisionID, TNS.EmployeeID, @TranMonth, @TranYear, HT14.DepartmentID, HT14.TeamID,TNS.AbsentTypeID,
			TNS.AbsentAmount, TNS.PeriodID, @UserID,GETDATE(),@UserID,GETDATE()
	FROM #DATA TNS			
	LEFT JOIN HT2400 HT14
		ON HT14.DivisionID = TNS.DIVISIONID AND HT14.EmployeeID = TNS.EmployeeID  AND HT14.TranMonth = @TranMonth AND HT14.TranYear= @TranYear
	WHERE NOT EXISTS (	SELECT TOP 1 1 FROM HT2402 HT24
						WHERE HT24.DIVISIONID = TNS.DIVISIONID AND HT24.EmployeeID = TNS.EmployeeID AND HT24.TranMonth = @TranMonth AND HT24.TranYear= @TranYear
								AND HT24.AbsentTypeID = TNS.AbsentTypeID AND HT24.PERIODID = TNS.PeriodID )
	
LB_RESULT:
SELECT * FROM #Data


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON

