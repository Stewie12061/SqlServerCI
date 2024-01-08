IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2152]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2152]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




















-- <Summary>
--- Load Master cho dự trù chi phí sản xuất
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Trọng Kiên	Create on: 03/03/2021


CREATE PROCEDURE [dbo].[MP2152]
(
    @DivisionID VARCHAR(50),
    @APK VARCHAR(50) = '',
    @APKMaster VARCHAR(50) = '',
    @Type VARCHAR(50) = ''
)
AS

DECLARE @sSQL NVARCHAR(max), 
        @sWhere  NVARCHAR(max) = '',
        @Level INT,
        @sSQLSL NVARCHAR (MAX) = '',
        @i INT = 1, @s VARCHAR(2),
        @sSQLJon NVARCHAR (MAX) = ''

IF ISNULL(@Type, '') = 'DTCP' 
BEGIN
SET @sWhere = @sWhere + 'AND CONVERT(VARCHAR(50),M1.APKMaster_9000)= '''+@APKMaster+''''
SELECT  @Level = MAX(Levels) FROM OT2201 WITH (NOLOCK) WHERE APKMaster_9000 = @APKMaster AND DivisionID = @DivisionID
END
ELSE
BEGIN
SET @sWhere = @sWhere + 'AND (CONVERT(VARCHAR(50),M1.APK)= '''+@APK+'''OR CONVERT(VARCHAR(50),M1.APKMaster_9000) = ''' + @APK + ''')'
SELECT  @Level = MAX(Levels) FROM OT2201 WITH (NOLOCK) WHERE @APK = @APK AND DivisionID = @DivisionID
END

    WHILE @i <= @Level
    BEGIN
        IF @i < 10 SET @s = '0' + CONVERT(VARCHAR, @i)
        ELSE SET @s = CONVERT(VARCHAR, @i)

        SET @sSQLSL=@sSQLSL+' ,ApprovePerson'+@s+'ID, ApprovePerson'+@s+'Name, O1.[Description] AS ApprovePerson'+@s+'Status ' 

        SET @sSQLJon =@sSQLJon+ '
                        LEFT JOIN (
                                  SELECT ApprovePersonID ApprovePerson'+@s+'ID, OOT1.APKMaster, OOT1.DivisionID,
                                         A1.FullName As ApprovePerson'+@s+'Name
                                  FROM OOT9001 OOT1 WITH (NOLOCK)
                                  INNER JOIN AT1103 A1 WITH (NOLOCK) ON A1.DivisionID=OOT1.DivisionID AND A1.EmployeeID=OOT1.ApprovePersonID
                                  WHERE OOT1.Level='+STR(@i)+'
                                  ) APP'+@s+' ON APP'+@s+'.DivisionID= OOT90.DivisionID  AND APP'+@s+'.APKMaster=OOT90.APK'

        SET @i = @i + 1	
    END

SET @sSQL = '
        SELECT  M1.APK
				, M1.DivisionID
				, M1.EstimateID
				, M1.TranMonth
				, M1.TranYear
				, M1.VoucherTypeID
				, M1.VoucherNo
				, M1.VoucherDate
				, M1.DepartmentID
				, M1.EmployeeID
				, M1.Description
				, M1.CreateUserID
				, M1.CreateDate
				, M1.LastModifyUserID
				, M1.LastModifyDate
				, M1.WareHouseID
				, M1.OrderStatus
				, M1.ObjectID
				, A1.ObjectName
				, A2.FullName AS EmployeeName
				, M1.SuppliesDate
				, M1.StatusID
				, M1.Note
				, M1.Levels
				, M1.ApproveLevel
				, M1.ApprovingLevel
				, M1.DeleteFlg
				, M1.APKMaster_9000							
				
				

    '+@sSQLSL+'
        FROM OT2201 M1 WITH (NOLOCK)
            LEFT JOIN OOT9000 OOT90 WITH (NOLOCK) ON M1.APKMaster_9000 = OOT90.APK
            LEFT JOIN OOT0099 O1 WITH (NOLOCK) ON O1.ID = ISNULL(M1.Status, 0) AND O1.CodeMaster = ''Status''
			LEFT JOIN AT1202 A1 WITH (NOLOCK) ON M1.ObjectID = A1.ObjectID
			LEFT JOIN AT1103 A2 WITH (NOLOCK) ON M1.EmployeeID = A2.EmployeeID

    '+@sSQLJon+'
    WHERE M1.DivisionID = '''+@DivisionID+''' '+@sWhere+''

EXEC (@sSQL)
PRINT (@sSQL)




















GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
