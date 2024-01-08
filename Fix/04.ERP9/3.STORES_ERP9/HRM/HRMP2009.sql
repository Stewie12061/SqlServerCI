IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2009]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2009]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- <Summary>
---- HRMP2009: Load thông tin màn hình cập nhật  kế hoạch tuyển dụng 
--- Tham khảo store load của wp0095(WMF2007)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Phương Thảo , Date: 28/08/2023--- Tham khảo store load của wp0095(WMF2007)
----Modify  by: Phương Thảo , Date: 19/09/2023--- [2023_08_IS_0051] Điều chỉnh luồng load master kế hoạch tuyển dụng 
/*-- <Example>

	exec HRMP2009 @DivisionID=N'BBA-SI',@RecruitPlanID=N'ec3a730e-316a-4cfe-a2f1-b49300dbde44',@APK=N'',@Type=N'',@Mode=N'2'
----*/

CREATE PROCEDURE HRMP2009
( 
    @DivisionID VARCHAR(50),
	@RecruitPlanID VARCHAR(50),
	@APK VARCHAR(50) = '',
	@Type VARCHAR(50) = '',
	@Mode TINYINT
)
AS 


DECLARE @Ssql Nvarchar(max), 
		@Ssql2 Nvarchar(max),
		@Swhere  Nvarchar(max) = '',
		@Level INT,
		@sSQLSL NVARCHAR (MAX) = '',
		@i INT = 1, @s VARCHAR(2),
		@sSQLJon NVARCHAR (MAX) = '',
		@sSelect AS NVARCHAR(MAX)

IF ISNULL(@Type, '') = 'KHTD' 
BEGIN
	SET @Swhere = @Swhere + 'AND CONVERT(VARCHAR(50),Temp.APK)= '''+@APK+''''
	SELECT @Level = MAX(Level) FROM OOT9001 WITH (NOLOCK) WHERE APKMaster = @APK

END
ELSE
BEGIN
	SET @Swhere = @Swhere + 'AND (Temp.RecruitPlanID = '''+@RecruitPlanID+''' OR CONVERT(VARCHAR(50),Temp.APK) = '''+@RecruitPlanID+''' OR Convert(Varchar(50),Temp.APK)= '''+@APK+''')'
	SELECT @Level = MAX(Level) FROM OOT9001 WITH (NOLOCK) LEFT JOIN HRMT2000  ON OOT9001.APKMaster = HRMT2000.APK  WHERE (HRMT2000.RecruitPlanID = @RecruitPlanID OR CONVERT(VARCHAR(50),HRMT2000.APK) = @RecruitPlanID)
END
	WHILE @i <= @Level
	BEGIN
		IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
		ELSE SET @s = CONVERT(VARCHAR, @i)
		SET @sSQLSL=@sSQLSL+' , APP'+@s+'.ApprovePerson'+@s+'ID, APP'+@s+'.ApprovePerson'+@s+'Name, APP'+@s+'.ApprovePerson'+@s+'Status, APP'+@s+'.ApprovePerson'+@s+'StatusName, APP'+@s+'.ApprovePerson'+@s+'Note'
		SET @sSQLJon =@sSQLJon+ '
						LEFT JOIN (SELECT ApprovePersonID ApprovePerson'+@s+'ID,OOT1.APKMaster,OOT1.DivisionID,OOT1.Status,
						 HT14.FullName As ApprovePerson'+@s+'Name, 
						OOT1.Status ApprovePerson'+@s+'Status, O99.Description ApprovePerson'+@s+'StatusName,
						OOT1.Note ApprovePerson'+@s+'Note
						FROM OOT9001 OOT1 WITH (NOLOCK)
						INNER JOIN AT1103 HT14 WITH (NOLOCK) ON (HT14.DivisionID=OOT1.DivisionID OR ISNULL(HT14.DivisionID,'''') = ''@@@'') AND HT14.EmployeeID=OOT1.ApprovePersonID
						LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1=ISNULL(OOT1.Status,0) AND O99.CodeMaster=''Status''
						WHERE OOT1.Level='+STR(@i)+'
						)APP'+@s+' ON APP'+@s+'.DivisionID= OOT90.DivisionID  AND APP'+@s+'.APKMaster=OOT90.APK'
		SET @i = @i + 1		
	END	
SET @sSQL = N'
SELECT DISTINCT HRMT2000.APK
, HRMT2000.DivisionID
, HRMT2000.RecruitPlanID
, HRMT2000.Description
, HRMT2000.DepartmentID
, AT1102.DepartmentName
, HRMT2000.FromDate
, HRMT2000.ToDate
, HRMT2000.Status

, HRMT2000.TotalCost-- tổng chi phí dự kiến
, Temp1.ActualCost --- chi phí hiện có
, Temp2.CostBoundary --- chi phí định biên
, Temp2.ApprovePerson01ID
, Temp2.ApprovePerson01Name
, Temp2.ApprovePerson01Status
, Temp2.ApprovePerson01StatusName
, Temp2.ApprovePerson01Note

FROM HRMT2000 WITH (NOLOCK) 
LEFT JOIN AT1102 WITH (NOLOCK) ON AT1102.DivisionID IN (HRMT2000.DivisionID, ''@@@'') AND HRMT2000.DepartmentID = AT1102.DepartmentID

LEFT JOIN HRMT1020 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT1020.DivisionID AND HRMT2000.DepartmentID = HRMT1020.DepartmentID
		AND (HRMT2000.FromDate BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate OR HRMT2000.ToDate BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate 
		OR (HRMT2000.FromDate <= HRMT1020.FromDate AND HRMT2000.ToDate >= HRMT1020.ToDate))

LEFT JOIN HRMT1021 WITH (NOLOCK) ON HRMT1020.DivisionID = HRMT1021.DivisionID AND Convert(Varchar(50),HRMT1020.APK) = HRMT1021.BoundaryID

LEFT JOIN (
		SELECT HRMT1020.BoundaryID, SUM(HRMT2000.TotalCost) AS ActualCost
		FROM HRMT2000 WITH (NOLOCK)
		LEFT JOIN HRMT1020 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT1020.DivisionID AND HRMT2000.DepartmentID = HRMT1020.DepartmentID
			AND (HRMT2000.FromDate BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate OR HRMT2000.ToDate BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate 
			OR (HRMT2000.FromDate <= HRMT1020.FromDate AND HRMT2000.ToDate >= HRMT1020.ToDate))
		WHERE HRMT2000.DivisionID = '''+@DivisionID+''' AND ISNULL(HRMT2000.DeleteFlg,0) = 0 AND HRMT2000.Status = 1
		AND Convert(Varchar(50),HRMT2000.APK) <> '''+@RecruitPlanID+''' 
		GROUP BY HRMT1020.BoundaryID
	) AS Temp1 ON HRMT1020.BoundaryID = Temp1.BoundaryID'

SET @Ssql2 =N'
LEFT JOIN (
		SELECT HRMT2001.DutyID, HRMT2000.DepartmentID, HRMT1020.BoundaryID, HRMT1020.CostBoundary
        '+@sSQLSL+'
		FROM HRMT2000 WITH (NOLOCK) 
		LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON HRMT2000.APK = OOT90.APK
		LEFT JOIN HRMT2001 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT2001.DivisionID AND  Convert(Varchar(50),HRMT2000.APK) = HRMT2001.RecruitPlanID
		LEFT JOIN HRMT1020 WITH (NOLOCK) ON HRMT2000.DivisionID = HRMT1020.DivisionID AND HRMT2000.DepartmentID = HRMT1020.DepartmentID 
			AND HRMT2000.FromDate BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate 
			AND HRMT2000.ToDate BETWEEN HRMT1020.FromDate AND HRMT1020.ToDate 
		INNER JOIN HRMT1021 WITH (NOLOCK) ON HRMT1021.DivisionID = HRMT2000.DivisionID  AND HRMT1021.BoundaryID = CONVERT(NVARCHAR(50), HRMT1020.APK)  AND HRMT1021.DutyID = HRMT2001.DutyID
			'+@sSQLJon+'
		WHERE HRMT2000.DivisionID = '''+@DivisionID+'''  AND (HRMT2000.RecruitPlanID= '''+@RecruitPlanID+''' OR Convert(Varchar(50),HRMT2000.APK)= '''+@RecruitPlanID+''' OR Convert(Varchar(50),HRMT2000.APK)= '''+@APK+''' )
		GROUP BY  APP01.ApprovePerson01ID, APP01.ApprovePerson01Name, APP01.ApprovePerson01Status, APP01.ApprovePerson01StatusName, APP01.ApprovePerson01Note,HRMT2001.DutyID, HRMT2000.DepartmentID, HRMT1020.BoundaryID, HRMT1020.CostBoundary
	) AS Temp2 ON HRMT1020.DepartmentID = Temp2.DepartmentID 
WHERE HRMT2000.DivisionID = '''+@DivisioNID+'''  AND (Convert(Varchar(50),HRMT2000.APK) = '''+@APK+''' OR CONVERT(NVARCHAR(50), HRMT2000.APK) = '''+@RecruitPlanID+''' )'

PRINT @sSQL
PRINT @sSQL2
EXEC (@sSQL + @sSQL2)








GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
