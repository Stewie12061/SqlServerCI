DECLARE @Cur CURSOR,
		@DivisionID VARCHAR(50),
		@TranMonth INT,
		@TranYear INT

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT MIN(TranMonth) TranMonth, MIN(TranYear) TranYear,AT1101.DivisionID
FROM HV9999,AT1101
GROUP BY AT1101.DivisionID
OPEN @Cur
FETCH NEXT FROM @Cur INTO @TranMonth, @TranYear,@DivisionID
WHILE @@FETCH_STATUS = 0
BEGIN	
		
	IF NOT EXISTS (SELECT TOP 1 1 FROM OOT0010 WHERE DivisionID=@DivisionID)
	BEGIN
		INSERT INTO OOT0010(DivisionID, TranMonth, TranYear, AbsentType, [Level],
		            CreateUserID, CreateDate, LastModifyUserID, LastModifyDate,VoucherTypeID)
		SELECT @DivisionID,@TranMonth,@TranYear,ID,1,
			  'ASOFTADMIN',GETDATE(),'ASOFTADMIN',GETDATE(),ID
		FROM OOT0099
		WHERE CodeMaster='Applying'
	END
	
	FETCH NEXT FROM @Cur INTO @TranMonth, @TranYear,@DivisionID
END 
CLOSE @Cur