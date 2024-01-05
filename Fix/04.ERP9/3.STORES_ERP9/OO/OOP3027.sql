IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP3027]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP3027]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Báo cáo nhân viên nghỉ việc và lý do nghỉ + Báo cáo nhân viên nghỉ việc theo bộ phận
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 190/03/2016
-- <Example>
---- 
/*-- <Example>
	OOP3027 @DivisionID='MK', @FromDate = '2016-02-01 00:00:00.000', @ToDate= '2016-04-16 00:00:00.000',@DepartmentID ='%', @SectionID = '%',
 	@SubsectionID = '%',@ProcessID = '%',@StatusID = '%'
----*/

CREATE PROCEDURE OOP3027
( 
 @DivisionID VARCHAR(50),
 @FromDate DATETIME,
 @ToDate DATETIME,
 @DepartmentID VARCHAR(50),
 @SectionID VARCHAR(50),
 @SubsectionID VARCHAR(50),
 @ProcessID VARCHAR(50),
 @StatusID VARCHAR(50)
)
AS 
EXEC OOP3017 @DivisionID, @FromDate, @ToDate,@DepartmentID , @SectionID,@SubsectionID,@ProcessID
EXEC OOP3019 @DivisionID, @FromDate, @ToDate,@DepartmentID , @SectionID,@SubsectionID,@ProcessID 
EXEC OOP3014 @DivisionID, @FromDate, @ToDate,@DepartmentID , @SectionID,@SubsectionID,@ProcessID,@StatusID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
