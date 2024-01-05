IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0019_DATE]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0019_DATE]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO












---- Created by Trọng Kiên
---- Date 09/12/2020
---- Purpose: Lọc ra các đơn hàng sắp đến ngày giao
-- exec OP0019_Date 'MT', NULL

CREATE PROCEDURE [dbo].[OP0019_Date] 
	@DivisionID NVARCHAR(50),
	@SOrderID NVARCHAR(50),
	@DeliveryDate VARCHAR(50),
	@UserID VARCHAR(50)
								
AS

DECLARE @sSQL01 NVARCHAR(MAX) = N'',
		@sSQL02 VARCHAR(MAX) = N'',
		@sSQL03 NVARCHAR(MAX) = N'',
		@sSQL04 NVARCHAR(MAX) = N'',
		@CustomizeIndex INT = -1

SET @CustomizeIndex = (SELECT CustomerName FROM CustomerIndex)

IF (@CustomizeIndex = 117) --- Customize Mai Thư
BEGIN
    SET @sSQL01 = N'SELECT	OT2002.InventoryID, OT2001.SOrderID, 
					G.ActualQuantity, 
					ISNULL(OT2002.OrderQuantity, 0) - ISNULL(G.ActualQuantity, 0)  AS EndQuantity, 
					OT2002.TransactionID,
					OT2002.Quantity01, OT2002.Quantity02, OT2002.Quantity03, OT2002.Quantity04, 
					OT2002.Quantity05, OT2002.Quantity06, OT2002.Quantity07, OT2002.Quantity08, OT2002.Quantity09, OT2002.Quantity10, 
					OT2002.Quantity11, OT2002.Quantity12, OT2002.Quantity13, OT2002.Quantity14, OT2002.Quantity15, OT2002.Quantity16, OT2002.Quantity17, OT2002.Quantity18, 
					OT2002.Quantity19, OT2002.Quantity20, 
					OT2002.Quantity21, OT2002.Quantity22, OT2002.Quantity23, OT2002.Quantity24, OT2002.Quantity25, OT2002.Quantity26, OT2002.Quantity27, OT2002.Quantity28, 
					OT2002.Quantity29, OT2002.Quantity30, 
		            OT2003_MT.Date,
					CONVERT (DECIMAL(28,8), 0) AS QUTY,
					CONVERT(DATETIME, ''1900-01-01'') AS MAXDAY,
					CONVERT(VARCHAR,((CONVERT(INT, CONVERT(DATETIME,DATE)) - CONVERT(INT, CONVERT(DATETIME,GETDATE()))))) AS DatePlan
					INTO #OT2003_AT3206_AG
					FROM OT2003_MT WITH (NOLOCK)
					LEFT JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = OT2003_MT.DivisionID AND OT2001.SOrderID = OT2003_MT.SOrderID
					LEFT JOIN OT2002 WITH (NOLOCK) ON OT2002.DivisionID = OT2001.DivisionID AND OT2002.SOrderID = OT2001.SOrderID
					INNER JOIN AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (''@@@'', OT2002.DivisionID) AND AT1302.InventoryID = OT2002.InventoryID
					LEFT JOIN (SELECT DivisionID, OrderID, OTransactionID, ISNULL(SUM(ActualQuantity), 0) AS ActualQuantity
												FROM AT3206_AG WITH (NOLOCK)  
												GROUP BY DivisionID, OrderID, OTransactionID) AS G ON OT2001.DivisionID = G.DivisionID AND
												OT2002.SOrderID = G.OrderID AND
												OT2002.TransactionID = G.OTransactionID
					LEFT JOIN SOT9020 S1 WITH (NOLOCK) ON OT2001.APK = S1.APKMaster AND S1.TableID = ''OT2001''
					WHERE OT2001.DivisionID = '''+@DivisionID+'''
						AND OrderType = 0	 
						AND OT2002.Finish = 0 
						AND ISNULL (AT1302.IsStocked, 0) = 1 
						AND ISNULL(OT2002.OrderQuantity, 0) - ISNULL(G.ActualQuantity, 0) > 0  
						AND (S1.FollowerID01 = '''+@UserID+''' OR S1.FollowerID02 = '''+@UserID+''' OR S1.FollowerID03 = '''+@UserID+''' OR S1.FollowerID04 = '''+@UserID+'''
						     OR S1.FollowerID05 = '''+@UserID+''' OR S1.FollowerID06 = '''+@UserID+''' OR S1.FollowerID07 = '''+@UserID+''' OR S1.FollowerID08 = '''+@UserID+'''
							 OR S1.FollowerID09 = '''+@UserID+''' OR S1.FollowerID10 = '''+@UserID+''' OR S1.FollowerID11 = '''+@UserID+''' OR S1.FollowerID12 = '''+@UserID+'''
							 OR S1.FollowerID13 = '''+@UserID+''' OR S1.FollowerID14 = '''+@UserID+''' OR S1.FollowerID15 = '''+@UserID+''' OR S1.FollowerID16 = '''+@UserID+'''
							 OR S1.FollowerID17 = '''+@UserID+''' OR S1.FollowerID18 = '''+@UserID+''' OR S1.FollowerID19 = '''+@UserID+''' OR S1.FollowerID20 = '''+@UserID+''')
						AND OT2001.SOrderID LIKE CASE WHEN ISNULL('''+ @SOrderID +''', '''') = '''' THEN ''%'' ELSE '''+ @SOrderID +''' END '

    SET @sSQL02 = N' DECLARE @i INT, @n INT,
					 @si VARCHAR(2), @Sql NVARCHAR(2000)
					 SELECT @i = 1, @n = 30 


					 WHILE (@i <=@n)
					 BEGIN
						 SELECT @si = CASE WHEN @i < 10 THEN ''0''+CONVERT(VARCHAR(1), @i) ELSE CONVERT(VARCHAR(2), @i) END
	
						 SET @sql = N''

						 UPDATE #OT2003_AT3206_AG
						 SET QUTY = ISNULL(QUTY, 0) + ISNULL(Quantity''+@si+'', 0)
						 WHERE DatePlan = '''''+@DeliveryDate+'''''

						 UPDATE #OT2003_AT3206_AG
						 SET MAXDAY = Date
						 WHERE DATEDIFF (d, Date, GETDATE()) < DATEDIFF (d, MAXDAY, GETDATE()) 
						 AND DatePlan = '''''+@DeliveryDate+'''''''
						
						 EXEC(@sql)

						 SET @i = @i + 1
					 END

					 SELECT DISTINCT SOrderID, MAXDAY as Date 
					 FROM #OT2003_AT3206_AG 
					 WHERE ISNULL(QUTY, 0) > ISNULL(ActualQuantity, 0)

					 DROP TABLE #OT2003_AT3206_AG '
END
ELSE
BEGIN
    SET @sSQL03 = N'SELECT	OT2002.InventoryID, OT2001.SOrderID, 
							G.ActualQuantity, 
							ISNULL(OT2002.OrderQuantity, 0) - ISNULL(G.ActualQuantity, 0)  AS EndQuantity, 
							OT2002.TransactionID,
							OT2002.Quantity01, OT2002.Quantity02, OT2002.Quantity03, OT2002.Quantity04, 
							OT2002.Quantity05, OT2002.Quantity06, OT2002.Quantity07, OT2002.Quantity08, OT2002.Quantity09, OT2002.Quantity10, 
							OT2002.Quantity11, OT2002.Quantity12, OT2002.Quantity13, OT2002.Quantity14, OT2002.Quantity15, OT2002.Quantity16, OT2002.Quantity17, OT2002.Quantity18, 
							OT2002.Quantity19, OT2002.Quantity20, 
							OT2002.Quantity21, OT2002.Quantity22, OT2002.Quantity23, OT2002.Quantity24, OT2002.Quantity25, OT2002.Quantity26, OT2002.Quantity27, OT2002.Quantity28, 
							OT2002.Quantity29, OT2002.Quantity30, 
							OT2003.Date01, OT2003.Date02, OT2003.Date03, OT2003.Date04, OT2003.Date05, OT2003.Date06, OT2003.Date07, OT2003.Date08, OT2003.Date09, OT2003.Date10,
							OT2003.Date11, OT2003.Date12, OT2003.Date13, OT2003.Date14, OT2003.Date15, OT2003.Date16, OT2003.Date17, OT2003.Date18, OT2003.Date19, OT2003.Date20,
							OT2003.Date21, OT2003.Date22, OT2003.Date23, OT2003.Date24, OT2003.Date25, OT2003.Date26, OT2003.Date27, OT2003.Date28, OT2003.Date29, OT2003.Date30,		
							CONVERT (DECIMAL(28,8), 0) AS QUTY,
							CONVERT(DATETIME,''1900-01-01'') AS MAXDAY
			        
					INTO #OT2003_AT3206_AG
			        FROM OT2003 WITH (NOLOCK)
			        LEFT JOIN OT2001 WITH (NOLOCK) ON OT2001.DivisionID = OT2003.DivisionID AND OT2001.SOrderID = OT2003.SOrderID
			        LEFT JOIN OT2002 WITH (NOLOCK) ON OT2002.DivisionID = OT2001.DivisionID AND OT2002.SOrderID = OT2001.SOrderID
			        INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', OT2002.DivisionID) AND AT1302.InventoryID = OT2002.InventoryID
			        LEFT JOIN (SELECT DivisionID, OrderID, OTransactionID, ISNULL(SUM(ActualQuantity), 0) AS ActualQuantity
										FROM AT3206_AG WITH (NOLOCK)  
										GROUP BY DivisionID, OrderID, OTransactionID) AS G ON OT2001.DivisionID = G.DivisionID AND
										OT2002.SOrderID = G.OrderID AND
										OT2002.TransactionID = G.OTransactionID
					LEFT JOIN SOT9020 S1 WITH (NOLOCK) ON OT2001.APK = S1.APKMaster AND S1.TableID = ''OT2001''
			        WHERE OT2001.DivisionID = '''+@DivisionID+'''
				    AND OrderType = 0	 
				    AND OT2002.Finish = 0 
				    AND ISNULL (AT1302.IsStocked,0) = 1 
				    AND ISNULL(OT2002.OrderQuantity, 0) - ISNULL(G.ActualQuantity, 0) > 0
					AND (S1.FollowerID01 = '''+@UserID+''' OR S1.FollowerID02 = '''+@UserID+''' OR S1.FollowerID03 = '''+@UserID+''' OR S1.FollowerID04 = '''+@UserID+'''
					OR S1.FollowerID05 = '''+@UserID+''' OR S1.FollowerID06 = '''+@UserID+''' OR S1.FollowerID07 = '''+@UserID+''' OR S1.FollowerID08 = '''+@UserID+'''
					OR S1.FollowerID09 = '''+@UserID+''' OR S1.FollowerID10 = '''+@UserID+''' OR S1.FollowerID11 = '''+@UserID+''' OR S1.FollowerID12 = '''+@UserID+'''
					OR S1.FollowerID13 = '''+@UserID+''' OR S1.FollowerID14 = '''+@UserID+''' OR S1.FollowerID15 = '''+@UserID+''' OR S1.FollowerID16 = '''+@UserID+'''
					OR S1.FollowerID17 = '''+@UserID+''' OR S1.FollowerID18 = '''+@UserID+''' OR S1.FollowerID19 = '''+@UserID+''' OR S1.FollowerID20 = '''+@UserID+''')  
				    AND OT2001.SOrderID LIKE CASE WHEN ISNULL('''+ @SOrderID +''', '''') = '''' THEN ''%'' ELSE '''+ @SOrderID +''' END'

    SET @sSQL04 = N' DECLARE @i INT, @n INT,
					         @si VARCHAR(2), @Sql NVARCHAR(2000)

					 SELECT @i = 1, @n = 30

					 WHILE (@i <=@n)
					 BEGIN
						 SELECT @si = CASE WHEN @i < 10 THEN ''0''+CONVERT(VARCHAR(1), @i) ELSE CONVERT(VARCHAR(2), @i) END
	
						 SET @sql = N''

						 UPDATE #OT2003_AT3206_AG
						 SET QUTY = ISNULL(QUTY, 0) + ISNULL(Quantity''+@si+'', 0)
						 WHERE Date''+@si+'' <= GetDate()

						 UPDATE #OT2003_AT3206_AG
						 SET MAXDAY = Date''+@si+''
						 WHERE DATEDIFF (d, Date''+@si+'', GETDATE()) < DATEDIFF (d, MAXDAY, GETDATE()) 
						 AND Date''+@si+'' <= GetDate()''
						
						 EXEC(@sql)

						 SET @i = @i + 1
					 END

					 SELECT DISTINCT SOrderID, MAXDAY AS Date 
					 FROM #OT2003_AT3206_AG 
					 WHERE ISNULL(QUTY, 0) > ISNULL(ActualQuantity, 0)

					 DROP TABLE #OT2003_AT3206_AG '

END

EXEC (@sSQL01 + ' ' + @sSQL02 + ' ' + @sSQL03 + ' ' + @sSQL04) 









GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
