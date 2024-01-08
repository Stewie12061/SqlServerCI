DECLARE @DivisionID VARCHAR(50), 
		@cur_AllDivision CURSOR

SET @cur_AllDivision = CURSOR SCROLL KEYSET FOR
SELECT DivisionID FROM AT1101

OPEN @cur_AllDivision
FETCH NEXT FROM @cur_AllDivision INTO @DivisionID
WHILE @@FETCH_STATUS = 0
  BEGIN	
	IF EXISTS (SELECT TOP 1 1 FROM sysObjects WHERE XType = 'U' and Name = 'POST0000')
	BEGIN
		IF NOT EXISTS (SELECT  TOP 1 1 FROM POST0000 WHERE DivisionID = @DivisionID)
		INSERT  POST0000  (DivisionID, TranMonth, TranYear)
		SELECT DivisionID, BeginMonth, BeginYear
		FROM AT1101 WHERE DivisionID = @DivisionID
	END
	IF EXISTS(SELECT TOP 1 1 FROM sysObjects WHERE XType = 'U' and Name = 'POST0000')
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM POST9999 WHERE DivisionID = @DivisionID)
		INSERT  POST9999  (DivisionID, TranMonth, TranYear, [Disabled],  BeginDate, EndDate )
		SELECT DivisionID, BeginMonth, BeginYear, 0, LTRIM(RTRIM(STR(BeginMonth)))+'/01/'+LTRIM(RTRIM(STR(BeginYear))) , 
		DATEADD(DAY, -1, DATEADD(MONTH, 1, LTRIM(RTRIM(STR(BeginMonth))) + '/01/' + LTRIM(RTRIM(STR(BeginYear)))))
		FROM AT1101 WHERE DivisionID = @DivisionID
	END
	FETCH NEXT FROM @cur_AllDivision INTO @DivisionID
  END
  
CLOSE @cur_AllDivision


