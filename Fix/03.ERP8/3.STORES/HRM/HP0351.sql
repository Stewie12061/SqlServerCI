IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0351]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0351]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- kết chuyển chấm công ca 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 09/10/2014 by Lê Thị Thu Hiền
---- 
---- Modified on 06/01/2015 by Thanh Sơn: cho chọn danh sách hệ số cần kết chuyển
---- Modified on 23/11/2016 by Bảo Thy: Bổ sung lưu C26->C100 (MEIKO)
-- <Example>
---- EXEC HP0351 'VK', 'ADMIN', 10, 2014, 'C01'',''C02', 'SABA(1)-TSN'',''MAMARES(1)-Q1'',''XUONGQ12', 1

CREATE PROCEDURE HP0351
( 
		@DivisionID AS NVARCHAR(50),
		@UserID AS NVARCHAR(50),
		@TranMonth AS INT,
		@TranYear AS INT,
		@CoefficientIDList NVARCHAR(1500),
		@ProjectIDList NVARCHAR(MAX),
		@IsAll TINYINT
) 
AS
DECLARE @AbsentDecimals TINYINT, @sSQL1 NVARCHAR(2000)
SET @AbsentDecimals = (SELECT TOP 1 ISNULL(AbsentDecimals, 0) FROM HT0000 WHERE DivisionID = @DivisionID )

CREATE TABLE #TAM (ProjectID NVARCHAR(50))

SET @sSQL1 = '
INSERT INTO #TAM (ProjectID)
SELECT DISTINCT ProjectID FROM HT2416 
WHERE DivisionID = '''+@DivisionID+''' AND TranMonth = '+STR(@TranMonth)+' AND Tranyear = '+STR(@TranYear)+'
	AND ProjectID IN ('''+@ProjectIDList+''')'

IF ISNULL(@IsAll, 0) = 0 EXEC (@sSQL1)
ELSE
	BEGIN
		INSERT INTO #TAM (ProjectID)
		SELECT DISTINCT ProjectID FROM HT2416 
		WHERE DivisionID = @DivisionID AND TranMonth = @TranMonth AND TranYear = @TranYear
	END
SELECT * FROM #TAM
CREATE TABLE #Period (PeriodID NVARCHAR(50))

INSERT INTO #Period (PeriodID)
SELECT DISTINCT PeriodID FROM HT2416 
WHERE DivisionID = @DivisionID AND TranMonth = @TranMonth AND Tranyear = @TranYear

DELETE FROM HT2432 WHERE DivisionID = @DivisionID AND TranMonth = @TranMonth AND TranYear = @TranYear AND ProjectID IN (SELECT ProjectID FROM #TAM)
 
INSERT INTO HT2432 (DivisionID,	TranMonth,	TranYear, ProjectID, PeriodID, DepartmentID, TeamID, AbsentTypeID,
	EmployeeID,AbsentAmount, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID)

SELECT HT.DivisionID, HT.TranMonth, HT.Tranyear, HT.ProjectID, HT.PeriodID, HT.DepartmentID,
	HT.TeamID,	HT.AbsentTypeID, HT.EmployeeID,
	CASE WHEN ISNULL(HT.UnitID, '') = 'H' THEN ROUND(SUM(HT.AbsentTime), @AbsentDecimals)
		ELSE ROUND(SUM(HT.AbsentTime)/8, @AbsentDecimals) END AbsentAmount,	GETDATE(), @UserID, GETDATE(), @UserID
FROM
(		
	SELECT	DISTINCT HT2416.DivisionID, HT2416.TranMonth, HT2416.Tranyear, HT2416.ProjectID, HT2416.PeriodID, HT1021.UnitID,
	HT2400.DepartmentID, HT2400.TeamID,	HT1021.AbsentTypeID, HT2416.EmployeeID, HT2416.ShiftCode, HT2416.AbsentDate,
	ISNULL(HT2416.AbsentTime,0) AS AbsentTime
	FROM HT2416 HT2416
		LEFT JOIN HT2400 HT2400 ON HT2400.DivisionID = HT2416.DivisionID AND HT2400.EmployeeID = HT2416.EmployeeID 
			AND HT2400.TranMonth = HT2416.TranMonth AND HT2400.Tranyear = HT2416.Tranyear
		LEFT JOIN
		(
			SELECT	H.DivisionID, H.ShiftID, H1.ParentID AS AbsentTypeID, H1.UnitID,
				CASE WHEN H.DateTypeID = 'SUN' THEN 1 WHEN H.DateTypeID = 'MON' THEN 2
					 WHEN H.DateTypeID = 'TUE' THEN 3 WHEN H.DateTypeID = 'WED' THEN 4
					 WHEN H.DateTypeID = 'THU' THEN 5 WHEN H.DateTypeID = 'FRI' THEN 6
					 WHEN H.DateTypeID = 'SAT' THEN 7 END DateType
			FROM HT1021 H 
				INNER JOIN HT1013 H1 ON H1.DivisionID = H.DivisionID AND H1.AbsentTypeID = H.AbsentTypeID AND H1.TypeID = 'N'
           	WHERE	H.DivisionID = @DivisionID
		) HT1021 
			ON HT1021.DivisionID = HT2416.DivisionID AND HT1021.ShiftID = HT2416.ShiftCode AND DATEPART(DW ,HT2416.AbsentDate) =  HT1021.DateType
	WHERE HT2416.DivisionID = @DivisionID
		AND HT2416.TranMonth = @TranMonth 
		AND HT2416.Tranyear = @TranYear
		AND HT2416.ProjectID IN (SELECT ProjectID FROM #TAM)
) HT
WHERE HT.DepartmentID IS NOT NULL
GROUP BY HT.DivisionID, HT.TranMonth, HT.Tranyear, HT.DepartmentID, HT.TeamID,	HT.AbsentTypeID,
	HT.EmployeeID, HT.ProjectID, HT.PeriodID, HT.UnitID	

DELETE FROM HT1121 WHERE DivisionID = @DivisionID AND ProjectID IN (SELECT ProjectID FROM #TAM)	
INSERT INTO HT1121 (DivisionID, ProjectID, EmployeeID)
SELECT DISTINCT HT2432.DivisionID, HT2432.ProjectID, HT2432.EmployeeID
FROM HT2432 HT2432
WHERE HT2432.DivisionID = @DivisionID AND HT2432.ProjectID IN (SELECT ProjectID FROM #TAM)
												
DELETE FROM HT2421 WHERE DivisionID = @DivisionID AND ProjectID IN (SELECT ProjectID FROM #TAM) 
			AND TranMonth = @TranMonth AND TranYear = @TranYear			
INSERT INTO HT2421 (DivisionID, ProjectID, EmployeeID, DepartmentID, TeamID, TranMonth, TranYear,
	BaseSalary, InsuranceSalary, Salary01, Salary02, Salary03, SalaryCoefficient, DutyCoefficient,
	TimeCoefficient, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID)
SELECT DISTINCT HT2432.DivisionID, HT2432.ProjectID, HT2432.EmployeeID, HT2432.DepartmentID, HT2400.TeamID,
    HT2432.TranMonth, HT2432.TranYear, BaseSalary, InsuranceSalary, Salary01, Salary02,
    Salary03, SalaryCoefficient, DutyCoefficient, TimeCoefficient, GETDATE(), GETDATE(), @UserID, @UserID
FROM HT2432 HT2432
	INNER JOIN HT2400 HT2400 ON HT2400.DivisionID = HT2432.DivisionID AND HT2400.EmployeeID = HT2432.EmployeeID 
		AND HT2400.TranMonth = HT2432.TranMonth AND HT2400.TranYear = HT2432.TranYear 
		AND HT2400.DepartmentID = HT2432.DepartmentID AND ISNULL (HT2400.TeamID,'') = ISNULL(HT2432.TeamID,'')
WHERE HT2432.DivisionID = @DivisionID
	AND HT2432.ProjectID IN (SELECT ProjectID FROM #TAM)
	AND HT2432.TranMonth = @TranMonth
	AND HT2432.TranYear = @TranYear

--------- Lưu Phụ cấp
--- Lấy lại giá trị của 25 hệ số trước khi xóa
CREATE TABLE #CTam (ProjectID VARCHAR(50), EmployeeID VARCHAR(50), C01 DECIMAL(28,8), C02 DECIMAL(28,8), C03 DECIMAL(28,8),
	C04 DECIMAL(28,8), C05 DECIMAL(28,8), C06 DECIMAL(28,8), C07 DECIMAL(28,8), C08 DECIMAL(28,8), C09 DECIMAL(28,8),
	C10 DECIMAL(28,8), C11 DECIMAL(28,8), C12 DECIMAL(28,8), C13 DECIMAL(28,8), C14 DECIMAL(28,8), C15 DECIMAL(28,8),
	C16 DECIMAL(28,8), C17 DECIMAL(28,8), C18 DECIMAL(28,8), C19 DECIMAL(28,8), C20 DECIMAL(28,8), C21 DECIMAL(28,8),
	C22 DECIMAL(28,8), C23 DECIMAL(28,8), C24 DECIMAL(28,8), C25 DECIMAL(28,8))
INSERT INTO #CTam (ProjectID, EmployeeID, C01, C02, C03, C04, C05, C06, C07, C08, C09, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25)
SELECT ProjectID, EmployeeID, C01, C02, C03, C04, C05, C06, C07, C08, C09, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25
FROM HT2430 WHERE DivisionID  = @DivisionID 
AND ProjectID IN (SELECT ProjectID FROM #TAM) 
AND TranMonth = @TranMonth
AND TranYear = @TranYear

DELETE FROM HT2430 WHERE DivisionID  = @DivisionID 
AND ProjectID IN (SELECT ProjectID FROM #TAM) 
--AND PeriodID IN (SELECT PeriodID FROM #Period)
AND TranMonth = @TranMonth
AND TranYear = @TranYear

INSERT INTO HT2430 (DivisionID,	ProjectID, PeriodID, EmployeeID, DepartmentID, TeamID, TranMonth, TranYear,
	C01, C02, C03, C04, C05, C06, C07, C08, C09, C10, C11, C12,	C13, C14, C15, C16,	C17, C18, C19, C20,
	C21, C22, C23, C24,	C25, BaseSalary, Salary01, Salary02, Salary03, SalaryCoefficient, TimeCoefficient,
	DutyCoefficient, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID, InsuranceSalary)
SELECT H.DivisionID, T.ProjectID, NULL,	H.EmployeeID, H.DepartmentID, H.TeamID,	H.TranMonth, H.TranYear,
	H.C01, H.C02, H.C03, H.C04,	H.C05, H.C06, H.C07, H.C08,	H.C09, H.C10, H.C11, H.C12,	H.C13, H.C14, H.C15,
	H.C16, H.C17, H.C18, H.C19,	H.C20, H.C21, H.C22, H.C23,	H.C24, H.C25, H.BaseSalary,	H.Salary01,	H.Salary02,	H.Salary03,
	H.SalaryCoefficient, H.TimeCoefficient,	H.DutyCoefficient, GETDATE(), GETDATE(),@UserID, @UserID, InsuranceSalary
FROM HT2400 H, #TAM T
WHERE H.DivisionID = @DivisionID AND H.TranMonth = @TranMonth AND H.TranYear = @TranYear
AND H.EmployeeID + T.ProjectID IN (SELECT EmployeeID + ProjectID FROM HT2416
                                   WHERE DivisionID = @DivisionID AND TranMonth = @TranMonth AND TranYear = @TranYear)

DELETE FROM HT2430_1 WHERE DivisionID  = @DivisionID 
	AND ProjectID IN (SELECT ProjectID FROM #TAM) 
	--AND PeriodID IN (SELECT PeriodID FROM #Period)
	AND TranMonth = @TranMonth
	AND TranYear = @TranYear
	
INSERT INTO HT2430_1
(
	DivisionID,	ProjectID,	PeriodID,	EmployeeID,
	TranMonth,	TranYear,
	C26, C27, C28, C29, C30, C31, C32, C33, C34, C35, 
	C36, C37, C38, C39, C40, C41, C42, C43, C44, C45, 
	C46, C47, C48, C49, C50, C51, C52, C53, C54, C55, 
	C56, C57, C58, C59, C60, C61, C62, C63, C64, C65, 
	C66, C67, C68, C69, C70, C71, C72, C73, C74, C75, 
	C76, C77, C78, C79, C80, C81, C82, C83, C84, C85, 
	C86, C87, C88, C89, C90, C91, C92, C93, C94, C95, 
	C96, C97, C98, C99, C100,C101, C102, C103, C104, 
	C105, C106, C107, C108, C109, C110, C111, C112, 
	C113, C114, C115, C116, C117, C118, C119, C120, C121, C122, C123, C124, 
	C125, C126, C127, C128, C129, C130, C131, C132, C133, C134, C135, C136, 
	C137, C138, C139, C140, C141, C142, C143, C144, C145, C146, C147, C148, 
	C149, C150, CreateDate,	LastModifyDate,	CreateUserID, LastModifyUserID
)
SELECT 
	H.DivisionID,	T.ProjectID, NULL, H.EmployeeID,--@Period,	
	H.TranMonth,	H.TranYear,
	H.C26, H.C27, H.C28, H.C29, H.C30, H.C31, H.C32, H.C33, H.C34, H.C35, 
	H.C36, H.C37, H.C38, H.C39, H.C40, H.C41, H.C42, H.C43, H.C44, H.C45, 
	H.C46, H.C47, H.C48, H.C49, H.C50, H.C51, H.C52, H.C53, H.C54, H.C55, 
	H.C56, H.C57, H.C58, H.C59, H.C60, H.C61, H.C62, H.C63, H.C64, H.C65, 
	H.C66, H.C67, H.C68, H.C69, H.C70, H.C71, H.C72, H.C73, H.C74, H.C75, 
	H.C76, H.C77, H.C78, H.C79, H.C80, H.C81, H.C82, H.C83, H.C84, H.C85, 
	H.C86, H.C87, H.C88, H.C89, H.C90, H.C91, H.C92, H.C93, H.C94, H.C95, 
	H.C96, H.C97, H.C98, H.C99, H.C100,	H.C101, H.C102, H.C103, H.C104, H.C105, H.C106, H.C107, H.C108, 
	H.C109, H.C110, H.C111, H.C112, H.C113, H.C114, H.C115, H.C116, H.C117, H.C118, H.C119, H.C120, 
	H.C121, H.C122, H.C123, H.C124, H.C125, H.C126, H.C127, H.C128, H.C129, H.C130, H.C131, H.C132, 
	H.C133, H.C134, H.C135, H.C136, H.C137, H.C138, H.C139, H.C140, H.C141, H.C142, H.C143, H.C144, 
	H.C145, H.C146, H.C147, H.C148, H.C149, H.C150, GETDATE(),GETDATE(),@UserID, @UserID
FROM HT2499 H, #TAM T--, #Period P
WHERE H.DivisionID = @DivisionID
AND H.TranMonth = @TranMonth
AND H.TranYear = @TranYear
AND H.EmployeeID+T.ProjectID IN (SELECT EmployeeID+ProjectID 
	                                FROM HT2416 
	                                WHERE DivisionID = @DivisionID 
	                                AND TranMonth = @TranMonth
	                                AND TranYear = @TranYear
	                                )                                   
---- Update lại giá trị của của các hệ số KHÔNG được chọn

DECLARE @i INT = 1, @sSQL NVARCHAR(MAX), @C NVARCHAR(10)
WHILE @i <= 25
BEGIN
	IF @i < 10 SET @C = 'C0' + CONVERT(VARCHAR(1), @i) ELSE SET @C = 'C' + CONVERT(VARCHAR(2), @i)
	SET @sSQL = 'IF ('''+@C+''' NOT IN ('''+@CoefficientIDList+'''))
				 UPDATE HT2430 SET '+@C+' = (SELECT TOP 1 '+@C+' FROM #CTam C WHERE C.ProjectID = HT2430.ProjectID AND C.EmployeeID = HT2430.EmployeeID)
				 WHERE HT2430.DivisionID = '''+@DivisionID+''' AND HT2430.TranMonth = '+STR(@TranMonth)+' AND HT2430.TranYear = '+STR(@TranYear)+'
				 AND HT2430.ProjectID IN (SELECT ProjectID FROM #TAM)  '
	EXEC (@sSQL)
	SET @i = @i + 1
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
