IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2018]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2018]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load combo ca làm việc
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Bảo Thy on 06/12/2016
---- Modified on 
-- <Example>
/*
    EXEC OOP2018 'MK', 'ASOFTADMIN', 'OOF2031', '001339', '2016-11-05', '2016-11-05'
*/

 CREATE PROCEDURE OOP2018
(
     @DivisionID VARCHAR(50),
     @UserID VARCHAR(50),
     @ScreenID VARCHAR(50), 
	 @EmployeeID VARCHAR(50),
	 @FromDate DATETIME,
	 @ToDate DATETIME
)
AS
DECLARE @sWhere NVARCHAR(MAX) = '',
		@sSQL NVARCHAR(MAX) = '',
		@FromApprenticeTime DATETIME,
		@ToApprenticeTime DATETIME

SET @sWhere = 'AND '+(SELECT CASE WHEN @ScreenID = 'OOF2011' THEN 'ISNULL(IsDXP,0) = 1 '
								  WHEN @ScreenID = 'OOF2071' THEN 'ISNULL(IsDXDC,0) = 1' 
								  WHEN @ScreenID = 'OOF2031' THEN 'ISNULL(IsDXLTG,0) = 1' END)

SELECT @FromApprenticeTime = FromApprenticeTime, @ToApprenticeTime = ToApprenticeTime
FROM HT1403 WITH (NOLOCK)
WHERE EmployeeID = @EmployeeID


IF ISNULL(CONVERT(VARCHAR(50),@FromApprenticeTime),'') <> '' AND ISNULL(CONVERT(VARCHAR(50),@ToApprenticeTime),'') <> ''
BEGIN
	SET @sWhere = @sWhere + ' ' + (SELECT CASE WHEN (@FromDate BETWEEN @FromApprenticeTime AND @ToApprenticeTime) AND (@ToDate BETWEEN @FromApprenticeTime AND @ToApprenticeTime)
											   THEN 'AND ISNULL(IsApprenticeShift,0) = 1'
										 WHEN @FromDate > @ToApprenticeTime THEN 'AND ISNULL(IsApprenticeShift,0) = 0'
										 ELSE '' END )
END
ELSE
SET @sWhere = @sWhere + ' ' + 'AND ISNULL(IsApprenticeShift,0) = 0'

SET @sSQl = '
	SELECT ShiftID, ShiftName
	FROM HT1020 WITH (NOLOCK)
	WHERE DivisionID= '''+@DivisionID+'''
	'+@sWhere+'
	ORDER BY ShiftID
'
EXEC (@sSQl)
--Print (@sSQl)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
