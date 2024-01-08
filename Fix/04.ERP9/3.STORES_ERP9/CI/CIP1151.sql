IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP1151]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP1151]
GO

/****** Object:  StoredProcedure [dbo].[CITP1151]    Script Date: 30/07/2020 14:05:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- <Summary>
---- Load Detail Cập nhật máy
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: nhttai on 13/10/2020
-- <Example> EXEC CITP1151 @DivisionID = 'VNP', @UserID = 'ASOFTADMIN ', @APK = 'DA53B4EC-D326-44D4-8785-AA4EA6344994'

CREATE PROCEDURE [dbo].[CIP1151]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50)
)

AS 

	SELECT T1.APK, T1.DivisionID, T1.MachineID, T1.StandardID, T1.Notes, T1.Disabled, T1.CreateDate
			, T1.CreateUserID, T1.LastModifyDate, T1.LastModifyUserID
			, T1.LastModifyDate, T1.LastModifyUserID
			, T2.MachineName
	FROM CIT1151 T1 WITH (NOLOCK) LEFT JOIN CIT1150 T2 WITH (NOLOCK) ON T2.DivisionID IN (T1.DivisionID,'@@@') AND T1.MachineID = T2.APK
	Order by T1.StandardID
GO
