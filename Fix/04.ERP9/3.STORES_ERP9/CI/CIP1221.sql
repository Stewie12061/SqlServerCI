IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP1221]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CIP1221]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Popup Master detail thiết lập khuyến mãi theo điều kiện (màn hình cập nhật).
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Thanh Lượng on 12/05/2023
----Modified by Nhat Thanh on 19/05/2023 : Bỏ join detail CIT1221
----Modified by Thanh Lượng on 23/05/2023 : Bổ sung division dùng chung
----Modified by Thanh Lượng on 12/23/2023 : Bổ sung trường OjectID.

-- <Example> EXEC CIP1221 @DivisionID = 'GREE', @UserID = '', @APK = 'C69E5AE4-6FE1-4829-B99A-78D1AB7D89D3'
----
CREATE PROCEDURE CIP1221
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
                                INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.DivisionID in (''@@@'',OOT1.DivisionID) AND A1.EmployeeID=OOT1.ApprovePersonID
                                WHERE OOT1.Level='+STR(@i)+'
                                  ) APP'+@s+' ON APP'+@s+'.DivisionID in (''@@@'', OOT90.DivisionID)  AND APP'+@s+'.APKMaster=OOT90.APK'
        SET @i = @i + 1	
    END
		SET @sSQL =N'SELECT	T1.APK, T1.DivisionID, T1.PromoteID, T1.PromoteName
						,T1.OID, T1.FromDate, T1.ToDate, T1.Description, T1.ObjectID
						, T1.IsCommon, T1.Disabled, T1.IsDiscountWallet, T1.IsEnd, T1.StatusSS, T1.Levels, T1.ApproveLevel, 
						T1.ApprovingLevel, T1.APKMaster_9000, ApprovalNotes
						--,T2.ConditionID, T2.AnchorID, T2.ConditionName, T2.ObjectCustomID, T2.PaymentID, T2.ToolID
						'+@sSQLSL+'
					FROM CIT1220 T1  WITH (NOLOCK)
						--LEFT JOIN CIT1221 T2 WITH(NOLOCK) ON T1.APK = T2.APKMaster AND T1.DivisionID = T2.DivisionID
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

