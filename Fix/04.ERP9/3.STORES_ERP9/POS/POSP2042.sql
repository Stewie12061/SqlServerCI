IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP2042]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP2042]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- Load dữ liệu biến động tồn kho hàng hóa trong ca (từ lúc mở ca đến khi đóng ca)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create by Tiểu Mai on 11/06/2018
---- Modify by Tra Giang on 13/11/2018: Chỉnh sửa store load dữ liệu tab kiểm kê bán hàng từ các phiếu bán/ nhâp/ trả/ xuất hàng thay vì viết chết dữ liệu
---- Modify by Tra Giang on 14/01/2019: Chỉnh sửa điều kiện lọc thời gian bắt đầu mở ca 
-- <Example>
---- EXEC POSP2042 'AT','CH001' , '', N'CA01', '2018-10-25 00:00:00.000'
CREATE PROCEDURE POSP2042
( 
		@DivisionID AS NVARCHAR(50),
		@ShopID NVARCHAR(50),
		@UserID NVARCHAR(50),
		@ShiftID NVARCHAR(50),
		@ShiftDate DATETIME,
		@PageNumber INT,
		@PageSize INT	
)				
AS 
DECLARE @SQL   NVARCHAR(MAX),
		@OpenTime DATETIME,
		@CloseTime DATETIME,
		@TotalRow NVARCHAR(50) = N'',
		 @OrderBy NVARCHAR(500) = N''
		
SET @OpenTime = (SELECT  TOP 1 CreateDate FROM POST2033 P33 WITH (NOLOCK)
                WHERE P33.DivisionID = @DivisionID AND P33.ShopID = @ShopID 
					 order by    P33.CreateDate desc
                )

--SET @CloseTime = (SELECT  TOP 1 CloseTime FROM POST2033 P33 WITH (NOLOCK)
--                WHERE P33.DivisionID = @DivisionID AND P33.ShopID = @ShopID 
--                )

SET @OrderBy = 'A02.InventoryID'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
SET @SQL = N'
	SELECT 	ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
	  A02.DivisionID,A02.InventoryID, A02.InventoryName, A02.UnitID,ISNULL(B.BeginQuantity,0) AS BeginQuantity
,ISNULL(C.ImQuantity,0) AS ImQuantity,ISNULL(SUM( a.SLHBTL),0) as ReturnQuantity,ISNULL(F.EX,0) AS ExQuantity
,ISNULL(E.MovedQuantity,0) AS MovedQuantity,ISNULL(B.BeginQuantity,0)-ISNULL(C.ImQuantity,0)-ISNULL(E.MovedQuantity,0)  as EndQuantity
FROM  AT1302 A02  WITH (NOLOCK)
	 LEFT JOIN(	 SELECT D.DivisionID, D.InventoryID, SUM(D.ActualQuantity) as EX	
					from POST00161 D WITH (NOLOCK) inner join POST0016 M  WITH (NOLOCK) on M.APK = D.APKMaster
					LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.DivisionID= D.DivisionID AND D.InventoryID = A02.InventoryID
					WHERE  M.DeleteFlg = 0   and (m.Pvoucherno is  null AND M.CVoucherNo IS NULL) AND D.InventoryID= A02.InventoryID
					 AND D.DivisionID= '''+@DivisionID+''' AND D.ShopID ='''+@ShopID+'''  
					AND CONVERT(VARCHAR,M.CreateDate,120) BETWEEN '''+CONVERT(VARCHAR,@OpenTime,120)+''' AND  '''+CONVERT(VARCHAR,getdate(),120)+''' 
					group by D.DivisionID,D.InventoryID)  F   on A02.DivisionID= F.DivisionID AND F.InventoryID = A02.InventoryID
	 
	 LEFT JOIN (SELECT D.InventoryID, SUM(D.ActualQuantity) as SLHBTL	
					from POST00161 D WITH (NOLOCK) inner join POST0016 M  WITH (NOLOCK) on M.APK = D.APKMaster
					LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A02.DivisionID= D.DivisionID AND D.InventoryID = A02.InventoryID
					WHERE  M.DeleteFlg = 0   and m.Pvoucherno is not null AND D.InventoryID= A02.InventoryID
					group by D.InventoryID)		a 	on A.InventoryID= A02.InventoryID
	 LEFT JOIN (SELECT P38.DivisionID, P39.InventoryID, SUM(P39.Quantity) as BeginQuantity	
					from POST0039 P39  WITH (NOLOCK) inner join POST0038 P38 WITH (NOLOCK) ON P38.APK= P39.APKMaster and P38.DivisionID=P39.DivisionID
					left join  AT1302 A02  WITH (NOLOCK) on P39.DivisionID= A02.DivisionID and P39.InventoryID=A02.InventoryID 
					 WHERE P38.DivisionID= '''+@DivisionID+''' AND P38.ShopID ='''+@ShopID+'''  
					AND CONVERT(VARCHAR,P38.VoucherDate,120) BETWEEN '''+CONVERT(VARCHAR,@OpenTime,120)+''' AND  '''+CONVERT(VARCHAR,getdate(),120)+''' 
					group by P38.DivisionID,P39.InventoryID ) B	ON B.DivisionID = A02.DivisionID and B.InventoryID=A02.InventoryID  
	LEFT JOIN (SELECT P15.DivisionID,  P151.InventoryID, SUM(P151.ActualQuantity) as ImQuantity	
					from POST00151 P151  WITH (NOLOCK) inner join POST0015 P15 WITH (NOLOCK) ON P15.APK=P151.APKMaster and P15.DivisionID= P151.DivisionID
					left join  AT1302 A02  WITH (NOLOCK) on P151.DivisionID = A02.DivisionID and P151.InventoryID=A02.InventoryID 
					 WHERE P15.DivisionID= '''+@DivisionID+''' AND P15.ShopID ='''+@ShopID+'''   
					AND CONVERT(VARCHAR,P15.VoucherDate,120) BETWEEN '''+CONVERT(VARCHAR,@OpenTime,120)+''' AND  '''+CONVERT(VARCHAR,getdate(),120)+''' 
					group by P15.DivisionID, P151.InventoryID ) C	ON C.DivisionID= A02.DivisionID and C.InventoryID=A02.InventoryID 
	LEFT JOIN (SELECT P27.DivisionID,  P28.InventoryID, SUM(P28.ShipQuantity) as MovedQuantity	
					from POST0028 P28  WITH (NOLOCK) inner join POST0027 P27 WITH (NOLOCK) ON P27.APK=P28.APKMaster and P27.DivisionID= P28.DivisionID
					left join  AT1302 A02  WITH (NOLOCK) on P27.DivisionID = A02.DivisionID and P28.InventoryID=A02.InventoryID 
					 WHERE P27.DivisionID= '''+@DivisionID+''' AND P27.ShopID ='''+@ShopID+''' AND  
					 CONVERT(VARCHAR,P27.VoucherDate,120) BETWEEN '''+CONVERT(VARCHAR,@OpenTime,120)+''' AND  '''+CONVERT(VARCHAR,getdate(),120)+''' 
					group by P27.DivisionID,  P28.InventoryID ) E	ON E.DivisionID= A02.DivisionID and E.InventoryID=A02.InventoryID 
 group by  A02.DivisionID,A02.InventoryID, A02.InventoryName, A02.UnitID,B.BeginQuantity,C.ImQuantity,F.EX,ISNULL(E.MovedQuantity,0)
 ORDER BY '+@OrderBy+' 
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
 
 '
 EXEC (@SQL)
 --Print (@SQL)









GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
