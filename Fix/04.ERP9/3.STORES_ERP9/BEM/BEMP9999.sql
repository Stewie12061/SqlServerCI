IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BEMP9999]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BEMP9999]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Khóa sổ kỳ kế toán module BEM
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Vĩnh Tâm, Date 02/06/2020
/*
	EXEC BEMP9999 'MK', 5, 2020, '2020-05-01', '2020-05-31'
 */

CREATE PROCEDURE [dbo].[BEMP9999]
			@DivisionID VARCHAR(50),
			@UserID VARCHAR(50),
			@TranMonth INT,
			@TranYear INT,
			@BeginDate DATETIME,
			@EndDate DATETIME
AS
BEGIN
	DECLARE @Closing BIT,
			@NextMonth TINYINT,
			@NextYear SMALLINT,
			@PeriodNum TINYINT,
			@MaxPeriod INT
	
	SELECT @PeriodNum = PeriodNum
	FROM AT1101 WITH (NOLOCK)
	WHERE DivisionID = @DivisionID
	
	IF @PeriodNum IS NULL
		SET @PeriodNum = 12

	SET @NextMonth = @TranMonth % @PeriodNum + 1
	SET @NextYear = @TranYear + @TranMonth / @PeriodNum

	SELECT  @Closing = Closing
	FROM 	BEMT9999 WITH (NOLOCK)
	WHERE 	DivisionID = @DivisionID AND TranMonth = @TranMonth AND TranYear = @TranYear
		
	SELECT 	@MaxPeriod = MAX(TranMonth + TranYear * 100)
 	FROM	BEMT9999 WITH (NOLOCK)
	WHERE	DivisionID = @DivisionID

	IF @Closing <> 1 
	BEGIN
		UPDATE 	BEMT9999
		SET 	Closing = 1
		FROM 	BEMT9999 WITH (NOLOCK)
		WHERE 	DivisionID = @DivisionID AND TranMonth = @TranMonth AND TranYear = @TranYear

		IF	@MaxPeriod < (@NextMonth + @NextYear * 100)
		BEGIN
			INSERT BEMT9999 (TranMonth,TranYear, DivisionID, Closing, BeginDate, EndDate)
			VALUES (@NextMonth, @NextYear, @DivisionID,0, @BeginDate, @EndDate)

			IF EXISTS (SELECT 1 FROM BEMT0000 WITH (NOLOCK) WHERE DivisionID = @DivisionID)
			BEGIN
				UPDATE BEMT0000
				SET TranMonth = @NextMonth, TranYear = @NextYear
				WHERE DivisionID = @DivisionID
			END
		END
	END
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
