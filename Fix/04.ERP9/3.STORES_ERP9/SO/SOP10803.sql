IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP10803]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP10803]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <History>
----Created by: Lê Thanh Lượng, Date: 05/07/2023
----Modify by: Lê Thanh Lượng, Date: 25/07/2023: [2023/07/TA/0069]: Bổ sung cho bộ màn hình kế hoạch doanh số Sell-OUT.
-- <Example>
--EXEC SOP10803 @DivisionID=N'DTI',@DivisionIDList=N'',@FromDate=NULL,@ToDate=NULL,@IsPeriod=0,@PeriodList=N'',@ObjectID=N'',@PageNumber=1,@PageSize=25

CREATE PROCEDURE [dbo].[SOP10803] (
 	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50),
	 @APKMaster_9000 VARCHAR(50) = '',
	 @Type VARCHAR(50) = ''			
) 
AS
DECLARE @sSQL NVARCHAR(MAX) = N'',
			@OrderBy NVARCHAR(MAX) = N'', 
			@TotalRow NVARCHAR(50) = N'',
			@PageNumber int = 1,
			@sSQLSL NVARCHAR (MAX) = '',
			@sSQLJon NVARCHAR(MAX) = '',
			@sWhere  NVARCHAR(max) = '',
			@Level INT,
			@i INT = 1,
			@s VARCHAR(2)

			IF ISNULL(@Type, '') = 'KHDSSI' or ISNULL(@Type, '') = 'KHDSSO' 
BEGIN
SET @sWhere = @sWhere + 'AND CONVERT(VARCHAR(50),T1.APKMaster_9000)= '''+@APKMaster_9000+''''
SELECT  @Level = MAX(Levels) FROM AT0161 WITH (NOLOCK) WHERE APKMaster_9000 = @APKMaster_9000 AND DivisionID = @DivisionID
END
ELSE
BEGIN
SET @sWhere = @sWhere + 'AND (CONVERT(VARCHAR(50),T1.APK)= '''+@APK+'''OR CONVERT(VARCHAR(50),T1.APKMaster_9000) = ''' + @APK + ''')'
SELECT  @Level = MAX(Levels) FROM AT0161 WITH (NOLOCK) WHERE @APK = @APK AND DivisionID = @DivisionID
END

    WHILE @i <= @Level
    BEGIN
        IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
        ELSE SET @s = CONVERT(VARCHAR, @i)
        SET @sSQLSL=@sSQLSL+' ,ApprovePerson'+@s+'ID, ApprovePerson'+@s+'Name, O99.[Description] AS ApprovePerson'+@s+'Status , ApprovePerson'+@s+'Note' 
        SET @sSQLJon =@sSQLJon+ '
                      LEFT JOIN (
                                SELECT ApprovePersonID ApprovePerson'+@s+'ID, OOT1.APKMaster, OOT1.DivisionID,
                                       A1.FullName As ApprovePerson'+@s+'Name,OOT1.Note AS ApprovePerson'+@s+'Note
                                FROM OOT9001 OOT1 WITH (NOLOCK)
                                INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.DivisionID in (''@@@'',OOT1.DivisionID) AND A1.EmployeeID=OOT1.ApprovePersonID
                                WHERE OOT1.Level='+STR(@i)+'
                                  ) APP'+@s+' ON APP'+@s+'.DivisionID in (''@@@'', OOT90.DivisionID)  AND APP'+@s+'.APKMaster=OOT90.APK'
        SET @i = @i + 1	
    END
		SET @sSQL =N'SELECT T1.APK, T1.DivisionID, T1.ObjectID, A2.ObjectName,
					T1.EmployeeID,T1.FromDate,A03.FullName AS EmployeeName,
					YEAR(T1.ToDate) as Year,T1.SalesYear,T1.APKMaster_9000,T1.StatusSS, T1.ApprovalNotes,
					T1.CreateDate, T1.CreateUserID, T1.LastModifyDate, T1.LastModifyUserID
					'+@sSQLSL+'
					FROM AT0161 T1 WITH (NOLOCK)			
					LEFT JOIN AT1202 A2 WITH(NOLOCK) ON A2.ObjectID = T1.ObjectID 
					LEFT JOIN AT1103 A03 WITH (NOLOCK) ON A03.EmployeeID = T1.EmployeeID 
					LEFT JOIN OOT0099 O99 WITH(NOLOCK) ON O99.CodeMaster = ''Status'' AND T1.StatusSS = O99.ID
					LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON T1.APKMaster_9000 = OOT90.APK           
						 '+@sSQLJon+'
					 WHERE T1.DivisionID = '''+@DivisionID+''' '+@sWhere+''
		EXEC (@sSQL)
		PRINT (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
