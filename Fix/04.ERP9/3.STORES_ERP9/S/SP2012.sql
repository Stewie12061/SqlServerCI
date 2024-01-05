IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SP2012]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SP2012]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO












-- <Summary>
--- Load Dữ liệu màn hình xem chi tiết SF2012 
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Tấn Thành	Create on: 06/10/2020


Create PROCEDURE [dbo].[SP2012]
(
	@DivisionID VARCHAR(50),
	@APK VARCHAR(50) = '',
	@APKMaster VARCHAR(50) = '',
	@Type VARCHAR(50) = ''
)
AS

DECLARE @sSQL NVARCHAR(MAX)


SET @sSQL = '
	SELECT S1.APK, S1.DivisionID, S1.PipeLineID, S1.PipeLineName, 
			S3.RefObjectName AS RefObject, S1.Description, S1.CreateUserID, 
			S1.CreateDate, S1.LastModifyUserID, S1.LastModifyDate, 
			S2.Description AS ConditionTypeID, S4.Description AS StatusID
	FROM ST2010 S1 WITH (NOLOCK)
		LEFT JOIN ST0099 S2 WITH (NOLOCK) ON S2.ID = S1.ConditionTypeID AND S2.CodeMaster = ''ConditionActiveType'' AND ISNULL(S2.Disabled,0) = 0
		LEFT JOIN ST2015 S3 WITH (NOLOCK) ON S3.ObjectTableName = S1.RefObject AND S3.DivisionID IN (S1.DivisionID,''@@@'') AND ISNULL(S3.Disabled,0) = 0
		LEFT JOIN ST0099 S4 WITH (NOLOCK) ON S4.ID = S1.StatusID AND S4.CodeMaster = ''PipelineStatus'' AND ISNULL(S4.Disabled,0) = 0
	WHERE S1.APK = ''' + @APK + ''' AND S1.DivisionID = ''' + @DivisionID + ''''

EXEC (@sSQL)
PRINT (@sSQL)













GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
