IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP1598]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP1598]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-------- Created BY Nguyen Quoc Huy, Date 2.10.2006
-------- In Tinh hinh tang giam tai san co dinh
-------Last Edit Thuy Tuyen, date : 22/09/2007
----Them truong TotalAmount de ho tro man hinh hien thi du lieu truoc khi in
--- Lasted Update BY Van Nhan, Date 24/10/2007

/**********************************************
** Edited BY: [GS] [Cẩm Loan] [29/07/2010]
***********************************************/
---- Modified on 03/09/2013 by Le Thi Thu Hien : Khong luu vao bang AT1597 tự sinh các trường trong bang tam
---- Modified by Tiểu Mai on 16/06/2017: Fix bug in báo cáo lỗi do trùng cột vì có nhiều dữ liệu theo DivisionID giống nhau


CREATE PROCEDURE [dbo].[AP1598]
    @DivisionID NVARCHAR(50), 
    @TranMonthFrom INT, 
    @TranYearFrom INT, 
    @TranMonthTo INT, 
    @TranYearTo INT, 
    @ReportCode NVARCHAR(50)
AS

DECLARE 
@AT1599Cursor CURSOR, 
@AT1501Cursor CURSOR, 
@LineID NVARCHAR(50), 
@AccountIDFrom NVARCHAR(50), 
@AccountIDTo NVARCHAR(50), 
@Method NVARCHAR(50), 
@TypeValues NVARCHAR(50), 
@Cause NVARCHAR(50), 
@AssetGroupID NVARCHAR(50), 
@NumGroupID TINYINT, 
@Sign NVARCHAR(50), 
@NowStatusID NVARCHAR(50), 
@strSQL NVARCHAR(MAX), 
@strSQL1 NVARCHAR(MAX), 
@strSQL2 NVARCHAR(MAX), 
@strSQL3 NVARCHAR(MAX), 
@Amount01 DECIMAL(28, 8),
@sAmount AS NVARCHAR(MAX),
@sAmount1 AS NVARCHAR(MAX),
@CustomerName INT

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
IF @CustomerName = 50 --- Customize Meiko
	EXEC AP1598_MK @DivisionID, @TranMonthFrom, @TranYearFrom, @TranMonthTo, @TranYearTo, @ReportCode

ELSE
BEGIN

	SET @sAmount = ''
	SET @sAmount1 = ''
	SET @strSQL2 = ''
	SET @strSQL1 = ''
	SET @strSQL3 = ''

	SET NOCOUNT ON

	IF EXISTS(SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[TAM]'))
		DROP TABLE TAM

	SET @strSQL1 = N'
	SELECT DivisionID, LineID, LineDescription, LineDescriptionE, PrintStatus, Level1, 0 AS Accumulator, Notes, Sign 
	'

	SET @AT1501Cursor = CURSOR SCROLL KEYSET FOR
			SELECT AssetGroupID, Orders FROM AT1501 WHERE Orders <= 99 AND DivisionID = @DivisionID ORDER BY Orders
		OPEN @AT1501Cursor
		FETCH NEXT FROM @AT1501Cursor INTO @AssetGroupID, @NumGroupID
		WHILE @@FETCH_STATUS = 0
			BEGIN 
				EXEC AP1599 @NumGroupID, @DivisionID, @AccountIDFrom, @AccountIDTo, @TranMonthFrom, @TranYearFrom, @TranMonthTo, @TranYearTo, @Method, @Cause, @TypeValues, @AssetGroupID, @Sign, @NowStatusID, @OutputAmount = @Amount01 OUTPUT 
				----EXEC AP1597 @LineID, @NumGroupID, @Amount01 

            		SET @sAmount = @sAmount + ' ,Convert(Decimal(28,8),ISNULL('+STR(@Amount01)+', 0)) AS Amount'+CONVERT(VARCHAR(2),@NumGroupID)+' '
            		SET @sAmount1 = @sAmount1 + ' + ISNULL('+STR(@Amount01)+', 0) '
            
				FETCH NEXT FROM @AT1501Cursor INTO @AssetGroupID, @NumGroupID
			END
		CLOSE @AT1501Cursor

	SET @strSQL1 = @strSQL1 + @sAmount + '
	INTO	TAM
	FROM	AT1599
	WHERE	ReportCode = '''+@ReportCode+''' 
			AND DivisionID = '''+@DivisionID+''' '
	EXEC(@strSQL1)
	---------------------------------- Dua du lieu vao bang tam --------------------------------------------------------------------------------------------------------------------------------------
	--DELETE AT1597
	--Insert AT1597 (DivisionID, LineID, LineDescription, LineDescriptionE, PrintStatus, Amount01, Amount02, Amount03, Amount04, Amount05, Amount06, Amount07, Amount08, Amount09, Amount10, Level1, Accumulator, Notes, Sign)
	--SELECT DivisionID, LineID, LineDescription, LineDescriptionE, PrintStatus, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, Level1, 0, Notes, Sign 
	--FROM AT1599 WHERE ReportCode = @ReportCode AND DivisionID = @DivisionID

	------------------------------ Xu ly chi tiet ----------------------------------------------------------------------------------------------------------------------------------------------------------------
	SET @Amount01 = 0
	SET @AT1599Cursor = CURSOR SCROLL KEYSET FOR
		SELECT LineID, AccountIDFrom, AccountIDTo, Method, TypeValues, LTRIM(RTRIM(ISNULL(Cause, ''))) AS Cause, Sign, LTRIM(RTRIM(ISNULL(NowStatusID, ''))) AS NowStatusID
		FROM AT1599 WHERE ReportCode = @ReportCode AND DivisionID = @DivisionID 
	OPEN @AT1599Cursor
	FETCH NEXT FROM @AT1599Cursor INTO @LineID, @AccountIDFrom, @AccountIDTo, @Method, @TypeValues, @Cause, @Sign, @NowStatusID
	WHILE @@FETCH_STATUS = 0
		BEGIN 

		SET @AT1501Cursor = CURSOR SCROLL KEYSET FOR
			--SELECT AssetGroupID, Orders FROM AT1501 WHERE Orders <= 10 ORDER BY Orders
			SELECT AssetGroupID, Orders FROM AT1501 WHERE  Orders <=99 AND DivisionID = @DivisionID 
			ORDER BY Orders
		OPEN @AT1501Cursor
		FETCH NEXT FROM @AT1501Cursor INTO @AssetGroupID, @NumGroupID
		WHILE @@FETCH_STATUS = 0
			BEGIN 
				EXEC AP1599 @NumGroupID, @DivisionID, @AccountIDFrom, @AccountIDTo, @TranMonthFrom, @TranYearFrom, @TranMonthTo, @TranYearTo, @Method, @Cause, @TypeValues, @AssetGroupID, @Sign, @NowStatusID, @OutputAmount = @Amount01 OUTPUT 
				----EXEC AP1597 @LineID, @NumGroupID, @Amount01 
				SET @strSQL2 =' UPDATE TAM SET Amount'+CONVERT(VARCHAR(2),@NumGroupID)+' = Amount'+CONVERT(VARCHAR(2),@NumGroupID)+' + ISNULL('+Convert(Varchar(50),@Amount01)+', 0) WHERE LineID = '''+@LineID+''' AND DivisionID = '''+@DivisionID+'''  '            
				EXEC(@strSQL2)
				FETCH NEXT FROM @AT1501Cursor INTO @AssetGroupID, @NumGroupID
			END
		CLOSE @AT1501Cursor
		DEALLOCATE @AT1501Cursor 
		FETCH NEXT FROM @AT1599Cursor INTO @LineID, @AccountIDFrom, @AccountIDTo, @Method, @TypeValues, @Cause, @Sign, @NowStatusID
		END

	CLOSE @AT1599Cursor
	DEALLOCATE @AT1599Cursor
	/*
	---Lay tong so tien de tra ra man hinh hien thi du lieu truoc khi in

	Set @strSQL = '
	SELECT 
	DivisionID, 
	LineID, 
	SUM(ISNULL(Amount01, 0) 
	+ ISNULL(Amount02, 0) 
	+ ISNULL(Amount03, 0) 
	+ ISNULL(Amount04, 0) 
	+ ISNULL(Amount05, 0) 
	+ ISNULL(Amount06, 0) 
	+ ISNULL(Amount07, 0) 
	+ ISNULL(Amount08, 0) 
	+ ISNULL(Amount09, 0) 
	+ ISNULL(Amount10, 0)) AS TotalAmount
	FROM AT1597
	GROUP BY DivisionID, LineID
	'

	IF NOT EXISTS (SELECT 1 FROM sysObjects WHERE Xtype = 'V' AND Name = 'AV1588')
		EXEC('CREATE VIEW AV1588 -- Tạo bởi AP1598
		AS '+ @strSQL )
	ELSE
		EXEC('ALTER VIEW AV1588 -- Tạo bởi AP1598
		AS '+@strSQL)

	SET @NumGroupID = 1
	SET @strSQL ='
	SELECT AT1597.DivisionID, 
	AT1597.LineID, 
	AT1597.LineDescription, 
	AT1597.LineDescriptionE, 
	AV1588.TotalAmount, 
	AT1597.Notes, 
	AT1597.Level1, 
	AT1597.Amount01, 
	AT1597.Amount02, 
	AT1597.Amount03, 
	AT1597.Amount04, 
	AT1597.Amount05, 
	AT1597.Amount06, 
	AT1597.Amount07, 
	AT1597.Amount08, 
	AT1597.Amount09, 
	AT1597.Amount10
	FROM AT1597
	INNER JOIN AV1588 ON AV1588.DivisionID = AT1597.DivisionID AND AV1588.LineID = AT1597.LineID'

	IF NOT EXISTS (SELECT 1 FROM sysObjects WHERE Xtype = 'V' AND Name = 'AV1598')
		EXEC('CREATE VIEW AV1598 -- Tạo bởi AP1598
		AS '+ @strSQL )
	ELSE
		EXEC('ALTER VIEW AV1598 -- Tạo bởi AP1598
		AS '+@strSQL)
	*/


	---Lay tong so tien de tra ra man hinh hien thi du lieu truoc khi in

	Set @strSQL3 = '
	SELECT T.*, TotalAmount
	FROM TAM T
	LEFT JOIN (
	SELECT 
		DivisionID, LineID,
		SUM(0
		'+@sAmount1+'
		) AS TotalAmount
		FROM TAM 
		GROUP BY DivisionID, LineID
	) M
	ON M.DivisionID = T.DivisionID AND M.LineID = T.LineID
	ORDER BY T.DivisionID, T.LineID

	DROP TABLE TAM
	'

	--PRINT(@strSQL1)
	--PRINT(@strSQL2)
	--PRINT(@strSQL3)

	EXEC (@strSQL3)
END 
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

