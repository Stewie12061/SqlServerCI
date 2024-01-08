IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7909_TIENTIEN]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP7909_TIENTIEN]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





/********************************************
'* Edited by: [GS] [Minh Lâm] [29/07/2010]
'********************************************/
--- Created by Nguyen Van Nhan, Date  14/09/2008.
--- Tinh toan cac chi tieu so du no, du co cua cac chi tieu, len bang thuyet minh tai chinh
---- Modified by on 11/10/2012 by Lê Thị Thu Hiền : Bổ sung thêm strDivisionID
---- Modified by on 02/01/2013 by Lê Thị Thu Hiền : Thay đổi INSERT #DivisionID bằng Bảng tạm A00007
---- Modified on 31/03/2021 by Huỳnh Thử: Tách Store TienTien -- Xuất Execl nhiều divisionID

CREATE PROCEDURE [dbo].[AP7909_TIENTIEN]
       @DivisionID nvarchar(50) ,
       @ReportCode AS nvarchar(50) ,
       @TranYear AS INT,
       @StrDivisionID AS NVARCHAR(4000) = ''
AS
DECLARE
        @cur AS cursor ,
        @FromAccountID AS nvarchar(50) ,
        @ToAccountID AS nvarchar(50) ,
        @FromCorAccountID AS nvarchar(50) ,
        @ToCorAccountID AS nvarchar(50) ,
        @OperatorID AS nvarchar(50) ,
        @GroupID AS nvarchar(50) ,
        @TitleID AS nvarchar(50) ,
        @Amount01 AS decimal(28,8) ,
        @Amount02 AS decimal(28,8),
		@DivisionIDCur nvarchar(50) 

SET NOCOUNT ON
--- Xoa du lieu bang tam

--------------->>>> Chuỗi DivisionID
DECLARE @StrDivisionID_New AS NVARCHAR(4000)
	
SELECT @StrDivisionID_New = CASE WHEN @StrDivisionID = '%' THEN ' LIKE ''' + 
@StrDivisionID + '''' ELSE ' IN (''' + replace(@StrDivisionID, ',',''',''') + ''')' END

BEGIN		
	DELETE FROM	A00007 WHERE SPID = @@SPID
	INSERT INTO A00007(SPID, DivisionID) 
	EXEC('SELECT '''+@@SPID+''', DivisionID FROM AT1101 WHERE DivisionID '+@StrDivisionID_New+'')

	---------------------<<<<<<<<<< Chuỗi DivisionID

	DELETE AT7909
	INSERT AT7909
		( DivisionID,	
		  GroupID ,
		  TitleID ,
		  TitleName ,
		  LineDes ,
		  Amount01 ,
		  Amount02 )
		SELECT
			DivisionID,
			GroupID ,
			TitleID ,
			TitleName ,
			LineDes ,
			0 ,
			0
		FROM AT7905
		WHERE ReportCode = @ReportCode AND DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID)
		ORDER BY DivisionID
	PRINT @ReportCode
	SET @Cur = CURSOR SCROLL KEYSET FOR SELECT	DivisionID,
												GroupID ,
												TitleID ,
												OperatorID ,
												FromAccountID ,
												ToAccountID ,
												FromCorAccountID ,
												ToCorAccountID
										FROM	AT7905
										WHERE	ReportCode = @ReportCode AND DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID)
										ORDER BY DivisionID,GroupID ,TitleID
	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @DivisionIDCur,@GroupID,@TitleID,@OperatorID,@FromAccountID,@ToAccountID,@FromCorAccountID,@ToCorAccountID
	WHILE @@Fetch_Status = 0
		  BEGIN
				IF isnull(@FromCorAccountID , '') = ''
				   BEGIN
						 SET @FromCorAccountID = ''
						 SET @ToCorAccountID = '999'
				   END

				SET @Amount01 = 0
				SET @Amount02 = 0

				IF @GroupID IN ( '22c' , '23' , '25' , '26' , '27' , '28' , '29' , '30' , '31' , '32' , '33' , '34' )  --- co nghia la lay so phat sinh cua nam nay va nam truoc, hoac so du cua nam nay, nam truoc
				   BEGIN
						 EXEC AP7919_TIENTIEN @DivisionIDCur , @TranYear , @OperatorID , @FromAccountID , @ToAccountID , @FromCorAccountID , @ToCorAccountID , @Amount01 OUTPUT , @Amount02 OUTPUT, @StrDivisionID
					---Print @GroupID+'  '+@OperatorID+'  '+@FromAccountID+' '+@ToAccountID+' '+@FromCorAccountID+' '+@ToCorAccountID+'  = '+str(@Amount01,28,8)
				   END
				ELSE
				   BEGIN
						 IF isnull(@FromAccountID , '') <> ''
							BEGIN
								  SELECT
									  @Amount01 = ( SELECT	Sum(SignAmount)
													FROM	AV4301
													WHERE	DivisionID = @DivisionIDCur
															AND ( AccountID BETWEEN @FromAccountID AND @ToAccountID ) 
															AND TranYear <= @TranYear 
															AND CorAccountID BETWEEN @FromCorAccountID AND @ToCorAccountID )
								  SELECT
									  @Amount02 = ( SELECT	Sum(SignAmount)
													FROM	AV4301
													WHERE	DivisionID = @DivisionIDCur
															AND ( AccountID BETWEEN @FromAccountID AND @ToAccountID ) 
															AND CorAccountID BETWEEN @FromCorAccountID AND @ToCorAccountID 
															AND ( ( TranYear < @TranYear ) 
																	OR ( TranYear = @TranYear 
																		AND TranMonth = 1 
																		AND TransactionTypeID = 'T00' ) ) )

							END
						 IF @OperatorID = 'BA'   --- So du No
							BEGIN
								  SET @Amount01 = isnull(@Amount01 , 0)
								  SET @Amount02 = isnull(@Amount02 , 0)
							END
						 IF @OperatorID = 'BC'   --- So du Co
							BEGIN
								  SET @Amount01 = -isnull(@Amount01 , 0)
								  SET @Amount02 = -isnull(@Amount02 , 0)
							END
				   END
			--Print @GroupID
				IF @Amount01 <> 0 OR @Amount02 <> 0
				   BEGIN
						 UPDATE  AT7909
						 SET	Amount01 = @Amount01 ,
								Amount02 = @Amount02
						 WHERE  TitleID = @TitleID 
								AND DivisionID = @DivisionIDCur
				   END
				FETCH NEXT FROM @Cur INTO @DivisionIDCur,@GroupID,@TitleID,@OperatorID,@FromAccountID,@ToAccountID,@FromCorAccountID,@ToCorAccountID
		  END
	CLOSE @Cur

	SET NOCOUNT OFF
	DELETE FROM	A00007 WHERE SPID = @@SPID
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
