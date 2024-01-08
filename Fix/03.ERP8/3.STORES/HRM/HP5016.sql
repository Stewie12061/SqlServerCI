IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP5016]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP5016]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--- Create by Tiểu Mai on 24/02/2017
--- Purpose: Chấm công theo sản phẩm cho BourBon (CustomizeIndex = 38)
/*
 * 
 * 
 */

CREATE PROCEDURE HP5016
( 
		@DivisionID VARCHAR(50),
		@TranMonth INT,
		@TranYear INT,
		@PayrollMethodID NVARCHAR(50),
		@IncomeID NVARCHAR(50),
		@MethodID NVARCHAR(50),
		@Orders TINYINT,
		@IsIncome TINYINT
		
) 
AS 

IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N'tempdb.dbo.#HV5002')) 
	DROP TABLE #HV5016

CREATE TABLE #HV5016
(
	DivisionID NVARCHAR(50),
	EmployeeID NVARCHAR(50),
	TranMonth INT,
	TranYear INT,
	Amount DECIMAL(28,8)	
)	

INSERT INTO #HV5016 (DivisionID, EmployeeID, TranMonth, TranYear, Amount)
SELECT H11.DivisionID, H11.EmployeeID, H10.TranMonth, H10.TranYear, SUM(ISNULL(Amount,0)) AS Amount 
FROM HT0411 H11 WITH (NOLOCK)
LEFT JOIN HT0410 H10 WITH (NOLOCK) ON H10.DivisionID = H11.DivisionID AND H10.TrackingID = H11.TrackingID
WHERE H10.DivisionID = @DivisionID AND H10.TranMonth = @TranMonth AND H10.TranYear = @TranYear
GROUP BY H11.DivisionID, H11.EmployeeID, H10.TranMonth, H10.TranYear

If @Orders = 01
	BEGIN 
		IF @IsIncome = 1
			UPDATE HT3400 SET Income01 = H16.Amount --, IGAbsentAmount01 = ISNULL(@AbsentValues , 0)
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear
		ELSE
			UPDATE HT3400 SET SubAmount01 = H16.Amount 
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear                  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear                      
	END 				
ELSE IF  @Orders = 02
	BEGIN 
		IF @IsIncome = 1
			UPDATE HT3400 SET Income02 = H16.Amount --, IGAbsentAmount02 = ISNULL(@AbsentValues, 0)
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear
		ELSE
			UPDATE HT3400 SET SubAmount02 = H16.Amount  
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear                 
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear                      
	END 
ELSE  IF  @Orders = 03
	BEGIN 
		IF @IsIncome = 1
			UPDATE HT3400 SET Income03 = H16.Amount --, IGAbsentAmount03 = ISNULL(@AbsentValues, 0)
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear
		ELSE
			UPDATE HT3400 SET SubAmount03 = H16.Amount    
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear               
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear                      
	END 
Else If @Orders = 04
	Begin
		IF @IsIncome = 1
			UPDATE HT3400 SET Income04 = H16.Amount --, IGAbsentAmount04 = ISNULL(@AbsentValues, 0)
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear
		Else
			UPDATE HT3400 SET SubAmount04 = H16.Amount 
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear                  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear                      
	End
Else If @Orders = 05
	Begin
		IF @IsIncome = 1
			UPDATE HT3400 SET Income05 = H16.Amount --, IGAbsentAmount05 = ISNULL(@AbsentValues, 0)
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear
		Else
			UPDATE HT3400 SET SubAmount05 = H16.Amount  
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear                 
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear                      
	End
Else If @Orders = 06
	Begin
		IF @IsIncome = 1
			UPDATE HT3400 SET Income06 = H16.Amount --, IGAbsentAmount06 = ISNULL(@AbsentValues, 0)
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear
		Else
			UPDATE HT3400 SET SubAmount06 = H16.Amount 
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear                  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear                      
	End
Else If @Orders = 07
	Begin
		IF @IsIncome = 1
			UPDATE HT3400 SET Income07 = H16.Amount --, IGAbsentAmount07 = ISNULL(@AbsentValues, 0)
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear
		Else
			UPDATE HT3400 SET SubAmount07 = H16.Amount 
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear                  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear                      
	End
Else If @Orders = 08
	Begin
		IF @IsIncome = 1
			UPDATE HT3400 SET Income08 = H16.Amount --, IGAbsentAmount08 = ISNULL(@AbsentValues, 0)
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear
		Else
			UPDATE HT3400 SET SubAmount08 = H16.Amount 
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear                 
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear                      
	End
Else If @Orders = 09
	Begin
		IF @IsIncome = 1
			UPDATE HT3400 SET Income09 = H16.Amount --, IGAbsentAmount09 = ISNULL(@AbsentValues, 0)
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear
		Else
			UPDATE HT3400 SET SubAmount09 = H16.Amount
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear                   
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear                      
	End
Else If @Orders = 10
	Begin
		IF @IsIncome = 1
			UPDATE HT3400 SET Income10 = H16.Amount --, IGAbsentAmount10 = ISNULL(@AbsentValues, 0)
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear
		Else
			UPDATE HT3400 SET SubAmount10 = H16.Amount
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear                   
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear                      
	End
Else If @Orders = 11
	Begin
		IF @IsIncome = 1
			UPDATE HT3400 SET Income11 = H16.Amount --, IGAbsentAmount11 = ISNULL(@AbsentValues, 0)
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear
		Else
			UPDATE HT3400 SET SubAmount11 = H16.Amount
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear                   
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear                      
	End
Else If @Orders = 12
	Begin
		IF @IsIncome = 1
			UPDATE HT3400 SET Income12 = H16.Amount --, IGAbsentAmount12 = ISNULL(@AbsentValues , 0)
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear
		Else
			UPDATE HT3400 SET SubAmount12 = H16.Amount
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear                   
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear                      
	End
Else If @Orders = 13
	Begin
		IF @IsIncome = 1
			UPDATE HT3400 SET Income13 = H16.Amount --, IGAbsentAmount13 = ISNULL(@AbsentValues, 0)
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear
		Else
			UPDATE HT3400 SET SubAmount13 = H16.Amount 
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear                  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear                      
	End
Else If @Orders = 14
	Begin
		IF @IsIncome = 1
			UPDATE HT3400 SET Income14 = H16.Amount --, IGAbsentAmount14 = ISNULL(@AbsentValues, 0)
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear
		Else
			UPDATE HT3400 SET SubAmount14 = H16.Amount  
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear                 
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear                      
	End
Else If @Orders = 15
	Begin
		IF @IsIncome = 1
			UPDATE HT3400 SET Income15 = H16.Amount --, IGAbsentAmount15 = ISNULL(@AbsentValues, 0)
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear
		Else
			UPDATE HT3400 SET SubAmount15 = H16.Amount  
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear                 
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear                      
	End
Else If @Orders = 16
	Begin
		IF @IsIncome = 1
			UPDATE HT3400 SET Income16 = H16.Amount --, IGAbsentAmount16 = ISNULL(@AbsentValues, 0)
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear
		Else
			UPDATE HT3400 SET SubAmount16 = H16.Amount   
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear                
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear                      
	End
Else If @Orders = 17
	Begin
		IF @IsIncome = 1
			UPDATE HT3400 SET Income17 = H16.Amount --, IGAbsentAmount17 = ISNULL(@AbsentValues, 0)
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear
		Else
			UPDATE HT3400 SET SubAmount17 = H16.Amount 
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear                  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear             
	End
Else If @Orders = 18
	Begin
		IF @IsIncome = 1
			UPDATE HT3400 SET Income18 = H16.Amount --, IGAbsentAmount18 = ISNULL(@AbsentValues, 0)
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear
		Else
			UPDATE HT3400 SET SubAmount18 = H16.Amount   
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear                
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear                      
	End
Else If @Orders = 19
	Begin
		IF @IsIncome = 1
			UPDATE HT3400 SET Income19 = H16.Amount --, IGAbsentAmount19 = ISNULL(@AbsentValues, 0)
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear
		Else
			UPDATE HT3400 SET SubAmount19 = H16.Amount   
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear                
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear                      
	End
Else If @Orders = 20
	Begin
		IF @IsIncome = 1
			UPDATE HT3400 SET Income20 = H16.Amount --, IGAbsentAmount20 = ISNULL(@AbsentValues, 0)
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear
		Else
			UPDATE HT3400 SET SubAmount20 = H16.Amount  
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear                 
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear                      
	End
Else If @Orders = 21
	Begin
		IF @IsIncome = 1
		Begin
			UPDATE HT3400 SET Income21 = H16.Amount --, IGAbsentAmount21 = ISNULL(@AbsentValues, 0)
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear
		End
	End
Else If @Orders = 22
	Begin
		IF @IsIncome = 1
			UPDATE HT3400 SET Income22 = H16.Amount --, IGAbsentAmount22 = ISNULL(@AbsentValues, 0)
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear                
	End
Else If @Orders = 23
	Begin
		IF @IsIncome = 1
			UPDATE HT3400 SET Income23 = H16.Amount --, IGAbsentAmount23 = ISNULL(@AbsentValues, 0)
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear
	End
Else If @Orders = 24
	Begin
		IF @IsIncome = 1
			UPDATE HT3400 SET Income24 = H16.Amount --, IGAbsentAmount24 = ISNULL(@AbsentValues, 0)
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear                   
	End
Else If @Orders = 25
	Begin
		IF @IsIncome = 1
			UPDATE HT3400 SET Income25 = H16.Amount --, IGAbsentAmount25 = ISNULL(@AbsentValues, 0)
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear
	End
Else If @Orders = 26
	Begin
		IF @IsIncome = 1
			UPDATE HT3400 SET Income26 = H16.Amount --, IGAbsentAmount26 = ISNULL(@AbsentValues, 0)
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear
	End
Else If @Orders = 27
	Begin
		IF @IsIncome = 1
			UPDATE HT3400 SET Income27 = H16.Amount --, IGAbsentAmount27 = ISNULL(@AbsentValues, 0)
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear
	End
Else If @Orders = 28
	Begin
		IF @IsIncome = 1
			UPDATE HT3400 SET Income28 = H16.Amount --, IGAbsentAmount28 = ISNULL(@AbsentValues, 0)
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear
	End
Else If @Orders = 29
	Begin
		IF @IsIncome = 1
			UPDATE HT3400 SET Income29 = H16.Amount --, IGAbsentAmount29 = ISNULL(@AbsentValues, 0)
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear
	End
Else If @Orders = 30
	Begin
		IF @IsIncome = 1
			UPDATE HT3400 SET Income30 = H16.Amount --, IGAbsentAmount30 = ISNULL(@AbsentValues, 0)
			FROM HT3400
			LEFT JOIN #HV5016 H16 ON H16.DivisionID = HT3400.DivisionID AND H16.EmployeeID = HT3400.EmployeeID AND H16.TranMonth = HT3400.TranMonth AND H16.TranYear = HT3400.TranYear  
			WHERE HT3400.DivisionID = @DivisionID AND PayrollMethodID = @PayrollMethodID AND HT3400.TranMonth = @TranMonth AND HT3400.TranYear = @TranYear
	End

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
