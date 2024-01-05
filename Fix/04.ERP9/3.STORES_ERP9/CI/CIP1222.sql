IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP1222]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CIP1222]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load View Master detail thiết lập khuyến mãi theo điều kiện (màn hình cập nhật).
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Thanh Lượng on 12/05/2023
----Modified by ... on ... :
----Modified by Thanh Lượng on 23/05/2023 : Bổ sung division dùng chung
----Modified by Thanh Lượng on 12/23/2023 : Bổ sung trường OjectID.
-- <Example> EXEC CIP1222 @DivisionID = 'GREE', @UserID = '', @APK = 'C69E5AE4-6FE1-4829-B99A-78D1AB7D89D3'

CREATE PROCEDURE CIP1222
( 
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

			IF ISNULL(@Type, '') = 'KMTDK' 
BEGIN
SET @sWhere = @sWhere + 'AND CONVERT(VARCHAR(50),T1.APKMaster_9000)= '''+@APKMaster_9000+''''
SELECT  @Level = MAX(Levels) FROM CIT1220 WITH (NOLOCK) WHERE APKMaster_9000 = @APKMaster_9000 AND DivisionID = @DivisionID
END
ELSE
BEGIN
SET @sWhere = @sWhere + 'AND (CONVERT(VARCHAR(50),T1.APK)= '''+@APK+'''OR CONVERT(VARCHAR(50),T1.APKMaster_9000) = ''' + @APK + ''')'
SELECT  @Level = MAX(Levels) FROM CIT1220 WITH (NOLOCK) WHERE @APK = @APK AND DivisionID = @DivisionID
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
                                  INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.DivisionID in (''@@@'', OOT1.DivisionID) AND A1.EmployeeID=OOT1.ApprovePersonID
                                  WHERE OOT1.Level='+STR(@i)+'
                                  ) APP'+@s+' ON APP'+@s+'.DivisionID in (''@@@'', OOT90.DivisionID)  AND APP'+@s+'.APKMaster=OOT90.APK'
        SET @i = @i + 1	
    END
		SET @sSQL =N'
						SELECT T1.APK, T1.DivisionID, T1.PromoteID, T1.PromoteName
								, T1.FromDate, T1.ToDate, T1.[Description], AT1202.ObjectName
								, STUFF(( SELECT '', '' + AT1015.AnaName
								FROM   AT1015 WITH (NOLOCK) 
								WHERE   AT1015.AnaID IN (SELECT Value FROM dbo.StringSplit(REPLACE(T1.OID, '' '', ''''), '',''))
								ORDER BY AT1015.AnaID
								FOR XML PATH('''')), 1, 1, '''') AS OID
								, T1.IsCommon, T1.[Disabled], A1.FullName AS CreateUserID, T1.CreateDate, A2.FullName AS LastModifyUserID, T1.LastModifyDate
								,T1.IsDiscountWallet,T1.Levels,T1.ApproveLevel,T1.ApprovingLevel, T1.APKMaster_9000, ApprovalNotes
								'+@sSQLSL+'
								FROM CIT1220 T1 WITH (NOLOCK)    
								LEFT JOIN AT1103 A1 WITH (NOLOCK) ON T1.CreateUserID = A1.EmployeeID 
								LEFT JOIN AT1103 A2 WITH (NOLOCK) ON T1.LastModifyUserID = A2.EmployeeID  
								LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID in (T1.DivisionID,''@@@'') and AT1202.ObjectID = T1.ObjectID
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


