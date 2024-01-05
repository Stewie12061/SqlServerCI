DECLARE @DivisionID VARCHAR(50), 
		@cur_AllDivision CURSOR

SET @cur_AllDivision = CURSOR SCROLL KEYSET FOR
SELECT DivisionID FROM AT1101

OPEN @cur_AllDivision
FETCH NEXT FROM @cur_AllDivision INTO @DivisionID
WHILE @@FETCH_STATUS = 0
  BEGIN	
	IF EXISTS (SELECT TOP 1 1 FROM sysObjects WHERE XType = 'U' and Name = 'CRMT00000')
	BEGIN
		IF NOT EXISTS (SELECT  TOP 1 1 FROM CRMT00000 WHERE DivisionID = @DivisionID)
		INSERT  CRMT00000  (DivisionID, TranMonth, TranYear)
		SELECT DivisionID, BeginMonth, BeginYear
		FROM AT1101 WHERE DivisionID = @DivisionID
	END
	
	FETCH NEXT FROM @cur_AllDivision INTO @DivisionID
  END
CLOSE @cur_AllDivision


