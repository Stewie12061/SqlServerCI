IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP0368]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP0368]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load dữ liệu màn hình Duyệt đợt tuyển dụng lần 1 - HF0367 [Customize ANGEL]
-- <History>
---- Created by Tiểu Mai on 10/03/2016 
---- Modified by Phương Thảo on 18/05/2017: Sửa danh mục dùng chung
-- <Example>
/*
	exec HP0367 'TH', '03/01/2016', '03/11/2016', '%', '%', '%', 1
 */

CREATE PROCEDURE [dbo].[HP0368]  
		@DivisionID NVARCHAR(50),
		@FromDate DATETIME,
		@ToDate DATETIME,
		@RecruitTimeID NVARCHAR(50),
		@DepartmentID NVARCHAR(50), 
		@DutyID NVARCHAR(50),
		@IsType NVARCHAR(50)	--- 0: chưa duyệt
								--- 1: đã duyệt
 AS
DECLARE @sSQL NVARCHAR(MAX)

IF @IsType = 0

Set @sSQL = N' 
			SELECT HT1411.*, HT1409.RecruitName, HT1409.FromDate, HT1409.ToDate, HT1409.Notes, HT1409.TotalCost,
				AT1102.DepartmentName, HT1102.DutyName, HT1102.IsApproveRecruit, AT0099.Description as IsConfirmName, HT1101.TeamName
			FROM HT1411
			INNER JOIN HT1409 ON HT1409.DivisionID = HT1411.DivisionID AND HT1409.RecruitTimeID = HT1411.RecruitTimeID
			LEFT JOIN HT1102 ON HT1102.DivisionID = HT1411.DivisionID AND HT1102.DutyID = HT1411.DutyID
			LEFT JOIN AT1102 ON AT1102.DepartmentID = HT1411.DepartmentID
			LEFT JOIN HT1101 ON HT1101.DivisionID = HT1411.DivisionID AND HT1101.TeamID = HT1411.TeamID
			LEFT JOIN AT0099 ON AT0099.ID = HT1411.IsConfirm02 AND AT0099.CodeMaster = ''AT00000011''
			WHERE HT1411.DivisionID = '''+@DivisionID+'''
				AND (HT1409.FromDate BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,21)+'''
				OR HT1409.ToDate BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,21)+'''
				OR '''+CONVERT(VARCHAR(10),@FromDate,21)+''' BETWEEN HT1409.FromDate AND HT1409.ToDate
				OR '''+CONVERT(VARCHAR(10),@ToDate,21)+''' BETWEEN HT1409.FromDate AND HT1409.ToDate)
				AND HT1411.RecruitTimeID LIKE '''+@RecruitTimeID+'''
				AND HT1411.DepartmentID LIKE '''+@DepartmentID+'''
				AND HT1411.DutyID LIKE '''+@DutyID+'''
				AND HT1411.IsConfirm02 = 0
				AND HT1411.IsConfirm01 = 1
				AND HT1411.StatusRecruit = 0
'
ELSE 
	Set @sSQL = N' 
			SELECT HT1411.*, HT1409.RecruitName, HT1409.FromDate, HT1409.ToDate, HT1409.Notes, HT1409.TotalCost,
					AT1102.DepartmentName, HT1102.DutyName, HT1102.IsApproveRecruit,AT0099.Description as IsConfirmName, HT1101.TeamName
			FROM HT1411
			INNER JOIN HT1409 ON HT1409.DivisionID = HT1411.DivisionID AND HT1409.RecruitTimeID = HT1411.RecruitTimeID
			LEFT JOIN HT1102 ON HT1102.DivisionID = HT1411.DivisionID AND HT1102.DutyID = HT1411.DutyID
			LEFT JOIN AT1102 ON AT1102.DepartmentID = HT1411.DepartmentID
			LEFT JOIN HT1101 ON HT1101.DivisionID = HT1411.DivisionID AND HT1101.TeamID = HT1411.TeamID
			LEFT JOIN AT0099 ON AT0099.ID = HT1411.IsConfirm02 AND AT0099.CodeMaster = ''AT00000011''
			WHERE HT1411.DivisionID = '''+@DivisionID+'''
				AND (HT1409.FromDate BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,21)+'''
				OR HT1409.ToDate BETWEEN '''+CONVERT(VARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,21)+'''
				OR '''+CONVERT(VARCHAR(10),@FromDate,21)+''' BETWEEN HT1409.FromDate AND HT1409.ToDate
				OR '''+CONVERT(VARCHAR(10),@ToDate,21)+''' BETWEEN HT1409.FromDate AND HT1409.ToDate)
				AND HT1411.RecruitTimeID LIKE '''+@RecruitTimeID+'''
				AND HT1411.DepartmentID LIKE '''+@DepartmentID+'''
				AND HT1411.DutyID LIKE '''+@DutyID+'''
				AND HT1411.IsConfirm01 = 1 
				AND HT1411.IsConfirm02 = 1
				AND HT1411.StatusRecruit = 1
'
EXEC (@sSQL)
--PRINT (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
