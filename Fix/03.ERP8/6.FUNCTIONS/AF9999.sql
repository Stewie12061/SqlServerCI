IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AF9999]') AND XTYPE IN (N'FN', N'IF', N'TF'))
DROP FUNCTION [DBO].[AF9999]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- AF9999 
-- <Summary>
---- Load danh sách các ngày trong khoảng thời gian (tối đa 10 năm)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created on 18/09/2017 by 
---- 
---- Modified on  by 
-- <Example>
---- select * from AF9999('d', '01/09/2017', '10/10/2017')

CREATE FUNCTION AF9999
( 
      @Type CHAR(1),	--d: day, w: week, m: month
      @StartDate DATETIME,
      @EndDate DATETIME
) 
RETURNS
@ReturnTable    TABLE 
(ReturnDate DATETIME)
AS
BEGIN
;WITH cteReturnData (ReturnDate) AS (
    SELECT @StartDate
    UNION ALL
    SELECT 
            CASE
                WHEN @Type = 'd' THEN DATEADD(dd, 1, ReturnDate)
                WHEN @Type = 'w' THEN DATEADD(ww, 1, ReturnDate)
                WHEN @Type = 'm' THEN DATEADD(mm, 1, ReturnDate)
            END
    FROM cteReturnData
    WHERE ReturnDate <= 
            CASE
                WHEN @Type = 'd' THEN DATEADD(dd, -1, @EndDate)
                WHEN @Type = 'w' THEN DATEADD(ww, -1, @EndDate)
                WHEN @Type = 'm' THEN DATEADD(mm, -1, @EndDate)
            END)
          
INSERT INTO @ReturnTable (ReturnDate)
SELECT	ReturnDate
FROM	cteReturnData
OPTION	(MAXRECURSION 3660);		--Gioi han so lan lap lai, neu tinh theo ngay la 10 nam
RETURN

END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

