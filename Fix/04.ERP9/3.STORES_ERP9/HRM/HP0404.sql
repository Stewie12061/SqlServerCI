IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0404]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0404]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load danh sách hồ sơ phép thiết lập phương pháp tính phép (ERP 9.0)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Tiểu Mai on 12/12/2016
----Modified by: Văn Tài on 19/08/2021: Bổ sung trường hợp nhân viên không có tổ nhóm.
-- <Example>
---- 
/*-- <Example>
	EXEC HP0404 @DivisionID='ANG',@TranMonth=1,@TranYear=2016,@MethodVacationID=NULL,@ListDepartmentID=N'''def'',''xyz''',@ListTeamID=N'%'
----*/

CREATE PROCEDURE HP0404
( 
	 @DivisionID VARCHAR(50),
	 @TranMonth INT,
	 @TranYear INT,
	 @MethodVacationID NVARCHAR(50), --- NULL: Lưới chưa thiết lập
	 @ListDepartmentID NVARCHAR(MAX),
	 @ListTeamID NVARCHAR(MAX)
)
AS 
DECLARE @sSQL NVARCHAR (MAX)

set @sSQL = ''

SET @sSQL = 'SELECT HT2803.EmpLoaMonthID, HT2803.EmployeeID, HV1400.FullName 
	FROM HT2803 WITH (NOLOCK)
	LEFT JOIN HV1400 ON HV1400.DivisionID = HT2803.DivisionID AND HV1400.EmployeeID = HT2803.EmployeeID
	WHERE HT2803.DivisionID = '''+@DivisionID+''' 
		AND Isnull(HT2803.MethodVacationID,'''') = '''+ISNULL(@MethodVacationID,'')+''' 
		AND HT2803.TranMonth = '+Convert(nvarchar(5),@TranMonth)+' AND HT2803.TranYear = '+Convert(Nvarchar(8),@TranYear)

IF Isnull(@ListDepartmentID,'%') = '%'
BEGIN
	SET @sSQL = @sSQL + '
	 AND HV1400.DepartmentID LIKE ''%''	'
END 
ELSE   
	BEGIN
		SET @sSQL = @sSQL + '
		 AND HV1400.DepartmentID IN ('''+@ListDepartmentID+''') '
	END
 
IF Isnull(@ListTeamID,'%') = '%'
BEGIN
	SET @sSQL = @sSQL + '
	 AND HV1400.TEAMID LIKE ''%''	'
END 
ELSE   
	BEGIN
		SET @sSQL = @sSQL + '
		 AND (HV1400.TEAMID IN ('''+@ListTeamID+''') OR ISNULL(HV1400.TEAMID, '''') = '''') '
	END          		

PRINT @sSQL
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
