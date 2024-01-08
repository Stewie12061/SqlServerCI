IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0515]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0515]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load sản phẩm trả về (NEWTOYO)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Khả Vi, Date: 23/09/2017
---- Modified by Bảo Thy on 27/09/2017: Bổ sung load tổng tiền trừ hàng trả về
-- <Example>
---- 
/*-- <Example>
	EXEC [HP0515] @DivisionID= 'CH', @FromDepartment='PB1',
	@ToDepartment = 'Z1', @TeamID = '', @TranMonth = 5, @TranYear = 2017, 
	@IsMode = 0, @TransactionID= '131af9fe-b521-4e6d-a882-3cac539695cd'
	
----*/
CREATE PROCEDURE HP0515
( 
	 @DivisionID VARCHAR(50),
	 @FromDepartment VARCHAR(50), 
	 @ToDepartment VARCHAR(50), 
	 @TeamID VARCHAR(50),
	 @TranMonth INT,
	 @TranYear INT,
	 @IsMode TINYINT, --- 0 Load edit 
					-- 1 Load truy vấn
	 @TransactionID VARCHAR(50)
)

AS 

DECLARE @sSQL NVARCHAR (MAX)=N'', 
		@sWhere NVARCHAR(MAX)=N'',
        @OrderBy NVARCHAR(500)=N'', 
		@Period INT = 0

SET @OrderBy = 'HT1116.EmployeeID'
SET @Period = (@TranMonth + @TranYear * 100)
SET @sWhere = @sWhere + ' HT1116.DivisionID = '''+@DivisionID+''' AND (HT1116.TranMonth + HT1116.TranYear * 100) = '+STR(@Period)+' '


IF (@IsMode = 1)
BEGIN 

	IF (@FromDepartment IS NOT NULL AND @ToDepartment IS NULL) SET @sWhere = @sWhere + '
	AND HT1400.DepartmentID  >= '''+@ToDepartment+''' '
	IF (@FromDepartment IS NULL AND @ToDepartment IS NOT NULL) SET @sWhere = @sWhere + '
	AND HT1400.DepartmentID <= '''+@ToDepartment+''' '
	IF (@FromDepartment IS NOT NULL AND @ToDepartment IS NOT NULL) SET @sWhere = @sWhere + '
	AND HT1400.DepartmentID BETWEEN '''+@FromDepartment+''' AND '''+@ToDepartment+''' '
	IF ISNULL(@TeamID,'') <> '' SET @sWhere = @sWhere + '
	AND ISNULL(HT1400.TeamID,'''') LIKE ''%'+@TeamID+'%'' '



	SET @sSQL= N'
	SELECT DISTINCT HT1116.TransactionID, HT1116.DivisionID, HT1116.EmployeeID,
	(CASE 
		WHEN MiddleName = '''' THEN LTRIM(RTRIM(ISNULL(HT1400.LastName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HT1400.FirstName,''''))) 
		WHEN MiddleName <> '''' THEN LTRIM(RTRIM(ISNULL(HT1400.LastName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HT1400.MiddleName,''''))) + '' '' +  LTRIM(RTRIM(ISNULL(HT1400.FirstName,''''))) 
		WHEN MiddleName IS NULL THEN LTRIM(RTRIM(ISNULL(HT1400.LastName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HT1400.FirstName,''''))) 
	END) AS EmployeeName, HT1116.RepayTotalAmount, HT1116.RemainAmount, HT1116.CreateUserID, HT1116.CreateDate, 
	HT1116.LastModifyUserID, HT1116.LastModifyDate
	FROM HT1116 WITH (NOLOCK)
	INNER JOIN HT1400 WITH (NOLOCK) ON HT1116.EmployeeID = HT1400.EmployeeID AND HT1116.DivisionID = HT1400.DivisionID
	WHERE '+@sWhere+'
	ORDER BY '+@OrderBy+'
	'
END 


IF (@IsMode = 0)
BEGIN 
	SET @sWhere = @sWhere + 'AND HT1116.TransactionID = '''+@TransactionID+''' '
	SET @sSQL= N'
	SELECT DISTINCT HT1116.TransactionID, HT11161.APKMaster,HT1116.DivisionID, HT1116.EmployeeID,
	(CASE 
		WHEN MiddleName = '''' THEN LTRIM(RTRIM(ISNULL(HT1400.LastName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HT1400.FirstName,''''))) 
		WHEN MiddleName <> '''' THEN LTRIM(RTRIM(ISNULL(HT1400.LastName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HT1400.MiddleName,''''))) + '' '' +  LTRIM(RTRIM(ISNULL(HT1400.FirstName,''''))) 
		WHEN MiddleName IS NULL THEN LTRIM(RTRIM(ISNULL(HT1400.LastName,''''))) + '' '' + LTRIM(RTRIM(ISNULL(HT1400.FirstName,''''))) 
	END) AS EmployeeName, HT11161.MachineID, HT1109.MachineName, HT11161.RepayQuantity, HT11161.RepayAmount, 
	HT1116.RepayTotalAmount, HT1116.RemainAmount, HT11161.Notes, HT1116.CreateUserID, HT1116.CreateDate, 
	HT1116.LastModifyUserID, HT1116.LastModifyDate
	FROM HT1116 WITH (NOLOCK)
	INNER JOIN HT1400 WITH (NOLOCK) ON HT1116.EmployeeID = HT1400.EmployeeID AND HT1116.DivisionID = HT1400.DivisionID
	INNER JOIN HT11161 WITH (NOLOCK) ON HT1116.TransactionID = HT11161.APKMaster AND HT1116.DivisionID = HT11161.DivisionID
	INNER JOIN HT1109 WITH (NOLOCK) ON HT11161.MachineID = HT1109.MachineID AND HT11161.DivisionID = HT1109.DivisionID
	WHERE '+@sWhere+'
	ORDER BY '+@OrderBy+'
	'
END 

--PRINT @sSQL

EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
