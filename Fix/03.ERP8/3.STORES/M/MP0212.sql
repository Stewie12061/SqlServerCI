IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0212]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0212]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Tạo bộ hệ số tự động theo thống kê kết quả sản xuất
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
-- <History>
----Created by: Kiều Nga, Date: 24/09/2022
-- <Example>
----Modified by Thanh Lượng on 03/03/2023: [2023/02/TA/0146] - Bổ sung thay đổi trường lấy dữ liệu InventoryID -> DetailID để tạo bộ hệ số cho BTP/TP.
----Modified by Nhật Thanh on 30/03/2023: [2023/02/TA/0146] - Cải tiến: Mỗi công đoạn sẽ sinh ra 3 bộ hệ số
---- 
/*-- <Example>
		EXEC MP0212 @DivisionID = 'EXV', @UserID = 'ASOFTADMIN',@TranMonth = 9,@TranYear= 2022
----*/

CREATE PROCEDURE MP0212 ( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @TranMonth AS INT,
     @TranYear AS INT 	 
)
AS 
BEGIN
	DECLARE @PhaseID VARCHAR(50) ='',
			@InventoryID VARCHAR(50) ='',
			@MachineTime DECIMAL(28,8) = 0,
			@LaborTime DECIMAL(28,8) = 0,
			@TotalMachineTime DECIMAL(28,8) = 0,
			@TotalLaborTime DECIMAL(28,8) = 0,
			@CoValueMachineTime DECIMAL(28,8) = 0,
			@CoValueLaborTime DECIMAL(28,8) = 0,
			@CoefficientMachineID VARCHAR(50) = '',
			@CoefficientLaborID VARCHAR(50) = '',
			@CoefficientQuantityID VARCHAR(50) = ''

	CREATE TABLE #MP0212Ignore
	(
		PhaseID VARCHAR(50),
		InventoryID VARCHAR(50)
	)

	-- Xóa dữ liệu bộ hệ số trước đó
	DELETE FROM MT1604 WHERE DivisionID = @DivisionID
	DELETE FROM MT1605 WHERE DivisionID = @DivisionID

	SELECT M.PhaseID, M.DetailID,SUM(ISNULL(M.MachineTime,0)) as MachineTime, SUM(ISNULL(M.LaborTime,0)) as LaborTime

	FROM MT2211 M WITH (NOLOCK)
	LEFT JOIN MT2210 M2 WITH (NOLOCK) ON M.APKMaster = M2.APK
	WHERE M.PhaseID IS NOT NULL AND M.DetailID IS NOT NULL 
	AND M2.DivisionID = @DivisionID AND M2.TranMonth = @TranMonth AND M2.TranYear = @TranYear
	GROUP BY M.PhaseID, M.DetailID
	ORDER BY M.PhaseID, M.DetailID
	-- Lấy giá trị MachineTime, LaborTime
	SELECT M.PhaseID, M.DetailID,SUM(ISNULL(M.MachineTime,0)) as MachineTime, SUM(ISNULL(M.LaborTime,0)) as LaborTime
	INTO #MP0212
	FROM MT2211 M WITH (NOLOCK)
	LEFT JOIN MT2210 M2 WITH (NOLOCK) ON M.APKMaster = M2.APK
	WHERE M.PhaseID IS NOT NULL AND M.DetailID IS NOT NULL 
	AND M2.DivisionID = @DivisionID AND M2.TranMonth = @TranMonth AND M2.TranYear = @TranYear
	GROUP BY M.PhaseID, M.DetailID
	ORDER BY M.PhaseID, M.DetailID
	
	IF EXISTS (SELECT TOP 1 1 FROM #MP0212)
	BEGIN
		-- Lấy tổng giá trị
		SELECT @TotalMachineTime = SUM(ISNULL(MachineTime,0)),@TotalLaborTime = SUM(ISNULL(LaborTime,0)) 
		FROM #MP0212

		DECLARE @strTranMonth NVARCHAR(50) ='',
				@strTranYear NVARCHAR(50) = LTRIM(RTRIM(STR(@TranYear)))

		IF(@TranMonth < 10)
			SET @strTranMonth = '0'+ LTRIM(RTRIM(STR(@TranMonth)))
		ELSE
			SET @strTranMonth = LTRIM(RTRIM(STR(@TranMonth)))

		SET @CoefficientMachineID = @strTranYear +'/'+ @strTranMonth +'/'+ N'BHSMachineTime';
		SET @CoefficientLaborID = @strTranYear +'/'+ @strTranMonth +'/'+ N'BHSLaborTime';
		SET @CoefficientQuantityID = @strTranYear +'/'+ @strTranMonth +'/'+ N'BHSQuantity';

		-- Thêm mới MT1604
		INSERT INTO MT1604 (APK,DivisionID,CoefficientID,CoefficientName,[Description],InventoryTypeID,EmployeeID,CoType,CreateUserID
		,CreateDate,LastModifyUserID,LastModifyDate)
		SELECT NEWID(),@DivisionID,CONCAT(@CoefficientMachineID,PhaseID),N'Bộ hệ số MachineTime kỳ '+@strTranMonth +'/'+ @strTranYear,'','%'
		,@UserID,0,@UserID,GETDATE(),@UserID,GETDATE()
		FROM #MP0212
		GROUP BY PhaseID

		INSERT INTO MT1604 (APK,DivisionID,CoefficientID,CoefficientName,[Description],InventoryTypeID,EmployeeID,CoType,CreateUserID
		,CreateDate,LastModifyUserID,LastModifyDate)
		SELECT NEWID(),@DivisionID,CONCAT(@CoefficientLaborID,PhaseID),N'Bộ hệ số LaborTime kỳ '+@strTranMonth +'/'+ @strTranYear,'','%'
		,@UserID,0,@UserID,GETDATE(),@UserID,GETDATE()
		FROM #MP0212
		GROUP BY PhaseID

		INSERT INTO MT1604 (APK,DivisionID,CoefficientID,CoefficientName,[Description],InventoryTypeID,EmployeeID,CoType,CreateUserID
		,CreateDate,LastModifyUserID,LastModifyDate)
		SELECT NEWID(),@DivisionID,CONCAT(@CoefficientQuantityID,PhaseID),N'Bộ hệ số đơn hàng sản xuất kỳ '+@strTranMonth +'/'+ @strTranYear,'','%'
		,@UserID,0,@UserID,GETDATE(),@UserID,GETDATE()
		FROM #MP0212
		GROUP BY PhaseID

		WHILE EXISTS (SELECT TOP 1 1 FROM #MP0212 T1 LEFT JOIN #MP0212Ignore T2 ON T1.PhaseID = T2.PhaseID AND T1.DetailID = T2.InventoryID WHERE T2.InventoryID IS NULL)
		BEGIN
			SELECT TOP 1 @PhaseID = T1.PhaseID 
					,@InventoryID = T1.DetailID
					,@MachineTime = T1.MachineTime
					,@LaborTime = T1.LaborTime
			FROM #MP0212 T1
			LEFT JOIN #MP0212Ignore T2 ON T1.PhaseID = T2.PhaseID AND T1.DetailID = T2.InventoryID
			WHERE T2.InventoryID IS NULL

			-- Tính toán giá trị hệ số
			SET @CoValueMachineTime = @MachineTime/@TotalMachineTime
			SET @CoValueLaborTime = @LaborTime/@TotalLaborTime

			-- Thêm mới MT1605
			INSERT INTO MT1605 (APK,DivisionID,DeCoefficientID,CoefficientID,InventoryID,CoValue,Notes)
			VALUES (NEWID(),@DivisionID,CONCAT(@CoefficientMachineID,@PhaseID),CONCAT(@CoefficientMachineID,@PhaseID),@InventoryID,@CoValueMachineTime,N'Công đoạn ' +@PhaseID)

			INSERT INTO MT1605 (APK,DivisionID,DeCoefficientID,CoefficientID,InventoryID,CoValue,Notes)
			VALUES (NEWID(),@DivisionID,CONCAT(@CoefficientLaborID,@PhaseID),CONCAT(@CoefficientLaborID,@PhaseID),@InventoryID,@CoValueLaborTime,N'Công đoạn ' +@PhaseID)

			INSERT INTO MT1605 (APK,DivisionID,DeCoefficientID,CoefficientID,InventoryID,CoValue,Notes)
			VALUES (NEWID(),@DivisionID,CONCAT(@CoefficientQuantityID,@PhaseID),CONCAT(@CoefficientQuantityID,@PhaseID),@InventoryID,1,N'Công đoạn ' +@PhaseID)

			INSERT INTO #MP0212Ignore(PhaseID,InventoryID)
			SELECT @PhaseID, @InventoryID
		END
	END

END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
