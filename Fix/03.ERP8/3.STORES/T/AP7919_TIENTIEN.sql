IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7919_TIENTIEN]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP7919_TIENTIEN]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--- Phuc vu viec tinh so du, so phat sinh No, Co cua nam nay, nam truoc trongbang Thuyet Minh Tai chinh
--- Created by Nguyen Van Nhan, Date 19/07/2009
---- Modified by on 11/10/2012 by Lê Thị Thu Hiền : Bổ sung thêm strDivisionID
---- Modified by on 02/01/2013 by Lê Thị Thu Hiền : Thay đổi INSERT #DivisionID bằng Bảng tạm A00007
---- Modified on 31/03/2021 by Huỳnh Thử: Tách Store TienTien -- Xuất Execl nhiều divisionID

CREATE PROCEDURE [dbo].[AP7919_TIENTIEN] 
				@DivisionID as nvarchar(50), 
				@TranYear as int, 
				@OperatorID as nvarchar(50), 
				@FromAccountID as nvarchar(50), 
				@ToAccountID as nvarchar(50), 
				@FromCorAccountID as nvarchar(50), 
				@ToCorAccountID as nvarchar(50), 
				@Amount01 decimal(28,8) output, 
				@Amount02 decimal(28,8) OUTPUT,
				@StrDivisionID AS NVARCHAR(4000) = ''
 AS

Declare @LastYear as int,
		@D_C as nvarchar(1),
		@Values as nvarchar(20)

Set @Values=''

--------------->>>> Chuỗi DivisionID
DECLARE @StrDivisionID_New AS NVARCHAR(4000)
	
SELECT @StrDivisionID_New = CASE WHEN @StrDivisionID = '%' THEN ' LIKE ''' + 
@StrDivisionID + '''' ELSE ' IN (''' + replace(@StrDivisionID, ',',''',''') + ''')' END

DELETE FROM	A00007 WHERE SPID = @@SPID
INSERT INTO A00007(SPID, DivisionID) 
EXEC('SELECT '''+@@SPID+''', DivisionID FROM AT1101 WHERE DivisionID '+@StrDivisionID_New+'')

---------------------<<<<<<<<<< Chuỗi DivisionID

---Print @OperatorID
Set @LastYear =@TranYear-1

		 If isnull(@FromAccountID,'')<>'' and @OperatorID in ( 'BA','BC')
			Begin
				Select @Amount01 =(	Select Sum(SignAmount)  
									From AV4301 
				                   	Where DivisionID = @DivisionID
				                   			and (AccountID between @FromAccountID and @ToAccountID) 
				                   			and	TranYear<= @TranYear and isnull(CorAccountID,@Values) between @FromCorAccountID and @ToCorAccountID)
				Select @Amount02 =(	Select Sum(SignAmount)  
				                   	From AV4301 
				                   	Where DivisionID = @DivisionID  and 
											(AccountID between @FromAccountID and @ToAccountID) and  isnull(CorAccountID,@Values) between @FromCorAccountID and @ToCorAccountID and
											( (TranYear< @TranYear) or (TranYear =@TranYear and TranMonth =1 and TransactionTypeID='T00')   ))

			If @OperatorID ='BA'   --- So du No
				Begin
					    Set  @Amount01 = isnull(@Amount01,0)	
					    Set  @Amount02 = isnull(@Amount02,0)	
				End
			If @OperatorID ='BC'   --- So du Co
				Begin
					    Set  @Amount01 = -isnull(@Amount01,0)	
					    Set  @Amount02 = -isnull(@Amount02,0)	
				End

		End

		 If isnull(@FromAccountID,'')<>'' and @OperatorID in ( 'PD','PC')
			Begin
				set @D_C =right(@OperatorID,1)
				Select @Amount01 =(Select	Sum(SignAmount)  
				                   From		AV4301 
				                   Where	DivisionID = @DivisionID
										and (AccountID between @FromAccountID and @ToAccountID) 
										and D_C=@D_C and TransactionTypeID<>'T00' 
										and	TranYear= @TranYear 
										and isnull(CorAccountID,@Values) between @FromCorAccountID and @ToCorAccountID)
				Select @Amount02 =(Select	Sum(SignAmount)  
				                   From		AV4301 
				                   Where	DivisionID = @DivisionID
											and D_C=@D_C 
											and TransactionTypeID<>'T00' 
											and	(AccountID between @FromAccountID and @ToAccountID) 
											and  isnull(CorAccountID,@Values) between @FromCorAccountID and @ToCorAccountID 
											and	(TranYear= @LastYear) )
				If @D_C ='C' 
					Begin
						Set @Amount01 = -@Amount01
						Set  @Amount02 = -@Amount02
					End
	
		End



		 If isnull(@FromAccountID,'')<>'' and @OperatorID in ( 'LD','LC')
			Begin
				Select @Amount01 =(Select Sum(SignAmount)  
				                   From AV4301 
				                   Where DivisionID = @DivisionID
										and (AccountID between @FromAccountID and @ToAccountID) 
										and	TranYear<= @LastYear 
										and isnull(CorAccountID,@Values) between @FromCorAccountID and @ToCorAccountID)
				Select @Amount02 =(Select Sum(SignAmount)  
				                   From AV4301 
				                   Where DivisionID = @DivisionID
										and (AccountID between @FromAccountID and @ToAccountID) 
										and  isnull(CorAccountID,@Values) between @FromCorAccountID and @ToCorAccountID 
										and	( (TranYear< @LastYear) 
												or (TranYear =@LastYear 
												and TranMonth =1 
												and TransactionTypeID='T00')   ))

			If @OperatorID ='LD'   --- So du No
				Begin
					    Set  @Amount01 = isnull(@Amount01,0)	
					    Set  @Amount02 = isnull(@Amount02,0)	
				End
			If @OperatorID ='LC'   --- So du Co
				Begin
					    Set  @Amount01 = -isnull(@Amount01,0)	
					    Set  @Amount02 = -isnull(@Amount02,0)	
				End

		End

---Select @Amount01 output, @Amount02 output
DELETE FROM	A00007 WHERE SPID = @@SPID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

