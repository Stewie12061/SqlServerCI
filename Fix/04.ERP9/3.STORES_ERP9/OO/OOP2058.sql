IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OOP2058]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OOP2058]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load Form OOP2058: Kiểm tra dữ liệu HRM đã được sử dụng thì không thể bỏ duyệt
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Trần Quốc Tuấn, Date: 07/12/2015
--- Modified on 03/01/201 by Bảo Anh: Bổ sung biến @APKDetail, @Table
--- Modified on 20/06/2020 by Tấn Thành:  [BEM] Bổ sung điều kiện INSERT theo "DNCT"
--- Modified on 10/09/2020 by Trọng Kiên: [PO] Bổ sung điều kiện Type = "DHM"
--- Modified on 31/11/2020 by Huỳnh Thử:  [HRM] Bổ sung duyệt Kế hoạch tuyển dụng
--- Modified on 16/12/2020 by Huỳnh Thử:  [HRM] Bổ sung duyệt Điều chỉnh tạm thời
--- Modified on 24/12/2020 by Vĩnh Tâm:   [BEM] Bổ sung điều kiện Type = "PDN" xử lý kiểm tra và xóa dữ liệu
--- Modified on 24/12/2020 by Vĩnh Tâm:   [BEM] Bổ sung điều kiện kiểm tra trước khi xóa dữ liệu liên quan DNCT
--- Modified on 23/07/2021 by Đình Hoà:Bổ sung duyệt bảng tính giá(BTG)
--- Modified on 03/08/2021 by Đình Hoà:Bổ sung duyệt Phiếu báo giá Sale(PBGKD) - (SGNP)
--- Modified on 14/05/2022 by Kiều Nga:Bổ sung duyệt Văn bản đi, Văn bản đến (CSG).
--- Modified on 06/09/2022 by Đức Tuyên: Bổ sung duyệt Đề nghị thu/chi ('DNT','DNC').
--- Modified on 05/04/2023 by Thanh Lượng: Bổ sung duyệt Quản lý chất lượng ca (QLCLC).
--- Modified on 13/04/2023 by Hoài Thanh: Bổ sung duyệt đơn hàng bán SELL OUT.
--- Modified on 12/05/2023 by Thanh Lượng: Bổ sung duyệt chương trình khuyến mãi theo điều kiện(KMTDK).
--- Modified on 28/06/2023 by Thanh Lượng: Bổ sung duyệt Bảng giá bán Sell-in(BGSI).
--- Modified on 12/07/2023 by Thanh Lượng: Bổ sung duyệt kế hoạch doanh số (Sell In)(KHDSSI).
--- Modified on 25/07/2023 by Thanh Lượng: Bổ sung duyệt kế hoạch doanh số (Sell Out)(KHDSSO).


-- <Example>
---- 
/*
   OOP2055 @DivisionID='CTY',@UserID='ASOFTADMIN',@TranMonth=8,@TranYear=2015,@PageNumber=1,@PageSize=25,@IsSearch=0,
	@ID=NULL,@CreateUserID=NULL,@DepartmentID=NULL,@SectionID=NULL,
	@SubsectionID=NULL,@ProcessID=NULL,@Status=NULL,@Type=NULL,@NextApprovePersonID=NULL,
	@IsCheckALL=0,@APKList='0EC81717-A1ED-4FD6-849F-00456CA4170E'
*/
CREATE PROCEDURE dbo.OOP2058
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@APKMaster VARCHAR(50), --- APK OOT9000
	@APK VARCHAR(50), --- APK của bảng OOT9001
	@Type VARCHAR(50),--- Loại gì
	@Status TINYINT,	-- 1 là duyệt 2 là không duyệt
	@APKDetail VARCHAR(50),
	@Table VARCHAR(50)
)
AS 
DECLARE @MessageID VARCHAR(50),
		@StatusID TINYINT,
		@Params VARCHAR(50),
		@LastStatus INT

CREATE TABLE #TAM (LastStatus INT)

IF @Type ='BPC'
  	EXEC('INSERT INTO #TAM SELECT TOP 1 1 FROM ' + @Table + ' WITH (NOLOCK) WHERE DivisionID=''' + @DivisionID + '''
								AND APKMaster=''' + @APKMaster + '''
								AND ApproveLevel = ApprovingLevel')
ELSE IF @Type ='BGNCC' OR @Type='PBG' OR @Type='YCMH' OR @Type='DMDA' OR @Type='PBGNC' OR @Type='PBGKHCU' OR @Type='PBGSALE' OR @Type='DHB'OR @Type='DHB-SELLOUT' OR @Type='DHDC' OR @Type='DT' OR
		@Type ='TTDL' OR @Type='TGCT' OR @Type='BCCT' OR @Type='DCT' OR @Type='PDN' OR @Type ='DNCT' OR @Type='DHM' OR @Type='TTSX' OR @Type='DTCP' OR @Type='BTG' OR @Type='PBGKD' OR @Type='DNT' OR @Type='DNC'  OR
		@Type='KMTDK' OR @Type='BGSI' OR @Type='KHDSSI' OR @Type='KHDSSO' 
	EXEC('INSERT INTO #TAM SELECT TOP 1 1 FROM ' + @Table + ' WITH (NOLOCK) WHERE DivisionID=''' + @DivisionID + '''
								AND APKMaster_9000=''' + @APKMaster + '''
								AND ApproveLevel = ApprovingLevel')
ELSE IF @Type ='CH' 
	EXEC('INSERT INTO #TAM SELECT TOP 1 1 FROM ' + @Table + ' WITH (NOLOCK) WHERE DivisionID=''' + @DivisionID + '''
								AND APKMaster_9000=''' + @APKMaster + '''')
ELSE IF @Type ='KHTD' 
	EXEC('INSERT INTO #TAM SELECT TOP 1 1 FROM ' + @Table + ' WITH (NOLOCK) WHERE DivisionID=''' + @DivisionID + '''
								AND APK=''' + @APKMaster + '''
								AND ApproveLevel = ApprovingLevel')
ELSE IF @Type ='DCTT' 
	EXEC('INSERT INTO #TAM SELECT TOP 1 1 FROM ' + @Table + ' WITH (NOLOCK) WHERE DivisionID=''' + @DivisionID + '''
								AND APK=''' + @APKMaster + '''
								AND ApproveLevel = ApproveLevel')

ELSE IF @Type ='VBDEN' OR @Type ='VBDI'
	EXEC('INSERT INTO #TAM SELECT TOP 1 1 ')
ELSE IF @Type != 'QLCLC'
	EXEC('INSERT INTO #TAM SELECT TOP 1 1 FROM ' + @Table + ' WITH (NOLOCK) WHERE DivisionID=''' + @DivisionID + '''
								AND APKMaster=''' + @APKMaster + ''' AND APK = ''' + @APKDetail + '''
								AND ApproveLevel = ApprovingLevel')

SELECT @LastStatus = LastStatus FROM #TAM

IF @Status=2 AND ISNULL(@LastStatus,0) = 1
BEGIN
	IF @Type='BPC'
	BEGIN
		IF EXISTS (SELECT TOP 1 1 
				   FROM OOT2000 WITH (NOLOCK)
				   INNER JOIN OOT9000 OOT90 WITH (NOLOCK) ON OOT90.APK = OOT2000.APKMaster AND OOT90.DivisionID = OOT2000.DivisionID
				   INNER JOIN HT2401 HT21 WITH (NOLOCK) ON HT21.EmployeeID = OOT2000.EmployeeID AND HT21.TranMonth = OOT90.TranMonth
				   AND HT21.TranYear = OOT90.TranYear
		           WHERE OOT2000.APKMaster=@APKMaster)
		    BEGIN
				SET @MessageID='OOFML000026'
				SET @StatusID=1
				SET @Params =(SELECT TOP 1 ID FROM OOT9000 WITH (NOLOCK) WHERE DivisionID=@DivisionID AND APK=@APKMaster)
		    END
		 ELSE
				SET @APKMaster=NULL 
	END
	ELSE IF @Type='DXDC'
	BEGIN
		IF EXISTS (SELECT TOP 1 1 
				   FROM OOT2070 OOT10 WITH (NOLOCK)
				   INNER JOIN OOT9000 OOT90 WITH (NOLOCK) ON OOT90.APK = OOT10.APKMaster AND OOT90.DivisionID = OOT10.DivisionID
				   INNER JOIN HT2401 HT21 WITH (NOLOCK) ON HT21.EmployeeID = OOT10.EmployeeID AND HT21.TranMonth = OOT90.TranMonth
				   AND HT21.TranYear = OOT90.TranYear AND HT21.AbsentDate=CONVERT(DATE,OOT10.ChangeFromDate)
		           WHERE OOT10.APKMaster=@APKMaster AND OOT10.APK = @APKDetail)
		           BEGIN
		           	SET @MessageID='OOFML000026'
		           	SET @StatusID=1
		           	SET @Params =(SELECT TOP 1 ID FROM OOT9000 WITH (NOLOCK) WHERE DivisionID=@DivisionID AND APK=@APKMaster)
		           END
		ELSE
		SET @APKMaster=NULL 
	END
	ELSE IF @Type='DXP'
	BEGIN
		IF EXISTS (SELECT TOP 1 1 
				   FROM OOT2010 OOT10 WITH (NOLOCK)
				   INNER JOIN OOT9000 OOT90 WITH (NOLOCK) ON OOT90.APK = OOT10.APKMaster AND OOT90.DivisionID = OOT10.DivisionID
				   INNER JOIN HT2401 HT21 WITH (NOLOCK) ON HT21.EmployeeID = OOT10.EmployeeID AND HT21.TranMonth = OOT90.TranMonth
				   AND HT21.TranYear = OOT90.TranYear AND HT21.AbsentDate=CONVERT(DATE,OOT10.LeaveFromDate)
		           WHERE OOT10.APKMaster=@APKMaster AND OOT10.APK = @APKDetail)
		           BEGIN
		           	SET @MessageID='OOFML000026'
		           	SET @StatusID=1
		           	SET @Params =(SELECT TOP 1 ID FROM OOT9000 WITH (NOLOCK) WHERE DivisionID=@DivisionID AND APK=@APKMaster)
		           END
		ELSE
			SET @APKMaster=NULL 
	END
	ELSE IF @Type='DXRN'
	BEGIN
	
		IF EXISTS (SELECT TOP 1 1 
				   FROM OOT2020 OOT10 WITH (NOLOCK)
				   INNER JOIN OOT9000 OOT90 WITH (NOLOCK) ON OOT90.APK = OOT10.APKMaster AND OOT90.DivisionID = OOT10.DivisionID
				   INNER JOIN HT2408 HT21 WITH (NOLOCK) ON HT21.EmployeeID = OOT10.EmployeeID AND HT21.TranMonth = OOT90.TranMonth
				   AND HT21.TranYear = OOT90.TranYear AND HT21.AbsentDate=CONVERT(DATE,OOT10.GoToDate)
				   AND HT21.AbsentTime=CONVERT(TIME(0),OOT10.GoToDate,0)
		           WHERE OOT10.APKMaster=@APKMaster AND OOT10.APK = @APKDetail)
		           BEGIN
		           	SET @MessageID='OOFML000026'
		           	SET @StatusID=1
		           	SET @Params =(SELECT TOP 1 ID FROM OOT9000 WITH (NOLOCK) WHERE DivisionID=@DivisionID AND APK=@APKMaster)
		           END
		ELSE
			SET @APKMaster=NULL 
	END
	ELSE IF @Type='DXLTG'
	BEGIN
		IF EXISTS (SELECT TOP 1 1 
				   FROM OOT2030 OOT10 WITH (NOLOCK)
				   INNER JOIN OOT9000 OOT90 WITH (NOLOCK) ON OOT90.APK = OOT10.APKMaster AND OOT90.DivisionID = OOT10.DivisionID
				   INNER JOIN HT2401 HT21 WITH (NOLOCK) ON HT21.EmployeeID = OOT10.EmployeeID AND HT21.TranMonth = OOT90.TranMonth
				   AND HT21.TranYear = OOT90.TranYear AND HT21.AbsentDate=CONVERT(DATE,OOT10.WorkFromDate)
		           WHERE OOT10.APKMaster=@APKMaster AND OOT10.APK = @APKDetail)
		           BEGIN
		           	SET @MessageID='OOFML000026'
		           	SET @StatusID=1
		           	SET @Params =(SELECT TOP 1 ID FROM OOT9000 WITH (NOLOCK) WHERE DivisionID=@DivisionID AND APK=@APKMaster)
		           END
		 ELSE
			SET @APKMaster=NULL 
	END
	ELSE IF @Type='DCTT'
	BEGIN
		IF EXISTS (SELECT TOP 1 1 
				   FROM HRMT2170 HT2170 WITH (NOLOCK)
				   INNER JOIN OOT9000 OOT90 WITH (NOLOCK) ON OOT90.APK = HT2170.APK AND OOT90.DivisionID = HT2170.DivisionID				   
		           WHERE HT2170.APK=@APKMaster AND HT2170.APK = @APKDetail)
		           BEGIN
		           	SET @MessageID='OOFML000026'
		           	SET @StatusID=1
		           	SET @Params =(SELECT TOP 1 ID FROM OOT9000 WITH (NOLOCK) WHERE DivisionID=@DivisionID AND APK=@APKMaster)
		           END
		 ELSE
			SET @APKMaster=NULL 
	END
	ELSE IF @Type='DXBSQT'
	BEGIN
		IF EXISTS (SELECT TOP 1 1 
				   FROM OOT2040 OOT10 WITH (NOLOCK)
				   INNER JOIN OOT9000 OOT90 WITH (NOLOCK) ON OOT90.APK = OOT10.APKMaster AND OOT90.DivisionID = OOT10.DivisionID
				   INNER JOIN HT2408 HT21 WITH (NOLOCK) ON HT21.EmployeeID = OOT10.EmployeeID AND HT21.TranMonth = OOT90.TranMonth
				   AND HT21.TranYear = OOT90.TranYear AND HT21.AbsentDate=CONVERT(DATE,OOT10.Date)
				   AND HT21.AbsentTime=CONVERT(TIME(0),OOT10.Date,0)
		           WHERE OOT10.APKMaster=@APKMaster AND OOT10.APK = @APKDetail)
		           BEGIN
		           	SET @MessageID='OOFML000026'
		           	SET @StatusID=1
		           	SET @Params =(SELECT TOP 1 ID FROM OOT9000 WITH (NOLOCK) WHERE DivisionID=@DivisionID AND APK=@APKMaster)
		           END
		ELSE
			SET @APKMaster=NULL 
	END
	ELSE IF @Type = 'DNCT'
	BEGIN
		IF EXISTS (
				-- DNCT có Phiếu đề nghị đã được duyệt
				SELECT TOP 1 1
				FROM BEMT2010 B1 WITH (NOLOCK) 
					INNER JOIN BEMT2000 B2 WITH (NOLOCK) ON B2.APKInherited = B1.APK AND B2.DivisionID = B1.DivisionID AND ISNULL(B2.DeleteFlg, 0) = 0 AND ISNULL(B2.IsAutoCreated, 0) = 0
					INNER JOIN OOT9000 OO1 WITH (NOLOCK) ON OO1.APK = B2.APKMaster_9000 AND OO1.DivisionID = B1.DivisionID
					INNER JOIN OOT9001 OO2 WITH (NOLOCK) ON OO2.APKMaster = OO1.APK AND OO2.[Status] = 1
				WHERE B1.APKMaster_9000 = @APKMaster AND B1.DivisionID = @DivisionID)
			OR
			EXISTS (
				-- DNCT đã được kế thừa để tạo các Phiếu đề nghị
				SELECT TOP 1 1
				FROM BEMT2010 B1 WITH (NOLOCK)
					INNER JOIN BEMT2000 B2 WITH (NOLOCK) ON B2.APKInherited = B1.APK AND B2.DivisionID = B1.DivisionID AND ISNULL(B2.IsAutoCreated, 0) = 0 AND ISNULL(B2.DeleteFlg, 0) = 0
				WHERE B1.APKMaster_9000 = @APKMaster AND B1.DivisionID = @DivisionID)
			BEGIN
					-- Lưu không thành công, Đề nghị công tác {0} đang được sử dụng!
		           	SET @MessageID = 'BEMFML000013'
		           	SET @StatusID = 1
		           	SET @Params = (SELECT TOP 1 VoucherNo FROM BEMT2010 WITH (NOLOCK) WHERE DivisionID=@DivisionID AND APKMaster_9000 = @APKMaster)
		    END
		ELSE
			BEGIN
				-- Xóa các phiếu Chi tiết xét duyệt của các phiếu DNTU/DNTTTU/DNTT
				UPDATE OOT9001
				SET DeleteFlag = 1
				FROM BEMT2010 B1 WITH (NOLOCK)
					INNER JOIN BEMT2000 B2 WITH (NOLOCK) ON B1.APK = B2.APKInherited AND ISNULL(B2.DeleteFlg, 0) = 0
					INNER JOIN OOT9000 O1 WITH (NOLOCK) ON O1.APK = B2.APKMaster_9000
					INNER JOIN OOT9001 O2 WITH (NOLOCK) ON O1.APK = O2.APKMaster
				WHERE B1.APKMaster_9000 = @APKMaster

				-- Xóa các phiếu Chi tiết xét duyệt của các phiếu DNTU/DNTTTU/DNTT
				UPDATE OOT9000
				SET DeleteFlag = 1
				FROM BEMT2010 B1 WITH (NOLOCK)
					INNER JOIN BEMT2000 B2 WITH (NOLOCK) ON B1.APK = B2.APKInherited AND ISNULL(B2.DeleteFlg, 0) = 0
					INNER JOIN OOT9000 O1 WITH (NOLOCK) ON O1.APK = B2.APKMaster_9000
				WHERE B1.APKMaster_9000 = @APKMaster

				-- Xóa các phiếu DNTU/DNTTTU/DNTT
				UPDATE BEMT2000
				SET DeleteFlg = 1
				FROM BEMT2000 B1 WITH (NOLOCK)
					INNER JOIN BEMT2010 B2 WITH(NOLOCK) ON B2.APK = B1.APKInherited
				WHERE B2.APKMaster_9000 = @APKMaster AND B1.DivisionID = @DivisionID AND ISNULL(B1.DeleteFlg, 0) = 0

				SET @APKMaster = NULL
			END
	END
	ELSE IF @Type = 'PDN'
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM OOT9001 WITH (NOLOCK) WHERE APK = @APK AND APKMaster = @APKMaster)
		BEGIN
			IF EXISTS (SELECT TOP 1 1
						FROM BEMT2001 B1 WITH (NOLOCK)
							INNER JOIN AT9010 A1 WITH (NOLOCK) ON B1.APK = A1.InheritTransactionID
								AND A1.InheritTableID = @Table AND B1.APKMaster = A1.InheritVoucherID AND A1.Status = 1
						WHERE B1.APKMaster_9000 = @APKMaster)
				BEGIN
						-- Phiếu tạm thu/tạm chi của {0} đã được duyệt, bạn không thể chuyển trạng thái duyệt!
						SET @MessageID = 'BEMFML000014'
						SET @StatusID = 1
						SET @Params = (SELECT TOP 1 VoucherNo FROM BEMT2000 WITH (NOLOCK) WHERE DivisionID = @DivisionID AND APKMaster_9000 = @APKMaster)
				END
			ELSE
				BEGIN
					-- Xóa dữ liệu duyệt detail của phiếu đề nghị
					-- Các bảng OOT9000 và OOT9001 đã được store xử lý
					DELETE OOT9004
					FROM OOT9004 O1 WITH (NOLOCK)
						INNER JOIN OOT9001 O2 WITH (NOLOCK) ON O1.APK9001 = O2.APK
					WHERE O2.APKMaster = @APKMaster

					-- Xóa dữ liệu phiếu tạm thu/tạm chi (chưa được duyệt)
					DELETE AT9010
					FROM AT9010 A1 WITH (NOLOCK)
						INNER JOIN BEMT2001 B1 WITH (NOLOCK) ON A1.InheritTableID = @Table AND A1.InheritVoucherID = B1.APKMaster
					WHERE B1.APKMaster_9000 = @APKMaster

					-- Xóa dữ liệu phiếu BTTH liên quan
					DELETE AT9000
					FROM AT9000 A1 WITH (NOLOCK)
						INNER JOIN BEMT2001 B1 WITH (NOLOCK) ON A1.InheritTableID = @Table AND A1.InheritTransactionID = B1.APK AND A1.InheritVoucherID = B1.APKMaster
					WHERE B1.APKMaster_9000 = @APKMaster
				END
		END
	END

IF ISNULL(@MessageID,'') <> ''
   SELECT @MessageID MessageID,@StatusID [Status],@Params Params,@APKMaster APKMaster

END





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
