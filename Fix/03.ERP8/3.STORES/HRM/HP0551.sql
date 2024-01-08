IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0551]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0551]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Thực hiện bỏ chấm công (MAITHU)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Lê Hoàng, Date: 19/05/2021
/*-- <Example>
	HP0551 @DivisionID = 'VF', @StrDivisionID = '', @UserID = 'ASOFTADMIN', @TranMonth = 12, @TranYear = 2017, @DepartmentID = '', @TeamID = '', @EmployeeID = '', 
	@FromProductID = '', @ToProductID = ''

	HP0551 @DivisionID, @UserID, @StrDivisionID, @TranMonth, @TranYear, @DepartmentID, @TeamID, @EmployeeID, @FromProductID, @ToProductID
----*/

CREATE PROCEDURE HP0551
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50), 
	@ProducingProcessID VARCHAR(MAX),
	@PhaseID VARCHAR(50),
	@IsAllProcess INT,
	@IsDate INT,
	@TranMonth INT,
	@TranYear INT,
	@Date DATETIME
)

AS 
DECLARE @sSQL NVARCHAR(MAX) = N'', 
		@sWhere NVARCHAR(MAX) = N''

IF @IsDate = 0
BEGIN
    IF @IsAllProcess = 0
	BEGIN
		DELETE FROM HT1904_MT WHERE DivisionID = @DivisionID 
		AND ProducingProcessID = @ProducingProcessID AND PhaseID = @PhaseID
		AND TranMonth = @TranMonth AND TranYear = @TranYear
	END
	ELSE
	BEGIN
		DELETE FROM HT1904_MT WHERE DivisionID = @DivisionID 
		AND ProducingProcessID = @ProducingProcessID
		AND TranMonth = @TranMonth AND TranYear = @TranYear
	END
END
ELSE
BEGIN
	IF @IsAllProcess = 0
	BEGIN
		DELETE FROM HT1904_MT WHERE DivisionID = @DivisionID 
		AND ProducingProcessID = @ProducingProcessID AND PhaseID = @PhaseID
		AND CONVERT(DATE,TimekeepingDate) = CONVERT(DATE,@Date)
	END
	ELSE
	BEGIN
		DELETE FROM HT1904_MT WHERE DivisionID = @DivisionID 
		AND ProducingProcessID = @ProducingProcessID 
		AND CONVERT(DATE,TimekeepingDate) = CONVERT(DATE,@Date)
	END
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
