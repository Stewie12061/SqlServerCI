IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BP3005]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[BP3005]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Biểu đồ sản lượng sản xuất
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- Noi goi: BI\Finance\Biểu đồ  sản lượng sản xuất
-- <History>
---- Create on 28/06/2016 by Phuong Thao: 
---- Modified on 28/06/2016 by Phuong Thao
---- Modified on 22/05/2017 by Bảo Thy: Sửa danh mục dùng chung
---- Modified by Tiểu Mai on 10/07/2017: Chỉnh sửa cách lọc dữ liệu theo yêu cầu khách hàng (Phụ lục 2)
---- Modified by Tiểu Mai on 23/08/2017: Bổ sung tham số MPT mặt hàng 03
---- Modified by Tiểu Mai on 11/10/2017: Chỉnh sửa lại cách sắp xếp thứ tự hiển thị
---- Modified by Văn Tài  on 25/04/2022: Bổ sung điều kiện DivisionID @@@.
-- <Example>
---- EXEC BP3005 'ANG', 1, 2017, 7,2017,'TBSW140','TBSW260','TKUW80N01','TKUW80N02','BNKU05', 'BNKU09', '', '', '', '', '', '', ''
CREATE PROCEDURE BP3005
( 
	@DivisionID VARCHAR(50), 	
	@FromMonth INT, 
	@FromYear INT, 	
	@ToMonth INT, 
	@ToYear INT, 		
	@FromInventoryID01 VARCHAR(50),
	@ToInventoryID01 VARCHAR(50),
	@FromInventoryID02 VARCHAR(50),
	@ToInventoryID02 VARCHAR(50),
	@FromInventoryID03 VARCHAR(50),
	@ToInventoryID03 VARCHAR(50),
	@FromInventoryID04 VARCHAR(50),
	@ToInventoryID04 VARCHAR(50),
	@FromInventoryID05 VARCHAR(50),
	@ToInventoryID05 VARCHAR(50),
	@FromInventoryTypeID VARCHAR(50) = '',
	@ToInventoryTypeID VARCHAR(50) = '',
	@FromI03ID VARCHAR(50) = '',
	@ToI03ID VARCHAR(50) = ''
) 
AS
SET NOCOUNT ON


DECLARE	@sSQL1 as nvarchar(MAX),
		@sSQL2 as nvarchar(MAX),
		@sSQL3 as nvarchar(MAX),		
		@sSQL4 as Varchar(MAX),
		@sSQL5 as varchar(MAX),
		@sSQL6 as Nvarchar(MAX),			
		@sSQL7 as varchar(MAX),
		@strwhereAnaID  nvarchar(MAX)	

SET @sSQL1 = N''
SET @sSQL2 = N''

DECLARE @Cur_Ware CURSOR, @GroupID NVARCHAR(50), @FromInventoryID NVARCHAR(50), @ToInventoryID NVARCHAR(50)

SET @Cur_Ware = CURSOR SCROLL KEYSET FOR 
	SELECT GroupID, FromInventoryID, ToInventoryID
	FROM (
		SELECT 'Group01' AS GroupID, @FromInventoryID01 AS FromInventoryID, @ToInventoryID01 AS ToInventoryID
		FROM AT1302 WITH (NOLOCK)
		WHERE AT1302.DivisionID IN ('@@@', @DivisionID)
				AND ISNULL(@FromInventoryID01,'') <> '' AND ISNULL(@ToInventoryID01,'') <> '' 
				AND (InventoryID BETWEEN @FromInventoryID01 AND @ToInventoryID01)
		UNION
		SELECT 'Group02' AS GroupID, @FromInventoryID02 AS FromInventoryID, @ToInventoryID02 AS ToInventoryID
		FROM AT1302 WITH (NOLOCK)
		WHERE AT1302.DivisionID IN ('@@@', @DivisionID)
				AND ISNULL(@FromInventoryID02,'') <> '' AND ISNULL(@ToInventoryID02,'') <> '' 
				AND (InventoryID BETWEEN @FromInventoryID02 AND @ToInventoryID02)
		UNION
		SELECT 'Group03' AS GroupID, @FromInventoryID03 AS FromInventoryID, @ToInventoryID03 AS ToInventoryID
		FROM AT1302 WITH (NOLOCK)
		WHERE AT1302.DivisionID IN ('@@@', @DivisionID)
				AND ISNULL(@FromInventoryID03,'') <> '' AND ISNULL(@ToInventoryID03,'') <> '' 
				AND (InventoryID BETWEEN @FromInventoryID03 AND @ToInventoryID03)
		UNION
		SELECT 'Group04' AS GroupID, @FromInventoryID04 AS FromInventoryID, @ToInventoryID04 AS ToInventoryID
		FROM AT1302 WITH (NOLOCK)
		WHERE AT1302.DivisionID IN ('@@@', @DivisionID)
				AND ISNULL(@FromInventoryID04,'') <> '' AND ISNULL(@ToInventoryID04,'') <> '' 
				AND (InventoryID BETWEEN @FromInventoryID04 AND @ToInventoryID04)
		UNION
		SELECT 'Group05' AS GroupID, @FromInventoryID05 AS FromInventoryID, @ToInventoryID05 AS ToInventoryID
		FROM AT1302 WITH (NOLOCK)
		WHERE AT1302.DivisionID IN ('@@@', @DivisionID)
				AND ISNULL(@FromInventoryID05,'') <> '' AND ISNULL(@ToInventoryID05,'') <> '' 
				AND (InventoryID BETWEEN @FromInventoryID05 AND @ToInventoryID05)
	) T
	ORDER BY T.GroupID    
OPEN @Cur_Ware
FETCH NEXT FROM @Cur_Ware INTO @GroupID, @FromInventoryID, @ToInventoryID

WHILE @@Fetch_Status = 0 
	BEGIN
		IF ISNULL(@sSQL1,'') <> ''
			SET @sSQL1 = @sSQL1 + '
				UNION
				SELECT '''+@GroupID+''' as GroupID, T1.DivisionID, T1.TranMonth, T1.TranYear, '''+@GroupID+''' AS ProductID, SUM(T2.ActualQuantity) AS Quantity
				FROM	MT1802 T2 with (nolock)	
				INNER JOIN MT1801 T1 with (nolock) ON T2.DivisionID = T1.DivisionID AND T1.VoucherID = T2.VoucherID 
				LEFT JOIN AT1302 A02 with (nolock) ON A02.DivisionID IN (''@@@'', T2.DivisionID) AND A02.InventoryID = T2.ProductID
				WHERE	T1.DivisionID = '''+@DivisionID+'''			
						AND T1.TranYear*100 + T1.TranMonth BETWEEN '+STR(@FromMonth)+'+ '+STR(@FromYear)+'*100 AND '+STR(@ToMonth)+'+ '+STR(@ToYear)+'*100							
						AND T1.VoucherDate <= GETDATE()		
						AND ProductID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+'''
						AND A02.InventoryTypeID BETWEEN '''+@FromInventoryTypeID+''' AND '''+@ToInventoryTypeID+'''
						AND A02.I03ID BETWEEN '''+@FromI03ID+''' AND '''+@ToI03ID+'''
				GROUP BY T1.DivisionID, T1.TranMonth, T1.TranYear
				'
		ELSE 
			SET @sSQL1 = @sSQL1 + '
				SELECT '''+@GroupID+''' as GroupID, T1.DivisionID, T1.TranMonth, T1.TranYear, '''+@GroupID+''' AS ProductID, SUM(T2.ActualQuantity) AS Quantity
				INTO	#BP3005_AT2007
				FROM	MT1802 T2 with (nolock)	
				INNER JOIN MT1801 T1 with (nolock) ON T2.DivisionID = T1.DivisionID AND T1.VoucherID = T2.VoucherID 
				LEFT JOIN AT1302 A02 with (nolock) ON A02.DivisionID IN (''@@@'', T2.DivisionID) AND A02.InventoryID = T2.ProductID
				WHERE	T1.DivisionID = '''+@DivisionID+'''			
						AND T1.TranYear*100 + T1.TranMonth BETWEEN '+STR(@FromMonth)+'+ '+STR(@FromYear)+'*100 AND '+STR(@ToMonth)+'+ '+STR(@ToYear)+'*100						
						AND T1.VoucherDate <= GETDATE()		
						AND ProductID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+'''
						AND A02.InventoryTypeID BETWEEN '''+@FromInventoryTypeID+''' AND '''+@ToInventoryTypeID+'''
						AND A02.I03ID BETWEEN '''+@FromI03ID+''' AND '''+@ToI03ID+'''
				GROUP BY T1.DivisionID, T1.TranMonth, T1.TranYear
				'
		IF ISNULL(@sSQL2,'') <> ''
			SET @sSQL2 = @sSQL2 + '
				UNION
				SELECT  T1.DivisionID, T2.TranMonth, T2.TranYear, '''+@GroupID+''' AS ProductID, SUM(ISNULL(T1.ErrorQuantity,0)) AS Quantity
				FROM	MT1802 T1 with (nolock)	
				INNER JOIN MT1801 T2 with (nolock) ON T1.VoucherID = T2.VoucherID 
				LEFT JOIN AT1302 A02 with (nolock) ON A02.DivisionID IN (''@@@'', T1.DivisionID) AND A02.InventoryID = T1.ProductID
				WHERE	T1.DivisionID = '''+@DivisionID+'''			
						AND T2.TranYear*100 + T2.TranMonth BETWEEN '+STR(@FromMonth)+'+ '+STR(@FromYear)+'*100 AND '+STR(@ToMonth)+'+ '+STR(@ToYear)+'*100
						AND T2.VoucherDate <= GETDATE()		
						AND T1.ProductID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+'''
						AND A02.InventoryTypeID BETWEEN '''+@FromInventoryTypeID+''' AND '''+@ToInventoryTypeID+'''
						AND A02.I03ID BETWEEN '''+@FromI03ID+''' AND '''+@ToI03ID+'''
				GROUP BY T1.DivisionID, T2.TranMonth, T2.TranYear--, T1.ProductID
				'
		ELSE 
			SET @sSQL2 = @sSQL2 + '
				SELECT  T1.DivisionID, T2.TranMonth, T2.TranYear, '''+@GroupID+''' AS ProductID, SUM(ISNULL(T1.ErrorQuantity,0)) AS Quantity
				INTO	#BP3005_MT1802
				FROM	MT1802 T1 with (nolock)	
				INNER JOIN MT1801 T2 with (nolock) ON T1.VoucherID = T2.VoucherID 
				LEFT JOIN AT1302 A02 with (nolock) ON A02.DivisionID IN (''@@@'', T1.DivisionID) AND A02.InventoryID = T1.ProductID
				WHERE	T1.DivisionID = '''+@DivisionID+'''			
						AND T2.TranYear*100 + T2.TranMonth BETWEEN '+STR(@FromMonth)+'+ '+STR(@FromYear)+'*100 AND '+STR(@ToMonth)+'+ '+STR(@ToYear)+'*100
						AND T2.VoucherDate <= GETDATE()		
						AND T1.ProductID BETWEEN '''+@FromInventoryID+''' AND '''+@ToInventoryID+'''
						AND A02.InventoryTypeID BETWEEN '''+@FromInventoryTypeID+''' AND '''+@ToInventoryTypeID+'''
						AND A02.I03ID BETWEEN '''+@FromI03ID+''' AND '''+@ToI03ID+'''
				GROUP BY T1.DivisionID, T2.TranMonth, T2.TranYear--, T1.ProductID
				'
		FETCH NEXT FROM @Cur_Ware INTO @GroupID, @FromInventoryID, @ToInventoryID
	END 

CLOSE @Cur_Ware

IF ISNULL(@sSQL1,'') <> '' AND ISNULL(@sSQL2,'') <> ''
	SET @sSQL3 = '
	SELECT	T1.DivisionID, T1.TranMonth, T1.TranYear, T1.ProductID, T1.Quantity AS StandardQuantity, ISNULL(T2.Quantity,0) AS ErrorQuantity, 
			ISNULL(T2.Quantity,0)/T1.Quantity AS Rate, LTRIM(RTRIM(T1.TranMonth)) + ''/'' + LTRIM(RTRIM(T1.TranYear)) AS Period
	FROM	#BP3005_AT2007 T1
	LEFT JOIN #BP3005_MT1802 T2 ON T1.DivisionID = T2.DivisionID AND T1.TranMonth = T2.TranMonth AND T1.TranYear = T2.TranYear AND T1.ProductID = T2.ProductID
	WHERE ISNULL(T1.Quantity,0) <> 0
	ORDER BY T1.ProductID, T1.TranYear, T1.TranMonth
	'

PRINT (@sSQL1)
PRINT (@sSQL2)
PRINT @sSQL3
EXEC (@sSQL1+@sSQL2+@sSQL3)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

