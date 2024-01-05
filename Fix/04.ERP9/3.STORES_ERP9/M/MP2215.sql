IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2215]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2215]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid: Màn hình kế thừa lệnh sản xuất (Detail)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Hoàng Long 14/09/2023
----Modify by: Thanh Lượng on 15/09/2023 - Cập nhật : [2023/09/TA/0070] - Xử lý bổ sung trường Specification (Customize PANGLOBE).
----
/*-- <Example>
    MP2215 @DivisionID = 'AIC', @UserID = '', @PageNumber = 1, @PageSize = 25, @ROrderID = 'KHSX/06/2021/0006'
----*/

CREATE PROCEDURE [dbo].[MP2215]
( 
     @DivisionID VARCHAR(50),
     @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT,	
     @VoucherNo VARCHAR(MAX),
	 @APK VARCHAR(MAX) = '',
	 @APKMaster VARCHAR(MAX),
	 @ObjectID VARCHAR(50),
	 @NodeID VARCHAR(50),
	 @VersionBOM INT,
	 @IsInherit INT
)
AS

DECLARE 
	@sSQL NVARCHAR(MAX) = N'',
	@sSQL01 NVARCHAR(MAX) = N'',
    @sWhere NVARCHAR(MAX) = N'',
    @TotalRow NVARCHAR(50) = N'',
    @OrderBy NVARCHAR(500) = N'',
    @sJoin NVARCHAR(MAX) = N'',
	@sElement NVARCHAR(MAX) = N'',
	@sCondition NVARCHAR(MAX) = N'',
	@sGroupby NVARCHAR(MAX) = N'',
	@CustomerIndex INT = (SELECT CustomerName FROM CustomerIndex)

SET @sSQL = @sSQL + N'
        SELECT ROW_NUMBER() OVER(ORDER BY M61.APK) AS RowNum
             , COUNT(*) OVER() AS TotalRow
             , M61.MaterialID, M61.MaterialName
	         , M61.UnitID, M61.UnitName
	         , M61.PhaseID, A26.PhaseName
	         , M61.MachineID, C50.MachineName
	         , M61.StartDate, M61.MaterialQuantity, M61.Description, M61.PONumber, AT13.Specification
        FROM MT2161 M61 WITH(NOLOCK)
	        LEFT JOIN MT2160 M60 WITH(NOLOCK) ON M60.APK = M61.APKMaster
	        LEFT JOIN AT0126 A26 WITH(NOLOCK) ON A26.PhaseID = M61.PhaseID
	        LEFT JOIN CIT1150 C50 WITH(NOLOCK) ON C50.MachineID = M61.MachineID
			LEFT JOIN AT1302 AT13 WITH (NOLOCK) ON AT13.InventoryID = M61.MaterialID AND AT13.DivisionID IN (''@@@'',M61.DivisionID)
        WHERE M60.APK =''' + @APK + ''' AND M60.DivisionID = ''' +@DivisionID+'''
        ORDER BY M61.CreateDate
        '
EXEC (@sSQL)
PRINT(@sSQL )


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
