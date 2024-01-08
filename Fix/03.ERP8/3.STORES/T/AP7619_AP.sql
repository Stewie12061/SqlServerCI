IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7619_AP]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP7619_AP]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----- Created by Tiểu Mai
---- Created Date 06/07/2016
---- Purpose: Tinh toan du lieu dong cu the cho tung  ma phan tich. Phuc vu in bang P/L theo ma phan tich cho An Phát
---- Modified by Bảo Anh on 27/05/2017: Sửa danh mục dùng chung
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.

CREATE PROCEDURE [dbo].[AP7619_AP] 
				@DivisionID nvarchar(50), 
				@FromMonth as int, 
				@FromYear  as int,  
				@ToMonth  as int,  
				@ToYear  as int,  
				@CaculatorID nvarchar(50), 
				@FromAccountID  nvarchar(50),  
				@ToAccountID  nvarchar(50),  
				@FromCorAccountID  nvarchar(50),  
				@ToCorAccountID  nvarchar(50), 
				@AnaTypeID  nvarchar(50),  
				@FromAnaID  nvarchar(50), 
				@ToAnaID  nvarchar(50), 
				@FromWareHouseID  nvarchar(50), 
				@ToWareHouseID nvarchar(50), 
				@FieldID nvarchar(50),  
				@AnaID nvarchar(50), 
				@BudgetID as nvarchar(50),
				@Amount decimal(28,8) OUTPUT,
				@StrDivisionID AS NVARCHAR(4000) = ''

AS

--Print '@AnaID:' + @AnaID
--Print '@BudgetID:' + @BudgetID
--Print '@FromAnaID:' + @FromAnaID
--Print '@ToAnaID:' + @ToAnaID
--Print '@AnaTypeID:' + @AnaTypeID
--------------->>>> Chuỗi DivisionID
DECLARE @StrDivisionID_New AS NVARCHAR(4000)
	
SELECT @StrDivisionID_New = CASE WHEN @StrDivisionID = '%' THEN ' LIKE ''' + 
@StrDivisionID + '''' ELSE ' IN (''' + replace(@StrDivisionID, ',',''',''') + ''')' END
		
DELETE FROM	A00007 WHERE SPID = @@SPID
INSERT INTO A00007(SPID, DivisionID) 
EXEC('SELECT '''+@@SPID+''', DivisionID FROM AT1101 WHERE DivisionID '+@StrDivisionID_New+'')

---------------------<<<<<<<<<< Chuỗi DivisionID


---- TH1 ---  trong ky:  PA  (lay phat sinh No - Ps Co)
If @CaculatorID ='PA'
  If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
   Set @Amount = (select sum(SignAmount) 
			From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
					DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
					(TranMonth+TranYear*100 between @FromMonth + 100*@FromYear AND @ToMonth + 100*@ToYear)  AND
					FilterMaster = @AnaID AND BudgetID = @BudgetID AND
					TransactionTypeID <>'T00' AND
					(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
					CorAccountID between @FromCorAccountID AND @ToCorAccountID )
  Else
   Set @Amount = (select sum(SignAmount) 
			From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
					DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
					(TranMonth+TranYear*100 between @FromMonth + 100*@FromYear AND @ToMonth + 100*@ToYear)  AND
					FilterMaster = @AnaID AND BudgetID = @BudgetID AND
					TransactionTypeID <>'T00' AND
					(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
					CorAccountID between @FromCorAccountID AND @ToCorAccountID )

	

--- TH 2 ---  trong nam YA (lay phat sinh No - Ps Co)
If @CaculatorID ='YA'
  If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
   Set @Amount = (select sum(SignAmount) 
			From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
					DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
					(TranYear between @FromYear AND @ToYear)  AND
					FilterMaster = @AnaID AND BudgetID = @BudgetID AND
					TransactionTypeID <>'T00' AND
					(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
					CorAccountID between @FromCorAccountID AND @ToCorAccountID )
  Else
   Set @Amount = (select sum(SignAmount) 
			From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
					DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
					(TranYear between @FromYear AND @ToYear)  AND
					FilterMaster = @AnaID AND BudgetID = @BudgetID AND
					TransactionTypeID <>'T00' AND
					(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
					CorAccountID between @FromCorAccountID AND @ToCorAccountID )

----TH3 --- So du trong ky (Lay no - co den hien tai BA)
If @CaculatorID ='BA'
  If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
   Set @Amount = (select sum(SignAmount) 
			From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
					DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
					(TranMonth+TranYear*100 <=  @ToMonth + 100*@ToYear)  AND
					FilterMaster = @AnaID AND BudgetID = @BudgetID AND
					(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
					CorAccountID between @FromCorAccountID AND @ToCorAccountID )
  Else
   Set @Amount = (select sum(SignAmount) 
			From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
					DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
					(TranMonth+TranYear*100 <=  @ToMonth + 100*@ToYear)  AND
					FilterMaster = @AnaID AND BudgetID = @BudgetID AND
					(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
					CorAccountID between @FromCorAccountID AND @ToCorAccountID )


--Print @CaculatorID+'  '+@AnaID+'  '+@BudgetID+ '  '+@FromAccountID+'  '+@ToAccountID+' ma ptc: '+@FromAnaID
---- TH4 ---- Phat sinh Co  PC
If @CaculatorID ='PC'
  If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
  BEGIN
  		IF @BudgetID = 'AA'
  			Set @Amount = (select -sum(SignQuantity) 
			From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
					DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
					(TranMonth+TranYear*100 between @FromMonth + 100*@FromYear AND @ToMonth + 100*@ToYear)  AND
					D_C = 'C' AND TransactionTypeID <>'T00' AND
					FilterMaster = @AnaID AND BudgetID = 'AA' AND
					(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
					CorAccountID between @FromCorAccountID AND @ToCorAccountID)
		ELSE
			Set @Amount = (select -sum(SignAmount) 
			From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
					DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
					(TranMonth+TranYear*100 between @FromMonth + 100*@FromYear AND @ToMonth + 100*@ToYear)  AND
					D_C = 'C'  AND TransactionTypeID <>'T00' AND
					FilterMaster = @AnaID AND BudgetID = @BudgetID AND
					(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
					CorAccountID between @FromCorAccountID AND @ToCorAccountID)
  END
   
  Else
   Set @Amount = (select -sum(SignAmount) 
			From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
					DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
					(TranMonth+TranYear*100 between @FromMonth + 100*@FromYear AND @ToMonth + 100*@ToYear)  AND
					D_C ='C'  AND TransactionTypeID <>'T00' AND
					FilterMaster = @AnaID AND BudgetID = @BudgetID AND
					(FilterDetail between @FromAnaID AND  @ToAnaID ) )

---- TH5 ---- Phat sinh  No - PD
If @CaculatorID ='PD'
  If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
  BEGIN
  			IF @BudgetID = 'AA'
  			Set @Amount = (select sum(SignQuantity) 
			From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
					DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
					(TranMonth+TranYear*100 between @FromMonth + 100*@FromYear AND @ToMonth + 100*@ToYear)  AND
					D_C ='D' AND TransactionTypeID <>'T00' AND
					FilterMaster = @AnaID AND BudgetID = 'AA' AND
					(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
					CorAccountID between @FromCorAccountID AND @ToCorAccountID)
			ELSE   			
  			Set @Amount = (select sum(SignAmount) 
			From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
					DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
					(TranMonth+TranYear*100 between @FromMonth + 100*@FromYear AND @ToMonth + 100*@ToYear)  AND
					D_C ='D' AND TransactionTypeID <>'T00' AND
					FilterMaster = @AnaID AND BudgetID = @BudgetID AND
					(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
					CorAccountID between @FromCorAccountID AND @ToCorAccountID)
  END
   
  Else
   Set @Amount = (select sum(SignAmount) 
			From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
					DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
					(TranMonth+TranYear*100 between @FromMonth + 100*@FromYear AND @ToMonth + 100*@ToYear)  AND
					D_C ='D'and TransactionTypeID <>'T00' AND
					FilterMaster = @AnaID AND BudgetID = @BudgetID AND
					(FilterDetail between @FromAnaID AND  @ToAnaID ) )
---- TH6 ---- So du lk truoc BL
If @CaculatorID ='BL'
  If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
   Set @Amount = (select sum(SignAmount) 
			From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
					DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
					( (TranMonth+TranYear*100 <  @FromMonth + 100*@FromYear) or TransactionTypeID='T00')  AND
					FilterMaster = @AnaID AND BudgetID = @BudgetID AND
					(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
					CorAccountID between @FromCorAccountID AND @ToCorAccountID )
  Else
   Set @Amount = (select sum(SignAmount) 
			From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
					DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
					( (TranMonth+TranYear*100 <  @FromMonth + 100*@FromYear) or TransactionTypeID='T00')  AND
					FilterMaster = @AnaID AND BudgetID = @BudgetID AND
					(FilterDetail between @FromAnaID AND  @ToAnaID ) )

---- TH7 ----Phat sinh Co trong nam YC
If @CaculatorID ='YC'
  If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
   Set @Amount = (select -sum(SignAmount) 
			From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
					DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
					(TranYear  between @FromYear AND @ToYear)  AND
					D_C ='C'  AND TransactionTypeID <>'T00' AND
					FilterMaster = @AnaID AND BudgetID = @BudgetID AND
					(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
					CorAccountID between @FromCorAccountID AND @ToCorAccountID)
  Else
   Set @Amount = (select -sum(SignAmount) 
			From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
					DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
					(TranYear  between @FromYear AND @ToYear)  AND
					D_C ='C'  AND TransactionTypeID <>'T00' AND
					FilterMaster = @AnaID AND BudgetID = @BudgetID AND
					(FilterDetail between @FromAnaID AND  @ToAnaID ) )
		

---- TH8 ----Phat sinh No trong nam YD


Set @Amount = isnull(@Amount,0)

If @CaculatorID ='YD'
  If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
   Set @Amount = (select sum(SignAmount) 
			From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
					DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
					(TranYear  between @FromYear AND @ToYear)  AND
					D_C ='D'  AND TransactionTypeID <>'T00' AND
					FilterMaster = @AnaID AND BudgetID = @BudgetID AND
					(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
					CorAccountID between @FromCorAccountID AND @ToCorAccountID)
  Else
   Set @Amount = (select sum(SignAmount) 
			From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
					DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
					(TranYear  between @FromYear AND @ToYear)  AND
					D_C ='D'  AND TransactionTypeID <>'T00' AND
					FilterMaster = @AnaID AND BudgetID = @BudgetID AND
					(FilterDetail between @FromAnaID AND  @ToAnaID ) )

---- TH9 ---- So dau nam theo nien do Nhat (dau ky 4) -  customize cho Meiko


Set @Amount = isnull(@Amount,0)

If @CaculatorID ='JBY'
	 If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
	   Set @Amount = (select sum(SignAmount) 
				From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
						DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
						(TranMonth+TranYear*100 <=  3 + 100*@ToYear)  AND
						FilterMaster = @AnaID AND BudgetID = @BudgetID AND
						(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
						CorAccountID between @FromCorAccountID AND @ToCorAccountID )
	  Else
	   Set @Amount = (select sum(SignAmount) 
				From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
						DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
						(TranMonth+TranYear*100 <=  3 + 100*@ToYear)  AND
						FilterMaster = @AnaID AND BudgetID = @BudgetID AND
						(FilterDetail between @FromAnaID AND  @ToAnaID )  )

---- TH10 ---- So du dau ky ben No ('BD')

Set @Amount = isnull(@Amount,0)

If @CaculatorID ='BD'
	 If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
	   Set @Amount = (select sum(SignAmount) 
				From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
						DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
						( (TranMonth+TranYear*100 <  @FromMonth + 100*@FromYear) or TransactionTypeID='T00')  AND
						D_C = 'D' AND
						FilterMaster = @AnaID AND BudgetID = @BudgetID AND
						(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
						CorAccountID between @FromCorAccountID AND @ToCorAccountID )
	Else
	   Set @Amount = (select sum(SignAmount) 
				From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
						DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
						( (TranMonth+TranYear*100 <  @FromMonth + 100*@FromYear) or TransactionTypeID='T00')  AND
						D_C = 'D' AND
						FilterMaster = @AnaID AND BudgetID = @BudgetID AND
						(FilterDetail between @FromAnaID AND  @ToAnaID ) )

---- TH11---- So du dau ky ben Co ('BC')

Set @Amount = isnull(@Amount,0)

If @CaculatorID ='BC'
	 If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
	   Set @Amount = (-1) * (select sum(SignAmount) 
				From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
						DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
						( (TranMonth+TranYear*100 <  @FromMonth + 100*@FromYear) or TransactionTypeID='T00')  AND
						D_C = 'C' AND
						FilterMaster = @AnaID AND BudgetID = @BudgetID AND
						(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
						CorAccountID between @FromCorAccountID AND @ToCorAccountID )
	Else
	   Set @Amount = (-1) *  (select sum(SignAmount) 
				From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
						DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
						( (TranMonth+TranYear*100 <  @FromMonth + 100*@FromYear) or TransactionTypeID='T00')  AND
						D_C = 'C' AND
						FilterMaster = @AnaID AND BudgetID = @BudgetID AND
						(FilterDetail between @FromAnaID AND  @ToAnaID ) )


---- TH12---- Doanh thu CM ('CM')

Set @Amount = isnull(@Amount,0)

If @CaculatorID ='CM'
BEGIN	
	 If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
	 BEGIN
		IF @BudgetID = 'AA'
			Set @Amount = (SELECT SUM((ISNULL(ActualQuantity,0) * ISNULL(SalePrice01,0))) AS Amount FROM AT2007
							LEFT JOIN AT2006 ON AT2006.DivisionID = AT2007.DivisionID AND AT2006.VoucherID = AT2007.VoucherID
							LEFT JOIN AT1302 ON AT1302.DivisionID IN (AT2007.DivisionID,'@@@') AND AT1302.InventoryID = AT2007.InventoryID
							WHERE AT2006.TranMonth + AT2006.TranYear* 100 BETWEEN @FromMonth + @FromYear*100 AND @ToMonth + @ToYear*100
								AND ISNULL(DebitAccountID,'') BETWEEN @FromAccountID AND @ToAccountID
								AND ISNULL(CreditAccountID,'') BETWEEN @FromCorAccountID AND @ToCorAccountID
								AND ISNULL(Ana06ID,'') BETWEEN @FromAnaID AND @ToAnaID
								AND WareHouseID BETWEEN @FromWareHouseID AND @ToWareHouseID
								AND (Case when AT2006.TranMonth < 10 then ('0' + CONVERT(NVARCHAR(2),AT2006.TranMonth)+ '/' + CONVERT(NVARCHAR(4),AT2006.TranYear)) ELSE CONVERT(NVARCHAR(5),AT2006.TranMonth)+ '/' + CONVERT(NVARCHAR(4),AT2006.TranYear)  END) = @AnaID
								AND KindVoucherID IN (1, 3, 5))
		ELSE
		   Set @Amount = (select sum(SignAmount) 
					From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
							DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
							( (TranMonth+TranYear*100 <  @FromMonth + 100*@FromYear) or TransactionTypeID='B00')  AND
							D_C = 'D' AND
							FilterMaster = @AnaID AND BudgetID = @BudgetID AND
							(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
							CorAccountID between @FromCorAccountID AND @ToCorAccountID )
		END
	ELSE
	BEGIN
		IF @BudgetID = 'AA'
			Set @Amount = (SELECT SUM((ISNULL(ActualQuantity,0) * ISNULL(SalePrice01,0))) AS Amount FROM AT2007
							LEFT JOIN AT2006 ON AT2006.DivisionID = AT2007.DivisionID AND AT2006.VoucherID = AT2007.VoucherID
							LEFT JOIN AT1302 ON AT1302.DivisionID IN (AT2007.DivisionID,'@@@') AND AT1302.InventoryID = AT2007.InventoryID
							WHERE AT2006.TranMonth + AT2006.TranYear* 100 BETWEEN @FromMonth + @FromYear*100 AND @ToMonth + @ToYear*100
								AND ISNULL(DebitAccountID,'') BETWEEN @FromAccountID AND @ToAccountID
								AND ISNULL(Ana06ID,'') BETWEEN @FromAnaID AND @ToAnaID
								AND WareHouseID BETWEEN @FromWareHouseID AND @ToWareHouseID
								AND KindVoucherID IN (1, 3, 5)
								AND (Case when AT2006.TranMonth < 10 then ('0' + CONVERT(NVARCHAR(2),AT2006.TranMonth)+ '/' + CONVERT(NVARCHAR(4),AT2006.TranYear)) ELSE CONVERT(NVARCHAR(5),AT2006.TranMonth)+ '/' + CONVERT(NVARCHAR(4),AT2006.TranYear)  END) = @AnaID
								)
		ELSE
			Set @Amount = (select sum(SignAmount) 
					From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
							DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
							( (TranMonth+TranYear*100 <  @FromMonth + 100*@FromYear) or TransactionTypeID='B00')  AND
							D_C = 'D' AND
							FilterMaster = @AnaID AND BudgetID = @BudgetID AND
							(FilterDetail between @FromAnaID AND  @ToAnaID ) )
		
	END	
END					
DELETE FROM	A00007 WHERE SPID = @@SPID



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

