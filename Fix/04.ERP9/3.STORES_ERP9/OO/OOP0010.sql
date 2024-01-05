IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP0010]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP0010]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form OOF0010: Danh sách chức vụ phân quyền
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Trần Quốc Tuấn, Date: 27/11/2017
-- <Example>
---- 
/*
	OOP0010 @DivisionID='MK',@UserID='',@TranYear=2016,@TranMonth=3,@APKMaster='D50E3BD7-E717-4661-A295-8F450389900D',@RollLevel=3

*/
CREATE PROCEDURE dbo.OOP0010
(	
	@DivisionID VARCHAR(70),
	@UserID VARCHAR(70),
	@TranMonth INT,
	@TranYear INT,
	@APKMaster VARCHAR(50),
	@RollLevel INT
)
AS


SELECT ROW_NUMBER() OVER (ORDER BY DutyID) AS RowNumber,COUNT(*) OVER () AS TotalRow,A.*
FROM
(
SELECT DISTINCT  HT2.DutyID, HT2.DutyName,
(CASE WHEN OO11.DutyID IS NULL THEN 0 ELSE 1 END) IsPermision,
(CASE WHEN OO11.DutyID IS NOT NULL AND OOT90.APK IS NOT NULL  THEN 1 ELSE 0 END) IsLock
FROM HT1102 HT2
FULL JOIN OOT0011 OO11 ON OO11.DivisionID=HT2.DivisionID AND OO11.DutyID=HT2.DutyID AND OO11.RollLevel=@RollLevel AND OO11.APKMaster=@APKMaster
LEFT JOIN 
( SELECT DISTINCT APK, DivisionID,TranMonth,TranYear,Type
	FROM OOT9000
) OOT90 ON OOT90.DivisionID = HT2.DivisionID AND OOT90.TranMonth=@TranMonth AND TranYear=@TranYear 
AND [TYPE] =(SELECT TOP 1 AbsentType FROM OOT0011 WHERE DivisionID=@DivisionID AND APKMaster=@APKMaster)
WHERE HT2.DivisionID=@DivisionID
)A
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
