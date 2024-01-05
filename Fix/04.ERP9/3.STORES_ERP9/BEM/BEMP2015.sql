IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[BEMP2015]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[BEMP2015]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Kiểm tra dữ liệu các bảng BEMT2010, BEMT2020, BEMT2030, BEMT2040, BEMT2050, BEMT2000 trước khi sửa đã được duyệt/ kế thừa hay chưa
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Tấn Thành, Date 15/06/2020
-- <Example
CREATE PROCEDURE BEMP2015 
( 
    @DivisionID VARCHAR(50),
    @APK VARCHAR(50), 
    @FormID VARCHAR(50)
) 
AS 

CREATE TABLE #BEMT2015P_Errors (Status TINYINT, Params VARCHAR(50), MessageID VARCHAR(50), APK VARCHAR(50))
DECLARE @VoucherNo VARCHAR(50)

IF @FormID = 'BEMF2010' 
    BEGIN
        SELECT @VoucherNo = VoucherNo FROM BEMT2010 WHERE APK = @APK

    --- Kiểm tra phiếu đã duyệt
        IF EXISTS(SELECT TOP 1 1 FROM BEMT2010 B1 WITH (NOLOCK) 
                    LEFT JOIN OOT9000 O1 WITH (NOLOCK) ON B1.APKMaster_9000 = O1.APK
                    LEFT JOIN OOT9001 O2 WITH (NOLOCK) ON O2.APKMaster = O1.APK AND O2.DivisionID = @DivisionID
                    WHERE B1.APK = @APK AND B1.DivisionID = @DivisionID AND O2.[Status] = 1)
            BEGIN
                INSERT INTO #BEMT2015P_Errors (Status, Params, MessageID, APK)
                SELECT 1 AS Status, @VoucherNo AS Params,'00ML000117' AS MessageID, @APK
            END
    END

IF @FormID = 'BEMF2020' 
    BEGIN
        SELECT @VoucherNo = VoucherNo FROM BEMT2020 WHERE APK = @APK

    --- Kiểm tra phiếu đã duyệt
        IF EXISTS(SELECT TOP 1 1 FROM BEMT2020 B1 WITH (NOLOCK) 
                    LEFT JOIN BEMT2021 B2 WITH (NOLOCK) ON B2.APKMaster = B1.APK
                    INNER JOIN BEMT2001 B3 WITH (NOLOCK) ON CHARINDEX(CONVERT(VARCHAR(50), B2.APK), B3.ListAPKDInherited) > 0
                    WHERE B1.APK = @APK AND B1.DivisionID = @DivisionID AND B3.[Status] = 1)
            BEGIN
                INSERT INTO #BEMT2015P_Errors (Status, Params, MessageID, APK)
                SELECT 1 AS Status, @VoucherNo AS Params,'00ML000117' AS MessageID, @APK
            END
    END

IF @FormID = 'BEMF2030' 
    BEGIN
        SELECT @VoucherNo = VoucherNo FROM BEMT2030 WHERE APK = @APK

    --- Kiểm tra phiếu đã duyệt
        IF EXISTS(SELECT TOP 1 1 FROM BEMT2030 B1 WITH (NOLOCK) 
                    LEFT JOIN OOT9000 O1 WITH (NOLOCK) ON B1.APKMaster_9000 = O1.APK
                    LEFT JOIN OOT9001 O2 WITH (NOLOCK) ON O2.APKMaster = O1.APK  AND O2.DivisionID = @DivisionID
                    WHERE B1.APK = @APK AND B1.DivisionID = @DivisionID AND O2.[Status] = 1)
            BEGIN
                INSERT INTO #BEMT2015P_Errors (Status, Params, MessageID, APK)
                SELECT 1 AS Status, @VoucherNo AS Params,'00ML000117' AS MessageID, @APK
            END
    END

IF @FormID = 'BEMF2040' 
    BEGIN
        SELECT @VoucherNo = VoucherNo FROM BEMT2040 WHERE APK = @APK

    --- Kiểm tra phiếu đã duyệt
        IF EXISTS(SELECT TOP 1 1 FROM BEMT2040 B1 WITH (NOLOCK) 
                    LEFT JOIN OOT9000 O1 WITH (NOLOCK) ON B1.APKMaster_9000 = O1.APK
                    LEFT JOIN OOT9001 O2 WITH (NOLOCK) ON O2.APKMaster = O1.APK AND O2.DivisionID = @DivisionID
                    WHERE B1.APK = @APK AND B1.DivisionID = @DivisionID AND O2.[Status] = 1)
            BEGIN
                INSERT INTO #BEMT2015P_Errors (Status, Params, MessageID, APK)
                SELECT 1 AS Status, @VoucherNo AS Params,'00ML000117' AS MessageID, @APK
            END
    END

IF @FormID = 'BEMF2050' 
    BEGIN
        SELECT @VoucherNo = VoucherNo FROM BEMT2050 WHERE APK = @APK

    --- Kiểm tra phiếu đã duyệt
        IF EXISTS(SELECT TOP 1 1 FROM BEMT2050 B1 WITH (NOLOCK) 
                    LEFT JOIN OOT9000 O1 WITH (NOLOCK) ON B1.APKMaster_9000 = O1.APK
                    LEFT JOIN OOT9001 O2 WITH (NOLOCK) ON O2.APKMaster = O1.APK AND O2.DivisionID = @DivisionID
                    WHERE B1.APK = @APK AND B1.DivisionID = @DivisionID AND O2.[Status] = 1)
            BEGIN
                INSERT INTO #BEMT2015P_Errors (Status, Params, MessageID, APK)
                SELECT 1 AS Status, @VoucherNo AS Params,'00ML000117' AS MessageID, @APK
            END
    END

IF @FormID = 'BEMF2000' 
    BEGIN
        SELECT @VoucherNo = VoucherNo FROM BEMT2000 WHERE APK = @APK

		--- Kiểm tra phiếu đã duyệt
		IF (EXISTS(SELECT TOP 1 1 FROM BEMT2000 B1 WITH (NOLOCK) 
				LEFT JOIN OOT9000 O1 WITH (NOLOCK) ON B1.APKMaster_9000 = O1.APK
				LEFT JOIN OOT9001 O2 WITH (NOLOCK) ON O2.APKMaster = O1.APK AND O2.DivisionID = @DivisionID
				WHERE B1.APK = @APK AND B1.DivisionID = @DivisionID AND O2.[Status] = 1)
		   OR
		   EXISTS(SELECT TOP 1 1 FROM BEMT2001 B1 WITH (NOLOCK) 
				LEFT JOIN OOT9000 O1 WITH (NOLOCK) ON B1.APKMaster_9000 = O1.APK
				LEFT JOIN OOT9001 O2 WITH (NOLOCK) ON O2.APKMaster = O1.APK AND O2.DivisionID = @DivisionID
				WHERE B1.APKMaster = @APK AND B1.DivisionID = @DivisionID AND O2.[Status] = 1))
			BEGIN
                INSERT INTO #BEMT2015P_Errors (Status, Params, MessageID, APK)
                SELECT 1 AS Status, @VoucherNo AS Params,'00ML000117' AS MessageID, @APK
            END
		--- Kiểm tra phiếu đã được kế thừa.
		IF EXISTS(SELECT TOP 1 1
					FROM BEMT2000 B1 WITH (NOLOCK)
						LEFT JOIN BEMT2001 B2 WITH (NOLOCK) ON B2.APKMaster = B1.APK AND B2.DivisionID = B1.DivisionID AND ISNULL(B2.DeleteFlg,0) = 0
						LEFT JOIN BEMT2000 B3 WITH (NOLOCK) ON B3.DivisionID = B1.DivisionID AND ISNULL(B3.DeleteFlg,0) = 0
						LEFT JOIN BEMT2001 B4 WITH (NOLOCK) ON B4.APKMaster = B3.APK AND B4.DivisionID = B1.DivisionID
					WHERE B1.DivisionID = @DivisionID AND B1.APK = @APK AND (B3.APKInherited = B1.APK OR B4.APKDInherited = B2.APK OR B4.APKMInherited = B1.APK))
			BEGIN
                INSERT INTO #BEMT2015P_Errors (Status, Params, MessageID, APK)
                SELECT 1 AS Status, @VoucherNo AS Params,'00ML000179' AS MessageID, @APK
            END
	    
    END

SELECT * FROM #BEMT2015P_Errors


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
