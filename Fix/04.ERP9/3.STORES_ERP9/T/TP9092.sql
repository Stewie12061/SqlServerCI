IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[TP9092]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[TP9092]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
----<Summary>
---- Đổ nguồn kỳ ngân sách
---- 
----<Param>
---- 
----<Return>
---- 
----<Reference>
----
----<History>
----<Created by>: Như Hàn, Date: 29/10/2018
---- Modified by ... on ...:
----<Example>
/*
	EXEC TP9092 'AIC1','Y', 1, 2020, 1
	EXEC TP9092 @DivisionID, @BudgetType, @Mode, @Year, @Month
*/
CREATE PROCEDURE [dbo].[TP9092] 	
(
	@DivisionID VARCHAR(50),
	@BudgetType NVARCHAR(50), 
	@Mode INT = '', 
	@Year INT = '',
	@Month INT = ''
)
AS

IF ISNULL(@Mode,0) = 0
BEGIN
	CREATE TABLE #MONTH (MM Int)
	CREATE TABLE #YEAR (YYYY Int)

	DECLARE @IM int = 0, @IY int = 0, @Y Int = Year(GetDate())

	WHILE @IM >= 0  AND (CASE WHEN ISNULL(@BudgetType,'') = 'M' THEN 12 ELSE 4 END) > @IM
				BEGIN 
					SET @IM= @IM+1
					INSERT INTO #MONTH (MM)
					VALUES (@IM)
				END  
	WHILE @IY >= 0  AND @IY < 10
				BEGIN 
					INSERT INTO #YEAR (YYYY)
					VALUES (@Y)
					SET @Y = @Y+1
					SET @IY = @IY+1
				END  

	IF @BudgetType IN ('M','Q')
	BEGIN
		SELECT MM As Month FROM #MONTH
		SELECT YYYY As Year FROM #YEAR
	END
	ELSE
	BEGIN
		SELECT '' AS Month
		SELECT YYYY As Year FROM #YEAR
	END

	DROP TABLE #MONTH
	DROP TABLE #YEAR
END
ELSE IF ISNULL(@Mode,0) = 1
BEGIN

	SELECT CASE WHEN  MONTH(STARTDATE) + (3 * (@Month -1)) > 12  
    THEN MONTH(STARTDATE) + (3 * (@Month -1)) - 12
    ELSE MONTH(STARTDATE) + (3 * (@Month -1))
    END [TranMonth], DivisionID, Year(STARTDATE) YearStart, Year(EndDate) YearEnd
	 INTO #AT1101
    FROM AT1101 WHERE DivisionID = @DivisionID

	SELECT *,
	CASE WHEN (YearStart != YearEnd AND @Month = 4) THEN @Year + 1 ELSE @Year END TranYear
	FROM #AT1101

END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

