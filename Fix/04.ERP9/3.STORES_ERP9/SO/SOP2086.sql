IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2086]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2086]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid: màn hình kế thừa thông tin sản xuất
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Trọng Kiên on 22/02/2021
-- <Example>
---- 
/*-- <Example>
    SOP2086 @DivisionID = 'AIC', @UserID = '', @PageNumber = 1, @PageSize = 25, @ROrderID = 'sfasdf'

----*/

CREATE PROCEDURE [dbo].[SOP2086]
( 
     @DivisionID VARCHAR(50),
     @UserID VARCHAR(50),
     @PageNumber INT,
     @PageSize INT,	 
     @VoucherNo NVARCHAR(MAX),
	 @InventoryID NVARCHAR(MAX)
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @TotalRow NVARCHAR(50) = N'',
        @OrderBy NVARCHAR(500) = N'',
        @sJoin NVARCHAR(MAX) =N''

SET @OrderBy = 'S1.VoucherNo, S1.RoutingID DESC'
SET @sWhere = ''

SET @sSQL = @sSQL + N'
SELECT S2.VoucherNo
		, M1.PhaseID
		, M1.PhaseName
		, S2.ObjectID
		, A4.ObjectName
		, S1.MaterialID			AS MaterialID
		, MIN(A3.InventoryName) AS MaterialName
		, M1.PhaseTime
		, M1.UnitID
		, M7.Description AS UnitName
		, C1.TimeLimit
		, M2.RoutingTime
		, C1.WorkersLimit
		, M1.ResourceName
		, C1.MachineID
		, C1.MachineName
		, C1.UnitID AS UnitIDDetail
		, M6.Description AS UnitIDDetailName
		, C1.GoldLimit AS GoalLimit
		, M2.RoutingID
INTO #TempSOT2082
FROM MT2131 M1 WITH (NOLOCK)
    LEFT JOIN MT2130 M2 WITH (NOLOCK) ON M1.APKMaster = M2.APK
	LEFT JOIN MT2120 M3 WITH (NOLOCK) ON M2.RoutingID = M3.RoutingID
	LEFT JOIN CIT1150 C1 WITH (NOLOCK) ON M1.ResourceID = C1.MachineID
	LEFT JOIN SOT2082 S1 WITH (NOLOCK) ON M1.PhaseID = S1.PhaseID
	LEFT JOIN MT0099 M7 WITH (NOLOCK) ON M7.CodeMaster = ''RoutingUnit'' AND ISNULL(M7.Disabled, 0) = 0 AND M1.UnitID = M7.ID 
	LEFT JOIN SOT2080 S2 WITH (NOLOCK) ON S1.APKMaster = S2.APK
	LEFT JOIN MT0099 M4 WITH (NOLOCK) ON S1.DisplayName = M4.ID AND M4.CodeMaster = ''DisplayName'' AND ISNULL(M4.Disabled, 0)= 0
	LEFT JOIN AT1015 A2 WITH (NOLOCK) ON S1.KindSuppliers = A2.AnaID
	LEFT JOIN MT0099 M5 WITH (NOLOCK) ON S1.UnitSizeID = M5.ID AND M5.CodeMaster = ''UnitSize'' AND ISNULL(M5.Disabled, 0) = 0
	LEFT JOIN CRMT0099 C2 WITH (NOLOCK) ON C2.CodeMaster = ''CRMF2111.PrintType'' AND ISNULL(C2.Disabled, 0) = 0 AND S1.PrintTypeID = C2.ID
	LEFT JOIN CRMT0099 C3 WITH (NOLOCK) ON C3.CodeMaster = ''CRMF2111.RunPaper'' AND ISNULL(C3.Disabled, 0) = 0 AND S1.RunPaperID = C3.ID 
	LEFT JOIN AT1302 A3 WITH (NOLOCK) ON S1.MaterialID = A3.InventoryID
	LEFT JOIN MT0099 M6 WITH (NOLOCK) ON M6.ID = C1.UnitID AND M6.CodeMaster = ''RoutingUnit'' AND ISNULL(M6.Disabled, 0)= 0
	LEFT JOIN AT1202 A4 WITH (NOLOCK) ON S2.ObjectID = A4.ObjectID
	LEFT JOIN SOT2081 S3 WITH (NOLOCK) ON S2.APK = S3.APKMaster
WHERE M3.NodeID IN (''' + @InventoryID + ''') AND S2.VoucherNo IN (''' + @VoucherNo + ''')
GROUP BY S2.VoucherNo
		, M1.PhaseID
		, M1.PhaseName
		, S2.ObjectID
		, A4.ObjectName
		, S1.MaterialID
		, M1.PhaseTime
		, C1.TimeLimit
		, C1.WorkersLimit
		, M1.ResourceName
		, C1.MachineID
		, C1.MachineName
		, C1.UnitID
		, M6.Description
		, C1.GoldLimit
		, M2.RoutingID
		, M2.RoutingTime
		, S1.PhaseOrder
		, M1.UnitID
		, M7.Description
ORDER BY S2.VoucherNo, M2.RoutingID, S1.PhaseOrder DESC

DECLARE @Count INT
SELECT @Count = COUNT (*) FROM #TempSOT2082

SELECT @Count AS TotalRow
		, S1.VoucherNo
		, S1.PhaseID
		, S1.PhaseName
		, S1.ObjectID
		, S1.ObjectName
		, S1.MaterialID
		, S1.MaterialName
		, S1.WorkersLimit
		, S1.PhaseTime
		, S1.RoutingTime
		, S1.TimeLimit
		, S1.UnitID
		, S1.UnitName
		, S1.ResourceName
		, S1.MachineID
		, S1.MachineName
		, S1.UnitIDDetail
		, S1.UnitIDDetailName
		, S1.GoalLimit
		, S1.RoutingID

FROM #TempSOT2082 S1
ORDER BY ' + @OrderBy + '
OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '

    EXEC (@sSQL)
    PRINT(@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
