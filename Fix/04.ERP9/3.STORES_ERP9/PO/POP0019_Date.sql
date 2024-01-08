IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP0019_DATE]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP0019_DATE]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO












---- Created by Trọng Kiên
---- Date 09/12/2020
---- Purpose: Lọc ra các đơn hàng sắp đến ngày nhận
-- exec POP0019_Date 'MT', NULL
----Editted by: Nhật Quang , Date: 04/08/2022: Bổ sung thêm số lượng người theo dõi từ 20 lên 50.
CREATE PROCEDURE [dbo].[POP0019_Date] 
	@DivisionID NVARCHAR(50),
	@POrderID NVARCHAR(50),
	@NumberRecieveDay VARCHAR(50),
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
    SET @sSQL01 = N'SELECT	OT3002.InventoryID, OT3001.POrderID, 
					G.ActualQuantity, 
					ISNULL(OT3002.OrderQuantity, 0) - ISNULL(G.ActualQuantity, 0)  AS EndQuantity, 
					OT3002.TransactionID,
					OT3002.Quantity01, OT3002.Quantity02, OT3002.Quantity03, OT3002.Quantity04, 
					OT3002.Quantity05, OT3002.Quantity06, OT3002.Quantity07, OT3002.Quantity08, OT3002.Quantity09, OT3002.Quantity10, 
					OT3002.Quantity11, OT3002.Quantity12, OT3002.Quantity13, OT3002.Quantity14, OT3002.Quantity15, OT3002.Quantity16, OT3002.Quantity17, OT3002.Quantity18, 
					OT3002.Quantity19, OT3002.Quantity20, 
					OT3002.Quantity21, OT3002.Quantity22, OT3002.Quantity23, OT3002.Quantity24, OT3002.Quantity25, OT3002.Quantity26, OT3002.Quantity27, OT3002.Quantity28, 
					OT3002.Quantity29, OT3002.Quantity30, 
		            OT3003_MT.Date,
					CONVERT (DECIMAL(28,8), 0) AS QUTY,
					CONVERT(DATETIME, ''1900-01-01'') AS MAXDAY,
					CONVERT(VARCHAR,((CONVERT(INT, CONVERT(DATETIME,DATE)) - CONVERT(INT, CONVERT(DATETIME,GETDATE()))))) AS DatePlan
					INTO #OT3003_AT3206_AG
					FROM OT3003_MT WITH (NOLOCK)
					LEFT JOIN OT3001 WITH (NOLOCK) ON OT3001.DivisionID = OT3003_MT.DivisionID AND OT3001.POrderID = OT3003_MT.POrderID
					LEFT JOIN OT3002 WITH (NOLOCK) ON OT3002.DivisionID = OT3001.DivisionID AND OT3002.POrderID = OT3001.POrderID
					INNER JOIN AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (''@@@'', OT3002.DivisionID) AND AT1302.InventoryID = OT3002.InventoryID
					LEFT JOIN (SELECT DivisionID, OrderID, OTransactionID, ISNULL(SUM(ActualQuantity), 0) AS ActualQuantity
												FROM AT3206_AG WITH (NOLOCK)  
												GROUP BY DivisionID, OrderID, OTransactionID) AS G ON OT3001.DivisionID = G.DivisionID AND
												OT3002.POrderID = G.OrderID AND
												OT3002.TransactionID = G.OTransactionID
					LEFT JOIN POT9020 P1 WITH (NOLOCK) ON OT3001.APK = P1.APKMaster AND P1.TableID = ''OT3001''
					WHERE OT3001.DivisionID = '''+@DivisionID+'''
						AND OrderType = 0	 
				        AND ISNULL(OT3002.Finish, 0) = 0 
						AND ISNULL (AT1302.IsStocked, 0) = 1 
						AND ISNULL(OT3002.OrderQuantity, 0) - ISNULL(G.ActualQuantity, 0) > 0  
						AND (P1.FollowerID01 = '''+@UserID+''' OR P1.FollowerID02 = '''+@UserID+''' OR P1.FollowerID03 = '''+@UserID+''' OR P1.FollowerID04 = '''+@UserID+'''
						     OR P1.FollowerID05 = '''+@UserID+''' OR P1.FollowerID06 = '''+@UserID+''' OR P1.FollowerID07 = '''+@UserID+''' OR P1.FollowerID08 = '''+@UserID+'''
							 OR P1.FollowerID09 = '''+@UserID+''' OR P1.FollowerID10 = '''+@UserID+''' OR P1.FollowerID11 = '''+@UserID+''' OR P1.FollowerID12 = '''+@UserID+'''
							 OR P1.FollowerID13 = '''+@UserID+''' OR P1.FollowerID14 = '''+@UserID+''' OR P1.FollowerID15 = '''+@UserID+''' OR P1.FollowerID16 = '''+@UserID+'''
							 OR P1.FollowerID17 = '''+@UserID+''' OR P1.FollowerID18 = '''+@UserID+''' OR P1.FollowerID19 = '''+@UserID+''' OR P1.FollowerID20 = '''+@UserID+''' OR P1.FollowerID21 = '''+@UserID+''' OR P1.FollowerID22 = '''+@UserID+''' OR P1.FollowerID23 = '''+@UserID+''' OR P1.FollowerID24 = '''+@UserID+''' OR P1.FollowerID25 = '''+@UserID+''' OR P1.FollowerID26 = '''+@UserID+''' OR P1.FollowerID27 = '''+@UserID+''' OR P1.FollowerID28 = '''+@UserID+''' OR P1.FollowerID29 = '''+@UserID+''' OR P1.FollowerID30 = '''+@UserID+''' OR P1.FollowerID31 = '''+@UserID+''' OR P1.FollowerID32 = '''+@UserID+''' OR P1.FollowerID33 = '''+@UserID+''' OR P1.FollowerID34 = '''+@UserID+''' OR P1.FollowerID35 = '''+@UserID+''' OR P1.FollowerID36 = '''+@UserID+''' OR P1.FollowerID37 = '''+@UserID+''' OR P1.FollowerID38 = '''+@UserID+''' OR P1.FollowerID39 = '''+@UserID+''' OR P1.FollowerID40 = '''+@UserID+''' OR P1.FollowerID41 = '''+@UserID+''' OR P1.FollowerID42 = '''+@UserID+''' OR P1.FollowerID43 = '''+@UserID+''' OR P1.FollowerID44 = '''+@UserID+''' OR P1.FollowerID45 = '''+@UserID+''' OR P1.FollowerID46 = '''+@UserID+''' OR P1.FollowerID47 = '''+@UserID+''' OR P1.FollowerID48 = '''+@UserID+''' OR P1.FollowerID49 = '''+@UserID+''' OR P1.FollowerID50 = '''+@UserID+''')
						AND OT3001.POrderID LIKE CASE WHEN ISNULL('''+ @POrderID +''', '''') = '''' THEN ''%'' ELSE '''+ @POrderID +''' END '

    SET @sSQL02 = N' DECLARE @i INT, @n INT,
					 @si VARCHAR(2), @Sql NVARCHAR(2000)
					 SELECT @i = 1, @n = 30 


					 WHILE (@i <=@n)
					 BEGIN
						 SELECT @si = CASE WHEN @i < 10 THEN ''0''+CONVERT(VARCHAR(1), @i) ELSE CONVERT(VARCHAR(2), @i) END
	
						 SET @sql = N''

						 UPDATE #OT3003_AT3206_AG
						 SET QUTY = ISNULL(QUTY, 0) + ISNULL(Quantity''+@si+'', 0)
						 WHERE DatePlan = '''''+@NumberRecieveDay+'''''

						 UPDATE #OT3003_AT3206_AG
						 SET MAXDAY = Date
						 WHERE DATEDIFF (d, Date, GETDATE()) < DATEDIFF (d, MAXDAY, GETDATE()) 
						 AND DatePlan = '''''+@NumberRecieveDay+'''''''
						
						 EXEC(@sql)

						 SET @i = @i + 1
					 END

					 SELECT DISTINCT POrderID, MAXDAY as Date 
					 FROM #OT3003_AT3206_AG 
					 WHERE ISNULL(QUTY, 0) > ISNULL(ActualQuantity, 0)

					 DROP TABLE #OT3003_AT3206_AG '
END
ELSE
BEGIN
    SET @sSQL03 = N'SELECT	OT3002.InventoryID, OT3001.POrderID, 
							G.ActualQuantity, 
							ISNULL(OT3002.OrderQuantity, 0) - ISNULL(G.ActualQuantity, 0)  AS EndQuantity, 
							OT3002.TransactionID,
							OT3002.Quantity01, OT3002.Quantity02, OT3002.Quantity03, OT3002.Quantity04, 
							OT3002.Quantity05, OT3002.Quantity06, OT3002.Quantity07, OT3002.Quantity08, OT3002.Quantity09, OT3002.Quantity10, 
							OT3002.Quantity11, OT3002.Quantity12, OT3002.Quantity13, OT3002.Quantity14, OT3002.Quantity15, OT3002.Quantity16, OT3002.Quantity17, OT3002.Quantity18, 
							OT3002.Quantity19, OT3002.Quantity20, 
							OT3002.Quantity21, OT3002.Quantity22, OT3002.Quantity23, OT3002.Quantity24, OT3002.Quantity25, OT3002.Quantity26, OT3002.Quantity27, OT3002.Quantity28, 
							OT3002.Quantity29, OT3002.Quantity30, 
							OT3003.Date01, OT3003.Date02, OT3003.Date03, OT3003.Date04, OT3003.Date05, OT3003.Date06, OT3003.Date07, OT3003.Date08, OT3003.Date09, OT3003.Date10,
							OT3003.Date11, OT3003.Date12, OT3003.Date13, OT3003.Date14, OT3003.Date15, OT3003.Date16, OT3003.Date17, OT3003.Date18, OT3003.Date19, OT3003.Date20,
							OT3003.Date21, OT3003.Date22, OT3003.Date23, OT3003.Date24, OT3003.Date25, OT3003.Date26, OT3003.Date27, OT3003.Date28, OT3003.Date29, OT3003.Date30,		
							CONVERT (DECIMAL(28,8), 0) AS QUTY,
							CONVERT(DATETIME,''1900-01-01'') AS MAXDAY
			        
					INTO #OT3003_AT3206_AG
			        FROM OT3003 WITH (NOLOCK)
			        LEFT JOIN OT3001 WITH (NOLOCK) ON OT3001.DivisionID = OT3003.DivisionID AND OT3001.POrderID = OT3003.POrderID
			        LEFT JOIN OT3002 WITH (NOLOCK) ON OT3002.DivisionID = OT3001.DivisionID AND OT3002.POrderID = OT3001.POrderID
			        INNER JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (''@@@'', OT3002.DivisionID) AND AT1302.InventoryID = OT3002.InventoryID
			        LEFT JOIN (SELECT DivisionID, OrderID, OTransactionID, ISNULL(SUM(ActualQuantity), 0) AS ActualQuantity
										FROM AT3206_AG WITH (NOLOCK)  
										GROUP BY DivisionID, OrderID, OTransactionID) AS G ON OT3001.DivisionID = G.DivisionID AND
										OT3002.POrderID = G.OrderID AND
										OT3002.TransactionID = G.OTransactionID
					LEFT JOIN SOT9020 P1 WITH (NOLOCK) ON OT3001.APK = P1.APKMaster AND P1.TableID = ''OT3001''
			        WHERE OT3001.DivisionID = '''+@DivisionID+'''
				    AND OrderType = 0	 
				    AND ISNULL(OT3002.Finish, 0) = 0 
				    AND ISNULL (AT1302.IsStocked,0) = 1 
				    AND ISNULL(OT3002.OrderQuantity, 0) - ISNULL(G.ActualQuantity, 0) > 0
					AND (P1.FollowerID01 = '''+@UserID+''' OR P1.FollowerID02 = '''+@UserID+''' OR P1.FollowerID03 = '''+@UserID+''' OR P1.FollowerID04 = '''+@UserID+'''
					OR P1.FollowerID05 = '''+@UserID+''' OR P1.FollowerID06 = '''+@UserID+''' OR P1.FollowerID07 = '''+@UserID+''' OR P1.FollowerID08 = '''+@UserID+'''
					OR P1.FollowerID09 = '''+@UserID+''' OR P1.FollowerID10 = '''+@UserID+''' OR P1.FollowerID11 = '''+@UserID+''' OR P1.FollowerID12 = '''+@UserID+'''
					OR P1.FollowerID13 = '''+@UserID+''' OR P1.FollowerID14 = '''+@UserID+''' OR P1.FollowerID15 = '''+@UserID+''' OR P1.FollowerID16 = '''+@UserID+'''
					OR P1.FollowerID17 = '''+@UserID+''' OR P1.FollowerID18 = '''+@UserID+''' OR P1.FollowerID19 = '''+@UserID+''' OR P1.FollowerID20 = '''+@UserID+''' OR P1.FollowerID21 = '''+@UserID+''' OR P1.FollowerID22 = '''+@UserID+''' OR P1.FollowerID23 = '''+@UserID+''' OR P1.FollowerID24 = '''+@UserID+''' OR P1.FollowerID25 = '''+@UserID+''' OR P1.FollowerID26 = '''+@UserID+''' OR P1.FollowerID27 = '''+@UserID+''' OR P1.FollowerID28 = '''+@UserID+''' OR P1.FollowerID29 = '''+@UserID+''' OR P1.FollowerID30 = '''+@UserID+''' OR P1.FollowerID31 = '''+@UserID+''' OR P1.FollowerID32 = '''+@UserID+''' OR P1.FollowerID33 = '''+@UserID+''' OR P1.FollowerID34 = '''+@UserID+''' OR P1.FollowerID35 = '''+@UserID+''' OR P1.FollowerID36 = '''+@UserID+''' OR P1.FollowerID37 = '''+@UserID+''' OR P1.FollowerID38 = '''+@UserID+''' OR P1.FollowerID39 = '''+@UserID+''' OR P1.FollowerID40 = '''+@UserID+''' OR
					  P1.FollowerID41 = '''+@UserID+''' OR P1.FollowerID42 = '''+@UserID+''' OR P1.FollowerID43 = '''+@UserID+''' OR
					  P1.FollowerID44 = '''+@UserID+''' OR P1.FollowerID45 = '''+@UserID+''' OR P1.FollowerID46 = '''+@UserID+''' OR
					  P1.FollowerID47 = '''+@UserID+''' OR P1.FollowerID48 = '''+@UserID+''' OR P1.FollowerID49 = '''+@UserID+''' OR
					  P1.FollowerID50 = '''+@UserID+''')  
				    AND OT3001.POrderID LIKE CASE WHEN ISNULL('''+ @POrderID +''', '''') = '''' THEN ''%'' ELSE '''+ @POrderID +''' END'

    SET @sSQL04 = N' DECLARE @i INT, @n INT,
					         @si VARCHAR(2), @Sql NVARCHAR(2000)

					 SELECT @i = 1, @n = 30

					 WHILE (@i <=@n)
					 BEGIN
						 SELECT @si = CASE WHEN @i < 10 THEN ''0''+CONVERT(VARCHAR(1), @i) ELSE CONVERT(VARCHAR(2), @i) END
	
						 SET @sql = N''

						 UPDATE #OT3003_AT3206_AG
						 SET QUTY = ISNULL(QUTY, 0) + ISNULL(Quantity''+@si+'', 0)
						 WHERE Date''+@si+'' <= GetDate()

						 UPDATE #OT3003_AT3206_AG
						 SET MAXDAY = Date''+@si+''
						 WHERE DATEDIFF (d, Date''+@si+'', GETDATE()) < DATEDIFF (d, MAXDAY, GETDATE()) 
						 AND Date''+@si+'' <= GetDate()''
						
						 EXEC(@sql)

						 SET @i = @i + 1
					 END

					 SELECT DISTINCT POrderID, MAXDAY AS Date 
					 FROM #OT3003_AT3206_AG 
					 WHERE ISNULL(QUTY, 0) > ISNULL(ActualQuantity, 0)

					 DROP TABLE #OT3003_AT3206_AG '

END

EXEC (@sSQL01 + ' ' + @sSQL02 + ' ' + @sSQL03 + ' ' + @sSQL04) 









GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
