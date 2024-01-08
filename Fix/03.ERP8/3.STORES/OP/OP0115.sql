IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0115]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0115]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- OP0115
-- <Summary>
---- Load đơn hàng dựa theo kỳ và ngày (ANGEL)
---- Created on 20/04/2017 Hải Long
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Modified on 11/08/2014 by 
-- <Example>
---- exec OP0115 @DivisionID = 'ANG', @FromPeriod = 201704, @ToPeriod = 201704, @FromDate = '2017-04-01 00:00:00', @ToDate = '2017-04-30 00:00:00', @Mode = 1

CREATE PROCEDURE [DBO].[OP0115]
( 
	@DivisionID AS NVARCHAR(50),		
	@FromPeriod AS INT,
	@ToPeriod AS INT,
	@FromDate AS DATETIME,
	@ToDate AS DATETIME,
	@Mode AS TINYINT  -- 0: theo kỳ, 1: theo ngày
) 
AS
DECLARE @sSQL AS NVARCHAR(MAX)

IF @Mode = 0
BEGIN
	SET @sSQL = '
	SELECT SOrderID AS Code
	FROM OT2001 WITH (NOLOCK)
	WHERE DivisionID = ''' + @DivisionID + '''
	AND ISNULL(OrderStatus,0) = 1
	AND ISNULL(OrderType,0) = 0
	AND TranMonth + TranYear*100 BETWEEN ' + CONVERT(NVARCHAR(10), @FromPeriod) + ' AND ' + CONVERT(NVARCHAR(10), @ToPeriod) + '
	ORDER BY Code
	'	
END
ELSE
BEGIN
	SET @sSQL = '
	SELECT SOrderID AS Code
	FROM OT2001 WITH (NOLOCK)
	WHERE DivisionID = ''' + @DivisionID + '''
	AND ISNULL(OrderStatus,0) = 1
	AND ISNULL(OrderType,0) = 0
	AND OrderDate BETWEEN ''' + CONVERT(NVARCHAR(10), @FromDate, 102) + ''' AND ''' + CONVERT(NVARCHAR(10), @ToDate, 102) + '''
	ORDER BY Code
	'	
END	

--PRINT @sSQL
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
