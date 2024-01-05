IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP0002]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP0002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form EDMF0000: Danh sách chức vụ phân quyền
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo, Date: 23/10/2018
-- <Example>
---- 
/*
	EDMP0002 @DivisionID='BS',@UserID='ASOFTADMIN',@APKMaster='0CF7D864-C29C-472F-8E57-21D278435995', @RollLevel='1'


*/
CREATE PROCEDURE EDMP0002
(	
	@DivisionID VARCHAR(70),
	@UserID VARCHAR(70),
	@APKMaster VARCHAR(50),
	@RollLevel INT
)
AS


SELECT ROW_NUMBER() OVER (ORDER BY DutyID) AS RowNumber,A.*
FROM
(
SELECT DISTINCT  HT2.DutyID, HT2.DutyName,
(CASE WHEN  T1.DutyID IS NULL THEN 0 ELSE 1 END) IsPermision
FROM HT1102 HT2
FULL JOIN EDMT0003 AS  T1 ON  T1.DivisionID = HT2.DivisionID AND  T1.DutyID = HT2.DutyID AND  T1.RollLevel= @RollLevel AND  T1.APKMaster = @APKMaster

WHERE HT2.DivisionID = @DivisionID
)A
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO




