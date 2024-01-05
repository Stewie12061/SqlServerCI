IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[KPIP30241]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)           
DROP PROCEDURE [DBO].[KPIP30241]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









-- <Summary>
---- Quy định giờ công vi phạm
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
-- Create on 10/10/2019 by Trường Lãm
CREATE PROCEDURE [dbo].[KPIP30241]
(
    @DivisionID VARCHAR(50),
    @AssignedToUserID VARCHAR(50),
    @TranMonth INT = NULL,
    @TranYear INT = NULL,
    @Period VARCHAR(10) = NULL
)
AS
BEGIN

    DECLARE @KPI1 AS TABLE (STT VARCHAR(10),
                            TargetsID NVARCHAR(250),
                            TargetsName NVARCHAR(250),
                            Quantity DECIMAL(28,4),
                            TargetsGroupPercentage DECIMAL(28,2),
                            Total DECIMAL(28,2),
                            TypeData VARCHAR(10),
                            EmployeeID VARCHAR(50))

    DECLARE @KPI2 AS TABLE (STT VARCHAR(10),
                            TargetsID NVARCHAR(250),
                            TargetsName NVARCHAR(250),
                            Quantity DECIMAL(28,4),
                            TargetsGroupPercentage DECIMAL(28,2),
                            PunishRate DECIMAL(28,2),
                            Total DECIMAL(28,2),
                            TypeData VARCHAR(10))

    DECLARE @KPI3 AS TABLE (STT VARCHAR(10),
                            TargetsID NVARCHAR(250),
                            TargetsName NVARCHAR(250),
                            Quantity DECIMAL(28,4),
                            TargetsGroupPercentage DECIMAL(28,2),
                            PunishRate DECIMAL(28,2),
                            Total DECIMAL(28,2),
                            TypeData VARCHAR(10))

    DECLARE @minCount int = 1, @maxCount int

    INSERT INTO @KPI1 (STT, TargetsID, TargetsName, Quantity, TargetsGroupPercentage, Total, TypeData)
    EXEC KPIP30223 @DivisionID, @AssignedToUserID, @TranMonth, @TranYear, '4'
    --exec KPIP30223 @DivisionID = N'DTI', @AssignedToUserID ='BAOTOAN', @TranMonth = '7', @TranYear = '2019', @Mode = '4'

    -- Trường hợp vi phạm trể task
    INSERT INTO @KPI2 (STT, TargetsID, TargetsName, Quantity, TargetsGroupPercentage, PunishRate, Total, TypeData)

    SELECT ROW_NUMBER() OVER(ORDER BY T1.TargetsName) STT,
        T1.TargetsID, T1.TargetsName, T1.Quantity, T1.TargetsGroupPercentage, T1.PunishRate, T1.Total, T1.TypeData
        FROM (
                -- Trường hợp trể task và nằm trong khoảng 1-->100%
                SELECT K1.STT, K1.TargetsID, K1.TargetsName, K1.Quantity, K1.TargetsGroupPercentage, O.PunishRate, K1.Total, K1.TypeData                
                FROM OOT1081 O WITH (NOLOCK)
                INNER JOIN OOT1080 O1 WITH (NOLOCK) ON O1.APK = O.APKMaster
                    CROSS JOIN @KPI1 K1 
                WHERE O1.CreateUserID = 'TRUONGLAM' 
                --O.APKMaster = '1310c79c-d7aa-49b5-aa37-a085e8357851' 
                AND K1.Total > 0 AND K1.TargetsGroupPercentage <= O.PunishRate
                
                -- Trường hợp trể task và lớn hơn 100%--> PunishRate = 100 
                UNION ALL
                SELECT K1.STT, K1.TargetsID, K1.TargetsName, K1.Quantity, K1.TargetsGroupPercentage, 100 AS PunishRate, K1.Total, K1.TypeData                
                FROM OOT1081 O WITH (NOLOCK)
                INNER JOIN OOT1080 O1 WITH (NOLOCK) ON O1.APK = O.APKMaster
                    CROSS JOIN @KPI1 K1 
                WHERE O1.CreateUserID = 'TRUONGLAM' 
                --O.APKMaster = '1310c79c-d7aa-49b5-aa37-a085e8357851' 
                AND K1.Total > 0 AND K1.TargetsGroupPercentage > 100
                ) T1
    -- Trường hợp Cố tình vi phạm
    INSERT INTO @KPI3 (STT, TargetsID, TargetsName, Quantity, TargetsGroupPercentage, PunishRate, Total, TypeData)

    SELECT ROW_NUMBER() OVER(ORDER BY T2.TargetsName) STT,
        T2.TargetsID, T2.TargetsName, T2.Quantity, T2.TargetsGroupPercentage, T2.PunishRate, T2.Total, T2.TypeData
        FROM (
                SELECT K1.STT, K1.TargetsID, K1.TargetsName, K1.Quantity, K1.TargetsGroupPercentage, O.PunishRate, K1.Total, K1.TypeData
                
                FROM OOT1081 O WITH (NOLOCK)
                INNER JOIN OOT1080 O1 WITH (NOLOCK) ON O1.APK = O.APKMaster
                    CROSS JOIN @KPI1 K1 
                WHERE O1.CreateUserID = 'TRUONGLAM' 
                --O.APKMaster = '1310c79c-d7aa-49b5-aa37-a085e8357851' 
                AND K1.Total = 0 
                --AND K1.TargetsGroupPercentage <= O.PunishRate
                ) T2
    --SELECT * FROM @KPI2
    --SELECT @maxCount = MAX(STT) FROM @KPI2

     SELECT ROW_NUMBER() OVER(ORDER BY T1.TargetsName) STT
        , T1.TargetsID, T1.TargetsName, T1.Quantity, T1.TargetsGroupPercentage, T1.Total, T1.TypeData 
        FROM (
                -- Trể task
                SELECT K1.TargetsID, K1.TargetsName,K1.Quantity, K1.TargetsGroupPercentage
                , ( MIN(PunishRate) * K1.Total / 100) AS Total, K1.TypeData 
                FROM @KPI2 K2
                INNER JOIN @KPI1 K1 ON K1.TargetsID = K2.TargetsID
                GROUP BY K1.TargetsGroupPercentage, K1.TargetsID, K1.TargetsName,K1.Quantity, K1.TargetsGroupPercentage, K1.Total, K1.TypeData

                UNION ALL
                -- Cố tình vi phạm
                SELECT K1.TargetsID, K1.TargetsName,K1.Quantity, K1.TargetsGroupPercentage/3 AS TargetsGroupPercentage
                , K1.TargetsGroupPercentage AS Total, K1.TypeData 
                FROM @KPI3 K2
                INNER JOIN @KPI1 K1 ON K1.TargetsID = K2.TargetsID
                GROUP BY K1.TargetsGroupPercentage, K1.TargetsID, K1.TargetsName,K1.Quantity, K1.TargetsGroupPercentage, K1.Total, K1.TypeData 
            )  AS T1
        ORDER BY T1.Total
END









GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
