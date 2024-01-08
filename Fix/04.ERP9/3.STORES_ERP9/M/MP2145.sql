IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2145]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2145]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load Grid: Màn hình kế thừa kế hoạch sản xuất (Detail)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Trọng Kiên on 05/04/2021
----Modified by Lê Hoàng on 03/06/2021: Sửa điều kiện khi join Bộ định mức/Version BOM.
----Modified by Đình Hòa on 08/06/2021: Join kế thừa cho nghiệp vụ đơn hàng sản xuất, Bổ sung param để phân biệt kế thừ từ nguồn nào.
----Modified by Đình Ly on 23/06/2021: Chỉnh sửa điều kiện load chi tiết Quy trình sản xuất.
----Modified by Kiều Nga on 27/01/2022: Fix lỗi kế hoạch sản xuất đã kế thừa rồi vẫn còn load lại
----Modified by Kiều Nga on 04/10/2022: Fix lỗi lệnh sản xuất đã xóa nhưng không load lại kế thừa
----Modified by Đức Tuyên on 04/08/2023: Điều chỉnh lệnh sản xuất customize MAITHU
----Modify by: Thanh Lượng on 15/09/2023 - Cập nhật : [2023/09/TA/0070] - Xử lý bổ sung trường Specification (Customize PANGLOBE).
----
/*-- <Example>
    MP2145 @DivisionID = 'AIC', @UserID = '', @PageNumber = 1, @PageSize = 25, @ROrderID = 'KHSX/06/2021/0006'
----*/

CREATE PROCEDURE [dbo].[MP2145]
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
	 @IsInherit INT -- 1: Kế thừa Thông tin sản xuất, 2: Kế thừa đơn hàng sản xuất.
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


IF(@CustomerIndex = 117) -- Khách hàng MAITHU
BEGIN
	SET @sWhere = ''
	SET @OrderBy = 'M1.PhaseID, StartDateManufacturing'
	SET @sElement = N'M1.MachineID, M1.MachineName, M1.MaterialID, M43.Date AS StartDateManufacturing, M43.APK AS APK_MT2143'

	SET @sGroupby = N'
	GROUP BY M43.APK, M1.APK, M1.MachineID, M1.MachineName, M1.MaterialID, M43.Date, M1.APKMaster,
	M1.VoucherNoProduct, M1.PhaseID, M1.PhaseName, M1.UnitID, M1.UnitName,
	M1.TimeLimit, M1.TimeNumber, M1.GoalLimit, M1.TimeNumberPlan, M1.WorkersLimit, M1.SpaceTimes'

	SET @sJoin = 'LEFT JOIN MT2143 M43 WITH (NOLOCK) ON M1.APK = M43.APKMaster'

-- Xử lý load dữ liệu cho màn hình.
SET @sSQL = @sSQL + N'
	SELECT DISTINCT '+ @sElement + ' 
		, M1.APK
		, M1.APKMaster
		, M1.VoucherNoProduct
		, M1.PhaseID, M1.PhaseName
		, M1.UnitID, M1.UnitName
		, M1.TimeLimit
		, M1.TimeNumber
		, M1.GoalLimit
		, M1.TimeNumberPlan
		, M1.WorkersLimit
		, M1.SpaceTimes
	INTO #FirstTemp
	FROM MT2142 M1 WITH (NOLOCK)'

SET @sWhere = ' 
WHERE CONVERT(VARCHAR(50), M1.APKMaster) = (''' + @APKMaster + ''') AND M1.VoucherNoProduct = (''' + @VoucherNo + ''')
      AND M43.APK NOT IN (SELECT MT2161.InheritTransactionID FROM MT2161 WITH (NOLOCK) 
							INNER JOIN MT2160 WITH (NOLOCK) ON MT2161.APKMaster = MT2160.APK 
							WHERE MT2161.InheritTableID =''MT2140'' AND MT2161.InheritTransactionID IS NOT NULL)'

SET @sSQL01 = ' 
	DECLARE @Count INT
	SELECT @Count = COUNT (*) FROM #FirstTemp

	SELECT @Count AS TotalRow
		, M1.APK
		, M1.APK_MT2143 AS APK_MT2143
		, M1.APKMaster
		, M1.MachineID, M1.MachineName
		, M1.MaterialID
		, M1.VoucherNoProduct
		, M1.StartDateManufacturing
		, M1.UnitID, M1.UnitName
		, M1.PhaseID, M1.PhaseName
		, M1.TimeLimit
		, M1.TimeNumber
		, M1.GoalLimit
		, M1.TimeNumberPlan
		, M1.WorkersLimit
		, M1.SpaceTimes
	FROM #FirstTemp M1
	ORDER BY ' + @OrderBy + '
	OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
	FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
END

ELSE
BEGIN
	SET @sWhere = ''
	SET @OrderBy = 'M1.PhaseID, StartDateManufacturing'
	SET @sElement = N'MT42.MachineID, MT42.MachineName, MT43.Date AS StartDateManufacturing, MT43.APK AS APK_MT2143'

	SET @sGroupby = N'
	GROUP BY MT43.APK, MT42.MachineID, MT42.MachineName, MT43.Date, MT42.APKMaster,
	MT42.VoucherNoProduct, MT42.PhaseID, MT42.PhaseName, MT42.UnitID, MT42.UnitName,AT12.Specification,
	MT42.TimeLimit, MT42.TimeNumber, MT42.GoalLimit, MT42.TimeNumberPlan, MT42.WorkersLimit, MT42.SpaceTimes, MT42.MaterialID
	, MT41.APK_BomVersion, MT42.APK, MT40.VoucherNo, MT41.nvarchar01 '

	IF @VersionBOM = 0
		SET @sJoin = '
			LEFT JOIN MT2143 MT43 WITH (NOLOCK) ON MT42.APK = MT43.APKMaster'
	ELSE
		SET @sJoin = '
			LEFT JOIN MT2143 MT43 WITH (NOLOCK) ON MT42.APK = MT43.APKMaster'

	-- Xử lý load dữ liệu cho màn hình.
	SET @sSQL = @sSQL + N'
		SELECT DISTINCT '+ @sElement + ' 
			, MT42.APK AS APK_MT2142
			, MT42.APKMaster
			, MT42.VoucherNoProduct
			, MT42.MaterialID
			, MT42.PhaseID, MT42.PhaseName
			, MT42.UnitID, MT42.UnitName
			, AT12.Specification
			, MT42.TimeLimit
			, MT42.TimeNumber
			, MT42.GoalLimit
			, MT42.TimeNumberPlan
			, MT42.WorkersLimit
			, MT42.SpaceTimes
			, MT41.APK_BomVersion
			, MT40.VoucherNo
			, MT41.nvarchar01
		INTO #FirstTemp

		FROM MT2141 MT41 WITH (NOLOCK)
			LEFT JOIN MT2142 MT42 WITH (NOLOCK) ON MT41.DivisionID = MT42.DivisionID
											AND MT41.APK = MT42.APK_MT2141
			LEFT JOIN MT2140 MT40 WITH (NOLOCK) ON MT40.DivisionID = MT41.DivisionID 
											AND MT40.APK = MT41.APKMaster 
			LEFT JOIN AT1302 AT12 WITH (NOLOCK) ON AT12.InventoryID = MT42.MaterialID
		'

	SET @sWhere = ' 
	WHERE CONVERT(VARCHAR(50), MT42.APKMaster) = (''' + @APKMaster + ''') 
			AND MT42.VoucherNoProduct = (''' + @VoucherNo + ''')
			AND CONVERT(VARCHAR(50), MT42.APK_MT2141) = CONVERT(VARCHAR(50), MT41.APK)
			AND MT41.APK = ''' + @APK + ''''

	SET @sSQL01 = ' 
		DECLARE @Count INT
		SELECT @Count = COUNT (*) FROM #FirstTemp

		SELECT @Count AS TotalRow
			, M1.APK_MT2142 AS  APK
			, M1.APK_MT2143 AS APK_MT2143
			, M1.APKMaster
			, M1.MaterialID
			, M1.MachineID, M1.MachineName
			, M1.VoucherNoProduct
			, M1.StartDateManufacturing
			, M1.UnitID, M1.UnitName
			, M1.Specification
			, M1.PhaseID, M1.PhaseName
			, M1.TimeLimit
			, M1.TimeNumber
			, M1.GoalLimit
			, M1.TimeNumberPlan
			, M1.WorkersLimit
			, M1.SpaceTimes 
			, M1.APK_BomVersion
			, ''MT2142'' AS InheritTableID
			, M1.VoucherNo AS InheritVoucherID
			, M1.APK_MT2142 AS  InheritTransactionID
			, M1.nvarchar01
		
		FROM #FirstTemp M1
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY 
		'
END

EXEC (@sSQL + @sJoin + @sWhere + @sGroupby + @sSQL01)
PRINT(@sSQL + @sJoin + @sWhere + @sGroupby + @sSQL01)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
