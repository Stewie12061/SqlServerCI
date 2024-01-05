IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP30001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP30001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- EDMR30001: bc tinh hinh hoat dong thang
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Văn Tình, Date: 30/11/2018
-- <Example>
--	EDMP30001 @DivisionID = 'BE',@LanguageID = 'vi-VN',@Date = '2019-04-12 00:00:00.000'
--- EDMP30001 @DivisionID,@LanguageID,@Date

CREATE PROCEDURE [dbo].[EDMP30001]
( 
	 @DivisionID VARCHAR(50),
	 @LanguageID VARCHAR(50),
	 @Date DATETIME
)
AS 
SET NOCOUNT ON

DECLARE @SchoolYearID VARCHAR(50) = NULL 
DECLARE @sSQL NVARCHAR (MAX)
DECLARE @dStartMonth DATETIME, @dEndMonth DATETIME
DECLARE @dFromSchoolYearID DATETIME, @dToSchoolYearID DATETIME
DECLARE @QuantityLeave INT, @QuantityLeave2 INT, @Quantity INT, @Quantity2 INT, @TranferStudent INT
SELECT @QuantityLeave = 0, @QuantityLeave2  = 0, @Quantity = 0, @Quantity2 = 0, @TranferStudent = 0
----Lấy ngày đầu tháng và ngày cuối tháng theo điều kiện search ngày 
SELECT @dStartMonth = DATEADD(dd,-(DAY(@Date)-1),@Date)
SELECT @dEndMonth = DATEADD(dd,-(DAY(DATEADD(mm,1,@Date))),DATEADD(mm,1,@Date))


IF ISNULL(@SchoolYearID,'') = ''
	SELECT TOP 1 @SchoolYearID = SchoolYearID FROM EDMT1040 WITH(NOLOCK) WHERE [Disabled] = 0 AND DivisionID IN (@DivisionID,'@@@') AND @Date BETWEEN DateFrom AND DateTo

SELECT @dFromSchoolYearID = DateFrom, @dToSchoolYearID =  DateTo FROM EDMT1040 WITH(NOLOCK) WHERE [Disabled] = 0 AND SchoolYearID = @SchoolYearID


 -----Sỉ sổ hs đầu tháng 
 SELECT @Quantity = COUNT(DISTINCT B.StudentID) 
FROM EDMT2040 A WITH (NOLOCK)
LEFT JOIN EDMT2041 B WITH (NOLOCK) ON A.APK = B.APKMaster
WHERE A.DivisionID = @DivisionID AND A.SchoolYearID = @SchoolYearID AND 
A.AttendanceDate BETWEEN @dStartMonth  AND @Date

----Sỉ số hs cuối tháng 
SELECT @Quantity2 = COUNT(DISTINCT B.StudentID)
FROM EDMT2040 A WITH (NOLOCK) 
LEFT JOIN EDMT2041 B WITH (NOLOCK) ON A.APK = B.APKMaster
WHERE A.DivisionID = @DivisionID AND A.SchoolYearID = @SchoolYearID AND 
A.AttendanceDate BETWEEN @dStartMonth  AND @dEndMonth



--HS nghỉ hoc trong tháng
	SELECT @QuantityLeave = COUNT(StudentID)
	FROM EDMT2080 WITH(NOLOCK) 
	WHERE DeleteFlg = 0 AND DivisionID = @DivisionID  
		AND LeaveDate BETWEEN @dStartMonth AND @dEndMonth


--Chuyển cơ sở 
SELECT @TranferStudent = COUNT(StudentID)
	FROM EDMT2140 WITH(NOLOCK) 
	WHERE DeleteFlg = 0 AND @dStartMonth <= FromEffectiveDate  AND FromEffectiveDate <= @Date

SELECT CAST(1 AS INT) AS STT, CAST('SSDT' AS VARCHAR(20)) AS KeyCode, @Quantity AS Quantity, CAST(N'Sĩ số đầu tháng' AS NVARCHAR(128)) AS Comment
UNION ALL
SELECT CAST(2 AS INT) AS STT, CAST('SSCT' AS VARCHAR(20)) AS KeyCode, @Quantity2 AS Quantity, CAST(N'Sĩ số cuối tháng' AS NVARCHAR(128)) AS Comment
UNION ALL
SELECT CAST(3 AS INT) AS STT, CAST('BENGHI' AS VARCHAR(20)) AS KeyCode, @QuantityLeave AS Quantity, CAST(N'Bé nghỉ' AS NVARCHAR(128)) AS Comment
UNION ALL
SELECT CAST(4 AS INT) AS STT, CAST('CHUYENCS' AS VARCHAR(20)) AS KeyCode, @TranferStudent AS Quantity, CAST(N'Chuyển cơ sở' AS NVARCHAR(128)) AS Comment

-- 2. TÌNH HÌNH GV, BM ==> lấy từ HRM


 


GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

