﻿-- <Summary>
---- 
-- <History>
---- Create on 05/07/2019 by Như Hàn
---- Modified on ... by 
-- <Example>
DECLARE @DivisionID NVarchar(50)

DECLARE cur_AllDivision CURSOR FOR
SELECT AT1101.DivisionID FROM AT1101

OPEN cur_AllDivision
FETCH NEXT FROM cur_AllDivision INTO @DivisionID

WHILE @@fetch_status = 0
  BEGIN
	
	If exists(Select Top 1 1 From sysObjects Where XType = 'U' and Name = 'LMT0000')
	Begin
		If not Exists (Select 1 From LMT0000 where DefDivisionID = @DivisionID)
		Insert  LMT0000  (DefDivisionID, DefTranMonth, DefTranYear)
		Select DivisionID, BeginMonth, BeginYear
		From AT1101 where DivisionID=@DivisionID
	End
	If exists(Select Top 1 1 From sysObjects Where XType = 'U' and Name = 'LMT9999')
	Begin
		If not Exists (Select 1 From LMT9999 where DivisionID = @DivisionID)
		Insert  LMT9999  (DivisionID, TranMonth, TranYear, Disabled,  BeginDate, EndDate )
		Select DivisionID, BeginMonth, BeginYear, 0, ltrim(rtrim(str(BeginMonth)))+'/01/'+ltrim(rtrim(str(BeginYear))) , DATEADD(day, -1, DATEADD(MONTH, 1, ltrim(rtrim(str(BeginMonth))) + '/01/' + ltrim(rtrim(str(BeginYear)))))
		From AT1101 where DivisionID=@DivisionID
	End
	
    FETCH NEXT FROM cur_AllDivision INTO @DivisionID
  END
  
CLOSE cur_AllDivision
DEALLOCATE cur_AllDivision

