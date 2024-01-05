IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2016]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2016]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- Load dữ liệu màn hình CHỌN POF2016
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create by Tiểu Mai on 27/06/2018
----Modify by Trà Giang on 25/10/2018: bổ sung load mặt hàng theo nhóm hàng hóa
----Modify by Trà Giang on 23/11/2018: bổ sung Search điều kiện lọc
-- <Example>
---- exec POP2016 N'AT', N'ASOFTADMIN', N'OB', N'hàng',1,25
----exec POP2016 @DivisionID=N'AT',@UserID=N'ASOFTADMIN',@PageNumber=1,@PageSize=25,@InventoryTypeID='LK', @Mode=2, @TxtSearch=N'C'
CREATE PROCEDURE POP2016
( 
		@DivisionID AS NVARCHAR(50),
		@UserID NVARCHAR(50),
		@PageNumber INT,
		@PageSize INT, 
		@InventoryTypeID NVARCHAR(250),
		@TxtSearch NVARCHAR(250),
		@Mode INT --1 Load Mặt hàng, 2: Load NCC , 3: khách hàng 
) 
AS 

DECLARE @sSQL NVARCHAR(MAX)='',
		@TotalRow NVARCHAR(50),
		@Orderby NVARCHAR(MAX)='',
		@Orderby2 NVARCHAR(MAX)='',
		@sWhere NVARCHAR(MAX) = N'',
		@sWhere1 NVARCHAR(MAX) = N''
SET @TotalRow = ''
SET @Orderby='A02.InventoryID '
SET @Orderby2='ObjectID '        
IF @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'
--IF  ISNULL(@InventoryTypeID,'')= N''
		 
IF ISNULL(@InventoryTypeID,'') != '' SET @sWhere = @sWhere + '
AND A02.InventoryTypeID = N'''+@InventoryTypeID+''' '

BEGIN

IF @Mode=1
BEGIN 
IF @TxtSearch IS NOT NULL SET @sWhere1 = @sWhere1 +'
								AND (A02.InventoryID LIKE N''%'+@TxtSearch+'%'' 
								OR A02.InventoryName LIKE N''%'+@TxtSearch+'%'' )'
 SET @sSQL =N'
	    SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
        InventoryID as SelectionID, InventoryName as SelectionName, A02.DivisionID, InventoryID  AS Orderby, A02.UnitID, A04.UnitName
		FROM AT1302 A02 WITH (NOLOCK)
		inner join AT1301 A01 WITH (NOLOCK) on A01.InventoryTypeID=A02.InventoryTypeID
		left join AT1304 A04 WITH (NOLOCK) ON A02.UnitID=A04.UnitID 
		WHERE A02.Disabled = 0 and A02.DivisionID IN ('''+@DivisionID+''',''@@@'')'+@sWhere+@sWhere1+'
		ORDER BY '+@OrderBy+'
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
 END 
  ELSE
 IF @Mode=2
BEGIN 
IF @TxtSearch IS NOT NULL SET @sWhere1 = @sWhere1 +'
								AND (AT1202.ObjectID LIKE N''%'+@TxtSearch+'%'' 
								OR AT1202.ObjectName LIKE N''%'+@TxtSearch+'%'' )'
   SET @sSQL =N'
	      SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy2+') AS RowNum, '+@TotalRow+' AS TotalRow,
   DivisionID,ObjectID as SelectionID ,ObjectName as SelectionName,IsSupplier from AT1202 WITH (NOLOCK)
    WHERE   IsSupplier=1 AND DivisionID  IN ('''+@DivisionID+''',''@@@'') '+@sWhere1+'
	ORDER BY '+@OrderBy2+'
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'
 END
 ELSE
 BEGIN 
 IF @TxtSearch IS NOT NULL SET @sWhere1 = @sWhere1 +'
								AND (AT1202.ObjectID LIKE N''%'+@TxtSearch+'%'' 
								OR AT1202.ObjectName LIKE N''%'+@TxtSearch+'%'' )'

   SET @sSQL =N'
	 
		SELECT  ROW_NUMBER() OVER (ORDER BY '+@OrderBy2+') AS RowNum, '+@TotalRow+' AS TotalRow,
    DivisionID,ObjectID as SelectionID ,ObjectName as SelectionName,IsSupplier,Address,Tel,Contactor ,DeAddress from AT1202 WITH (NOLOCK)
    WHERE   IsCustomer=1 AND DivisionID  IN ('''+@DivisionID+''',''@@@'') '+@sWhere1+'
	ORDER BY '+@OrderBy2+'
	OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
	FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'


 END
 END
PRINT (@sSQL)
EXEC (@sSQL)









GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
