﻿IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP7619]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP7619]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






----- Created by Van Nhan AND Thuy Tuyen
---- Created Date 15/06/2006
---- Purpose: Tinh toan du lieu dong cu the cho tung  ma phan tich. Phu vu in bang P/L theo ma phan tich
---- Modified by on 11/10/2012 by Lê Thị Thu Hiền : Bổ sung thêm strDivisionID
---- Modified by on 02/01/2013 by Lê Thị Thu Hiền : Thay đổi INSERT #DivisionID bằng Bảng tạm A00007
---- Modified by on 17/04/2015 by Thanh Sơn: Bổ sung lấy số lượng cho trường hợp Budget = 'AQ', số liệu 'BD'
---- Modified by on 03/12/2015 by Phương Thảo: Bổ sung lấy số dư đầu năm theo niên độ TC nhật bản - customize Meiko
---- Modified by on 04/04/2016 by Phương Thảo: Bổ sung chỉ tiêu : 'BD' (số du Nợ đầu kỳ) và  'BC' (Số dư có đầu kỳ)
---- Modified by on 27/10/2023 by Đức Tuyên: Bổ sung thiết lập báo cáo dòng tiền theo đối tượng (Customize INNOTEK).

CREATE PROCEDURE [dbo].[AP7619] 
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
				@FieldID nvarchar(50),  
				@AnaID nvarchar(50), 
				@BudgetID as nvarchar(50),
				@Amount decimal(28,8) OUTPUT,
				@Amount2 decimal(28,8) OUTPUT,				
				@StrDivisionID AS NVARCHAR(4000) = ''

AS

--Print '@AnaID:' + @AnaID
--Print '@BudgetID:' + @BudgetID
--Print '@FromAnaID:' + @FromAnaID
--Print '@ToAnaID:' + @ToAnaID
--Print '@AnaTypeID:' + @AnaTypeID
--------------->>>> Chuỗi DivisionID
DECLARE @StrDivisionID_New AS NVARCHAR(4000),
		@CustomerName INT	
		
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)			

SET @Amount2 = 0
	
SELECT @StrDivisionID_New = CASE WHEN @StrDivisionID = '%' THEN ' LIKE ''' + 
@StrDivisionID + '''' ELSE ' IN (''' + replace(@StrDivisionID, ',',''',''') + ''')' END
		
DELETE FROM	A00007 WHERE SPID = @@SPID
INSERT INTO A00007(SPID, DivisionID) 
EXEC('SELECT '''+@@SPID+''', DivisionID FROM AT1101 WHERE DivisionID '+@StrDivisionID_New+'')

---------------------<<<<<<<<<< Chuỗi DivisionID


---- TH1 ---  trong ky:  PA  (lay phat sinh No - Ps Co)
If @CaculatorID ='PA'
  If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
  BEGIN
		SELECT @Amount = sum(SignAmount), @Amount2 = sum(SignAmount2) 
		From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
				(TranMonth+TranYear*100 between @FromMonth + 100*@FromYear AND @ToMonth + 100*@ToYear)  AND
				FilterMaster = @AnaID AND BudgetID = @BudgetID AND
				TransactionTypeID <>'T00' AND
				(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
				CorAccountID between @FromCorAccountID AND @ToCorAccountID  			
  END
  ELSE
  BEGIN
		SELECT @Amount = sum(SignAmount), @Amount2 = sum(SignAmount2)  
		From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
				(TranMonth+TranYear*100 between @FromMonth + 100*@FromYear AND @ToMonth + 100*@ToYear)  AND
				FilterMaster = @AnaID AND BudgetID = @BudgetID AND
				TransactionTypeID <>'T00' AND
				(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
				CorAccountID between @FromCorAccountID AND @ToCorAccountID 			  	 	
  END	

	

--- TH 2 ---  trong nam YA (lay phat sinh No - Ps Co)
If @CaculatorID ='YA'
  If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
  BEGIN
		SELECT @Amount = sum(SignAmount), @Amount2 = sum(SignAmount2)  
		From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
				(TranYear between @FromYear AND @ToYear)  AND
				FilterMaster = @AnaID AND BudgetID = @BudgetID AND
				TransactionTypeID <>'T00' AND
				(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
				CorAccountID between @FromCorAccountID AND @ToCorAccountID     				  	  	
  END
  ELSE
  BEGIN
		SELECT @Amount = sum(SignAmount), @Amount2 = sum(SignAmount2) 
		From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
				(TranYear between @FromYear AND @ToYear)  AND
				FilterMaster = @AnaID AND BudgetID = @BudgetID AND
				TransactionTypeID <>'T00' AND
				(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
				CorAccountID between @FromCorAccountID AND @ToCorAccountID   				
  END	

----TH3 --- So du trong ky (Lay no - co den hien tai BA)
If @CaculatorID ='BA'
  If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
  BEGIN
		SELECT @Amount = sum(SignAmount), @Amount2 = sum(SignAmount2) 
		From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
				(TranMonth+TranYear*100 <=  @ToMonth + 100*@ToYear)  AND
				FilterMaster = @AnaID AND BudgetID = @BudgetID AND
				(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
				CorAccountID between @FromCorAccountID AND @ToCorAccountID  					
  END
  ELSE
  BEGIN
		SELECT @Amount = sum(SignAmount), @Amount2 = sum(SignAmount2)
		From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
				(TranMonth+TranYear*100 <=  @ToMonth + 100*@ToYear)  AND
				FilterMaster = @AnaID AND BudgetID = @BudgetID AND
				(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
				CorAccountID between @FromCorAccountID AND @ToCorAccountID 			  		
  END	


--Print @CaculatorID+'  '+@AnaID+'  '+@BudgetID+ '  '+@FromAccountID+'  '+@ToAccountID+' ma ptc: '+@FromAnaID
---- TH4 ---- Phat sinh Co  PC
If @CaculatorID ='PC'
  If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
  BEGIN
  		IF @BudgetID = 'AQ'
  		BEGIN
  			SELECT @Amount = -sum(SignQuantity), @Amount2 = -sum(SignQuantity)
			From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
					DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
					(TranMonth+TranYear*100 between @FromMonth + 100*@FromYear AND @ToMonth + 100*@ToYear)  AND
					D_C = 'C' AND TransactionTypeID <>'T00' AND
					FilterMaster = @AnaID AND BudgetID = 'AA' AND
					(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
					CorAccountID between @FromCorAccountID AND @ToCorAccountID										
  		END
		ELSE
		BEGIN
  			SELECT @Amount = -sum(SignAmount), @Amount2 = -sum(SignAmount2)
			From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
					DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
					(TranMonth+TranYear*100 between @FromMonth + 100*@FromYear AND @ToMonth + 100*@ToYear)  AND
					D_C = 'C'  AND TransactionTypeID <>'T00' AND
					FilterMaster = @AnaID AND BudgetID = @BudgetID AND
					(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
					CorAccountID between @FromCorAccountID AND @ToCorAccountID											
		END	
  END 
  ELSE
  BEGIN 
  		SELECT @Amount = -sum(SignAmount), @Amount2 = -sum(SignAmount2)
		From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
				(TranMonth+TranYear*100 between @FromMonth + 100*@FromYear AND @ToMonth + 100*@ToYear)  AND
				D_C ='C'  AND TransactionTypeID <>'T00' AND
				FilterMaster = @AnaID AND BudgetID = @BudgetID AND
				(FilterDetail between @FromAnaID AND  @ToAnaID ) 			  	 	
  END	

---- TH5 ---- Phat sinh  No - PD
If @CaculatorID ='PD'
  If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
  BEGIN
  		IF @BudgetID = 'AQ'
  		BEGIN
  			SELECT @Amount = sum(SignQuantity), @Amount2 = sum(SignQuantity)  
			From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
					DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
					(TranMonth+TranYear*100 between @FromMonth + 100*@FromYear AND @ToMonth + 100*@ToYear)  AND
					D_C ='D' AND TransactionTypeID <>'T00' AND
					FilterMaster = @AnaID AND BudgetID = 'AA' AND
					(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
					CorAccountID between @FromCorAccountID AND @ToCorAccountID  								
  		END
		ELSE 
		BEGIN
  			SELECT @Amount = sum(SignAmount), @Amount2 = sum(SignAmount2)
			From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
					DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
					(TranMonth+TranYear*100 between @FromMonth + 100*@FromYear AND @ToMonth + 100*@ToYear)  AND
					D_C ='D' AND TransactionTypeID <>'T00' AND
					FilterMaster = @AnaID AND BudgetID = @BudgetID AND
					(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
					CorAccountID between @FromCorAccountID AND @ToCorAccountID								
		END	  			
  END
  ELSE 
  BEGIN
  		SELECT @Amount = sum(SignAmount), @Amount2 = sum(SignAmount2)
		From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
				(TranMonth+TranYear*100 between @FromMonth + 100*@FromYear AND @ToMonth + 100*@ToYear)  AND
				D_C ='D'and TransactionTypeID <>'T00' AND
				FilterMaster = @AnaID AND BudgetID = @BudgetID AND
				(FilterDetail between @FromAnaID AND  @ToAnaID )  				
  END	

---- TH6 ---- So du lk truoc BL
If @CaculatorID ='BL'
  If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
  BEGIN 
  		SELECT @Amount = sum(SignAmount), @Amount2 = sum(SignAmount2)
		From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
				( (TranMonth+TranYear*100 <  @FromMonth + 100*@FromYear) or TransactionTypeID='T00')  AND
				FilterMaster = @AnaID AND BudgetID = @BudgetID AND
				(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
				CorAccountID between @FromCorAccountID AND @ToCorAccountID  			
  END
  ELSE
  BEGIN 
  		SELECT @Amount = sum(SignAmount), @Amount2 = sum(SignAmount2)
		From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
				( (TranMonth+TranYear*100 <  @FromMonth + 100*@FromYear) or TransactionTypeID='T00')  AND
				FilterMaster = @AnaID AND BudgetID = @BudgetID AND
				(FilterDetail between @FromAnaID AND  @ToAnaID )  					  	 	
  END	 

---- TH7 ----Phat sinh Co trong nam YC
If @CaculatorID ='YC'
  If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
  BEGIN
  		SELECT @Amount = -sum(SignAmount), @Amount2 = -sum(SignAmount2)
		From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
				(TranYear  between @FromYear AND @ToYear)  AND
				D_C ='C'  AND TransactionTypeID <>'T00' AND
				FilterMaster = @AnaID AND BudgetID = @BudgetID AND
				(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
							CorAccountID between @FromCorAccountID AND @ToCorAccountID				  	
  END
  ELSE 
  BEGIN
  		SELECT @Amount = -sum(SignAmount), @Amount2 = -sum(SignAmount2)
		From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
				(TranYear  between @FromYear AND @ToYear)  AND
				D_C ='C'  AND TransactionTypeID <>'T00' AND
				FilterMaster = @AnaID AND BudgetID = @BudgetID AND
				(FilterDetail between @FromAnaID AND  @ToAnaID )   				
  END	
		

---- TH8 ----Phat sinh No trong nam YD


Set @Amount = isnull(@Amount,0)

If @CaculatorID ='YD'
  If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
  BEGIN
  		SELECT @Amount = sum(SignAmount), @Amount2 = sum(SignAmount2)
		From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
				(TranYear  between @FromYear AND @ToYear)  AND
				D_C ='D'  AND TransactionTypeID <>'T00' AND
				FilterMaster = @AnaID AND BudgetID = @BudgetID AND
				(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
				CorAccountID between @FromCorAccountID AND @ToCorAccountID  				 		
  END
  ELSE
  BEGIN
  		SELECT @Amount = sum(SignAmount), @Amount2 = sum(SignAmount2)
		From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
				(TranYear  between @FromYear AND @ToYear)  AND
				D_C ='D'  AND TransactionTypeID <>'T00' AND
				FilterMaster = @AnaID AND BudgetID = @BudgetID AND
				(FilterDetail between @FromAnaID AND  @ToAnaID )  				  		
  END


---- TH9 ---- So dau nam theo nien do Nhat (dau ky 4) -  customize cho Meiko


Set @Amount = isnull(@Amount,0)

If @CaculatorID ='JBY'
	 If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
	 BEGIN
  		SELECT @Amount = sum(SignAmount), @Amount2 = sum(SignAmount2)
		From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
				(TranMonth+TranYear*100 <=  3 + 100*@ToYear)  AND
				FilterMaster = @AnaID AND BudgetID = @BudgetID AND
				(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
				CorAccountID between @FromCorAccountID AND @ToCorAccountID 					 		
	 END
	 ELSE
	 BEGIN
  		SELECT @Amount = sum(SignAmount), @Amount2 = sum(SignAmount2)
		From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
				(TranMonth+TranYear*100 <=  3 + 100*@ToYear)  AND
				FilterMaster = @AnaID AND BudgetID = @BudgetID AND
				(FilterDetail between @FromAnaID AND  @ToAnaID )  					 	
	 END	 


---- TH10 ---- So du dau ky ben No ('BD')

Set @Amount = isnull(@Amount,0)

If @CaculatorID ='BD'
	 If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
	 BEGIN
  		SELECT @Amount = sum(SignAmount), @Amount2 = sum(SignAmount2)
		From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
				( (TranMonth+TranYear*100 <  @FromMonth + 100*@FromYear) or TransactionTypeID='T00')  AND
				D_C = 'D' AND
				FilterMaster = @AnaID AND BudgetID = @BudgetID AND
				(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
				CorAccountID between @FromCorAccountID AND @ToCorAccountID 				 		 	
	 END
	 ELSE
	 BEGIN
  		SELECT @Amount = sum(SignAmount), @Amount2 = sum(SignAmount2)
		From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
				( (TranMonth+TranYear*100 <  @FromMonth + 100*@FromYear) or TransactionTypeID='T00')  AND
				D_C = 'D' AND
				FilterMaster = @AnaID AND BudgetID = @BudgetID AND
				(FilterDetail between @FromAnaID AND  @ToAnaID ) 					 	
	 END

---- TH11---- So du dau ky ben Co ('BC')

Set @Amount = isnull(@Amount,0)

If @CaculatorID ='BC'
	 If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
	 BEGIN
  		SELECT @Amount = -sum(SignAmount), @Amount2 = -sum(SignAmount2)
		From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
				( (TranMonth+TranYear*100 <  @FromMonth + 100*@FromYear) or TransactionTypeID='T00')  AND
				D_C = 'C' AND
				FilterMaster = @AnaID AND BudgetID = @BudgetID AND
				(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
				CorAccountID between @FromCorAccountID AND @ToCorAccountID 				 		 	
	 END
	 ELSE
	 BEGIN
  		SELECT @Amount = -sum(SignAmount), @Amount2 = -sum(SignAmount2)
		From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
				( (TranMonth+TranYear*100 <  @FromMonth + 100*@FromYear) or TransactionTypeID='T00')  AND
				D_C = 'C' AND
				FilterMaster = @AnaID AND BudgetID = @BudgetID AND
				(FilterDetail between @FromAnaID AND  @ToAnaID ) 					 		
	 END	



---- TH12 ---- So du cuoi ky ben No ('ED')

Set @Amount = isnull(@Amount,0)

If @CaculatorID ='ED'
	 If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
	 BEGIN
  		SELECT @Amount = sum(SignAmount), @Amount2 = sum(SignAmount2)
		From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
				( (TranMonth+TranYear*100 <=  @ToMonth + 100*@ToYear) )  AND
				D_C = 'D' AND
				FilterMaster = @AnaID AND BudgetID = @BudgetID AND
				(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
				CorAccountID between @FromCorAccountID AND @ToCorAccountID 			 		 		 	
	 END
	 ELSE
	 BEGIN
  		SELECT @Amount = sum(SignAmount), @Amount2 = sum(SignAmount2)
		From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
				( (TranMonth+TranYear*100 <=  @ToMonth + 100*@ToYear) )   AND
				D_C = 'D' AND
				FilterMaster = @AnaID AND BudgetID = @BudgetID AND
				(FilterDetail between @FromAnaID AND  @ToAnaID ) 						 		
	 END


---- TH13---- So du cuoi ky ben Co ('EC')

Set @Amount = isnull(@Amount,0)

If @CaculatorID ='EC'
	 If  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
	 BEGIN
  		SELECT @Amount = -sum(SignAmount), @Amount2 = -sum(SignAmount2)
		From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
				( (TranMonth+TranYear*100 <=  @ToMonth + 100*@ToYear) )  AND
				D_C = 'C' AND
				FilterMaster = @AnaID AND BudgetID = @BudgetID AND
				(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
				CorAccountID between @FromCorAccountID AND @ToCorAccountID 						 	
	 END
	 ELSE 
	 BEGIN
  		SELECT @Amount = -sum(SignAmount), @Amount2 = -sum(SignAmount2)
		From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
				DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
				( (TranMonth+TranYear*100 <=  @ToMonth + 100*@ToYear) )   AND
				D_C = 'C' AND
				FilterMaster = @AnaID AND BudgetID = @BudgetID AND
				(FilterDetail between @FromAnaID AND  @ToAnaID ) 				 		 	
	 END	

IF (@CustomerName = 161)
BEGIN
	---- Phát sinh có trong kỳ (Period Credit) theo đối tượng
	IF @CaculatorID ='YI'
	BEGIN
		IF ISNULL(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
		BEGIN
			IF @BudgetID = 'AQ'
				BEGIN
				SELECT @Amount = -sum(SignQuantity), @Amount2 = -sum(SignQuantity)
				From AV9091 Where AccountID between @FromAccountID AND @ToAccountID
						AND DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID)
						AND (TranMonth+TranYear*100 between @FromMonth + 100*@FromYear AND @ToMonth + 100*@ToYear)
						AND D_C = 'C' AND TransactionTypeID <>'T00'
						AND FilterMaster = @AnaID AND BudgetID = 'AA'
						AND (FilterDetail between @FromAnaID AND  @ToAnaID )
						AND CorAccountID between @FromCorAccountID AND @ToCorAccountID
			END
			ELSE
			BEGIN
				SELECT @Amount = -sum(SignAmount), @Amount2 = -sum(SignAmount2)
				From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
						DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
						(TranMonth+TranYear*100 between @FromMonth + 100*@FromYear AND @ToMonth + 100*@ToYear)  AND
						D_C = 'C'  AND TransactionTypeID <>'T00' AND
						FilterMaster = @AnaID AND BudgetID = @BudgetID AND
						(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
						CorAccountID between @FromCorAccountID AND @ToCorAccountID
			END
		END
		ELSE
		BEGIN
			SELECT @Amount = -sum(SignAmount), @Amount2 = -sum(SignAmount2)
			From AV9091 Where AccountID between @FromAccountID AND @ToAccountID 
					AND DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID)
					AND (TranMonth+TranYear*100 between @FromMonth + 100*@FromYear AND @ToMonth + 100*@ToYear)
					AND D_C ='C'
					AND TransactionTypeID <>'T00'
					AND FilterMaster = @AnaID AND BudgetID = @BudgetID 
					AND (FilterDetail between @FromAnaID AND  @ToAnaID )
		END
	END

	---- Phát sinh nợ trong kỳ (Period Debit) theo đối tượng
	IF @CaculatorID ='YK'
	BEGIN
		IF  isnull(@FromCorAccountID,'')<>'' or isnull(@ToCorAccountID,'')<>''   --- Co tai khoan doi ung
		BEGIN
			IF @BudgetID = 'AQ'
			BEGIN
				SELECT @Amount = sum(SignQuantity), @Amount2 = sum(SignQuantity)  
				From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
						DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
						(TranMonth+TranYear*100 between @FromMonth + 100*@FromYear AND @ToMonth + 100*@ToYear)  AND
						D_C ='D' AND TransactionTypeID <>'T00' AND
						FilterMaster = @AnaID AND BudgetID = 'AA' AND
						(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
						CorAccountID between @FromCorAccountID AND @ToCorAccountID
			END
			ELSE 
			BEGIN
				SELECT @Amount = sum(SignAmount), @Amount2 = sum(SignAmount2)
				From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
						DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
						(TranMonth+TranYear*100 between @FromMonth + 100*@FromYear AND @ToMonth + 100*@ToYear)  AND
						D_C ='D' AND TransactionTypeID <>'T00' AND
						FilterMaster = @AnaID AND BudgetID = @BudgetID AND
						(FilterDetail between @FromAnaID AND  @ToAnaID ) AND
						CorAccountID between @FromCorAccountID AND @ToCorAccountID	
			END
		END
		ELSE 
		BEGIN
			SELECT @Amount = sum(SignAmount), @Amount2 = sum(SignAmount2)
			From AV9091 Where AccountID between @FromAccountID AND @ToAccountID AND
					DivisionID IN (SELECT DivisionID FROM A00007 WHERE SPID = @@SPID) AND 
					(TranMonth+TranYear*100 between @FromMonth + 100*@FromYear AND @ToMonth + 100*@ToYear)  AND
					D_C ='D'and TransactionTypeID <>'T00' AND
					FilterMaster = @AnaID AND BudgetID = @BudgetID AND
					(FilterDetail between @FromAnaID AND  @ToAnaID )
		END
	END
END

DELETE FROM	A00007 WHERE SPID = @@SPID



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

