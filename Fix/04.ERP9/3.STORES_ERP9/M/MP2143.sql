IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2143]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2143]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








-- <Summary>
---- Load Detail kế hoạch sản xuất (thông tin phiếu sản xuất)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Trọng Kiên on 01/03/2021
----Modify by: Thanh Lượng on 15/09/2023 - Cập nhật : [2023/09/TA/0070] - Xử lý bổ sung trường Specification (Customize PANGLOBE).
-- <Example> EXEC MP2143 @DivisionID = 'BE', @UserID = '', @APK = '9B8430BF-53C2-4EAB-A524-50BC4F2FCA82'
CREATE PROCEDURE MP2143
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50)
)

AS 

	DECLARE @sSQL NVARCHAR(MAX) = N'',
			@OrderBy NVARCHAR(MAX) = N'', 
			@TotalRow NVARCHAR(50) = N'',
			@sWhere NVARCHAR(MAX) = N''

	SET @OrderBy = N'Orders'

	SET @sSQL = N'
				SELECT  M1.APK, M1.APKMaster, M1.DivisionID, M1.DeleteFlg, M1.CreateUserID, M1.CreateDate, M1.LastModifyDate, M1.UnitID, M1.UnitName,
							   M1.LastModifyUserID, M1.VoucherNoProduct, M1.InventoryID, M1.InventoryName, M1.ObjectID, M1.ObjectName,
							   M1.DateDelivery, M1.StartDate, M1.EndDate, M1.StatusID, M1.StatusName, M1.Number, M1.Quantity, M1.EndDatePlan, M1.Orders
							   , M1.InheritTableID, M1.InheritVoucherID, M1.InheritTransactionID, M1.APK_BomVersion
                               , M1.nvarchar01, M1.nvarchar02, M1.nvarchar03, M1.nvarchar04, M1.nvarchar05, M1.nvarchar06, M1.nvarchar07, M1.nvarchar08, M1.nvarchar09, M1.nvarchar10, A12.Specification
						INTO #TempMP2143
						FROM MT2141 M1 WITH (NOLOCK)
						LEFT JOIN AT1302 A12 WITH (NOLOCK) ON A12.InventoryID = M1.InventoryID
						WHERE CONVERT(VARCHAR(50),M1.APKMaster) = '''+@APK+''' AND M1.DivisionID = ''' + @DivisionID + '''

				DECLARE @Count INT
				SELECT @Count = COUNT(*) FROM #TempMP2143
				
				SELECT  CONVERT(INT, ROW_NUMBER() OVER (ORDER BY '+@OrderBy+')) AS RowNum, @Count AS TotalRow
						, APK, APKMaster, DivisionID, DeleteFlg, CreateUserID, CreateDate, LastModifyDate, LastModifyUserID
						, VoucherNoProduct, InventoryID, InventoryName, ObjectID, ObjectName, DateDelivery, StartDate, EndDate
						, StatusID, StatusName, Number, Quantity, EndDatePlan, UnitID, UnitName, Orders
						, InheritTableID, InheritVoucherID, InheritTransactionID, APK_BomVersion
                        , nvarchar01, nvarchar02, nvarchar03, nvarchar04, nvarchar05, nvarchar06, nvarchar07, nvarchar08, nvarchar09, nvarchar10,Specification
				FROM #TempMP2143 WITH (NOLOCK) 
				ORDER BY '+@OrderBy+''

 	 EXEC (@sSQL)
 







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
