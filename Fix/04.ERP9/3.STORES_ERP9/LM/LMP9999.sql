IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[LMP9999]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[LMP9999]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Khóa sổ Module LM
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 22/01/2018 by Phương Thảo
----Modify on
-- <Example>
/*  
 EXEC LMP9999 @DivisionID=N'AS',@TranMonth=1,@TranYear=2018,@BeginDate='2018-02-01 00:00:00',@EndDate='2018-02-28 00:00:00'
*/
----

CREATE PROCEDURE [dbo].[LMP9999] 
				@DivisionID nvarchar(50),
				@UserID  nvarchar(50),
				@TranMonth as int, 
				@TranYear as int,
				@BeginDate as datetime,
				@EndDate as datetime
	
 AS


Declare @Closing As TinyInt,
		@NextMonth 	Int,
		@NextYear 	int,
		@PeriodNum 	TinyInt,
		@MaxPeriod	Int 
	
	
	SELECT 	@PeriodNum = PeriodNum
	FROM	AT1101 ---AT0001
	
	If @PeriodNum Is Null 
		Set @PeriodNum = 12

	Set @NextMonth = @TranMonth % @PeriodNum + 1
	Set @NextYear = @TranYear + @TranMonth/@PeriodNum

	SELECT  @Closing = Closing
	From 	LMT9999
	Where 	DivisionID = @DivisionID And TranMonth = @TranMonth And TranYear = @TranYear
		
	Select 	@MaxPeriod = Max(TranMonth + TranYear * 100)
 	From	LMT9999
	Where	DivisionID = @DivisionID

	If  @Closing <> 1 
	Begin
		
		
		Update 	LMT9999
		Set 	Closing = 1
		From 	LMT9999
		Where 	DivisionID = @DivisionID And TranMonth =@TranMonth And TranYear = @TranYear

		IF	@MaxPeriod < (@NextMonth + @NextYear * 100)
		Begin
			INSERT  LMT9999  (TranMonth,TranYear, DivisionID,Closing, BeginDate, EndDate) 
			VALUES	(@NextMonth,@NextYear, @DivisionID,0,@BeginDate, @EndDate)			

		
		End
		
		IF	@MaxPeriod >= (@NextMonth + @NextYear * 100)
		Begin	
			UPDATE 	LMT9999
			SET 	BeginDate = @BeginDate,
					EndDate = @EndDate
			FROM 	LMT9999
			WHERE 	DivisionID = @DivisionID 
					AND TranMonth = @NextMonth 
					AND TranYear = @NextYear
		end


	
	End



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

