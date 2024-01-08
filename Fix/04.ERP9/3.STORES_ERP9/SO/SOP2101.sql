IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2101]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2101]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Delete master và detail tiến độ giao hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
----Create on 09/08/2019 by Đình Ly
---- Modified by Đình Hoà, Date 13/07/2020 Bổ sung update IsShipDate khi xoá tiến độ giao hàng của dơn hàng bán.
---- Modified by Lê Hoàng, Date 08/06/2021 Kiểm tra không cho xóa, sửa tiến độ sinh tự động từ phiếu yêu cầu xuất kho

CREATE PROCEDURE [dbo].[SOP2101] (
	@DivisionID VARCHAR(50), 	-- Trường hợp @DivisionID đúng với DivisionID đăng nhập thì cho xóa
	@APK VARCHAR(50), 			-- Trường hợp sửa
	@APKList NVARCHAR(MAX), 	-- Trường hợp xóa hoặc xử lý enable/disable
	@TableID NVARCHAR(50), 		-- "OOT2140"	
	@Mode TINYINT, 				-- 0: Sửa, 1: Xóa; 2: Sửa (Disable/Enable)
	@IsDisable TINYINT, 		-- 1: Disable; 0: Enable
	@UserID VARCHAR(50)
) 
AS 
BEGIN
	DECLARE @sSQL NVARCHAR(MAX)
	IF @Mode = 1 -- Kiểm tra và xóa
	BEGIN
		SET @sSQL = '
				DECLARE @Status TINYINT, 
						@Message NVARCHAR(1000), 
						@Cur CURSOR, 
						@DelDivisionID VARCHAR(50),
						@DelAPK VARCHAR(50), 
						@DelVoucherNo NVARCHAR(250),
						@DelSOrderID NVARCHAR(250)

				DECLARE @OT2003 TABLE (
						Status TINYINT, 
						MessageID VARCHAR(100), 
						Params NVARCHAR(4000))
				SET @Status = 0
				SET @Message = ''''
				INSERT INTO @OT2003 (Status, MessageID, Params) 
											SELECT 2 AS Status, ''00ML000050'' AS MessageID, NULL AS Params
											union all
											SELECT 2 AS Status, ''00ML000052'' AS MessageID, NULL AS Params
											union all
											SELECT 2 AS Status, ''BEMFML000017'' AS MessageID, NULL AS Params
				SET @Cur = CURSOR SCROLL KEYSET FOR
				SELECT APK, DivisionID, VoucherNo, SOrderID FROM OT2003 WITH (NOLOCK) WHERE CAST(APK AS VARCHAR(50)) IN (''' + @APKList + ''')
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelVoucherNo, @DelSOrderID
				WHILE @@FETCH_STATUS = 0
				BEGIN

					EXEC OOP9000 ''' + @DivisionID + ''', NULL, ''' + @TableID + ''', @DelAPK, @DelVoucherNo, NULL, NULL, @Status OUTPUT
					IF (@DelDivisionID != ''' + @DivisionID + ''')
							UPDATE @OT2003 SET Params = ISNULL(Params, '''') + @DelVoucherNo + '', '' WHERE MessageID = ''00ML000050''
					ELSE IF (SELECT @Status) = 1
							UPDATE @OT2003 SET Params = ISNULL(Params, '''') + @DelVoucherNo + '', '' WHERE MessageID = ''00ML000052''
					ELSE IF EXISTS (SELECT TOP 1 1 FROM OT2003 O23 WITH(NOLOCK)
									LEFT JOIN OT2003_MT O23MT WITH(NOLOCK) ON O23MT.DivisionID = O23.DivisionID AND O23MT.SOrderID = O23.SOrderID
									LEFT JOIN WT0095 W95 WITH(NOLOCK) ON W95.DivisionID = O23.DivisionID AND W95.VoucherID = O23MT.InheritVoucherID
									WHERE O23.DivisionID = ''' + @DivisionID + ''' AND CONVERT(NVARCHAR(50),O23.APK) = @DelAPK AND W95.APK IS NOT NULL)
							UPDATE @OT2003 SET Params = ISNULL(Params, '''') + @DelVoucherNo + '', '' WHERE MessageID = ''BEMFML000017''
					ELSE 
						BEGIN

						    -- Update IsShipDate khi xoá tiến độ giao hàng sinh tự động
							UPDATE OT2001
							SET IsShipDate = 0, ShipDate = NULL, DeliveryAddress = NULL
							WHERE SOrderID = @DelSOrderID
	
							-- Xóa master tiến độ giao hàng OT2003
							DELETE FROM OT2003 WHERE CAST(APK AS VARCHAR(50)) = @DelAPK
							-- Update lại detail tiến độ giao hàng OT2002
							UPDATE OT2002 SET 
								Quantity01 = 0, Quantity02 = 0, Quantity03 = 0, Quantity04 = 0, Quantity05 = 0,
								Quantity06 = 0, Quantity07 = 0, Quantity08 = 0, Quantity09 = 0, Quantity10 = 0,
								Quantity11 = 0, Quantity12 = 0, Quantity13 = 0, Quantity14 = 0, Quantity15 = 0,
								Quantity16 = 0, Quantity17 = 0, Quantity18 = 0, Quantity19 = 0, Quantity20 = 0, 
								Quantity21 = 0, Quantity22 = 0, Quantity23 = 0, Quantity24 = 0, Quantity25 = 0,
								Quantity26 = 0, Quantity27 = 0, Quantity28 = 0, Quantity29 = 0, Quantity30 = 0,
								ShipDate = Null
							WHERE  SOrderID = @DelSOrderID

							-- Xóa thông tin tiến độ giao hàng OT2003_MT
							DELETE FROM OT2003_MT WHERE SOrderID = @DelSOrderID
						END					
				FETCH NEXT FROM @Cur INTO @DelAPK, @DelDivisionID, @DelVoucherNo, @DelSOrderID
					SET @Status = 0
				END
				CLOSE @Cur
				SELECT Status, MessageID, LEFT(Params, LEN(Params) - 1) AS Params FROM @OT2003 WHERE Params IS NOT NULL'
			EXEC (@sSQL)
			PRINT (@sSQL)
	END
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
