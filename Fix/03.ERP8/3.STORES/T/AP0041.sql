IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0041]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0041]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- AP0041
-- <Summary>
---- Stored đổ nguồn cho màn hình bút toán phân bổ chi phí nhiều cấp AF0354 (PACIFIC) 
---- Created on 12/04/2017 Hải Long
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Modified on 11/08/2014 by 
-- <Example>
---- EXEC AP0041 @DivisionID = 'ANG', @UserID = 'ASOFTADMIN', @FromPeriod = 201704, @ToPeriod = 201704

CREATE PROCEDURE [DBO].[AP0041]
( 
	@DivisionID AS NVARCHAR(50),
	@UserID AS NVARCHAR(50),	
	@FromPeriod AS INT,
	@ToPeriod AS INT
) 
AS
DECLARE @sSQL NVARCHAR(MAX),
		@FromPeriodTxt NVARCHAR(10),
		@ToPeriodTxt NVARCHAR(10)
SET @FromPeriodTxt = CONVERT(NVARCHAR(10), @FromPeriod)
SET @ToPeriodTxt = CONVERT(NVARCHAR(10), @ToPeriod)

SET @sSQL = N'
SELECT DivisionID, VoucherID, VoucherNo, VoucherDate, Description, AllocationID, AllocationLevelID, CurrencyID, ExchangeRate,
(CASE WHEN AllocationType = 1 THEN N''Tỉ lệ''
      WHEN AllocationType = 2 THEN N''Số lượng nhân viên''
      ELSE N''Giá trị ấn định'' END) as AllocationTypeName 
FROM AT9005 WITH (NOLOCK)
WHERE DivisionID = ''' + @DivisionID + '''
AND TranYear*100 + TranMonth BETWEEN ' + @FromPeriodTxt + ' AND ' + @ToPeriodTxt + '
ORDER BY VoucherDate, VoucherNo
'

--PRINT @sSQL
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
