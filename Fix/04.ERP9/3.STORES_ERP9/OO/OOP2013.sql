IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[OOP2013]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[OOP2013]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load thông tin detail Đơn xin nghỉ phép
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 08/12/2015
---- Modified on 20/06/2016 by Bảo Thy: Bổ sung ca làm việc, bỏ load trường loại phép
---- Modified on 07/12/2016 by Bảo Thy: Bổ sung FromWorkingDate, ToWorkingDate, IsNextDay
---- Modified on 18/01/2017 by Bảo Thy: Bổ sung IsNextDay
---- Modified on 28/06/2017 by Phương Thảo: Bổ sung IsValid (đơn hợp lệ theo quy định ĐTVS)
-- <Example>
---- 
/*
exec OOP2013 @DivisionID=N'MK',@UserID=N'000054',@APKMaster=N'B10ED011-66BA-4015-9C79-42423DD28AE4',@tranMonth=10,@TranYear=2016,@PageNumber=1,@PageSize=10
*/
CREATE PROCEDURE OOP2013
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@PageNumber INT,
	@PageSize INT,
	@APKMaster VARCHAR(50),
	@TranMonth INT,
	@TranYear INT
)
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
		@TotalRow NVARCHAR(50) = ''

SET @OrderBy = ' BT.EmployeeID'
IF @PageNumber IS NULL 
BEGIN
	SET  @sSQL1=''
	SET @TotalRow = 'NULL'	
END
ELSE if @PageNumber = 1 
BEGIN
SET @TotalRow = 'COUNT(*) OVER ()'
SET @sSQL1 = 'OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			  FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
END
ELSE 
BEGIN
	SET @TotalRow = 'NULL'
	SET @sSQL1 = 'OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			  FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
END
 	

SET @sSQL = '
SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, BT.*
	FROM
	(
SELECT
		OOT21.APK, OOT21.APKMaster, OOT90.DivisionID,
		HT14.EmployeeID,HT14.FullName EmployeeName,
		OOT21.Reason, OOT21.AbsentTypeID, OOT1000.Description AS AbsentTypeName,
		OOT21.ShiftID, OOT21.OldShiftID,
		OOT21.LeaveFromDate, OOT21.LeaveToDate, OOT21.TotalTime, OOT21.Status, OOT21.Note, OOT21.DeleteFlag,
		CONVERT(DECIMAL(28,2),ISNULL(C.OffsetTime,0)) OffsetTime, 0.0 AS TimeAllowance,0.0 OvertTime,0.0 OvertTimeNN,0.0 OvertTimeCompany, 0 AS FormStatus,
		OOT21.FromWorkingDate, OOT21.ToWorkingDate, OOT21.IsNextDay, ISNULL(OOT21.IsValid,0) AS IsValid
FROM OOT9000 OOT90 WITH (NOLOCK)
	INNER JOIN OOT2010 OOT21 WITH (NOLOCK) ON OOT21.DivisionID = OOT90.DivisionID AND OOT21.APKMaster = OOT90.APK
	INNER JOIN HV1400 HT14 ON HT14.DivisionID = OOT90.DivisionID AND HT14.EmployeeID = OOT21.EmployeeID
	LEFT JOIN OOT1000 ON OOT1000.DivisionID=OOT90.DivisionID AND OOT21.AbsentTypeID=OOT1000.AbsentTypeID
	LEFT JOIN 
	(SELECT ISNULL(SUM(CASE UnitID WHEN ''H'' THEN AbsentAmount
					WHEN ''D'' THEN (AbsentAmount*8)
					END),0) OffsetTime, A.EmployeeID, A.DivisionID
	FROM HT2401 A WITH (NOLOCK)
	LEFT JOIN HT1013 B WITH (NOLOCK) ON A.DivisionID=B.DivisionID AND A.AbsentTypeID=B.AbsentTypeID
	WHERE TypeID =''NB'' AND ISNULL(B.IsMonth,0)=0
		AND A.AbsentDate <= GETDATE() 
    GROUP BY A.EmployeeID,A.DivisionID
	)C ON C.DivisionID = HT14.DivisionID AND C.EmployeeID =HT14.EmployeeID
		
	WHERE OOT90.Type=''DXP''
		--AND OOT90.TranMonth = '+STR(@TranMonth)+'
		--AND OOT90.TranYear = '+STR(@TranYear)+'
		AND OOT90.DivisionID = '''+@DivisionID+'''
		AND OOT90.APK = '''+@APKMaster+'''
	)BT
		
ORDER BY '+@OrderBy+' '+@sSQL1
	
EXEC (@sSQL)
--PRINT(@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

