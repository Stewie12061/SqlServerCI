IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP2509]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP2509]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----Created by: Vo Thanh Huong
----Created date: 27/07/2004
----purpose: X? lý s? li?u IN báo cáo luong (t?ng PP)
---- Modified by Bảo Thy on 23/11/2016: Bổ sung C26->C150 (MEIKO)
---- Modified by Phương Thảo on 18/05/2017: Sửa danh mục dùng chung
/********************************************
'* Edited by: [GS] [Việt Khánh] [02/08/2010]
 EXEC HP2509   'MK', 10, 2016, NULL
'********************************************/

CREATE PROCEDURE [dbo].[HP2509] 
    @DivisionID NVARCHAR(50), 
    @TranMonth INT, 
    @TranYear INT, 
    @PayrollMethodID NVARCHAR(50)
AS

DECLARE @sSQL NVARCHAR(4000)='', 
		@sSelect1 NVARCHAR(4000)='',
		@sSelect2 NVARCHAR(4000)='',
		@sFrom NVARCHAR(4000)='',
		@DayperMonth INT,
		@CustomerIndex INT

SELECT @CustomerIndex = CustomerName From CustomerIndex

SELECT @DayPerMonth = ISNULL(DayPerMonth, 24) FROM HT0000 Where DivisionID = @DivisionID

SET @sSQL = '
    SELECT HT34.DivisionID, HT34.EmployeeID, FullName, LTRIM(RTRIM(LastName)) + ''' + ' ''' + ' + LTRIM(RTRIM( MiddleName)) AS LMName, FirstName, 
        HT34.TranMonth, HT34.TranYear, HT34.DepartmentID, AT11.DepartmentName, HT34.TeamID, HT24.BaseSalary, (HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS AvgBaseSalary, 
        HT24.SalaryCoefficient, HT24.DutyCoefficient, HT24.TimeCoefficient, 
        (HT24.TimeCoefficient*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS TimeSalary, 
        (HT24.DutyCoefficient*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS DutySalary, 
        SUM(ISNULL(Income01, 0)) AS Income01, SUM(ISNULL(Income02, 0)) AS Income02, SUM(ISNULL(Income03, 0)) AS Income03, SUM(ISNULL(Income04, 0)) AS Income04, 
        SUM(ISNULL(Income05, 0)) AS Income05, SUM(ISNULL(Income06, 0)) AS Income06, SUM(ISNULL(Income07, 0)) AS Income07, SUM(ISNULL(Income08, 0)) AS Income08, 
        SUM(ISNULL(Income09, 0)) AS Income09, SUM(ISNULL(Income10, 0)) AS Income10, InsAmount, HeaAmount, TempAmount, TraAmount, TaxAmount, 
        SUM(ISNULL(SubAmount01, 0)) AS SubAmount01, SUM(ISNULL(SubAmount02, 0)) AS SubAmount02, SUM(ISNULL(SubAmount03, 0)) AS SubAmount03, 
        SUM(ISNULL(SubAmount04, 0)) AS SubAmount04, SUM(ISNULL(SubAmount05, 0)) AS SubAmount05, 
        SUM(ISNULL(HT24.C01, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C01, SUM(ISNULL(HT24.C02, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C02, 
        SUM(ISNULL(HT24.C03, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C03, SUM(ISNULL(HT24.C04, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C04, 
        SUM(ISNULL(HT24.C05, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C05, SUM(ISNULL(HT24.C06, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C06, 
        SUM(ISNULL(HT24.C07, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C07, SUM(ISNULL(HT24.C08, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C08, 
        SUM(ISNULL(HT24.C09, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C09, SUM(ISNULL(HT24.C10, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C10, 
		SUM(ISNULL(HT24.C11, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C11, SUM(ISNULL(HT24.C12, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C12, 
        SUM(ISNULL(HT24.C13, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C13, SUM(ISNULL(HT24.C14, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C14, 
        SUM(ISNULL(HT24.C15, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C15, SUM(ISNULL(HT24.C16, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C16, 
        SUM(ISNULL(HT24.C17, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C17, SUM(ISNULL(HT24.C18, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C18, 
        SUM(ISNULL(HT24.C19, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C19, SUM(ISNULL(HT24.C20, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C20, 
		SUM(ISNULL(HT24.C21, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C21, SUM(ISNULL(HT24.C22, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C22, 
        SUM(ISNULL(HT24.C23, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C23, SUM(ISNULL(HT24.C24, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C24, 
        SUM(ISNULL(HT24.C25, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C25, SUM(ISNULL(HT25.C26, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C26, 
        SUM(ISNULL(HT25.C27, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C27, SUM(ISNULL(HT25.C28, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C28, 
        SUM(ISNULL(HT25.C29, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C29, SUM(ISNULL(HT25.C30, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C30, 
		SUM(ISNULL(HT25.C31, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C31, SUM(ISNULL(HT25.C32, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C32, 
        SUM(ISNULL(HT25.C33, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C33, SUM(ISNULL(HT25.C34, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C34, 
        SUM(ISNULL(HT25.C35, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C35, SUM(ISNULL(HT25.C36, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C36, 
        SUM(ISNULL(HT25.C37, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C37, SUM(ISNULL(HT25.C38, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C38, 
        SUM(ISNULL(HT25.C39, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C39, SUM(ISNULL(HT25.C40, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C40,
		'
		SET @sSelect1 =
		'SUM(ISNULL(HT25.C41, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C41, SUM(ISNULL(HT25.C42, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C42, 
        SUM(ISNULL(HT25.C43, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C43, SUM(ISNULL(HT25.C44, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C44, 
        SUM(ISNULL(HT25.C45, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C45, SUM(ISNULL(HT25.C46, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C46, 
        SUM(ISNULL(HT25.C47, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C47, SUM(ISNULL(HT25.C48, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C48, 
        SUM(ISNULL(HT25.C49, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C49, SUM(ISNULL(HT25.C50, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C50, 
		SUM(ISNULL(HT25.C51, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C51, SUM(ISNULL(HT25.C52, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C52, 
        SUM(ISNULL(HT25.C53, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C53, SUM(ISNULL(HT25.C54, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C54, 
        SUM(ISNULL(HT25.C55, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C55, SUM(ISNULL(HT25.C56, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C56, 
        SUM(ISNULL(HT25.C57, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C57, SUM(ISNULL(HT25.C58, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C58, 
        SUM(ISNULL(HT25.C59, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C59, SUM(ISNULL(HT25.C60, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C60, 
		SUM(ISNULL(HT25.C61, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C61, SUM(ISNULL(HT25.C62, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C62, 
        SUM(ISNULL(HT25.C63, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C63, SUM(ISNULL(HT25.C64, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C64, 
        SUM(ISNULL(HT25.C65, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C65, SUM(ISNULL(HT25.C66, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C66, 
        SUM(ISNULL(HT25.C67, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C67, SUM(ISNULL(HT25.C68, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C68, 
        SUM(ISNULL(HT25.C69, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C69, SUM(ISNULL(HT25.C70, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C70, 
		SUM(ISNULL(HT25.C71, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C71, SUM(ISNULL(HT25.C72, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C72, 
        SUM(ISNULL(HT25.C73, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C73, SUM(ISNULL(HT25.C74, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C74, 
        SUM(ISNULL(HT25.C75, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C75, SUM(ISNULL(HT25.C76, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C76, 
        SUM(ISNULL(HT25.C77, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C77, SUM(ISNULL(HT25.C78, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C78, 
        SUM(ISNULL(HT25.C79, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C79, SUM(ISNULL(HT25.C80, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C80, 
		SUM(ISNULL(HT25.C81, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C81, SUM(ISNULL(HT25.C82, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C82, 
        SUM(ISNULL(HT25.C83, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C83, SUM(ISNULL(HT25.C84, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C84, 
        SUM(ISNULL(HT25.C85, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C85, SUM(ISNULL(HT25.C86, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C86, 
        SUM(ISNULL(HT25.C87, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C87, SUM(ISNULL(HT25.C88, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C88, 
        SUM(ISNULL(HT25.C89, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C89, SUM(ISNULL(HT25.C90, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C90, 
		SUM(ISNULL(HT25.C91, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C91, SUM(ISNULL(HT25.C92, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C92, 
        SUM(ISNULL(HT25.C93, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C93, SUM(ISNULL(HT25.C94, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C94, 
        SUM(ISNULL(HT25.C95, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C95, SUM(ISNULL(HT25.C96, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C96, 
        SUM(ISNULL(HT25.C97, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C97, SUM(ISNULL(HT25.C98, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C98, 
        SUM(ISNULL(HT25.C99, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C99, SUM(ISNULL(HT25.C100, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C100, 
		'
		SET @sSelect2 = 
		'SUM(ISNULL(HT25.C101, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C101,SUM(ISNULL(HT25.C102, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C102, 
        SUM(ISNULL(HT25.C103, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C103,SUM(ISNULL(HT25.C104, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C104, 
        SUM(ISNULL(HT25.C105, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C105,SUM(ISNULL(HT25.C106, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C106, 
        SUM(ISNULL(HT25.C107, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C107,SUM(ISNULL(HT25.C108, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C108, 
        SUM(ISNULL(HT25.C109, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C109, 
		SUM(ISNULL(HT25.C110, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C110, SUM(ISNULL(HT25.C111, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C111, 
        SUM(ISNULL(HT25.C112, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C112, SUM(ISNULL(HT25.C113, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C113, 
        SUM(ISNULL(HT25.C114, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C114, SUM(ISNULL(HT25.C115, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C115, 
        SUM(ISNULL(HT25.C116, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C116, SUM(ISNULL(HT25.C117, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C117, 
        SUM(ISNULL(HT25.C118, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C118, SUM(ISNULL(HT25.C119, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C119, 
		SUM(ISNULL(HT25.C120, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C120, SUM(ISNULL(HT25.C121, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C121, 
        SUM(ISNULL(HT25.C122, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C122, SUM(ISNULL(HT25.C123, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C123, 
        SUM(ISNULL(HT25.C124, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C124, SUM(ISNULL(HT25.C125, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C125, 
        SUM(ISNULL(HT25.C126, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C126, SUM(ISNULL(HT25.C127, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C127, 
        SUM(ISNULL(HT25.C128, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C128, SUM(ISNULL(HT25.C129, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C129, 
		SUM(ISNULL(HT25.C130, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C130, SUM(ISNULL(HT25.C131, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C131, 
        SUM(ISNULL(HT25.C132, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C132, SUM(ISNULL(HT25.C133, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C133, 
        SUM(ISNULL(HT25.C134, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C134, SUM(ISNULL(HT25.C135, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C135, 
        SUM(ISNULL(HT25.C136, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C136, SUM(ISNULL(HT25.C137, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C137, 
        SUM(ISNULL(HT25.C138, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C138, SUM(ISNULL(HT25.C139, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C139, 
		SUM(ISNULL(HT25.C140, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C140, SUM(ISNULL(HT25.C141, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C141, 
        SUM(ISNULL(HT25.C142, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C142, SUM(ISNULL(HT25.C143, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C143, 
        SUM(ISNULL(HT25.C144, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C144, SUM(ISNULL(HT25.C145, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C145, 
        SUM(ISNULL(HT25.C146, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C146, SUM(ISNULL(HT25.C147, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C147, 
        SUM(ISNULL(HT25.C148, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C148, SUM(ISNULL(HT25.C149, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C149, 
		SUM(ISNULL(HT25.C150, 0)*HT24.BaseSalary/' + STR(@DayPerMonth) + ') AS C150, HV14.Orders '

		SET @sFrom = '
		FROM HT3400 HT34 
		INNER JOIN HV1400 HV14 ON HV14.EmployeeID = HT34.EmployeeID and HV14.DivisionID = HT34.DivisionID
		INNER JOIN HT2400 HT24 ON HT24.EmployeeID = HT34.EmployeeID AND HT24.TranMonth = HT34.TranMonth 
								AND HT24.TranYear = HT34.TranYear and HT24.DivisionID = HT34.DivisionID 
		INNER JOIN AT1102 AT11 ON AT11.DepartmentID = HT34.DepartmentID 
		 WHERE HT34.DivisionID = ''' + @DivisionID + ''' AND 
		     HT34.TranMonth = ' + STR(@TranMonth) + ' AND
		     HT34.TranYear = ' + STR(@TranYear) + ' AND 
		     PayrollMethodID LIKE ''' + isnull(@PayrollMethodID,'') + ''' 
		 GROUP BY HT34.EmployeeID, FullName, FirstName, MiddleName, LastName, 
		     HT34.DivisionID, HT34.TranMonth, HT34.TranYear, HT34.DepartmentID, AT11.Departmentname, 
		     HT34.TeamID, HT24.BaseSalary, HT24.SalaryCoefficient, HT24.DutyCoefficient, HT24.TimeCoefficient, 
		     InsAmount, HeaAmount, TempAmount, 
		     TraAmount, TaxAmount, HV14.Orders'

--PRINT (@sSQL)
--PRINT (@sSelect1)
--PRINT (@sSelect2)
--PRINT (@sFrom)

IF NOT EXISTS (SELECT TOP 1 1 FROM SysObjects WHERE Xtype = 'V' AND Name = 'HV2510' )
    EXEC('---tao boi HP2509
        CREATE VIEW HV2510 AS ' + @sSQL+@sSelect1+@sSelect2+@sFrom)
ELSE
    EXEC('---tao boi HP2509
        ALTER VIEW HV2510 AS ' + @sSQL+@sSelect1+@sSelect2+@sFrom)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
