IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2023]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2023]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load thông tin detail Đơn xin phép ra ngoài
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 10/12/2015
---- Modified on 07/12/2016 by Bảo Thy: Bổ sung FromWorkingDate, ToWorkingDate
-- <Example>
---- 
/*
   EXEC OOP2023 @DivisionID='MK',@UserID='ASOFTADMIN',@PageNumber=1,@PageSize=25,@APKMaster='68E5CD07-A5E5-4E0A-BDBA-E1D5E86BE682',@TranMonth=11,@TranYear=2015
   EXEC OOP2023 @DivisionID='CTY',@UserID='ASOFTADMIN',@PageNumber=NULL,@PageSize=25,@APKMaster='D5AC58CE-7ED5-43EE-9084-6BDD78AFA34C',@TranMonth=8,@TranYear=2015
*/
CREATE PROCEDURE OOP2023
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
SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, *
	FROM
	(
	SELECT
		OOT22.APK, OOT22.APKMaster, OOT90.DivisionID,
		HT14.EmployeeID,HT14.FullName EmployeeName,
		OOT22.Reason, OOT22.Place, OOT22.GoFromDate, OOT22.GoStraight, OOT22.GoToDate, OOT22.ComeStraight, 
		OOT22.Status, OOT22.Note, OOT22.DeleteFlag, 0 AS FormStatus, OOT22.FromWorkingDate, OOT22.ToWorkingDate
	FROM OOT9000 OOT90 
	INNER JOIN OOT2020 OOT22 ON OOT22.DivisionID = OOT90.DivisionID AND OOT90.APK = OOT22.APKMaster
	INNER JOIN HV1400 HT14 ON HT14.DivisionID = OOT22.DivisionID AND HT14.EmployeeID = OOT22.EmployeeID 
		WHERE OOT90.Type=''DXRN''
		--AND OOT90.TranMonth = '+STR(@TranMonth)+'
		--AND OOT90.TranYear = '+STR(@TranYear)+'
		AND OOT90.DivisionID = '''+@DivisionID+'''
		AND OOT90.APK = '''+@APKMaster+'''
	)BT
		
ORDER BY '+@OrderBy+'
'+@sSQL1
	
EXEC (@sSQL)
--PRINT(@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
