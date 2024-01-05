IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2036]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2036]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----- Created by Như Hàn
---- Created Date 05/11/2018
---- Purpose: Kiểm tra trước khi xóa, và update lại DeleteFlag = 1 (yêu cầu mua hàng)

---- Modified on 15/03/2019 by Như Hàn: Bổ sung kiểm tra trước khi xóa, sửa yêu cầu báo cáo nhà cung cấp
/*
	POP2036 'AS','482131B8-DF4C-4AD7-AF28-6586B6B6B520','<Data><APK>482131B8-DF4C-4AD7-AF28-6586B6B6B520</APK></Data>',1,''
*/
---- Modified on 24/12/2019 by Lương Mỹ: (yêu cầu mua hàng) Xóa khỏi db, không cần UpdateFlag
---- Modified on 26/07/2021 by Văn Tài : [DTI] Bổ sung cập nhật trạng thái công việc về Chưa thực hiện khi xóa.
---- Modified on 09/08/2021 by Văn Tài : [DTI] Điều chỉnh kiểm tra cho phép sửa/xóa, loại bỏ cấp độ duyệt.


CREATE PROCEDURE [dbo].[POP2036] 	
				@DivisionID VARCHAR(50),
				@APK VARCHAR(50), --Trường hợp sửa
				@APKList XML, --Trường hợp xóa
				@Mode TINYINT, --0: Sửa, 1: Xóa
				@FormID VARCHAR(50)
AS

DECLARE @CustomerIndex INT = (SELECT TOP 1 CustomerIndex.CustomerName FROM CustomerIndex WITH (NOLOCK))

CREATE TABLE #OT3101 (APK VARCHAR(50))
INSERT INTO #OT3101 (APK)
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK
FROM @APKList.nodes('//Data') AS X (Data)

CREATE TABLE #POP2036_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))

IF @Mode = 1
	BEGIN 

		IF @FormID = 'POF2030'
		BEGIN
			SELECT APK, DivisionID, ROrderID
			INTO #POP2036
			FROM OT3101 WITH (NOLOCK) WHERE CONVERT(Varchar(50),OT3101.APK) IN (SELECT APK FROM #OT3101)

			--- Kiểm tra phiếu đã duyệt
			IF  EXISTS (SELECT TOP 1 1 From OT3101 WITH (NOLOCK) 
				Left join OT3102 on OT3101.ROrderID = OT3102.ROrderID
				Where OT3101.DivisionID = @DivisionID and (CONVERT(Varchar (50),OT3101.APK) in (select APK from #OT3101) OR CONVERT(Varchar (50),OT3101.APK) = @APK) and OT3101.[Status] = 1 and OT3102.ApproveLevel > 0)
				BEGIN
					INSERT INTO #POP2036_Errors (Status, Params, MessageID, APK)
					SELECT 1 AS Status, #POP2036.ROrderID AS Params,'00ML000117' AS MessageID, #POP2036.APK
					FROM #POP2036
				END

			--- Kiểm tra phiếu đã kế thừa lập đơn hàng mua
			IF EXISTS (SELECT TOP 1 1 From OT3002 WITH (NOLOCK)  Inner Join  OT3001 WITH (NOLOCK) on OT3001.POrderID = OT3002.POrderID Where OT3002.DivisionID = @DivisionID and OT3002.ROrderID in (SELECT ROrderID FROM #POP2036))
				BEGIN
					INSERT INTO #POP2036_Errors (Status, Params, MessageID, APK)
					SELECT 1 AS Status, #POP2036.ROrderID AS Params,'00ML000179'AS MessageID, #POP2036.APK
					FROM #POP2036
					INNER JOIN OT3002 WITH (NOLOCK) ON #POP2036.DivisionID = OT3002.DivisionID AND #POP2036.ROrderID = OT3002.ROrderID
				END

			
			IF (@CustomerIndex = 114) -- ĐỨC TÍN
			BEGIN
				-- Cập nhật lại tình trạng chưa thực hiện.
				-- Vì khi hoàn tất YCMH thì công việc được tự động chuyển sang hoàn thành.
				UPDATE OT21
				SET OT21.StatusID = N'TTCV0001' -- Chưa thực hiện
				FROM OOT2110 OT21
				INNER JOIN OT3101 WITH (NOLOCK) ON OT3101.DivisionID = OT21.DivisionID
													AND OT3101.TaskID = OT21.TaskID
													AND OT3101.APK IN (SELECT APK FROM #POP2036)
													AND CONVERT(VARCHAR(50), OT3101.APK) NOT IN (SELECT APK FROM #POP2036_Errors)
			END

			DELETE T1 
			FROM OOT9000 T1 INNER JOIN OT3101 T2 ON T1.APK = T2.APKMaster_9000
			WHERE CONVERT(VARCHAR(50), T2.APK) NOT IN (SELECT APK FROM #POP2036_Errors) AND CONVERT(VARCHAR(50),T2.APK) in (select APK from #POP2036) 
		
			DELETE T1 
			FROM OOT9001 T1 INNER JOIN OT3101 T2 ON T1.APKMaster = T2.APKMaster_9000
			WHERE CONVERT(VARCHAR(50),T2.APK) NOT IN (SELECT APK FROM #POP2036_Errors) AND CONVERT(VARCHAR(50),T2.APK) in (select APK from #POP2036) 

			DELETE T1 
			FROM OT3101 T1 INNER JOIN #POP2036 T2 ON T1.APK = T2.APK
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM #POP2036_Errors T3 WHERE T1.APK = T3.APK)
		
			DELETE T1 
			FROM OT3102 T1 
			INNER JOIN #POP2036 T2 ON T1.ROrderID = T2.ROrderID
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM #POP2036_Errors T3 WHERE T2.APK = T3.APK)


		END

		IF @FormID = 'POF2040'
		BEGIN
			SELECT APK, DivisionID, VoucherNo
			INTO #POF2040
			FROM POT2021 WITH (NOLOCK) WHERE APK IN (SELECT APK FROM #OT3101) OR CONVERT(Varchar (50),APK) = @APK

		--- Kiểm tra phiếu đã kế thừa lập đơn hàng mua
			IF EXISTS (SELECT TOP 1 1 FROM OT3002 WITH (NOLOCK)  
						INNER JOIN  OT3001 WITH (NOLOCK) ON OT3001.POrderID = OT3002.POrderID 
						WHERE OT3002.DivisionID = @DivisionID AND OT3002.InheritVoucherID IN (SELECT Convert(varchar(50),APK) FROM #POF2040))
				BEGIN
					INSERT INTO #POP2036_Errors (Status, Params, MessageID, APK)
					SELECT 1 AS Status, #POF2040.VoucherNo AS Params,'00ML000179'AS MessageID, #POF2040.APK
					FROM #POF2040
					INNER JOIN OT3002 WITH (NOLOCK) ON #POF2040.DivisionID = OT3002.DivisionID AND #POF2040.APK = OT3002.InheritVoucherID
				END

			--- Kiểm tra phiếu đã duyệt
			IF  EXISTS (SELECT TOP 1 1 From POT2021 WITH (NOLOCK) 
				Left join POT2022 on POT2021.APK = POT2022.APKMaster
				Where POT2021.DivisionID = @DivisionID and( POT2021.APK in (select APK from #OT3101) OR CONVERT(Varchar (50),POT2021.APK) = @APK) and POT2021.[Status] = 1 and POT2022.ApproveLevel > 0)
				BEGIN
					INSERT INTO #POP2036_Errors (Status, Params, MessageID, APK)
					SELECT 1 AS Status, #POF2040.VoucherNo AS Params,'00ML000117' AS MessageID, #POF2040.APK
					FROM #POF2040
				END

			UPDATE T1 SET DeleteFlag = 1
			FROM POT2021 T1 INNER JOIN #POF2040 T2 ON T1.APK = T2.APK
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM #POP2036_Errors T3 WHERE T1.APK = T3.APK) 
		
			UPDATE T1 SET DeleteFlag = 1
			FROM POT2022 T1 INNER JOIN #POF2040 T2 ON T1.APKMaster = T2.APK
			WHERE NOT EXISTS (SELECT TOP 1 1 FROM #POP2036_Errors T3 WHERE T1.APKMaster = T3.APK)

			UPDATE T1 SET DeleteFlag = 1
			FROM OOT9000 T1 INNER JOIN POT2021 T2 ON T1.APK = T2.APKMaster_9000
			WHERE T2.APK not in (select APK from #POP2036_Errors) AND T2.APK in (select APK from #POF2040) 
		
			UPDATE T1 SET DeleteFlag = 1
			FROM OOT9001 T1 INNER JOIN POT2021 T2 ON T1.APKMaster = T2.APKMaster_9000
			WHERE T2.APK not in (select APK from #POP2036_Errors) AND T2.APK in (select APK from #POF2040) 

		END

	END

IF @Mode = 0
	BEGIN
		IF @FormID = 'POF2030'
		BEGIN
			DECLARE @ROrderID VARCHAR(50)
			SELECT @ROrderID = ROrderID FROM OT3101 WHERE APK = @APK

			IF (@CustomerIndex = 114) -- DUCTIN
			BEGIN
				--- Kiểm tra phiếu đã duyệt
				IF  EXISTS (SELECT TOP 1 1 From OT3101 WITH (NOLOCK) 
					Left join OT3102 on OT3101.ROrderID = OT3102.ROrderID
					Where OT3101.DivisionID = @DivisionID 
							and OT3101.APK = @APK 
							and OT3101.[Status] = 1)
					BEGIN
						INSERT INTO #POP2036_Errors (Status, Params, MessageID, APK)
						SELECT 1 AS Status, @ROrderID AS Params,'00ML000117' AS MessageID, @APK
					END
			END
			ELSE
			BEGIN
			--- Kiểm tra phiếu đã duyệt
				IF  EXISTS (SELECT TOP 1 1 From OT3101 WITH (NOLOCK) 
					Left join OT3102 on OT3101.ROrderID = OT3102.ROrderID
					Where OT3101.DivisionID = @DivisionID 
							and OT3101.APK = @APK 
							and OT3101.[Status] = 1 
							and OT3102.ApproveLevel > 0)
					BEGIN
						INSERT INTO #POP2036_Errors (Status, Params, MessageID, APK)
						SELECT 1 AS Status, @ROrderID AS Params,'00ML000117' AS MessageID, @APK
					END
			
			END

			--- Kiểm tra phiếu đã kế thừa lập đơn hàng mua
			IF EXISTS (SELECT TOP 1 1 From OT3002 WITH (NOLOCK)  Inner Join  OT3001 WITH (NOLOCK) on OT3001.POrderID = OT3002.POrderID Where OT3002.DivisionID = @DivisionID and OT3002.ROrderID = @ROrderID)
				BEGIN
					INSERT INTO #POP2036_Errors (Status, Params, MessageID, APK)
					SELECT 1 AS Status, @ROrderID, '00ML000179'AS MessageID, @APK
				END
		END
		IF @FormID = 'POF2040'
		BEGIN
		DECLARE @VoucherNo VARCHAR(50)
		SELECT @VoucherNo = VoucherNo FROM POT2021 WHERE APK = @APK
			IF EXISTS (SELECT TOP 1 1 From OT3002 WITH (NOLOCK)  Inner Join  OT3001 WITH (NOLOCK) on OT3001.POrderID = OT3002.POrderID Where OT3002.DivisionID = @DivisionID and OT3002.InheritVoucherID = @APK)
				BEGIN
					INSERT INTO #POP2036_Errors (Status, Params, MessageID, APK)
					SELECT 1 AS Status, @VoucherNo, '00ML000179'AS MessageID, @APK
				END

		--- Kiểm tra phiếu đã duyệt
		IF  EXISTS (SELECT TOP 1 1 From POT2021 WITH (NOLOCK) 
			Left join POT2022 on POT2021.APK = POT2022.APKMaster
			Where POT2021.DivisionID = @DivisionID and POT2021.APK = @APK and POT2021.[Status] = 1 and POT2022.ApproveLevel > 0)
			BEGIN
				INSERT INTO #POP2036_Errors (Status, Params, MessageID, APK)
				SELECT 1 AS Status, @VoucherNo AS Params,'00ML000117' AS MessageID, @APK
			END
			
		END
	END

SELECT * FROM #POP2036_Errors

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

