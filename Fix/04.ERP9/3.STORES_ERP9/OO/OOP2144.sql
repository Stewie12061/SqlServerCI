IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2144]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2144]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
--- Load Master cho màn hình Update - OOF2141 (Định mức dự án)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Tấn Lộc on: 25/07/2019
---- Update by: Đình Ly on: 13/08/2019
-- <Example>
/*
	EXEC OOP2144 'DTI', 'eb4f9f48-0c04-41b5-a3fe-47fb71a84853', '1f2b84ee-00fe-47f1-3199-a67d77115c21', 'DMDA'
	EXEC OOP2144 @DivisionID, @APK	
*/

Create PROCEDURE [dbo].[OOP2144]
(
	@DivisionID VARCHAR(50),
	@APK VARCHAR(50) = '',
	@APKMaster VARCHAR(50) = '',
	@Type VARCHAR(50) = ''
)
AS

DECLARE @Ssql NVARCHAR(max), 
		@Swhere  NVARCHAR(max) = '',
		@Level INT,
		@sSQLSL NVARCHAR (MAX) = '',
		@i INT = 1, @s VARCHAR(2),
		@sSQLJon NVARCHAR (MAX) = ''

IF ISNULL(@Type, '') = 'DMDA' 
BEGIN
SET @Swhere = @Swhere + 'AND CONVERT(VARCHAR(50),OOT2140.APKMaster_9000)= '''+@APKMaster+''''
SELECT  @Level = MAX(Levels) FROM OOT2140 WITH (NOLOCK) WHERE APKMaster_9000 = @APKMaster AND DivisionID = @DivisionID
END
ELSE
BEGIN
SET @Swhere = @Swhere + 'AND CONVERT(VARCHAR(50),OOT2140.APK)= '''+@APK+''''
SELECT  @Level = MAX(Levels) FROM OOT2140 WITH (NOLOCK) WHERE @APK = @APK AND DivisionID = @DivisionID
END

	WHILE @i <= @Level
	BEGIN
		IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
		ELSE SET @s = CONVERT(VARCHAR, @i)

		SET @sSQLSL=@sSQLSL+' , ApprovePerson'+@s+'ID, ApprovePerson'+@s+'Name' 
		
		SET @sSQLJon =@sSQLJon+ '
						LEFT JOIN (
						SELECT ApprovePersonID ApprovePerson'+@s+'ID, OOT1.APKMaster, OOT1.DivisionID, OOT1.Status,
						 A1.FullName As ApprovePerson'+@s+'Name
						FROM OOT9001 OOT1 WITH (NOLOCK)
						INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.DivisionID=OOT1.DivisionID AND A1.EmployeeID=OOT1.ApprovePersonID
						WHERE OOT1.Level='+STR(@i)+'
						) APP'+@s+' ON APP'+@s+'.DivisionID= OOT90.DivisionID  AND APP'+@s+'.APKMaster=OOT90.APK'
						
		SET @i = @i + 1		
	END

SET @Ssql = '
	SELECT OOT2140.APK, OOT2140.APKMaster_9000, OOT2100.ProjectName, OOT2140.ProjectID, OOT2140.QuotationID
	'+@sSQLSL+'
	FROM OOT2140 With (NOLOCK)
	LEFT JOIN OOT2100 ON OOT2140.ProjectID = OOT2100.ProjectID
	LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON OOT2140.APKMaster_9000 = OOT90.APK
	'+@sSQLJon+'
	WHERE OOT2140.DivisionID = '''+@DivisionID+''' '+@Swhere+''

EXEC (@Ssql)
PRINT (@Ssql)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
