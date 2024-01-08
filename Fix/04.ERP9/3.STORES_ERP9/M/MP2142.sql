IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2142]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2142]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- Load Detail kế hoạch sản xuất (thông tin máy)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Trọng Kiên on 01/03/2021
----Modify by: Nhật Quang on 07/03/2023 - Cập nhật : Bổ sung thêm select nvarchar01 -> 10, MaterialID, MaterialName, LineProduce
----Modify by: Nhật Quang on 16/03/2023 - Cập nhật : Bổ sung bỏ select nvarchar01 -> 10
----Modify by: Thanh Lượng on 15/09/2023 - Cập nhật : [2023/09/TA/0070] - Xử lý bổ sung trường Specification (Customize PANGLOBE).
-- <Example> EXEC MP2142 @DivisionID = 'BE', @UserID = '', @APK = '9B8430BF-53C2-4EAB-A524-50BC4F2FCA82'
CREATE PROCEDURE MP2142
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50)
)

AS 

	DECLARE @sSQL NVARCHAR(MAX) = N'',
			@sSQL1 NVARCHAR(MAX) = N'',
			@OrderBy NVARCHAR(MAX) = N'', 
			@TotalRow NVARCHAR(50) = N'',
			@sWhere NVARCHAR(MAX) = N''

	SET @OrderBy = N'Orders'
	SET @sSQL1 ='MaterialID, MaterialName, LineProduce, APK_MT2141, TotalQuantity
						, NULL AS Date01, NULL AS Date02, NULL AS Date03, NULL AS Date04, NULL AS Date05, NULL AS Date06, NULL AS Date07, NULL AS Date08, NULL AS Date09, NULL AS Date10
						, NULL AS Date11, NULL AS Date12, NULL AS Date13, NULL AS Date14, NULL AS Date15, NULL AS Date16, NULL AS Date17, NULL AS Date18, NULL AS Date19, NULL AS Date20
						, NULL AS Date21, NULL AS Date22, NULL AS Date23, NULL AS Date24, NULL AS Date25, NULL AS Date26, NULL AS Date27, NULL AS Date28, NULL AS Date29, NULL AS Date30
						, NULL AS Date31, NULL AS Date32, NULL AS Date33, NULL AS Date34, NULL AS Date35, NULL AS Date36, NULL AS Date37, NULL AS Date38, NULL AS Date39, NULL AS Date40
						, NULL AS Date41, NULL AS Date42, NULL AS Date43, NULL AS Date44, NULL AS Date45, NULL AS Date46, NULL AS Date47, NULL AS Date48, NULL AS Date49, NULL AS Date50
						, NULL AS Date51, NULL AS Date52, NULL AS Date53, NULL AS Date54, NULL AS Date55, NULL AS Date56, NULL AS Date57, NULL AS Date58, NULL AS Date59, NULL AS Date60
						, APK_BomVersion'
	SET @sSQL = N' SELECT M1.APK, M1.APKMaster, M1.DivisionID, M1.DeleteFlg, M1.CreateUserID, M1.CreateDate, M1.LastModifyDate, M1.LastModifyUserID, M1.MachineID, M1.MachineName, M1.VoucherNoProduct
						  , M1.UnitID, M1.UnitName, M1.GoalLimit, M1.TimeLimit, M1.TimeNumber, M1.StartDateManufacturing, M1.Quantity01, M1.Quantity02, M1.Quantity03, M1.Quantity04, M1.Quantity05
						  , M1.Quantity06, M1.Quantity07, M1.Quantity08, M1.Quantity09, M1.Quantity10, M1.Quantity11, M1.Quantity12, M1.Quantity13, M1.Quantity14, M1.Quantity15, M1.Quantity16
						  , M1.Quantity17, M1.Quantity18, M1.Quantity19, M1.Quantity20, M1.Quantity21, M1.Quantity22, M1.Quantity23, M1.Quantity24, M1.Quantity25, M1.Quantity26, M1.Quantity27
						  , M1.Quantity28, M1.Quantity29, M1.Quantity30, M1.Quantity31, M1.Quantity32, M1.Quantity33, M1.Quantity34, M1.Quantity35, M1.Quantity36, M1.Quantity37, M1.Quantity38
						  , M1.Quantity39, M1.Quantity40, M1.Quantity41, M1.Quantity42, M1.Quantity43, M1.Quantity44, M1.Quantity45, M1.Quantity46, M1.Quantity47, M1.Quantity48, M1.Quantity49
						  , M1.Quantity50, M1.Quantity51, M1.Quantity52, M1.Quantity53, M1.Quantity54, M1.Quantity55, M1.Quantity56, M1.Quantity57, M1.Quantity58, M1.Quantity59, M1.Quantity60
						  , M1.Orders, M1.PhaseID, M1.PhaseName, M1.TimeNumberPlan, M1.WorkersLimit, M1.SpaceTimes,
							M1.MaterialID, M1.MaterialName, M1.LineProduce,A12.Specification
						  , M1.APK_MT2141
						  , M1.TotalQuantity AS TotalQuantity
						  , CAST(M41.APK_BomVersion AS uniqueidentifier) AS APK_BomVersion
						INTO #TempMP2142
						FROM MT2142 M1 WITH (NOLOCK)
							LEFT JOIN MT2141 M41 WITH (NOLOCK) ON M41.APK = M1.APK_MT2141
							LEFT JOIN AT1302 A12 WITH (NOLOCK) ON A12.InventoryID = M41.InventoryID
						WHERE CONVERT(VARCHAR(50), M1.APKMaster) = '''+@APK+''' AND M1.DivisionID = ''' + @DivisionID + '''

				DECLARE @Count INT
				SELECT @Count = COUNT(*) FROM #TempMP2142
				
				SELECT  CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, @Count AS TotalRow
						, APK, APKMaster, DivisionID, DeleteFlg, CreateUserID, CreateDate, LastModifyDate
						, LastModifyUserID, MachineID, MachineName, VoucherNoProduct, UnitID, UnitName, Specification
						, GoalLimit, TimeLimit, TimeNumber, StartDateManufacturing, IIF(Quantity01 = 0 , NULL, Quantity01) AS Quantity01, IIF(Quantity02 = 0 , NULL, Quantity02) AS Quantity02
						, IIF(Quantity03 = 0 , NULL, Quantity03) AS Quantity03, IIF(Quantity04 = 0 , NULL, Quantity04) AS Quantity04, IIF(Quantity05 = 0 , NULL, Quantity05) AS Quantity05
						, IIF(Quantity06 = 0 , NULL, Quantity06) AS Quantity06, IIF(Quantity07 = 0 , NULL, Quantity07) AS Quantity07, IIF(Quantity08 = 0 , NULL, Quantity08) AS Quantity08
						, IIF(Quantity09 = 0 , NULL, Quantity09) AS Quantity09, IIF(Quantity10 = 0 , NULL, Quantity10) AS Quantity10, IIF(Quantity11 = 0 , NULL, Quantity11) AS Quantity11
						, IIF(Quantity12 = 0 , NULL, Quantity12) AS Quantity12, IIF(Quantity13 = 0 , NULL, Quantity13) AS Quantity13, IIF(Quantity14 = 0 , NULL, Quantity14) AS Quantity14
						, IIF(Quantity15 = 0 , NULL, Quantity15) AS Quantity15, IIF(Quantity16 = 0 , NULL, Quantity16) AS Quantity16, IIF(Quantity17 = 0 , NULL, Quantity17) AS Quantity17
						, IIF(Quantity18 = 0 , NULL, Quantity18) AS Quantity18, IIF(Quantity19 = 0 , NULL, Quantity19) AS Quantity19, IIF(Quantity20 = 0 , NULL, Quantity20) AS Quantity20
						, IIF(Quantity21 = 0 , NULL, Quantity21) AS Quantity21, IIF(Quantity22 = 0 , NULL, Quantity22) AS Quantity22, IIF(Quantity23 = 0 , NULL, Quantity23) AS Quantity23
						, IIF(Quantity24 = 0 , NULL, Quantity24) AS Quantity24, IIF(Quantity25 = 0 , NULL, Quantity25) AS Quantity25, IIF(Quantity26 = 0 , NULL, Quantity26) AS Quantity26
						, IIF(Quantity27 = 0 , NULL, Quantity27) AS Quantity27, IIF(Quantity28 = 0 , NULL, Quantity28) AS Quantity28, IIF(Quantity29 = 0 , NULL, Quantity29) AS Quantity29
						, IIF(Quantity30 = 0 , NULL, Quantity30) AS Quantity30, IIF(Quantity31 = 0 , NULL, Quantity31) AS Quantity31, IIF(Quantity32 = 0 , NULL, Quantity32) AS Quantity32
						, IIF(Quantity33 = 0 , NULL, Quantity33) AS Quantity33, IIF(Quantity34 = 0 , NULL, Quantity34) AS Quantity34, IIF(Quantity35 = 0 , NULL, Quantity35) AS Quantity35
						, IIF(Quantity36 = 0 , NULL, Quantity36) AS Quantity36, IIF(Quantity37 = 0 , NULL, Quantity37) AS Quantity37, IIF(Quantity38 = 0 , NULL, Quantity38) AS Quantity38
						, IIF(Quantity39 = 0 , NULL, Quantity39) AS Quantity39, IIF(Quantity40 = 0 , NULL, Quantity40) AS Quantity40, IIF(Quantity41 = 0 , NULL, Quantity41) AS Quantity41
						, IIF(Quantity42 = 0 , NULL, Quantity42) AS Quantity42, IIF(Quantity43 = 0 , NULL, Quantity43) AS Quantity43, IIF(Quantity44 = 0 , NULL, Quantity44) AS Quantity44
						, IIF(Quantity45 = 0 , NULL, Quantity45) AS Quantity45, IIF(Quantity46 = 0 , NULL, Quantity46) AS Quantity46, IIF(Quantity47 = 0 , NULL, Quantity47) AS Quantity47
						, IIF(Quantity48 = 0 , NULL, Quantity48) AS Quantity48, IIF(Quantity49 = 0 , NULL, Quantity49) AS Quantity49, IIF(Quantity50 = 0 , NULL, Quantity50) AS Quantity50
						, IIF(Quantity51 = 0 , NULL, Quantity51) AS Quantity51, IIF(Quantity52 = 0 , NULL, Quantity52) AS Quantity52, IIF(Quantity53 = 0 , NULL, Quantity53) AS Quantity53
						, IIF(Quantity54 = 0 , NULL, Quantity54) AS Quantity54, IIF(Quantity55 = 0 , NULL, Quantity55) AS Quantity55, IIF(Quantity56 = 0 , NULL, Quantity56) AS Quantity56
						, IIF(Quantity57 = 0 , NULL, Quantity57) AS Quantity57, IIF(Quantity58 = 0 , NULL, Quantity58) AS Quantity58, IIF(Quantity59 = 0 , NULL, Quantity59) AS Quantity59
						, IIF(Quantity60 = 0 , NULL, Quantity60) AS Quantity60, Orders, PhaseID, PhaseName, IIF(TimeNumberPlan = 0 , NULL, TimeNumberPlan) AS TimeNumberPlan
						, IIF(WorkersLimit = 0 , NULL, WorkersLimit) AS WorkersLimit, IIF(SpaceTimes = 0 , NULL, SpaceTimes) AS SpaceTimes,'+@sSQL1+'
				FROM #TempMP2142 WITH (NOLOCK) 
				ORDER BY '+@OrderBy+''
PRINT (@sSQL)
EXEC (@sSQL)
 






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
