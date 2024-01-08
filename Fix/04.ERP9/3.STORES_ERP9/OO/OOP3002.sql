IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP3002]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP3002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
 -- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Load danh sách nhân viên chưa phân ca theo kỳ
 -- <Return>
 ---- 
 -- <Reference>
 ---- 
 -- <History>
 ----Created by: Bảo Thy, Date: 18/02/2016
 ---- Modified by Bảo Thy on 06/09/2016: Lấy Khối, Phòng từ danh mục phòng ban, tổ nhóm
 ---- Modified by Phương Thảo on 22/05/2017: Sửa danh mục dùng chung
 /*-- <Example>
 	OOP3002 @TranMonth = 9, @TranYear= 2016,@DepartmentID ='%', @SectionID = '%',
 	@SubsectionID = '%',@ProcessID = '%'
 ----*/
CREATE PROCEDURE OOP3002
( 
 @TranMonth INT,
 @TranYear INT,
 @DepartmentID VARCHAR(50),
 @SectionID VARCHAR(50),
 @SubsectionID VARCHAR(50),
 @ProcessID VARCHAR(50)
)
AS

SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY HV1400.EmployeeID) AS STT, HV1400.EmployeeID, HV1400.FullName,MonthYear, HV1400.DepartmentID, HV1400.DepartmentName, 
 		ISNULL(HV1400.TEAMID,'') SectionID, ISNULL(HV1400.TeamName,'') SectionName, ISNULL(Ana04ID,'') SubsectionID, ISNULL(A13.AnaName,'') SubsectionName,
 		ISNULL(Ana05ID,'') ProcessID, ISNULL(A14.AnaName,'') ProcessName
FROM HV1400
LEFT JOIN HT1025 ON HT1025.DivisionID = HV1400.DivisionID AND HT1025.EmployeeID = HV1400.EmployeeID AND HT1025.TranMonth=@TranMonth AND HT1025.TranYear=@TranYear
LEFT JOIN HV9999 ON HV1400.DivisionID=HV9999.DivisionID AND HV9999.TranMonth=@TranMonth AND HV9999.TranYear=@TranYear
--LEFT JOIN AT1102 A11 WITH (NOLOCK) ON A11.DepartmentID=HV1400.DepartmentID 
--LEFT JOIN HT1101 A12 WITH (NOLOCK) ON A12.DivisionID = HV1400.DivisionID AND A12.TeamID=HV1400.TeamID
LEFT JOIN AT1011 A13 ON A13.AnaID=HV1400.Ana04ID AND A13.AnaTypeID='A04'
LEFT JOIN AT1011 A14 ON A14.AnaID=HV1400.Ana05ID AND A14.AnaTypeID='A05'
WHERE HV1400.EmployeeID NOT IN (SELECT EmployeeID FROM HT1025 WHERE TranMonth=@TranMonth AND TranYear=@TranYear)
 AND HV1400.StatusID IN (0,1,2,4)
 AND ISNULL(HV1400.DepartmentID,'') Like ISNULL(@DepartmentID,'%')
 AND ISNULL(HV1400.TEAMID,'') LIKE ISNULL(@SectionID,'%') 
 AND ISNULL(HV1400.Ana04ID,'') LIKE ISNULL(@SubsectionID,'%')
 AND ISNULL(HV1400.Ana05ID,'') LIKE ISNULL(@ProcessID,'%')
--GROUP BY HV1400.EmployeeID,HV1400.FullName,DepartmentID,MonthYear, HV1400.DepartmentName,TEAMID,HV1400.TeamName, Ana04ID,A13.AnaName,Ana05ID,A14.AnaName

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

