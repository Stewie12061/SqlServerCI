IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[HP0387]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP0387]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
----  Truy vấn Quyết định thuyên chuyển bộ phận
-- <Param>
----  
-- <Return>
---- 
-- <Reference> HRM/ Nghiệp vụ / Quản lý nhân sự
---- Quyết định thuyên chuyển bộ phận
-- <History>
---- Create on 01/06/2016 by Bảo Thy
---- Modified on 10/09/2020 by Nhựt Trường: tách store cho customer Meiko.
-- <Example>
---- exec HP0387 'MK', '%', '%' , '2016-06-01' , '2016-06-07'
CREATE PROCEDURE HP0387	
(
	@DivisionID Nvarchar(50),
	@DecideNo Nvarchar(50),
	@EmployeeID Nvarchar(50),
	@FromDate DATETIME,
	@ToDate DATETIME,
	@Mode TINYINT -- 0: Truy vấn, 1: Xuất Excel
)
AS
SET NOCOUNT ON

DECLARE @CustomerName INT
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

IF @CustomerName = 50 ---- Customize Meiko
BEGIN
	EXEC HP0387_MK @DivisionID, @DecideNo, @EmployeeID, @FromDate, @ToDate, @Mode
END
ELSE
BEGIN

SELECT DISTINCT	T1.DivisionID,T1.HistoryID, T1.DecideNo, T1.DecideDate,T5.FullName AS ProposerName,
		T3.FullName As DecidePersonName
FROM HT1302_MK T1 WITH(NOLOCK)
LEFT JOIN HV1400 T3 ON T1.DivisionID = T3.DivisionID AND T1.DecidePerson = T3.EmployeeID
LEFT JOIN HV1400 T5 ON T1.DivisionID = T5.DivisionID AND T1.Proposer = T5.EmployeeID
WHERE T1.DivisionID = @DivisionID
AND T1.DecideNo Like @DecideNo 
AND T1.EmployeeID LIKE @EmployeeID 
AND CONVERT(DATE,T1.DecideDate) BETWEEN CONVERT(DATE,@FromDate) AND CONVERT(DATE,@ToDate)

END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO