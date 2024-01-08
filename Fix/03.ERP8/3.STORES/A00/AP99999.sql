IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AP99999]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP99999]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/********************************************
-- <Summary>
--- Phát sinh tự động kỳ kế toán bị thiếu
-- <Param>
----
-- <Return>
----
-- <Reference>
'********************************************/
-- <Example>
--EXEC AP99999 @DivisionID=@DivisionID, @MaxPeriod=@MaxPeriod, @PeriodNum=@PeriodNum, @ModuleID =N'ASOFTM', @TableName=N'MT9999', @UserID=N'ASOFTADMIN', @CheckPeriod=@CheckPeriod

-- <History>
----- Create on 14/12/2022 by Đức Tuyên: Bổ sung phát sinh kỳ bị thiếu do sinh kỳ tự động trên ERP9.   

CREATE PROCEDURE [dbo].[AP99999] 
				@DivisionID nvarchar(20),
				@MaxPeriod as Int,
				@PeriodNum as TinyInt,
				@ModuleID as nvarchar(50),
				@TableName as nvarchar(50),
				@UserID NVARCHAR(50),
				@CheckPeriod as Int =0

AS

DECLARE 
	@sSQL VARCHAR (MAX) = ''
	
IF @CheckPeriod = 2 AND ISNULL(@TableName,'') <> ''
BEGIN
	SET @sSQL = N'
	DECLARE 
		@TempPeriod	Int,
		@TempDate DateTime,
		@TempTranMonth INT,
		@TempTranYear INT,
		@DataID NVARCHAR(50),
		@DataType NVARCHAR(50) = N''PE'',
		@DataName NVARCHAR(250),
		@GroupID NVARCHAR(50) = N''PE'',
		@GivenDate datetime = GETDATE()

	-- Lấy Kỳ đầu tiên --
	SELECT		TOP 1 @TempPeriod = (TranMonth + TranYear * 100)
					, @TempTranMonth = TranMonth
					, @TempTranYear = TranYear
	FROM		'+@TableName+' WITH(NOLOCK)
	WHERE		DivisionID = N''EXV''
	ORDER BY	CONVERT(DATE, (LTRIM(TranYear) + ''-'' + (CASE WHEN TranMonth < 10 THEN ''0''+LTRIM(TranMonth) ELSE LTRIM(TranMonth) END) + ''-''+ ''01''), 126)
	
	-- Kiểm tra và bổ sung các kỳ bị thiếu --
	--PRINT(@TempPeriod)
	WHILE(@TempPeriod <= '+LTRIM(@MaxPeriod)+')
	BEGIN
		SET @TempDate = CONVERT(DATETIME, (LTRIM(@TempTranYear) + ''-'' + (CASE WHEN @TempTranMonth < 10 THEN ''0''+LTRIM(@TempTranMonth) ELSE LTRIM(@TempTranMonth) END) + ''-''+ ''01''), 126)
		SET @DataID = (CASE WHEN @TempTranMonth < 10 THEN ''0''+LTRIM(@TempTranMonth) ELSE LTRIM(@TempTranMonth) END) + ''/'' + LTRIM(@TempTranYear)
	
		-- Kiểm tra và phát sinh kỳ --
		IF NOT EXISTS (SELECT TOP 1 1 FROM '+@TableName+' WITH(NOLOCK) WHERE TranMonth = @TempTranMonth AND TranYear = @TempTranYear)
		BEGIN
			INSERT		'+@TableName+'  (TranMonth,TranYear, DivisionID,Closing, BeginDate, EndDate) 
				VALUES		(@TempTranMonth,@TempTranYear, '''+@DivisionID+''',0,DATEADD(MM,DATEDIFF(MM, 0, @TempDate),0),DATEADD(MM,DATEDIFF(MM, -1, @TempDate),-1))
			IF EXISTS (SELECT 1 FROM AT0000 WHERE DefDivisionID = '''+@DivisionID+''')
			BEGIN
				UPDATE	MT0000
				SET		TranMonth = @TempTranMonth,
						TranYear = @TempTranYear			
			END
		END
	
		-- Kiểm tra và phát sinh phân quyền của kỳ --
		IF NOT EXISTS (SELECT DivisionID + ModuleID + DataID + DataType FROM AT1407 WHERE DivisionID + ModuleID + DataID + DataType = '''+@DivisionID+''' + '''+@ModuleID+''' + @DataID + @DataType)
	    BEGIN
			INSERT INTO AT1407(DivisionID, ModuleID, DataID, DataName, DataType, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID)
				SELECT DISTINCT '''+@DivisionID+''', '''+@ModuleID+''', @DataID, @DataName, @DataType, GETDATE(), '''+@UserID+''', GETDATE(), '''+@UserID+'''    
	    END
	    IF NOT EXISTS (SELECT DivisionID + ModuleID + DataID + DataType FROM AT1406 WHERE DivisionID + ModuleID + DataID + DataType = '''+@DivisionID+''' + '''+@ModuleID+''' + @DataID + @DataType)
	    BEGIN
			INSERT INTO AT1406(DivisionID, ModuleID, GroupID, DataID, DataType, Permission, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID) 
				SELECT DISTINCT '''+@DivisionID+''', '''+@ModuleID+''', GroupID, @DataID, @DataType, 1, GETDATE(), '''+@UserID+''', GETDATE(), '''+@UserID +'''
				FROM AT1401 
					INNER JOIN AT1409 ON AT1409.DivisionID =  AT1401.DivisionID 
				WHERE AT1401.DivisionID =  '''+@DivisionID+'''  
	    END
		ELSE IF NOT EXISTS (SELECT DivisionID + ModuleID + DataID + DataType + GroupID FROM AT1406 WHERE DivisionID + ModuleID + DataID + DataType + GroupID= '''+@DivisionID+''' + '''+@ModuleID+''' + @DataID + @DataType + @GroupID)
	    BEGIN
			INSERT INTO AT1406(DivisionID, ModuleID, GroupID, DataID, DataType, Permission, CreateDate, CreateUserID, LastModifyDate, LastModifyUserID) 
				SELECT DISTINCT '''+@DivisionID+''', '''+@ModuleID+''', GroupID, @DataID, @DataType, 1, GETDATE(), '''+@UserID+''', GETDATE(), '''+@UserID +'''
				FROM AT1401 
					INNER JOIN AT1409 ON AT1409.DivisionID =  AT1401.DivisionID 
				WHERE AT1401.DivisionID =  '''+@DivisionID+'''  AND AT1401.GroupID = @GroupID
	    END
		SET @TempTranYear = @TempTranYear + @TempTranMonth/'+LTRIM(@PeriodNum)+'
		SET @TempTranMonth = @TempTranMonth % '+LTRIM(@PeriodNum)+' + 1
		SET	@TempPeriod = (@TempTranMonth + @TempTranYear * 100)
	END'
END

--PRINT(@sSQL)
EXEC(@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON