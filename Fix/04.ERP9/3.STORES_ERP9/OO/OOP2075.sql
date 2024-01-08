IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2075]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[OOP2075]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
--- Import đơn xin đổi ca
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by Bảo Thy on 15/03/2018
---- Modified by on 
---- Modified by Xuân Nguyên on 05/01/2024 : [2024/01/IS/0009] Bổ sung import cột ApproveLevel cho OOT2070 và cột APKDetail cho OOT9001 
-- <Example>
/*
    EXEC OOP2075,0, 1
	EXEC OOP2075 @DivisionID = @DivisionID, @UserID = @UserID, @TranMonth = @TranMonth, @TranYear = @TranYear, @Mode = @Mode, @ImportTemplateID = @ImportTemplateID, @TransactionKey = @TransactionKey, @XML = @XML
*/

 CREATE PROCEDURE OOP2075
(
     @DivisionID VARCHAR(50),
     @UserID VARCHAR(50),
     @TranMonth INT,
     @TranYear INT,   
     @Mode TINYINT, --0 chưa hết dữ liệu, 1: hết dữ liệu
     @ImportTransTypeID NVARCHAR(250),
     @TransactionKey NVARCHAR(50),
     @XML XML
)
AS
DECLARE @Cur CURSOR,
		@Row INT,
		@TransactionID UNIQUEIDENTIFIER,
		@ID VARCHAR(100),
		@TypeID TINYINT,
		@DepartmentID VARCHAR(50),
		@TeamID VARCHAR(50),
		@EmployeeID VARCHAR(100),
		@FullName NVARCHAR(250),
		@D01 VARCHAR(50),
		@D02 VARCHAR(50),
		@D03 VARCHAR(50),
		@D04 VARCHAR(50),
		@D05 VARCHAR(50),
		@D06 VARCHAR(50),
		@D07 VARCHAR(50),
		@D08 VARCHAR(50),
		@D09 VARCHAR(50),
		@D10 VARCHAR(50),
		@D11 VARCHAR(50),
		@D12 VARCHAR(50),
		@D13 VARCHAR(50),
		@D14 VARCHAR(50),
		@D15 VARCHAR(50),
		@D16 VARCHAR(50),
		@D17 VARCHAR(50),
		@D18 VARCHAR(50),
		@D19 VARCHAR(50),
		@D20 VARCHAR(50),
		@D21 VARCHAR(50),
		@D22 VARCHAR(50),
		@D23 VARCHAR(50),
		@D24 VARCHAR(50),
		@D25 VARCHAR(50),
		@D26 VARCHAR(50),
		@D27 VARCHAR(50),
		@D28 VARCHAR(50),
		@D29 VARCHAR(50),
		@D30 VARCHAR(50),
		@D31 VARCHAR(50),
		@ApprovePersonID01 VARCHAR(50),
		@ApprovePersonID02 VARCHAR(50),
		@ApprovePersonID03 VARCHAR(50),
		@ApprovePersonID04 VARCHAR(50),
		@ApprovePersonID05 VARCHAR(50),
		@ApprovePersonID06 VARCHAR(50),
		@ApprovePersonID07 VARCHAR(50),
		@ApprovePersonID08 VARCHAR(50),
		@ApprovePersonID09 VARCHAR(50),
		@ApprovePersonID10 VARCHAR(50),
		@ErrorFlag TINYINT = 0,
		@ErrorColumn NVARCHAR(MAX)='',
		@ErrorMessage NVARCHAR(MAX)='',
		@Level INT,
		@EndMonth INT=0,
		@APK1 VARCHAR(50), --lưu giá trị APK cập nhật vào bảng
		@WorkDate DATETIME,
		@LeaveDate DATETIME,
		@Date DATETIME

SET @TransactionID = NEWID()
SET @EndMonth=(SELECT Day(DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,DATEFROMPARTS(@TranYear, @TranMonth, 1))+1,0))))

---------INSERT dữ liệu từ file excel vào bảng tạm---------------------------------------

IF EXISTS (SELECT TOP 1 1 FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(N'[dbo].[OOT2075]') AND TYPE IN (N'U'))
	DELETE OOT2075  WHERE DATEDIFF(DAY, CreateDate, GETDATE()) >= 1 -- xóa dữ liệu import thừa
	
INSERT INTO OOT2075([Row], DivisionID, TranMonth, TranYear, TypeID, ID, [Description],
            DepartmentID, TeamID, EmployeeID, FullName,
            D01, D02, D03, D04, D05, D06, D07, D08, D09, D10, D11, D12, D13, D14,
            D15  , D16, D17, D18, D19, D20, D21, D22, D23, D24, D25, D26, D27, D28,
            D29, D30, D31, Note, ApprovePersonID01, ApprovePersonID02,
            ApprovePersonID03, ApprovePersonID04, ApprovePersonID05,
            ApprovePersonID06, ApprovePersonID07,ApprovePersonID08,
            ApprovePersonID09,ApprovePersonID10,TransactionKey, TransactionID, CreateDate, ErrorColumn, ErrorMessage)												
SELECT	X.Data.query('OrderNo').value('.','INT') AS [Row],
		X.Data.query('DivisionID').value('.','NVARCHAR(50)') AS DivisionID,
		CONVERT(INT,LEFT(X.Data.query('Period').value('.','VARCHAR(10)'),2)) AS TranMonth,
		CONVERT(INT,RIGHT(X.Data.query('Period').value('.','VARCHAR(10)'),4)) AS TranYear,
		(CASE WHEN X.Data.query('TypeID').value('.', 'VARCHAR(50)') = '' THEN 0 ELSE X.Data.query('TypeID').value('.', 'TINYINT') END) AS TypeID,
		'' AS ID,	
		X.Data.query('Description').value('.','NVARCHAR(250)') AS [Description],
		X.Data.query('DepartmentID').value('.','VARCHAR(50)') AS DepartmentID,
		X.Data.query('TeamID').value('.','VARCHAR(50)') AS TeamID,
		X.Data.query('EmployeeID').value('.','VARCHAR(50)') AS EmployeeID,
		X.Data.query('FullName').value('.', 'NVARCHAR(250)') AS FullName,
		X.Data.query('D01').value('.', 'VARCHAR(50)') AS D01,
		X.Data.query('D02').value('.', 'VARCHAR(50)') AS D02,
		X.Data.query('D03').value('.', 'VARCHAR(50)') AS D03,
		X.Data.query('D04').value('.', 'VARCHAR(50)') AS D04,
		X.Data.query('D05').value('.', 'VARCHAR(50)') AS D05,
		X.Data.query('D06').value('.', 'VARCHAR(50)') AS D06,
		X.Data.query('D07').value('.', 'VARCHAR(50)') AS D07,
		X.Data.query('D08').value('.', 'VARCHAR(50)') AS D08,
		X.Data.query('D09').value('.', 'VARCHAR(50)') AS D09,
		X.Data.query('D10').value('.', 'VARCHAR(50)') AS D10,
		X.Data.query('D11').value('.', 'VARCHAR(50)') AS D11,
		X.Data.query('D12').value('.', 'VARCHAR(50)') AS D12,
		X.Data.query('D13').value('.', 'VARCHAR(50)') AS D13,
		X.Data.query('D14').value('.', 'VARCHAR(50)') AS D14,
		X.Data.query('D15').value('.', 'VARCHAR(50)') AS D15,
		X.Data.query('D16').value('.', 'VARCHAR(50)') AS D16,
		X.Data.query('D17').value('.', 'VARCHAR(50)') AS D17,
		X.Data.query('D18').value('.', 'VARCHAR(50)') AS D18,
		X.Data.query('D19').value('.', 'VARCHAR(50)') AS D19,
		X.Data.query('D20').value('.', 'VARCHAR(50)') AS D20,
		X.Data.query('D21').value('.', 'VARCHAR(50)') AS D21,
		X.Data.query('D22').value('.', 'VARCHAR(50)') AS D22,
		X.Data.query('D23').value('.', 'VARCHAR(50)') AS D23,
		X.Data.query('D24').value('.', 'VARCHAR(50)') AS D24,
		X.Data.query('D25').value('.', 'VARCHAR(50)') AS D25,
		X.Data.query('D26').value('.', 'VARCHAR(50)') AS D26,
		X.Data.query('D27').value('.', 'VARCHAR(50)') AS D27,
		X.Data.query('D28').value('.', 'VARCHAR(50)') AS D28,
		X.Data.query('D29').value('.', 'VARCHAR(50)') AS D29,
		X.Data.query('D30').value('.', 'VARCHAR(50)') AS D30,
		X.Data.query('D31').value('.', 'VARCHAR(50)') AS D31,
		X.Data.query('Note').value('.', 'NVARCHAR(250)') AS Note,
		X.Data.query('ApprovePersonID01').value('.', 'VARCHAR(50)') AS ApprovePersonID01,
		X.Data.query('ApprovePersonID02').value('.', 'VARCHAR(50)') AS ApprovePersonID02,
		X.Data.query('ApprovePersonID03').value('.', 'VARCHAR(50)') AS ApprovePersonID03,
		X.Data.query('ApprovePersonID04').value('.', 'VARCHAR(50)') AS ApprovePersonID04,
		X.Data.query('ApprovePersonID05').value('.', 'VARCHAR(50)') AS ApprovePersonID05,
		X.Data.query('ApprovePersonID06').value('.', 'VARCHAR(50)') AS ApprovePersonID06,
		X.Data.query('ApprovePersonID07').value('.', 'VARCHAR(50)') AS ApprovePersonID07,
		X.Data.query('ApprovePersonID08').value('.', 'VARCHAR(50)') AS ApprovePersonID08,
		X.Data.query('ApprovePersonID09').value('.', 'VARCHAR(50)') AS ApprovePersonID09,
		X.Data.query('ApprovePersonID10').value('.', 'VARCHAR(50)') AS ApprovePersonID10,
		@TransactionKey AS TransactionKey, @TransactionID, GETDATE(),'',''
FROM @XML.nodes('//Data') AS X (Data)

--------------Test dữ liệu import---------------------------------------------------
IF (SELECT TOP 1 DivisionID FROM OOT2075 WHERE TransactionKey = @TransactionKey) <> @DivisionID    -- Kiểm tra đơn vị hiện tại
BEGIN
	UPDATE OOT2075 SET ErrorMessage = (SELECT TOP 1 DataCol + '-OOFML000001' FROM A00065 WITH (NOLOCK) WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'DivisionID'),
					   ErrorColumn = 'DivisionID'
	GOTO EndMessage
END

IF (SELECT TOP 1 (TranMonth + TranYear * 100) FROM OOT2075 WHERE TransactionKey = @TransactionKey) <> (@TranMonth + @TranYear * 100)    -- Kiểm tra kỳ kế toán hiện tại
BEGIN
	UPDATE OOT2075 SET ErrorMessage = (SELECT TOP 1 DataCol + '-OOFML000002' FROM A00065 WITH (NOLOCK) WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'Period'),
					   ErrorColumn = 'Period'
	GOTO EndMessage
END

SET @Level=(SELECT LEVEL FROM OOT0010 WHERE DivisionID=@DivisionID AND TranMonth=@TranMonth AND TranYear=@TranYear AND AbsentType='DXDC')
SET @Level=ISNULL(@Level,0)

SET @Cur = CURSOR SCROLL KEYSET FOR
	SELECT [Row],TypeID,'' ID,ISNULL(DepartmentID,'') AS DepartmentID, ISNULL(TeamID,'') AS TeamID, ISNULL(EmployeeID,'') AS EmployeeID, ISNULL(FullName,'') AS FullName,
	ISNULL(D01,'') AS D01, ISNULL(D02,'') AS D02, ISNULL(D03,'') AS D03, ISNULL(D04,'') AS D04, ISNULL(D05,'') AS D05,
	ISNULL(D06,'') AS D06, ISNULL(D07,'') AS D07, ISNULL(D08,'') AS D08, ISNULL(D09,'') AS D09, ISNULL(D10,'') AS D10,
	ISNULL(D11,'') AS D11, ISNULL(D12,'') AS D12, ISNULL(D13,'') AS D13, ISNULL(D14,'') AS D14, ISNULL(D15,'') AS D15,
	ISNULL(D16,'') AS D16, ISNULL(D17,'') AS D17, ISNULL(D18,'') AS D18, ISNULL(D19,'') AS D19, ISNULL(D20,'') AS D20,
	ISNULL(D21,'') AS D21, ISNULL(D22,'') AS D22, ISNULL(D23,'') AS D23, ISNULL(D24,'') AS D24, ISNULL(D25,'') AS D25,
	ISNULL(D26,'') AS D26, ISNULL(D27,'') AS D27, ISNULL(D28,'') AS D28, ISNULL(D29,'') AS D29, ISNULL(D30,'') AS D30,
	ISNULL(D31,'') AS D31, ISNULL(ApprovePersonID01,'') AS ApprovePersonID01,
	ISNULL(ApprovePersonID02,'') AS ApprovePersonID02, ISNULL(ApprovePersonID03,'') AS ApprovePersonID03,
	ISNULL(ApprovePersonID04,'') AS ApprovePersonID04, ISNULL(ApprovePersonID05,'') AS ApprovePersonID05,
	ISNULL(ApprovePersonID06,'') AS ApprovePersonID06, ISNULL(ApprovePersonID07,'') AS ApprovePersonID07,
	ISNULL(ApprovePersonID08,'') AS ApprovePersonID08, ISNULL(ApprovePersonID09,'') AS ApprovePersonID09,
	ISNULL(ApprovePersonID10,'') AS ApprovePersonID10
	FROM OOT2075 WITH (NOLOCK)
	WHERE TransactionID = @TransactionID
	ORDER BY [Row]
		
OPEN @Cur
FETCH NEXT FROM @Cur INTO @Row,@TypeID,@ID,@DepartmentID, @TeamID, @EmployeeID, @FullName, 
						  @D01,@D02, @D03, @D04, @D05, @D06, @D07, @D08, @D09, @D10,
                          @D11, @D12, @D13, @D14, @D15, @D16, @D17, @D18, @D19,
                          @D20, @D21, @D22, @D23, @D24, @D25, @D26, @D27, @D28,
                          @D29, @D30, @D31, @ApprovePersonID01, @ApprovePersonID02,
                          @ApprovePersonID03, @ApprovePersonID04,@ApprovePersonID05, @ApprovePersonID06,
                          @ApprovePersonID07, @ApprovePersonID08,@ApprovePersonID09, @ApprovePersonID10
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @ErrorColumn = ''
	SET @ErrorMessage = ''

---- Kiểm tra NV trong file import bị trùng
	IF EXISTS (SELECT TOP 1 1 FROM OOT2075 WHERE EmployeeID = @EmployeeID AND TransactionKey = @TransactionKey HAVING COUNT(1) > 1)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK)
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'EmployeeID'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000038,'
		SET @ErrorColumn = @ErrorColumn + 'EmployeeID,'				
		SET @ErrorFlag = 1
	END

---- Kiểm tra tồn tại mã Mã phòng ban 
	IF @DepartmentID <> '' AND NOT EXISTS (SELECT TOP 1 1 FROM AT1102 WITH (NOLOCK) WHERE DepartmentID = @DepartmentID AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK)
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'DepartmentID'
											) + CONVERT(VARCHAR,@Row) + '-00ML000130,'
		SET @ErrorColumn = @ErrorColumn + 'DepartmentID,'				
		SET @ErrorFlag = 1
	END
	
---- Kiểm tra tồn tại mã Mã tổ nhóm nếu có nhập	
	IF ISNULL(@TeamID,'') <> '' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1101 WITH (NOLOCK) WHERE TeamID = @TeamID AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK)
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'TeamID'
											) + CONVERT(VARCHAR,@Row) + '-00ML000130,'
		SET @ErrorColumn = @ErrorColumn + 'TeamID,'				
		SET @ErrorFlag = 1
	END
	 ELSE
	IF ISNULL(@TeamID,'') <> '' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1101 WITH (NOLOCK) WHERE DepartmentID = @DepartmentID AND TeamID = @TeamID AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 WITH (NOLOCK)
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'TeamID'
											) + CONVERT(VARCHAR,@Row) + '-00ML000133,'
		SET @ErrorColumn = @ErrorColumn + 'TeamID,'				
		SET @ErrorFlag = 1
	END

---- Tạo mã mới
IF @ID=''		
	BEGIN		
		--kiểm tra tôn tại mã thì lấy không có thì tạo mới
		SET @ID = (SELECT TOP 1 ID FROM OOT2075 WHERE TransactionKey = @TransactionKey AND DepartmentID = @DepartmentID AND TeamID = @TeamID AND ISNULL(ID,'') <>'')
		IF ISNULL(@ID,'')=''
		BEGIN
			CREATE TABLE #VoucherNo (APK VARCHAR(50), LastKey INT,VoucherNo VARCHAR(100))
			INSERT INTO #VoucherNo (APK, LastKey,VoucherNo)
			EXEC OOP0000 @DivisionID, @TranMonth, @TranYear, 'OOT2070', 'DXDC'
			SELECT @APK1 = APK, @ID = VoucherNo FROM #VoucherNo	
			
			UPDATE AT4444 SET LastKey = LastKey + 1 WHERE APK = @APK1
			DROP TABLE #VoucherNo
		END
		UPDATE OOT2075 SET ID = @ID WHERE Row = @Row AND TransactionKey = @TransactionKey AND DepartmentID = @DepartmentID AND TeamID = @TeamID
	END
---- Kiểm tra tồn tại mã mã nhân viên và tên nhân viên
	IF NOT EXISTS (SELECT TOP 1 1 FROM HT1400 WHERE EmployeeID = @EmployeeID AND EmployeeStatus NOT IN (4,9))		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'EmployeeID'
											) + CONVERT(VARCHAR,@Row) + '-00ML000130,'
		SET @ErrorColumn = @ErrorColumn + 'EmployeeID,'				
		SET @ErrorFlag = 1
	END
	ELSE IF ISNULL(@FullName,'') <> '' AND NOT EXISTS (SELECT TOP 1 1 FROM HV1400 WHERE EmployeeID = @EmployeeID AND FullName = @FullName)
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'FullName'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000009,'
		SET @ErrorColumn = @ErrorColumn + 'FullName,'				
		SET @ErrorFlag = 1
	END
	ELSE
	IF NOT EXISTS (SELECT TOP 1 1 FROM HT1025 WITH (NOLOCK) 
	           WHERE EmployeeID = @EmployeeID AND Tranmonth = @Tranmonth AND TranYear = @TranYear)		---- Kiểm tra nhân viên đã được phân ca chưa
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'EmployeeID'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000068,'
		SET @ErrorColumn = @ErrorColumn + 'EmployeeID,'				
		SET @ErrorFlag = 1
	END
	ELSE
--- Kiểm tra nhân viên có thuộc phòng ban import 
	IF EXISTS (SELECT TOP 1 1 FROM HT1400 WHERE EmployeeID = @EmployeeID AND DepartmentID <> @DepartmentID)
	BEGIN 
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'EmployeeID')
											+ CONVERT(VARCHAR,@Row) + '-00ML000134,'
		SET @ErrorColumn = @ErrorColumn + 'EmployeeID,'				
		SET @ErrorFlag = 1										
	END
	ELSE
--- Kiểm tra nhân viên có thuộc tổ nhóm import nếu có nhập
	IF ISNULL(@TeamID,'') <> '' AND EXISTS (SELECT TOP 1 1 FROM HT1400 WHERE EmployeeID = @EmployeeID AND TeamID <> @TeamID)
	BEGIN 
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'EmployeeID')
											+ CONVERT(VARCHAR,@Row) + '-00ML000135,'
		SET @ErrorColumn = @ErrorColumn + 'EmployeeID,'				
		SET @ErrorFlag = 1										
	END

---- Kiểm tra thời gian sắp ca >= WorkDate
	CREATE TABLE #Temp (ShiftID VARCHAR(50), ShiftDate DATETIME)

	INSERT INTO #Temp
	VALUES (@D01, CONVERT(DATETIME,STR(@TranMonth)+'/01/'+STR(@TranYear),120)), (@D02, CONVERT(DATETIME,STR(@TranMonth)+'/02/'+STR(@TranYear),120)), 
		   (@D03, CONVERT(DATETIME,STR(@TranMonth)+'/03/'+STR(@TranYear),120)), (@D04, CONVERT(DATETIME,STR(@TranMonth)+'/04/'+STR(@TranYear),120)), 
		   (@D05, CONVERT(DATETIME,STR(@TranMonth)+'/05/'+STR(@TranYear),120)), (@D06, CONVERT(DATETIME,STR(@TranMonth)+'/06/'+STR(@TranYear),120)), 
		   (@D07, CONVERT(DATETIME,STR(@TranMonth)+'/07/'+STR(@TranYear),120)), (@D08, CONVERT(DATETIME,STR(@TranMonth)+'/08/'+STR(@TranYear),120)), 
		   (@D09, CONVERT(DATETIME,STR(@TranMonth)+'/09/'+STR(@TranYear),120)), (@D10, CONVERT(DATETIME,STR(@TranMonth)+'/10/'+STR(@TranYear),120)),
           (@D11, CONVERT(DATETIME,STR(@TranMonth)+'/11/'+STR(@TranYear),120)), (@D12, CONVERT(DATETIME,STR(@TranMonth)+'/12/'+STR(@TranYear),120)), 
		   (@D13, CONVERT(DATETIME,STR(@TranMonth)+'/13/'+STR(@TranYear),120)), (@D14, CONVERT(DATETIME,STR(@TranMonth)+'/14/'+STR(@TranYear),120)), 
		   (@D15, CONVERT(DATETIME,STR(@TranMonth)+'/15/'+STR(@TranYear),120)), (@D16, CONVERT(DATETIME,STR(@TranMonth)+'/16/'+STR(@TranYear),120)), 
		   (@D17, CONVERT(DATETIME,STR(@TranMonth)+'/17/'+STR(@TranYear),120)), (@D18, CONVERT(DATETIME,STR(@TranMonth)+'/18/'+STR(@TranYear),120)), 
		   (@D19, CONVERT(DATETIME,STR(@TranMonth)+'/19/'+STR(@TranYear),120)), (@D20, CONVERT(DATETIME,STR(@TranMonth)+'/20/'+STR(@TranYear),120)), 
		   (@D21, CONVERT(DATETIME,STR(@TranMonth)+'/21/'+STR(@TranYear),120)), (@D22, CONVERT(DATETIME,STR(@TranMonth)+'/22/'+STR(@TranYear),120)), 
		   (@D23, CONVERT(DATETIME,STR(@TranMonth)+'/23/'+STR(@TranYear),120)), (@D24, CONVERT(DATETIME,STR(@TranMonth)+'/24/'+STR(@TranYear),120)), 
		   (@D25, CONVERT(DATETIME,STR(@TranMonth)+'/25/'+STR(@TranYear),120)), (@D26, CONVERT(DATETIME,STR(@TranMonth)+'/26/'+STR(@TranYear),120)), 
		   (@D27, CONVERT(DATETIME,STR(@TranMonth)+'/27/'+STR(@TranYear),120)), (@D28, CONVERT(DATETIME,STR(@TranMonth)+'/28/'+STR(@TranYear),120))
           
	DECLARE @LastDate INT = DAY(DATEADD(DAY,-(DAY(CONVERT(DATETIME,STR(@TranMonth)+'/01/'+STR(@TranYear)))),DATEADD(MONTH,1,CONVERT(DATETIME,STR(@TranMonth)+'/01/'+STR(@TranYear))))) 
	IF @LastDate = 29 AND @TranMonth = 2
		INSERT INTO #Temp
		VALUES (@D31, CONVERT(VARCHAR(2),@TranMonth)+'/29/'+CONVERT(VARCHAR(4),@TranYear))
	IF @LastDate = 31 AND @TranMonth <> 2
		INSERT INTO #Temp
		VALUES (@D29, CONVERT(DATETIME,STR(@TranMonth)+'/29/'+STR(@TranYear),120)), (@D30, CONVERT(DATETIME,STR(@TranMonth)+'/30/'+STR(@TranYear),120))
	IF @LastDate = 31 AND @TranMonth <> 2
		INSERT INTO #Temp
		VALUES (@D31, CONVERT(VARCHAR(2),@TranMonth)+'/31/'+CONVERT(VARCHAR(4),@TranYear))	

	SET @WorkDate = (SELECT ISNULL(WorkDate,'') FROM HT1403 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND EmployeeID = @EmployeeID)
	
	SET @LeaveDate = (SELECT ISNULL(MAX(LeaveDate),'') FROM HT1380 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND EmployeeID = @EmployeeID GROUP BY EmployeeID)
	
	IF EXISTS (SELECT TOP 1 1 FROM #Temp WHERE Convert(Date,ISNULL(ShiftDate,'')) < Convert(Date,@WorkDate)  and Isnull(ShiftID,'') <> '')
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'EmployeeID'
											) + CONVERT(VARCHAR,@Row) + N'-OOFML000049-'+CONVERT(VARCHAR(10),@WorkDate,103)+'-'+@EmployeeID+','	
		SET @ErrorColumn = @ErrorColumn + 'EmployeeID,'		
		SET @ErrorFlag = 1
	END

	IF EXISTS (SELECT TOP 1 1 FROM #Temp WHERE Convert(Date,ISNULL(ShiftDate,'')) >= Convert(Date,@LeaveDate) and Isnull(ShiftID,'') <> '')
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'EmployeeID'
											) + CONVERT(VARCHAR,@Row) + N'-OOFML000053-'+CONVERT(VARCHAR(10),@LeaveDate,103)+'-'+@EmployeeID+','	
		SET @ErrorColumn = @ErrorColumn + 'EmployeeID,'		
		SET @ErrorFlag = 1
	END

--- Kiểm tra Mã Ca 1 nếu có nhập
	IF @D01 <> '' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID = @D01 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D01'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D01,'				
		SET @ErrorFlag = 1
	END

	IF ISNULL(@TypeID,0) = 1 ---Cập nhật bảng phân ca
	BEGIN
		IF @D01 <> '' AND (EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth = @TranMonth AND TranYear = @TranYear AND EmployeeID = @EmployeeID AND ISNULL(D01,'') <> '' ) 
						  OR EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
										 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
					                     WHERE TranMonth = @TranMonth AND TranYear = @TranYear AND EmployeeID = @EmployeeID AND ISNULL(D01,'') <> ''))	
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D01'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
			SET @ErrorColumn = @ErrorColumn + 'D01,'				
			SET @ErrorFlag = 1
		END
	END

--- Kiểm tra Mã Ca 2 nếu có nhập
	IF @D02<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D02 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D02'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D02,'				
		SET @ErrorFlag = 1
	END

	IF ISNULL(@TypeID,0) = 1 ---Cập nhật bảng phân ca
	BEGIN
		IF @D02<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D02,'')<>'' ) 
					     OR EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
										 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
					                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D02,'')<>''))	
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D02'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
			SET @ErrorColumn = @ErrorColumn + 'D02,'				
			SET @ErrorFlag = 1
		END
	END

--- Kiểm tra Mã Ca 3 nếu có nhập
	IF @D03 <> '' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID = @D03 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D03'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D03,'				
		SET @ErrorFlag = 1
	END

	IF ISNULL(@TypeID,0) = 1 ---Cập nhật bảng phân ca
	BEGIN
		IF @D03<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth = @TranMonth AND TranYear = @TranYear AND EmployeeID = @EmployeeID AND ISNULL(D03,'')<>'' ) 
					     OR EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
										 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
					                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D03,'')<>''))	
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D03'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
			SET @ErrorColumn = @ErrorColumn + 'D03,'				
			SET @ErrorFlag = 1
		END
	END

--- Kiểm tra Mã Ca 4 nếu có nhập
	IF @D04<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D04 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D04'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D04,'				
		SET @ErrorFlag = 1
	END

	IF ISNULL(@TypeID,0) = 1 ---Cập nhật bảng phân ca
	BEGIN
		IF @D04<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D04,'')<>'' ) 
					     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
										 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
					                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D04,'')<>''))	
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D04'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
			SET @ErrorColumn = @ErrorColumn + 'D04,'				
			SET @ErrorFlag = 1
		END
	END
--- Kiểm tra Mã Ca 5 nếu có nhập
	IF @D05<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D05 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D05'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D05,'				
		SET @ErrorFlag = 1
	END

	IF ISNULL(@TypeID,0) = 1 ---Cập nhật bảng phân ca
	BEGIN
		IF @D05<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D05,'')<>'' ) 
					     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
										 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
					                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D05,'')<>''))	
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D05'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
			SET @ErrorColumn = @ErrorColumn + 'D05,'				
			SET @ErrorFlag = 1
		END
	END
--- Kiểm tra Mã Ca 6 nếu có nhập
	IF @D06<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D06 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D06'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D06,'				
		SET @ErrorFlag = 1
	END

	IF ISNULL(@TypeID,0) = 1 ---Cập nhật bảng phân ca
	BEGIN
		IF @D06<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D06,'')<>'' ) 
					     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
										 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
					                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D06,'')<>''))	
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D06'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
			SET @ErrorColumn = @ErrorColumn + 'D06,'				
			SET @ErrorFlag = 1
		END
	END
--- Kiểm tra Mã Ca 7 nếu có nhập
	IF  @D07<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D07 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D07'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D07,'				
		SET @ErrorFlag = 1
	END

	IF ISNULL(@TypeID,0) = 1 ---Cập nhật bảng phân ca
	BEGIN
		IF @D07<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D07,'')<>'' ) 
					     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
										 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
					                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D07,'')<>''))	
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D07'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
			SET @ErrorColumn = @ErrorColumn + 'D07,'				
			SET @ErrorFlag = 1
		END
	END
--- Kiểm tra Mã Ca 8 nếu có nhập
	IF @D08<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D08 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D08'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D08,'				
		SET @ErrorFlag = 1
	END

	IF ISNULL(@TypeID,0) = 1 ---Cập nhật bảng phân ca
	BEGIN
		IF @D08<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D08,'')<>'' ) 
					     OR EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
										 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
					                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D08,'')<>''))	
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D08'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
			SET @ErrorColumn = @ErrorColumn + 'D08,'				
			SET @ErrorFlag = 1
		END
	END

--- Kiểm tra Mã Ca 9 nếu có nhập
	IF @D09<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D09 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D09'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D09,'				
		SET @ErrorFlag = 1
	END

	IF ISNULL(@TypeID,0) = 1 ---Cập nhật bảng phân ca
	BEGIN
		IF @D09<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D09,'')<>'' ) 
					     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
										 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
					                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D09,'')<>''))	
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D09'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
			SET @ErrorColumn = @ErrorColumn + 'D09,'				
			SET @ErrorFlag = 1
		END
	END
--- Kiểm tra Mã Ca 10 nếu có nhập
	IF @D10<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D10 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D10'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D10,'				
		SET @ErrorFlag = 1
	END

	IF ISNULL(@TypeID,0) = 1 ---Cập nhật bảng phân ca
	BEGIN
		IF @D10<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D10,'')<>'' ) 
					     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
										 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
					                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D10,'')<>''))	
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D10'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
			SET @ErrorColumn = @ErrorColumn + 'D10,'				
			SET @ErrorFlag = 1
		END
	END
--- Kiểm tra Mã Ca 11 nếu có nhập
	IF @D11<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D11 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D11'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D11,'				
		SET @ErrorFlag = 1
	END

	IF ISNULL(@TypeID,0) = 1 ---Cập nhật bảng phân ca
	BEGIN
		IF @D11<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D11,'')<>'' ) 
					     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
										 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
					                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D11,'')<>''))	
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D11'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
			SET @ErrorColumn = @ErrorColumn + 'D11,'				
			SET @ErrorFlag = 1
		END
	END
--- Kiểm tra Mã Ca 12 nếu có nhập
	IF @D12<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D12 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D12'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D12,'				
		SET @ErrorFlag = 1
	END

	IF ISNULL(@TypeID,0) = 1 ---Cập nhật bảng phân ca
	BEGIN
		IF @D12<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D12,'')<>'' ) 
					     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
										 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
					                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D12,'')<>''))	
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D12'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
			SET @ErrorColumn = @ErrorColumn + 'D12,'				
			SET @ErrorFlag = 1
		END
	END
--- Kiểm tra Mã Ca 13 nếu có nhập
	IF @D13<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D13 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D13'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D13,'				
		SET @ErrorFlag = 1
	END

	IF ISNULL(@TypeID,0) = 1 ---Cập nhật bảng phân ca
	BEGIN
		IF @D13<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D13,'')<>'' ) 
					     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
										 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
					                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D13,'')<>''))	
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D13'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
			SET @ErrorColumn = @ErrorColumn + 'D13,'				
			SET @ErrorFlag = 1
		END
	END
--- Kiểm tra Mã Ca 14 nếu có nhập
	IF @D14<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D14 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D14'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D14,'				
		SET @ErrorFlag = 1
	END

	IF ISNULL(@TypeID,0) = 1 ---Cập nhật bảng phân ca
	BEGIN
		IF @D14<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D14,'')<>'' ) 
					     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
										 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
					                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D14,'')<>''))	
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D14'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
			SET @ErrorColumn = @ErrorColumn + 'D14,'				
			SET @ErrorFlag = 1
		END
	END
--- Kiểm tra Mã Ca 15 nếu có nhập
	IF @D15<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D15 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D15'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D15,'				
		SET @ErrorFlag = 1
	END

	IF ISNULL(@TypeID,0) = 1 ---Cập nhật bảng phân ca
	BEGIN
		IF @D15<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D15,'')<>'' ) 
					     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
										 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
					                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D15,'')<>''))	
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D15'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
			SET @ErrorColumn = @ErrorColumn + 'D15,'				
			SET @ErrorFlag = 1
		END
	END
--- Kiểm tra Mã Ca 16 nếu có nhập
	IF @D16<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D16 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D16'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D16,'				
		SET @ErrorFlag = 1
	END

	IF ISNULL(@TypeID,0) = 1 ---Cập nhật bảng phân ca
	BEGIN
		IF @D16<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D16,'')<>'' ) 
					     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
										 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
					                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D16,'')<>''))	
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D16'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
			SET @ErrorColumn = @ErrorColumn + 'D16,'				
			SET @ErrorFlag = 1
		END
	END
--- Kiểm tra Mã Ca 17 nếu có nhập
	IF @D17<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D17 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D17'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D17,'				
		SET @ErrorFlag = 1
	END

	IF ISNULL(@TypeID,0) = 1 ---Cập nhật bảng phân ca
	BEGIN
		IF @D17<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D17,'')<>'' ) 
					     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
										 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
					                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D17,'')<>''))	
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D17'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
			SET @ErrorColumn = @ErrorColumn + 'D17,'				
			SET @ErrorFlag = 1
		END
	END
--- Kiểm tra Mã Ca 18 nếu có nhập
	IF @D18<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D18 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D18'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D18,'				
		SET @ErrorFlag = 1
	END

	IF ISNULL(@TypeID,0) = 1 ---Cập nhật bảng phân ca
	BEGIN
		IF @D18<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D18,'')<>'' ) 
					     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
										 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
					                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D18,'')<>''))	
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D18'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
			SET @ErrorColumn = @ErrorColumn + 'D18,'				
			SET @ErrorFlag = 1
		END
	END
--- Kiểm tra Mã Ca 19 nếu có nhập
	IF @D19<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D19 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D19'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D19,'				
		SET @ErrorFlag = 1
	END

	IF ISNULL(@TypeID,0) = 1 ---Cập nhật bảng phân ca
	BEGIN
		IF @D19<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D19,'')<>'' ) 
					     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
										 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
					                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D19,'')<>''))	
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D19'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
			SET @ErrorColumn = @ErrorColumn + 'D19,'				
			SET @ErrorFlag = 1
		END
	END
--- Kiểm tra Mã Ca 20 nếu có nhập
	IF @D20<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D20 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D20'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D20,'				
		SET @ErrorFlag = 1
	END

	IF ISNULL(@TypeID,0) = 1 ---Cập nhật bảng phân ca
	BEGIN
		IF @D20<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D20,'')<>'' ) 
					     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
										 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
					                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D20,'')<>''))	
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D20'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
			SET @ErrorColumn = @ErrorColumn + 'D20,'				
			SET @ErrorFlag = 1
		END
	END
--- Kiểm tra Mã Ca 21 nếu có nhập
	IF @D21<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D21 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D21'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D21,'				
		SET @ErrorFlag = 1
	END

	IF ISNULL(@TypeID,0) = 1 ---Cập nhật bảng phân ca
	BEGIN
		IF @D21<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D21,'')<>'' ) 
					     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
										 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
					                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D21,'')<>''))	
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D21'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
			SET @ErrorColumn = @ErrorColumn + 'D21,'				
			SET @ErrorFlag = 1
		END
	END
--- Kiểm tra Mã Ca 22 nếu có nhập
	IF @D22<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D22 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D22'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D22,'				
		SET @ErrorFlag = 1
	END

	IF ISNULL(@TypeID,0) = 1 ---Cập nhật bảng phân ca
	BEGIN
		IF @D22<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D22,'')<>'' ) 
					     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
										 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
					                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D22,'')<>''))	
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D22'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
			SET @ErrorColumn = @ErrorColumn + 'D22,'				
			SET @ErrorFlag = 1
		END
	END
--- Kiểm tra Mã Ca 23 nếu có nhập
	IF @D23<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D23 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D23'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D23,'				
		SET @ErrorFlag = 1
	END

	IF ISNULL(@TypeID,0) = 1 ---Cập nhật bảng phân ca
	BEGIN
		IF @D23<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D23,'')<>'' ) 
					     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
										 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
					                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D23,'')<>''))	
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D23'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
			SET @ErrorColumn = @ErrorColumn + 'D23,'				
			SET @ErrorFlag = 1
		END
	END
--- Kiểm tra Mã Ca 24 nếu có nhập
	IF @D24<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D24 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D24'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D24,'				
		SET @ErrorFlag = 1
	END

	IF ISNULL(@TypeID,0) = 1 ---Cập nhật bảng phân ca
	BEGIN
		IF @D24<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D24,'')<>'' ) 
					     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
										 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
					                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D24,'')<>''))	
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D24'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
			SET @ErrorColumn = @ErrorColumn + 'D24,'				
			SET @ErrorFlag = 1
		END
	END
--- Kiểm tra Mã Ca 25 nếu có nhập
	IF @D25<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D25 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D25'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D25,'				
		SET @ErrorFlag = 1
	END

	IF ISNULL(@TypeID,0) = 1 ---Cập nhật bảng phân ca
	BEGIN
		IF @D25<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D25,'')<>'' ) 
					     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
										 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
					                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D25,'')<>''))	
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D25'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
			SET @ErrorColumn = @ErrorColumn + 'D25,'				
			SET @ErrorFlag = 1
		END
	END
--- Kiểm tra Mã Ca 26 nếu có nhập
	IF @D26<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D26 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D26'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D26,'				
		SET @ErrorFlag = 1
	END

	IF ISNULL(@TypeID,0) = 1 ---Cập nhật bảng phân ca
	BEGIN
		IF @D26<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D26,'')<>'' ) 
					     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
										 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
					                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D26,'')<>''))	
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D26'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
			SET @ErrorColumn = @ErrorColumn + 'D26,'				
			SET @ErrorFlag = 1
		END
	END
--- Kiểm tra Mã Ca 27 nếu có nhập
	IF @D27<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D27 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D27'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D27,'				
		SET @ErrorFlag = 1
	END

	IF ISNULL(@TypeID,0) = 1 ---Cập nhật bảng phân ca
	BEGIN
		IF @D27<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D27,'')<>'' ) 
					     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
										 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
					                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D27,'')<>''))	
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D27'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
			SET @ErrorColumn = @ErrorColumn + 'D27,'				
			SET @ErrorFlag = 1
		END
	END
--- Kiểm tra Mã Ca 28 nếu có nhập
	IF @D28<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D28 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D28'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D28,'				
		SET @ErrorFlag = 1
	END

	IF ISNULL(@TypeID,0) = 1 ---Cập nhật bảng phân ca
	BEGIN
		IF @D28<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D28,'')<>'' ) 
					     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
										 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
					                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D28,'')<>''))	
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D28'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
			SET @ErrorColumn = @ErrorColumn + 'D28,'				
			SET @ErrorFlag = 1
		END
	END
--- Kiểm tra Mã Ca 29 nếu có nhập
IF @EndMonth>28
BEGIN
	IF @D29<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D29 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D29'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D29,'				
		SET @ErrorFlag = 1
	END

	IF ISNULL(@TypeID,0) = 1 ---Cập nhật bảng phân ca
	BEGIN
		IF @D29<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D29,'')<>'' ) 
					     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
										 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
					                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D29,'')<>''))	
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D29'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
			SET @ErrorColumn = @ErrorColumn + 'D29,'				
			SET @ErrorFlag = 1
		END
	END
END 
--- Kiểm tra Mã Ca 30 nếu có nhập
IF @EndMonth>29
BEGIN
	IF @D30<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D30 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D30'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D30,'				
		SET @ErrorFlag = 1
	END

	IF ISNULL(@TypeID,0) = 1 ---Cập nhật bảng phân ca
	BEGIN
		IF @D30<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D30,'')<>'' ) 
					     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
										 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
					                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D30,'')<>''))	
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D30'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
			SET @ErrorColumn = @ErrorColumn + 'D30,'				
			SET @ErrorFlag = 1
		END
	END
END 
--- Kiểm tra Mã Ca 31 nếu có nhập
IF @EndMonth>30
BEGIN
	IF @D31<>'' AND NOT EXISTS (SELECT TOP 1 1 FROM HT1020 WHERE ShiftID=@D31 AND [Disabled] = 0)		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D31'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000007,'
		SET @ErrorColumn = @ErrorColumn + 'D31,'				
		SET @ErrorFlag = 1
	END

	IF ISNULL(@TypeID,0) = 1 ---Cập nhật bảng phân ca
	BEGIN
		IF @D31<>'' AND( EXISTS (SELECT TOP 1 1 FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D31,'')<>'' ) 
					     OR  EXISTS (SELECT TOP 1 1 FROM OOT2000 OT20
										 INNER JOIN OOT9000 OT90 ON OT90.APK = OT20.APKMaster AND OT90.Type='BPC'
					                     WHERE TranMonth=@TranMonth AND TranYear=@TranYear AND EmployeeID=@EmployeeID AND ISNULL(D31,'')<>''))	
		BEGIN
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'D31'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000014,'
			SET @ErrorColumn = @ErrorColumn + 'D31,'				
			SET @ErrorFlag = 1
		END
	END
END 

--- Kiểm tra người duyệt 1
IF @Level > 0
BEGIN
	IF ISNULL(@ApprovePersonID01,'') = ''		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID01'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000011,'
		SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID01,'				
		SET @ErrorFlag = 1
		
	END 
	ELSE 
	BEGIN
		IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14
						INNER JOIN OOT0011 O11 ON O11.DutyID = H14.DutyID AND O11.RollLevel = 1 AND O11.AbsentType='DXDC'
						INNER JOIN OOT0010 O10 ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
		                WHERE H14.EmployeeID = @ApprovePersonID01 
		                AND O10.TranMonth = @TranMonth
		                AND O10.TranYear = @TranYear
						AND H14.EmployeeStatus NOT IN (4,9))
		BEGIN	
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID01'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000069,'
			SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID01,'				
			SET @ErrorFlag = 1
		END		
	END
END
--- Kiểm tra người duyệt 2
IF @Level >1
BEGIN
	IF @ApprovePersonID02=''		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID02'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000011,'
		SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID02,'				
		SET @ErrorFlag = 1
		
	END 
	ELSE 	
	BEGIN
		IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14
						INNER JOIN OOT0011 O11 ON O11.DutyID =H14.DutyID AND O11.RollLevel=1 AND O11.AbsentType='DXDC'
						INNER JOIN OOT0010 O10 ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
			            WHERE H14.EmployeeID=@ApprovePersonID02 
			            AND O10.TranMonth=@TranMonth
			            AND O10.TranYear=@TranYear
						AND H14.EmployeeStatus NOT IN (4,9))
		BEGIN	
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID02'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000069,'
			SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID02,'				
			SET @ErrorFlag = 1
		END
	END
END
--- Kiểm tra người duyệt 3
IF @Level >2
BEGIN
	IF @ApprovePersonID03=''		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID03'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000011,'
		SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID03,'				
		SET @ErrorFlag = 1
		
	END 
	ELSE 
	BEGIN
		IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14
						INNER JOIN OOT0011 O11 ON O11.DutyID =H14.DutyID AND O11.RollLevel=1 AND O11.AbsentType='DXDC'
						INNER JOIN OOT0010 O10 ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
			            WHERE H14.EmployeeID=@ApprovePersonID03
			            AND O10.TranMonth=@TranMonth
			            AND O10.TranYear=@TranYear
						AND H14.EmployeeStatus NOT IN (4,9))
		BEGIN	
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID03'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000069,'
			SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID03,'				
			SET @ErrorFlag = 1
		END
	END
END
--- Kiểm tra người duyệt 4
IF @Level >3
BEGIN
	IF @ApprovePersonID04=''		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID04'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000011,'
		SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID04,'				
		SET @ErrorFlag = 1
		
	END 
	ELSE 
	BEGIN
		IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14
						INNER JOIN OOT0011 O11 ON O11.DutyID =H14.DutyID AND O11.RollLevel=1 AND O11.AbsentType='DXDC'
						INNER JOIN OOT0010 O10 ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
			            WHERE H14.EmployeeID=@ApprovePersonID04
			            AND O10.TranMonth=@TranMonth
			            AND O10.TranYear=@TranYear
						AND H14.EmployeeStatus NOT IN (4,9))
		BEGIN	
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID04'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000069,'
			SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID04,'				
			SET @ErrorFlag = 1
		END
	END
END
--- Kiểm tra người duyệt 5
IF @Level >4
BEGIN
	IF @ApprovePersonID05=''		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID05'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000011,'
		SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID05,'				
		SET @ErrorFlag = 1
		
	END 
	ELSE 
	BEGIN
		IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14
						INNER JOIN OOT0011 O11 ON O11.DutyID =H14.DutyID AND O11.RollLevel=1 AND O11.AbsentType='DXDC'
						INNER JOIN OOT0010 O10 ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
			            WHERE H14.EmployeeID=@ApprovePersonID05
			            AND O10.TranMonth=@TranMonth
			            AND O10.TranYear=@TranYear
						AND H14.EmployeeStatus NOT IN (4,9))
		BEGIN	
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID05'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000069,'
			SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID05,'				
			SET @ErrorFlag = 1
		END
	END 
END
--- Kiểm tra người duyệt 6
IF @Level >5
BEGIN
	IF @ApprovePersonID06=''		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID06'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000011,'
		SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID06,'				
		SET @ErrorFlag = 1
		
	END 
	ELSE
	BEGIN
		IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14
						INNER JOIN OOT0011 O11 ON O11.DutyID =H14.DutyID AND O11.RollLevel=1 AND O11.AbsentType='DXDC'
						INNER JOIN OOT0010 O10 ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
			            WHERE H14.EmployeeID=@ApprovePersonID06
			            AND O10.TranMonth=@TranMonth
			            AND O10.TranYear=@TranYear
						AND H14.EmployeeStatus NOT IN (4,9))
		BEGIN	
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID06'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000069,'
			SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID06,'				
			SET @ErrorFlag = 1
		END
	END
END
--- Kiểm tra người duyệt 7
IF @Level >6
BEGIN
	IF @ApprovePersonID07=''		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID07'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000011,'
		SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID07,'				
		SET @ErrorFlag = 1
		
	END 
	ELSE
	BEGIN
		IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14
						INNER JOIN OOT0011 O11 ON O11.DutyID =H14.DutyID AND O11.RollLevel=1 AND O11.AbsentType='DXDC'
						INNER JOIN OOT0010 O10 ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
			            WHERE H14.EmployeeID=@ApprovePersonID07
			            AND O10.TranMonth=@TranMonth
			            AND O10.TranYear=@TranYear
						AND H14.EmployeeStatus NOT IN (4,9))
		BEGIN	
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID07'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000069,'
			SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID07,'				
			SET @ErrorFlag = 1
		END
	END
END
--- Kiểm tra người duyệt 8
IF @Level >7
BEGIN
	IF @ApprovePersonID08=''		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID08'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000011,'
		SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID08,'				
		SET @ErrorFlag = 1
		
	END 
	ELSE
	BEGIN
		IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14
						INNER JOIN OOT0011 O11 ON O11.DutyID =H14.DutyID AND O11.RollLevel=1 AND O11.AbsentType='DXDC'
						INNER JOIN OOT0010 O10 ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
			            WHERE H14.EmployeeID=@ApprovePersonID08
			            AND O10.TranMonth=@TranMonth
			            AND O10.TranYear=@TranYear
						AND H14.EmployeeStatus NOT IN (4,9))
		BEGIN	
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID08'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000069,'
			SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID08,'				
			SET @ErrorFlag = 1
		END
	END
END
--- Kiểm tra người duyệt 9
IF @Level >8
BEGIN
	IF @ApprovePersonID09=''		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID09'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000011,'
		SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID09,'				
		SET @ErrorFlag = 1
		
	END 
	ELSE
	BEGIN
		IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14
						INNER JOIN OOT0011 O11 ON O11.DutyID =H14.DutyID AND O11.RollLevel=1 AND O11.AbsentType='DXDC'
						INNER JOIN OOT0010 O10 ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
			            WHERE H14.EmployeeID=@ApprovePersonID09
			            AND O10.TranMonth=@TranMonth
			            AND O10.TranYear=@TranYear
						AND H14.EmployeeStatus NOT IN (4,9))
		BEGIN	
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID09'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000069,'
			SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID09,'				
			SET @ErrorFlag = 1
		END
	END
END
--- Kiểm tra người duyệt 10
IF @Level >9
BEGIN
	IF @ApprovePersonID10=''		
	BEGIN
		SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
											WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID10'
											) + CONVERT(VARCHAR,@Row) + '-OOFML000011,'
		SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID10,'				
		SET @ErrorFlag = 1
		
	END 
	ELSE 
	BEGIN
		IF  NOT EXISTS (SELECT TOP 1 1 FROM HV1400 H14
						INNER JOIN OOT0011 O11 ON O11.DutyID =H14.DutyID AND O11.RollLevel=1 AND O11.AbsentType='DXDC'
						INNER JOIN OOT0010 O10 ON O10.APK = O11.APKMaster AND O10.DivisionID = O11.DivisionID
			           WHERE H14.EmployeeID=@ApprovePersonID10
			           AND O10.TranMonth=@TranMonth
			           AND O10.TranYear=@TranYear
						AND H14.EmployeeStatus NOT IN (4,9))
		BEGIN	
			SET @ErrorMessage = @ErrorMessage + (SELECT TOP 1 DataCol FROM A00065 
												WHERE ImportTransTypeID = @ImportTransTypeID AND ColID = 'ApprovePersonID10'
												) + CONVERT(VARCHAR,@Row) + '-OOFML000069,'
			SET @ErrorColumn = @ErrorColumn + 'ApprovePersonID10,'				
			SET @ErrorFlag = 1
		END
	END
END
		
	IF @ErrorColumn <> ''
	BEGIN
		UPDATE OOT2075 SET ErrorMessage = LEFT(@ErrorMessage, LEN(@ErrorMessage) -1),
							ErrorColumn = LEFT(@ErrorColumn, LEN(@ErrorColumn) -1)
		WHERE [Row] = @Row

	END

	DROP TABLE #Temp

	FETCH NEXT FROM @Cur INTO  @Row,@TypeID,@ID,@DepartmentID, @TeamID, @EmployeeID, @FullName, 
						  @D01,@D02, @D03, @D04, @D05, @D06, @D07, @D08, @D09, @D10,
                          @D11, @D12, @D13, @D14, @D15, @D16, @D17, @D18, @D19,
                          @D20, @D21, @D22, @D23, @D24, @D25, @D26, @D27, @D28,
                          @D29, @D30, @D31, @ApprovePersonID01, @ApprovePersonID02,
                          @ApprovePersonID03, @ApprovePersonID04,@ApprovePersonID05, @ApprovePersonID06,
                          @ApprovePersonID07, @ApprovePersonID08,@ApprovePersonID09, @ApprovePersonID10
END
CLOSE @Cur


IF @Mode = 1 -- nếu dữ liệu truyền xuống đã hết
BEGIN
	
	IF NOT EXISTS (SELECT TOP 1 1 FROM OOT2075 WHERE TransactionKey = @TransactionKey AND ErrorColumn <> '') --- nếu không có lỗi
	BEGIN
		--- Insert master
		INSERT INTO OOT9000(DivisionID, TranMonth, TranYear, ID,
		            [Description], DepartmentID, [Type], SectionID, DeleteFlag, AppoveLevel, ApprovingLevel,
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate)
		SELECT A.*, 0, @Level, 0, @UserID, GETDATE(), @UserID,GETDATE()
		FROM 
		(
			SELECT DivisionID, TranMonth, TranYear, ID, MAX([Description]) [Description], 
			DepartmentID, 'DXDC' AS Type, TeamID
			FROM OOT2075
			WHERE TransactionKey = @TransactionKey
			GROUP BY DivisionID, TranMonth, TranYear, ID, DepartmentID, TeamID
		)A 
		-- Insert bảng đổi ca
		SELECT *, CONVERT(INT,RIGHT(StrDate,2)) AS Date
		INTO #TBL1
		FROM
		(
			SELECT TransactionKey, DivisionID, TypeID, TranMonth, TranYear, EmployeeID, ID, [D01],[D02],[D03],[D04],[D05],
			[D06],[D07],[D08],[D09],[D10],[D11],[D12],[D13],[D14],[D15],[D16],[D17],[D18],[D19],[D20],[D21],[D22],[D23],
			[D24],[D25],[D26],[D27],[D28],[D29],[D30],[D31]
			FROM OOT2075 WITH (NOLOCK)
			WHERE TransactionKey = @TransactionKey)p
			UNPIVOT
			(ShiftID FOR StrDate IN 
			([D01],[D02],[D03],[D04],[D05],[D06],[D07],[D08],[D09],[D10],[D11],[D12],[D13],[D14],[D15],[D16],[D17],[D18],[D19],
			[D20],[D21],[D22],[D23],[D24],[D25],[D26],[D27],[D28],[D29],[D30],[D31])
		)AS unpvt
		WHERE ISNULL(unpvt.ShiftID,'') <> ''
			
		--select '#TBL1', * from #TBL1
		--order by employeeid,date

		SELECT ROW_NUMBER() OVER (ORDER BY T1.EmployeeID, T1.Date, T1.ShiftID) AS Orders, T1.*, CASE WHEN ISNULL(T2.ShiftID,'') = '' THEN 1 ELSE 0 END AS Col
		INTO #TBL
		FROM #TBL1 T1
		LEFT JOIN #TBL1 T2 on T1.EmployeeID = T2.EmployeeID AND T1.ShiftID = T2.ShiftID and T1.Date = T2.Date + 1

		--select '#TBL', * from #TBL order by employeeid,orders
		
		--SELECT T1.*, (SELECT SUM(Col) FROM #TBL T2 where T2.Orders <= T1.Orders) AS SumCol
		--FROM #TBL AS T1
		--order by T1.EmployeeID, T1.Date, T1.ShiftID


		INSERT INTO OOT2070 (APK, DivisionID, APKMaster, EmployeeID, ShiftID, ChangeFromDate, ChangeToDate, Status, Note, DeleteFlag, ApproveLevel)
		SELECT NEWID(), Temp1.DivisionID, Temp2.APK, Temp1.EmployeeID, Temp1.ShiftID, CONVERT(DATETIME,CONVERT(VARCHAR(4),@TranYear)+'-'+CONVERT(VARCHAR(2),@TranMonth)+'-'+CONVERT(VARCHAR(2),Temp1.MinDate),120),
		CONVERT(DATETIME,CONVERT(VARCHAR(4),@TranYear)+'-'+CONVERT(VARCHAR(2),@TranMonth)+'-'+CONVERT(VARCHAR(2),Temp1.MaxDate),120), 0, NULL, 0, @Level
		FROM 
		(
			SELECT TransactionKey, DivisionID, TypeID, TranMonth, TranYear, EmployeeID, ID, ShiftID, MIN(Date) AS MinDate, MAX(Date) AS MaxDate
			FROM
			(
				SELECT T1.*, (SELECT SUM(Col) FROM #TBL T2 where T2.Orders <= T1.Orders) AS SumCol
				FROM #TBL AS T1
			)T
			GROUP BY TransactionKey, DivisionID, TypeID, TranMonth, TranYear, EmployeeID, ID, ShiftID, SumCol
		)Temp1
		INNER JOIN OOT9000 Temp2 ON Temp2.DivisionID = Temp1.DivisionID AND Temp2.TranMonth = Temp1.TranMonth AND Temp2.TranYear = Temp1.TranYear AND Temp2.ID = Temp1.ID
		WHERE Temp1.TransactionKey = @TransactionKey


		--- Insert người duyệt
		DECLARE @i INT = 1, @s VARCHAR(2),@sSQL NVARCHAR(MAX)
		WHILE @i <= @Level
		BEGIN
			IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
			ELSE SET @s = CONVERT(VARCHAR, @i)
			SET @sSQL='
			INSERT INTO OOT9001 (DivisionID, APKMaster, ApprovePersonID, [Level], DeleteFlag, [Status],APKDetail)
			SELECT A.DivisionID,OOT9.APK,ApprovePersonID,'+str(@i)+',0,0,OOT2.APK
			FROM
			(
				SELECT DivisionID, TranMonth, TranYear, ID, DepartmentID, TeamID, MAX(ApprovePersonID'+@s+') ApprovePersonID
				FROM OOT2075
				WHERE TransactionKey='''+@TransactionKey+'''
				GROUP BY DivisionID, TranMonth, TranYear, ID, DepartmentID, TeamID
			)A
			INNER JOIN OOT9000 OOT9 ON OOT9.DivisionID = A.DivisionID AND OOT9.TranMonth = A.TranMonth AND OOT9.TranYear = A.TranYear AND OOT9.ID = A.ID
			INNER JOIN OOT2070 OOT2  with (nolock) ON OOT2.DivisionID = A.DivisionID AND OOT2.APKMaster = OOT9.APK'
			--PRINT (@sSQL)
			EXEC (@sSQL)
			SET @i = @i + 1		
		END	
	END
	
END

EndMessage:;
SELECT [Row], ErrorColumn, ErrorMessage FROM OOT2075 
WHERE TransactionKey = @TransactionKey AND TransactionID = @TransactionID AND ErrorColumn <> ''
ORDER BY [Row]


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

