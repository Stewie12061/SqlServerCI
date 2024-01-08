IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0510]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0510]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Lưu hiệu chỉnh thời gian đứng máy thực tế (HF0510)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by Bảo Thy on 18/09/2017
---- Modified by on 

/*-- <Example>
	HP0510 @DivisionID='MK', @UserID = '', @TranMonth=9, @TranYear=2017, @XML=NULL
	hp0509
----*/

CREATE PROCEDURE [dbo].[HP0510]
(
	@DivisionID AS VARCHAR(50), 
	@UserID AS VARCHAR(50),
	@TranMonth INT,
	@TranYear INT,
	@XML XML
)
AS
CREATE TABLE #HP0510_Employee (EmployeeID VARCHAR(50), MachineID VARCHAR(50), [Date] VARCHAR(2), ActFromTime NVARCHAR(250), ActToTime NVARCHAR(250))
	
INSERT INTO #HP0510_Employee
SELECT X.Data.query('EmployeeID').value('.', 'NVARCHAR(50)') AS EmployeeID,
	   X.Data.query('MachineID').value('.', 'NVARCHAR(50)') AS MachineID,
	   X.Data.query('Date').value('.', 'NVARCHAR(50)') AS [Date],
	   X.Data.query('ActFromTime').value('.', 'NVARCHAR(250)') AS ActFromTime,
	   X.Data.query('ActToTime').value('.', 'NVARCHAR(250)') AS ActToTime
FROM @XML.nodes('//Data') AS X (Data)

SELECT @TranMonth TranMonth, @TranYear TranYear, EmployeeID, MachineID,
CONVERT(DATETIME,CONVERT(VARCHAR(4),@TranYear)+'-'+CONVERT(VARCHAR(2),@TranMonth)+'-'+ [Date],120) AS [Date], ActFromTime, ActToTime
INTO #Temp_HP0510
FROM #HP0510_Employee

DECLARE @LastModifyDate DATETIME = GETDATE()

UPDATE T1
SET T1.ActFromTime = T2.ActFromTime,
	T1.ActToTime = T2.ActToTime,
	T1.LastModifyUserID = @UserID,
	T1.LastModifyDate = @LastModifyDate
FROM HT1113 T1 WITH (NOLOCK)
INNER JOIN #Temp_HP0510 T2 ON T1.EmployeeID = T2.EmployeeID AND T1.MachineID = T2.MachineID AND T1.[Date] = T2.[Date]
						   AND T1.TranMonth+T1.TranYear*100 = T2.TranMonth+T2.TranYear*100
WHERE T1.DivisionID = @DivisionID

DROP TABLE #Temp_HP0510
DROP TABLE #HP0510_Employee

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
