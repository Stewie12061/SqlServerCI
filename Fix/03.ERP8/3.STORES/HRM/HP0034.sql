IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0034]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP0034]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference> HRM/Nghiep vu/ Cham cong
---- Bang phan ca
-- <History>
---- Create on 
---- Modified on 

-- <Example>
---- EXEC HP0034 'CTY', 8, 2015, '000054', 'D'
CREATE PROCEDURE HP0034	
(
	@DivisionID Nvarchar(50),
	@TranMonth int,
	@TranYear int,
	@EmployeeID Nvarchar(50),
	@Mode Varchar(10)
)
AS

Declare @CustomerName INT,
		@sSQL Nvarchar(4000)

IF (EXISTS(	SELECT Top 1 1
				FROM HT2401 
				WHERE EmployeeID = @EmployeeID AND DivisionID = @DivisionID AND TranMonth = @TranMonth AND TranYear = @TranYear)


OR Exists(SELECT Top 1 1 FROM HT0284
						  WHERE  EmployeeID = @EmployeeID and 
									 DivisionID = @DivisionID and 
									 TranMonth=@TranMonth And 
									 TranYear=@TranYear)
		
OR Exists(SELECT Top 1 1 FROM HT2402 WHERE EmployeeID = @EmployeeID And DivisionID = @DivisionID 
					AND TranMonth = @TranMonth and TranYear = @TranYear)
)
BEGIN
	IF(@Mode = 'E')
		SELECT 1 AS Status, 'HFML000515' AS Message
	ELSE
		SELECT 1 AS Status, 'HFML000516' AS Message

	RETURN
END

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
IF @CustomerName = 50
	BEGIN
	SET @sSQL	= '
		IF EXISTS (	SELECT TOP 1 1 
					FROM OOT9000 OOT90 
					INNER JOIN OOT2000 OOT20 ON OOT90.APK = OOT20.APK 
					WHERE	OOT90.Status = 1 AND OOT20.EmployeeID = '''+@EmployeeID+''' 
							AND OOT20.DivisionID = '''+@DivisionID+''' AND OOT90.TranMonth = '+STR(@TranMonth)+' 
							AND OOT90.TranYear = '+STR(@TranYear)+')
		BEGIN
			IF('''+@Mode+''' = ''E'')
			SELECT 1 AS Status, ''HFML000517'' AS Message
		ELSE
			SELECT 1 AS Status, ''HFML000518'' AS Message
		END
		'
	EXEC (@sSQL)
	RETURN
	END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

