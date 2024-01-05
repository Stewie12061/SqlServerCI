IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2114]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2114]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load master bảng tính giá
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <Histor>
---- Created by: Đình Hòa on: 22/06/2021


CREATE PROCEDURE SOP2114
(
	@DivisionID VARCHAR(50),
	@APK VARCHAR(50),
	@APKMaster VARCHAR(50) = '',
	@Type VARCHAR(50) = ''
)
AS

DECLARE @Ssql Nvarchar(max) ='', 
		@Swhere  Nvarchar(max) = '',
		@query AS NVARCHAR(MAX)='',
		@Level INT = 0,
		@sSQLSL NVARCHAR (MAX) = '',
		@i INT = 1, @s VARCHAR(2),
		@sSQLJon NVARCHAR (MAX) = ''

IF ISNULL(@Type, '') = 'BTG' 
BEGIN
	SET @Swhere = @Swhere + 'AND CONVERT(VARCHAR(50),S01.APKMaster_9000)= '''+@APKMaster+''''
	SELECT @Level = MAX(Level) FROM OOT9001 WITH (NOLOCK) WHERE APKMaster = @APKMaster
END
ELSE 
BEGIN
	SET @Swhere = @Swhere + 'AND (S01.APK = '''+@APK+''' OR S01.APKMaster_9000 = '''+@APK+''')'
	SELECT @Level = MAX(Level) FROM OOT9001 WITH (NOLOCK) LEFT JOIN SOT2110 S01 ON OOT9001.APKMaster = S01.APKMaster_9000  WHERE (S01.APK = @APK OR S01.APKMaster_9000 = @APK)
END

WHILE @i <= @Level
BEGIN
	IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
	ELSE SET @s = CONVERT(VARCHAR, @i)
	SET @sSQLSL=@sSQLSL+' , APP'+@s+'.ApprovePerson'+@s+'ID, APP'+@s+'.ApprovePerson'+@s+'Name, APP'+@s+'.ApprovePerson'+@s+'Status AS Status'+@s+', APP'+@s+'.ApprovePerson'+@s+'StatusName'
	SET @sSQLJon = @sSQLJon+ '
		LEFT JOIN (SELECT ApprovePersonID ApprovePerson'+@s+'ID,OOT1.APKMASter,OOT1.DivisionID,OOT1.Status,
			HT14.FullName AS ApprovePerson'+@s+'Name,
		OOT1.Status ApprovePerson'+@s+'Status, O99.Description ApprovePerson'+@s+'StatusName,
		OOT1.Note ApprovePerson'+@s+'Note
		FROM OOT9001 OOT1 WITH (NOLOCK)
		INNER JOIN AT1103 HT14 WITH (NOLOCK) ON HT14.DivisionID IN (''@@@'',OOT1.DivisionID) AND HT14.EmployeeID=OOT1.ApprovePersonID
		LEFT JOIN OOT0099 O99 WITH (NOLOCK) ON O99.ID1=ISNULL(OOT1.Status,0) AND O99.CodeMASter=''Status''
		WHERE OOT1.Level='+STR(@i)+')APP'+@s+' ON APP'+@s+'.DivisionID= OOT90.DivisionID  AND APP'+@s+'.APKMASter=OOT90.APK'
	SET @i = @i + 1		
END	

SET @Ssql = @Ssql + N' 
SELECT DISTINCT S01.*, S02.InventoryName, A15.AnaName AS ColorName, A02.ObjectName AS AccountName
	 '+@sSQLSL+'
	 FROM SOT2110 S01 WITH(NOLOCK)
     LEFT JOIN AT1302 S02 WITH(NOLOCK) ON S01.InventoryID = S02.InventoryID AND S02.DivisionID IN (''@@@'',S01.DivisionID)
	 LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON S01.APKMaster_9000 = OOT90.APK
	 LEFT JOIN AT1015 A15 WITH(NOLOCK) ON S01.ColorID = A15.AnaID AND A15.AnaTypeID = ''I02'' AND A15.DivisionID IN (''@@@'',S01.DivisionID)
	 LEFT JOIN AT1202 A02 WITH(NOLOCK) ON S01.AccountID = A02.ObjectID AND A02.DivisionID IN (''@@@'',S01.DivisionID)
	'+@sSQLJon+'
	 WHERE S01.DivisionID = '''+@DivisionID+''' '+@Swhere+' AND ISNULL(S01.DeleteFlag,0) = 0'

EXEC (@Ssql )
PRINT (@Ssql)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
