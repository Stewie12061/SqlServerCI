IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POT2031]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POT2031]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- Load nhà cung cấp theo mức độ ưu tiên
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
-- <History>
----Created by: Trà Giang, Date: 20/10/2018
-- <Example>
---- 
/*-- <Example>

	
	exec  POT2031 @DivisionID='AT',	 @UserID =N'',	 @LeadTimeID =N'LD004',	 @InventoryID =N'',		 @PageNumber=1,	 @PageSize =25,
	 @Priority1 =N'UnitPrice',
     @Priority2 =N'Quantity',
	 @Priority3 =N'DeliverDay'
----*/

CREATE PROCEDURE POT2031
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @LeadTimeID VARCHAR(50),
	 @InventoryID  VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,
	 @Priority1 VARCHAR(50),
     @Priority2 VARCHAR(50),
	 @Priority3 VARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @TotalRow NVARCHAR(50) = N'',
         @OrderBy NVARCHAR(500) = N''
--SET @OrderBy = 'P13.Priority1,P13.Priority2,P13.Priority3'

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF ISNULL(@LeadTimeID, '') != '' 
				SET @OrderBy = ' P14.'+@Priority1 + ', P14.' +@Priority2+', P14.' +@Priority3+''
	ELSE  SET @OrderBy = 'P14.UnitPrice,P14.DeliverDay,P14.Quantity'
SET @sSQL = @sSQL + N'

SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow,
   P14.DetailID, P14.ObjectID, A02.ObjectName, P14.Quantity, P14.UnitPrice, P14.DeliverDay, P13.Priority1,P13.Priority2,P13.Priority3
 FROM POT2014 P14 WITH (NOLOCK)
 left join POT2013 P13 WITH (NOLOCK) ON P13.DivisionID=P14.DivisionID and P13.LeadTimeID=P14.LeadTimeID
 LEFT JOIN AT1202 A02 WITH (NOLOCK) ON A02.ObjectID = P14.ObjectID
WHERE P14.DivisionID ='''+@DivisionID+''' and P14.LeadTimeID = '''+@LeadTimeID+''' AND P14.InventoryID ='''+@InventoryID+'''
ORDER BY '+@OrderBy+'

OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'


PRINT(@sSQL)
EXEC (@sSQL)


   







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
