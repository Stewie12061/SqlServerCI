IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2008]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2008]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load edit Kết hoạch tuyển dụng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Huỳnh Thử, Date: 11/11/2020
---- Modified on
-- <Example>
---- 
/*
   exec HRMP2056 'NTY', '4b9d0d76-178e-4de6-870e-2187da0da3f2'
*/

CREATE PROCEDURE HRMP2008
( 
	@DivisionID VARCHAR(50),
	@RecruitPlanID VARCHAR(50),
	@Mode TINYINT
)
AS
DECLARE @Cur CURSOR,
		@sSQL VARCHAR(MAX),
		@sSQL1 VARCHAR(MAX) = '',
		@sSQL2 VARCHAR(MAX) = '',
		@sSQLSL VARCHAR(MAX) = '',
		@sSQLJon VARCHAR(MAX) = '',
		@OrderBy NVARCHAR(500),
		@TotalRow NVARCHAR(50) = '',
		@EmployeeID VARCHAR(50),
		@Date DATETIME,
		@i INT = 1, @s VARCHAR(2)

WHILE @i < 6
BEGIN
	IF @i < 10 
		SET @s = '0' + CONVERT(VARCHAR, @i)
	ELSE 
		SET @s = CONVERT(VARCHAR, @i)
	SET @sSQLSL= @sSQLSL+'
			, ApprovePerson'+@s+'ID, ApprovePerson'+@s+'Name, ApprovePerson'+@s+'Status, ApprovePerson'+@s+'StatusName, ApprovePerson'+@s+'Note'
	SET @sSQLJon = @sSQLJon+ '
			LEFT JOIN (SELECT ApprovePersonID ApprovePerson'+@s+'ID,OOT1.APKMaster,OOT1.DivisionID,OOT1.Status,
			LTRIM(RTRIM(ISNULL(HT14.LastName,'''')))
				+ '' '' + LTRIM(RTRIM(ISNULL(HT14.MiddleName,''''))) 
				+ '' '' + LTRIM(RTRIM(ISNULL(HT14.FirstName,''''))) AS ApprovePerson'+@s+'Name,
			OOT1.Status ApprovePerson'+@s+'Status, O99.Description ApprovePerson'+@s+'StatusName,
			OOT1.Note ApprovePerson'+@s+'Note
		FROM OOT9001 OOT1
			INNER JOIN HT1400 HT14 ON HT14.DivisionID=OOT1.DivisionID AND HT14.EmployeeID=OOT1.ApprovePersonID
			LEFT JOIN OOT0099 O99 ON O99.ID1 = ISNULL(OOT1.Status,0) AND O99.CodeMaster=''Status''
		WHERE OOT1.Level='+STR(@i)+'
		) APP'+@s+' ON APP'+@s+'.DivisionID = HRMT2050.DivisionID AND APP'+@s+'.APKMaster = H51.APKMaster'
	SET @i = @i + 1		
END	

IF @Mode = 0
	BEGIN
		--- Dataset 1: Trả ra master
		SET @sSQL = ''
		
	END
ELSE
	BEGIN
		--- Dataset 2: Trả ra detail
		select HRMT2000.*,V1.FullName AS ApprovePerson01Name, V2.FullName AS ApprovePerson02Name, V3.FullName AS ApprovePerson03Name,
					V4.FullName AS ApprovePerson04Name, V5.FullName AS ApprovePerson05Name From HRMT2000 
		LEFT JOIN OOT9001 O91 WITH (NOLOCK) ON HRMT2000.DivisionID = O91.DivisionID AND HRMT2000.APK = O91.APKMaster
		LEFT JOIN HV1400 V1 ON V1.DivisionID = @DivisionID AND V1.EmployeeID = CASE WHEN O91.Level = 1 THEN O91.ApprovePersonID ELSE '' END
		LEFT JOIN HV1400 V2 ON V2.DivisionID = @DivisionID AND V2.EmployeeID = CASE WHEN O91.Level = 2 THEN O91.ApprovePersonID ELSE '' END
		LEFT JOIN HV1400 V3 ON V3.DivisionID = @DivisionID AND V3.EmployeeID = CASE WHEN O91.Level = 3 THEN O91.ApprovePersonID ELSE '' END
		LEFT JOIN HV1400 V4 ON V4.DivisionID = @DivisionID AND V4.EmployeeID = CASE WHEN O91.Level = 4 THEN O91.ApprovePersonID ELSE '' END
		LEFT JOIN HV1400 V5 ON V5.DivisionID = @DivisionID AND V5.EmployeeID = CASE WHEN O91.Level = 5 THEN O91.ApprovePersonID ELSE '' END
		where HRMT2000.DivisionID = @DivisionID AND HRMT2000.APK = @RecruitPlanID
	END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
