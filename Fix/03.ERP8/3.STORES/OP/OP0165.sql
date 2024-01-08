IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0165]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0165]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---Created by : Hai Long, date: 20/08/2016
---purpose: Phân bổ chi phí đơn hàng bán (Khách hàng: ABA)

CREATE PROCEDURE [dbo].[OP0165]  
(  
       @DivisionID nvarchar(50),  
       @TranMonth AS int,  
       @TranYear AS int,  
	   @Mode As Tinyint --0: Phân bổ, 1: Hủy phân bổ
)         
AS  
SET NOCOUNT ON  

If (@Mode = 0) 
Begin
	Declare @AccountID NVARCHAR(50)

	DECLARE @Cursor AS cursor
	SET @Cursor = CURSOR SCROLL KEYSET FOR   
	Select AccountID 
	From OT0005
	Where ISNULL(AccountID, '') <> '' And TypeID Between 'SD21' And 'SD40'
	Group by AccountID
		OPEN @Cursor
		FETCH NEXT FROM @Cursor INTO @AccountID
			WHILE @@FETCH_STATUS = 0  
				BEGIN 
					-- Tính chi phí trên mỗi KM
					SELECT SUM(ISNULL(Amount,0)) AS Amount, Ana01ID 
					INTO #TEMP
					FROM 
					(
						Select ISNULL(OriginalAmount, 0) * ISNULL(ExchangeRate, 1) AS Amount, Ana01ID From AT9000
						Where DivisionID = @DivisionID AND 
						TranMonth = @TranMonth AND 
						TranYear = @TranYear AND 
						DebitAccountID = @AccountID AND
						Ana01ID IS NOT NULL
						UNION ALL
						Select ISNULL(OriginalAmount, 0) * ISNULL(ExchangeRate, 1)*-1 AS Amount, Ana01ID From AT9000
						Where DivisionID = @DivisionID AND 
						TranMonth = @TranMonth AND 
						TranYear = @TranYear AND 
						CreditAccountID = @AccountID AND
						Ana01ID IS NOT NULL
					) A
					GROUP BY Ana01ID

					UPDATE #TEMP
					SET Amount = Amount/KmNumber
					FROM #TEMP
					INNER JOIN 
					(
						SELECT ISNULL(Sum(CASE WHEN ISNUMERIC(OT2002.Varchar10) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar10) END), 0) AS KmNumber, OT2002.Ana01ID 
						FROM OT2002
						INNER JOIN OT2001 on OT2002.SOrderID = OT2001.SOrderID
						WHERE	OT2001.DivisionID = @DivisionID 
								AND OT2001.OrderType = 0  
								AND OT2001.IsConfirm = 1
								AND OT2001.TranMonth = @TranMonth AND OT2001.TranYear = @TranYear
								AND CASE WHEN ISNUMERIC(OT2002.Varchar10) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar10) END > 0
								AND OT2002.Ana01ID IS NOT NULL
						GROUP BY OT2002.Ana01ID
					) A	ON #TEMP.Ana01ID = A.Ana01ID
						
					
					IF EXISTS (SELECT TOP 1 1 FROM #TEMP)
					BEGIN
						--Update vào từng đơn hàng bán trong kỳ
						
						Update OT2002
						SET 
						Varchar11 = Case When EXISTS(Select Top 1 1 From OT0005 Where TypeID = 'SD21' And IsUsed = 1 And AccountID = @AccountID) Then #TEMP.Amount*(CASE WHEN ISNUMERIC(OT2002.Varchar10) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar10) END) Else OT2002.Varchar11 End,
						Varchar12 = Case When EXISTS(Select Top 1 1 From OT0005 Where TypeID = 'SD22' And IsUsed = 1 And AccountID = @AccountID) Then #TEMP.Amount*(CASE WHEN ISNUMERIC(OT2002.Varchar10) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar10) END) Else OT2002.Varchar12 End,
						Varchar13 = Case When EXISTS(Select Top 1 1 From OT0005 Where TypeID = 'SD23' And IsUsed = 1 And AccountID = @AccountID) Then #TEMP.Amount*(CASE WHEN ISNUMERIC(OT2002.Varchar10) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar10) END) Else OT2002.Varchar13 End,
						Varchar14 = Case When EXISTS(Select Top 1 1 From OT0005 Where TypeID = 'SD24' And IsUsed = 1 And AccountID = @AccountID) Then #TEMP.Amount*(CASE WHEN ISNUMERIC(OT2002.Varchar10) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar10) END) Else OT2002.Varchar14 End,
						Varchar15 = Case When EXISTS(Select Top 1 1 From OT0005 Where TypeID = 'SD25' And IsUsed = 1 And AccountID = @AccountID) Then #TEMP.Amount*(CASE WHEN ISNUMERIC(OT2002.Varchar10) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar10) END) Else OT2002.Varchar15 End
						FROM OT2002 
						INNER JOIN OT2001 on OT2002.SOrderID = OT2001.SOrderID
						INNER JOIN #TEMP ON OT2002.Ana01ID = #TEMP.Ana01ID
						WHERE	OT2001.DivisionID = @DivisionID 
								AND OT2001.OrderType = 0  
								AND OT2001.IsConfirm = 1
								AND OT2001.TranMonth = @TranMonth AND OT2001.TranYear = @TranYear

						Update OT2002
						SET nvarchar08 =   CASE WHEN ISNUMERIC(OT2002.nvarchar09) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.nvarchar09) END + CASE WHEN ISNUMERIC(OT2002.nvarchar10) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.nvarchar10) END 
										 + CASE WHEN ISNUMERIC(OT2002.Varchar01) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar01) END + CASE WHEN ISNUMERIC(OT2002.Varchar02) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar02) END 
										 + CASE WHEN ISNUMERIC(OT2002.Varchar04) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar04) END + CASE WHEN ISNUMERIC(OT2002.Varchar05) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar05) END 
										 + CASE WHEN ISNUMERIC(OT2002.Varchar06) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar06) END + CASE WHEN ISNUMERIC(OT2002.Varchar07) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar07) END
										 + CASE WHEN ISNUMERIC(OT2002.Varchar11) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar11) END + CASE WHEN ISNUMERIC(OT2002.Varchar12) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar12) END
										 + CASE WHEN ISNUMERIC(OT2002.Varchar13) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar13) END 
						FROM OT2002 
						INNER JOIN OT2001 on OT2002.SOrderID = OT2001.SOrderID
						INNER JOIN #TEMP ON OT2002.Ana01ID = #TEMP.Ana01ID
						WHERE	OT2001.DivisionID = @DivisionID 
								AND OT2001.OrderType = 0  
								AND OT2001.IsConfirm = 1
								AND OT2001.TranMonth = @TranMonth AND OT2001.TranYear = @TranYear

						UPDATE OT2001
						SET IsAllocation = 1
						FROM OT2001 
						INNER JOIN OT2002 on OT2002.SOrderID = OT2001.SOrderID
						INNER JOIN #TEMP ON OT2002.Ana01ID = #TEMP.Ana01ID
						WHERE	OT2001.DivisionID = @DivisionID 
								AND OT2001.OrderType = 0  
								AND OT2001.IsConfirm = 1
								AND OT2001.TranMonth = @TranMonth AND OT2001.TranYear = @TranYear	
													
					END
				
					DROP TABLE #TEMP
					FETCH NEXT FROM @Cursor INTO @AccountID
				END
End
Else
Begin
	Update OT2002
	Set 
	Varchar11 = NULL,
	Varchar12 = NULL,
	Varchar13 = NULL,
	Varchar14 = NULL,
	Varchar15 = NULL
	FROM OT2002 INNER JOIN OT2001 on OT2002.SOrderID = OT2001.SOrderID
	WHERE	OT2001.DivisionID = @DivisionID 
			AND OT2001.OrderType = 0  
			AND OT2001.IsConfirm = 1
			AND OT2001.TranMonth = @TranMonth AND OT2001.TranYear = @TranYear

	Update OT2002
	SET nvarchar08 =   CASE WHEN ISNUMERIC(OT2002.nvarchar09) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.nvarchar09) END + CASE WHEN ISNUMERIC(OT2002.nvarchar10) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.nvarchar10) END 
					 + CASE WHEN ISNUMERIC(OT2002.Varchar01) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar01) END + CASE WHEN ISNUMERIC(OT2002.Varchar02) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar02) END 
					 + CASE WHEN ISNUMERIC(OT2002.Varchar04) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar04) END + CASE WHEN ISNUMERIC(OT2002.Varchar05) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar05) END 
					 + CASE WHEN ISNUMERIC(OT2002.Varchar06) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar06) END + CASE WHEN ISNUMERIC(OT2002.Varchar07) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar07) END
					 + CASE WHEN ISNUMERIC(OT2002.Varchar11) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar11) END + CASE WHEN ISNUMERIC(OT2002.Varchar12) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar12) END
					 + CASE WHEN ISNUMERIC(OT2002.Varchar13) = 0 THEN 0 ELSE CONVERT(DECIMAL(28,8), OT2002.Varchar13) END 
	FROM OT2002 INNER JOIN OT2001 on OT2002.SOrderID = OT2001.SOrderID
	WHERE	OT2001.DivisionID = @DivisionID 
			AND OT2001.OrderType = 0  
			AND OT2001.IsConfirm = 1
			AND OT2001.TranMonth = @TranMonth AND OT2001.TranYear = @TranYear

	UPDATE OT2001
	SET IsAllocation = 0
	WHERE	DivisionID = @DivisionID 
			AND OrderType = 0  
			AND IsConfirm = 1
			AND TranMonth = @TranMonth AND TranYear = @TranYear	
End


SET NOCOUNT OFF  


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO