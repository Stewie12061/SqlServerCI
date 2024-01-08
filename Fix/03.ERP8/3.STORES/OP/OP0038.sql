IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP0038]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[OP0038]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



---- Created by Tieu Mai
---- Date 02/17/2016
---- Purpose: Loc ra cac don hang mua giao hang tre.
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
-- exec OP0038 'KE', 'PO/02/2016/0001'
-- exec OP0038 'KE', NULL

CREATE PROCEDURE [dbo].[OP0038] 
	@DivisionID nvarchar(50),
	@POrderID NVARCHAR(50)
								
AS
DECLARE @sSQL NVARCHAR(MAX),
		@sSQL1 NVARCHAR(MAX),
		@Cur CURSOR,
		@ActualQuantity DECIMAL(28,8), 
		@EndQuantity DECIMAL(28,8), 
		@Quantity01 DECIMAL(28,8), 
		@Quantity02 DECIMAL(28,8), 
		@Quantity03 DECIMAL(28,8), 
		@Quantity04 DECIMAL(28,8), 
		@Quantity05 DECIMAL(28,8), 
		@Quantity06 DECIMAL(28,8), 
		@Quantity07 DECIMAL(28,8), 
		@Quantity08 DECIMAL(28,8), 
		@Quantity09 DECIMAL(28,8), 
		@Quantity10 DECIMAL(28,8), 
		@Quantity11 DECIMAL(28,8), 
		@Quantity12 DECIMAL(28,8), 
		@Quantity13 DECIMAL(28,8), 
		@Quantity14 DECIMAL(28,8), 
		@Quantity15 DECIMAL(28,8), 
		@Quantity16 DECIMAL(28,8), 
		@Quantity17 DECIMAL(28,8), 
		@Quantity18 DECIMAL(28,8), 
		@Quantity19 DECIMAL(28,8), 
		@Quantity20 DECIMAL(28,8), 
		@Quantity21 DECIMAL(28,8), 
		@Quantity22 DECIMAL(28,8), 
		@Quantity23 DECIMAL(28,8), 
		@Quantity24 DECIMAL(28,8), 
		@Quantity25 DECIMAL(28,8), 
		@Quantity26 DECIMAL(28,8), 
		@Quantity27 DECIMAL(28,8), 
		@Quantity28 DECIMAL(28,8), 
		@Quantity29 DECIMAL(28,8), 
		@Quantity30 DECIMAL(28,8), 
		@Date01 DATETIME, @Date02 DATETIME, @Date03 DATETIME, @Date04 DATETIME, @Date05 DATETIME, 
		@Date06 DATETIME, @Date07 DATETIME, @Date08 DATETIME, @Date09 DATETIME, @Date10 DATETIME,
		@Date11 DATETIME, @Date12 DATETIME, @Date13 DATETIME, @Date14 DATETIME, @Date15 DATETIME, 
		@Date16 DATETIME, @Date17 DATETIME, @Date18 DATETIME, @Date19 DATETIME, @Date20 DATETIME,
		@Date21 DATETIME, @Date22 DATETIME, @Date23 DATETIME, @Date24 DATETIME, @Date25 DATETIME, 
		@Date26 DATETIME, @Date27 DATETIME, @Date28 DATETIME, @Date29 DATETIME, @Date30 DATETIME
		
SET @sSQL = ''
SET @sSQL1 = ''

/*
IF ISNULL(@POrderID,'') = ''
	SET @Cur = CURSOR SCROLL KEYSET FOR
	SELECT DISTINCT OT3001.SOrderID, OV2902.ActualQuantity, OV2902.EndQuantity, OT3002.Quantity01, OT3002.Quantity02, OT3002.Quantity03, OT3002.Quantity04, OT3002.Quantity05, OT3002.Quantity06, OT3002.Quantity07, OT3002.Quantity08, OT3002.Quantity09, OT3002.Quantity10, 
		OT3002.Quantity11, OT3002.Quantity12, OT3002.Quantity13, OT3002.Quantity14, OT3002.Quantity15, OT3002.Quantity16, OT3002.Quantity17, OT3002.Quantity18, OT3002.Quantity19, OT3002.Quantity20, 
		OT3002.Quantity21, OT3002.Quantity22, OT3002.Quantity23, OT3002.Quantity24, OT3002.Quantity25, OT3002.Quantity26, OT3002.Quantity27, OT3002.Quantity28, OT3002.Quantity29, OT3002.Quantity30, 
		OT3003.Date01, OT3003.Date02, OT3003.Date03, OT3003.Date04, OT3003.Date05, OT3003.Date06, OT3003.Date07, OT3003.Date08, OT3003.Date09, OT3003.Date10,
		OT3003.Date11, OT3003.Date12, OT3003.Date13, OT3003.Date14, OT3003.Date15, OT3003.Date16, OT3003.Date17, OT3003.Date18, OT3003.Date19, OT3003.Date20,
		OT3003.Date21, OT3003.Date22, OT3003.Date23, OT3003.Date24, OT3003.Date25, OT3003.Date26, OT3003.Date27, OT3003.Date28, OT3003.Date29, OT3003.Date30
	FROM OT3003
	LEFT JOIN OT3001 ON OT3001.DivisionID = OT3003.DivisionID AND OT3001.POrderID = OT3003.POrderID
	LEFT JOIN OT3002 ON OT3002.DivisionID = OT3001.DivisionID AND OT3002.POrderID = OT3001.SOrderID
	LEFT JOIN OV2902 ON OV2902.DivisionID = OT3002.DivisionID AND OV2902.POrderID = OT3002.POrderID AND OV2902.TransactionID = OT3002.TransactionID
	WHERE OT3001.DivisionID = @DivisionID
		AND OrderType = 0
		AND OV2902.EndQuantity > 0
	
ELSE
	SET @Cur = CURSOR SCROLL KEYSET FOR
	SELECT DISTINCT OT3001.SOrderID, OV2902.ActualQuantity, OV2902.EndQuantity, OT3002.Quantity01, OT3002.Quantity02, OT3002.Quantity03, OT3002.Quantity04, OT3002.Quantity05, OT3002.Quantity06, OT3002.Quantity07, OT3002.Quantity08, OT3002.Quantity09, OT3002.Quantity10, 
		OT3002.Quantity11, OT3002.Quantity12, OT3002.Quantity13, OT3002.Quantity14, OT3002.Quantity15, OT3002.Quantity16, OT3002.Quantity17, OT3002.Quantity18, OT3002.Quantity19, OT3002.Quantity20, 
		OT3002.Quantity21, OT3002.Quantity22, OT3002.Quantity23, OT3002.Quantity24, OT3002.Quantity25, OT3002.Quantity26, OT3002.Quantity27, OT3002.Quantity28, OT3002.Quantity29, OT3002.Quantity30, 
		OT3003.Date01, OT3003.Date02, OT3003.Date03, OT3003.Date04, OT3003.Date05, OT3003.Date06, OT3003.Date07, OT3003.Date08, OT3003.Date09, OT3003.Date10,
		OT3003.Date11, OT3003.Date12, OT3003.Date13, OT3003.Date14, OT3003.Date15, OT3003.Date16, OT3003.Date17, OT3003.Date18, OT3003.Date19, OT3003.Date20,
		OT3003.Date21, OT3003.Date22, OT3003.Date23, OT3003.Date24, OT3003.Date25, OT3003.Date26, OT3003.Date27, OT3003.Date28, OT3003.Date29, OT3003.Date30
	FROM OT3003
	LEFT JOIN OT3001 ON OT3001.DivisionID = OT3003.DivisionID AND OT3001.POrderID = OT3003.POrderID
	LEFT JOIN OT3002 ON OT3002.DivisionID = OT3001.DivisionID AND OT3002.POrderID = OT3001.POrderID
	LEFT JOIN OV2902 ON OV2902.DivisionID = OT3002.DivisionID AND OV2902.POrderID = OT3002.POrderID AND OV2902.TransactionID = OT3002.TransactionID
	WHERE OT3001.DivisionID = @DivisionID
		AND OrderType = 0
		AND OV2902.EndQuantity > 0
		AND OT3001.POrderID = @POrderID	
OPEN @Cur
FETCH NEXT FROM @Cur INTO @POrderID, @ActualQuantity, @EndQuantity, @Quantity01, @Quantity02, @Quantity03, @Quantity04, @Quantity05, @Quantity06, @Quantity07, @Quantity08, @Quantity09, @Quantity10, 
	@Quantity11, @Quantity12, @Quantity13, @Quantity14, @Quantity15, @Quantity16, @Quantity17, @Quantity18, @Quantity19, @Quantity20, 
	@Quantity21, @Quantity22, @Quantity23, @Quantity24, @Quantity25, @Quantity26, @Quantity27, @Quantity28, @Quantity29, @Quantity30, 
	@Date01, @Date02, @Date03, @Date04, @Date05, @Date06, @Date07, @Date08, @Date09, @Date10,
	@Date11, @Date12, @Date13, @Date14, @Date15, @Date16, @Date17, @Date18, @Date19, @Date20,
	@Date21, @Date22, @Date23, @Date24, @Date25, @Date26, @Date27, @Date28, @Date29, @Date30
            
WHILE @@Fetch_Status = 0
    BEGIN
    	IF @Date30 IS NOT NULL 
        BEGIN
        	IF  Convert(Date,@Date30) < Convert(Date,GETDATE()) AND 
        	(Isnull(@Quantity01,0) + Isnull(@Quantity02,0) + Isnull(@Quantity03,0)+ Isnull(@Quantity04,0) + Isnull(@Quantity05,0) + Isnull(@Quantity06,0)+Isnull(@Quantity07,0)+Isnull(@Quantity08,0)+Isnull(@Quantity09,0)+Isnull(@Quantity10,0)
        	+Isnull(@Quantity11,0)+Isnull(@Quantity12,0)+Isnull(@Quantity13,0)+Isnull(@Quantity14,0)+Isnull(@Quantity15,0)+Isnull(@Quantity16,0)+Isnull(@Quantity17,0)+Isnull(@Quantity18,0)+Isnull(@Quantity19,0)+Isnull(@Quantity20,0)
        	+Isnull(@Quantity21,0)+Isnull(@Quantity22,0)+Isnull(@Quantity23,0)+Isnull(@Quantity24,0)+Isnull(@Quantity25,0)+Isnull(@Quantity26,0)+Isnull(@Quantity27,0)+Isnull(@Quantity28,0)+Isnull(@Quantity29,0)+Isnull(@Quantity30,0)) > ISNULL(@ActualQuantity,0)
        	BEGIN     	
				IF ISNULL(@sSQL,'') <> ''
					SET @sSQL  = @sSQL + 'Union
					'
				SET @sSQL = @sSQL + 'SELECT '''+@POrderID+''' as N''POrderID'', '''+convert(nvarchar(25),@Date30,101)+''' AS ''Date'' '
				--CONTINUE
			END
        END
    	IF @Date29 IS NOT NULL 
        BEGIN
        	IF  Convert(Date,@Date29) < Convert(Date,GETDATE()) AND 
        	(Isnull(@Quantity01,0) + Isnull(@Quantity02,0) + Isnull(@Quantity03,0)+ Isnull(@Quantity04,0) + Isnull(@Quantity05,0) + Isnull(@Quantity06,0)+Isnull(@Quantity07,0)+Isnull(@Quantity08,0)+Isnull(@Quantity09,0)+Isnull(@Quantity10,0)
        	+Isnull(@Quantity11,0)+Isnull(@Quantity12,0)+Isnull(@Quantity13,0)+Isnull(@Quantity14,0)+Isnull(@Quantity15,0)+Isnull(@Quantity16,0)+Isnull(@Quantity17,0)+Isnull(@Quantity18,0)+Isnull(@Quantity19,0)+Isnull(@Quantity20,0)
        	+Isnull(@Quantity21,0)+Isnull(@Quantity22,0)+Isnull(@Quantity23,0)+Isnull(@Quantity24,0)+Isnull(@Quantity25,0)+Isnull(@Quantity26,0)+Isnull(@Quantity27,0)+Isnull(@Quantity28,0)+Isnull(@Quantity29,0)) > ISNULL(@ActualQuantity,0)
        	BEGIN     	
				IF ISNULL(@sSQL,'') <> ''
					SET @sSQL  = @sSQL + 'Union
					'
				SET @sSQL = @sSQL + 'SELECT '''+@POrderID+''' as N''POrderID'', '''+convert(nvarchar(25),@Date29,101)+''' AS N''Date'' '
				--CONTINUE
			END
        END
    	IF @Date28 IS NOT NULL 
        BEGIN
        	IF  Convert(Date,@Date28) < Convert(Date,GETDATE()) AND 
        	(Isnull(@Quantity01,0) + Isnull(@Quantity02,0) + Isnull(@Quantity03,0)+ Isnull(@Quantity04,0) + Isnull(@Quantity05,0) + Isnull(@Quantity06,0)+Isnull(@Quantity07,0)+Isnull(@Quantity08,0)+Isnull(@Quantity09,0)+Isnull(@Quantity10,0)
        	+Isnull(@Quantity11,0)+Isnull(@Quantity12,0)+Isnull(@Quantity13,0)+Isnull(@Quantity14,0)+Isnull(@Quantity15,0)+Isnull(@Quantity16,0)+Isnull(@Quantity17,0)+Isnull(@Quantity18,0)+Isnull(@Quantity19,0)+Isnull(@Quantity20,0)
        	+Isnull(@Quantity21,0)+Isnull(@Quantity22,0)+Isnull(@Quantity23,0)+Isnull(@Quantity24,0)+Isnull(@Quantity25,0)+Isnull(@Quantity26,0)+Isnull(@Quantity27,0)+Isnull(@Quantity28,0)) > ISNULL(@ActualQuantity,0)
        	BEGIN     	
				IF ISNULL(@sSQL,'') <> ''
					SET @sSQL  = @sSQL + 'Union
					'
				SET @sSQL = @sSQL + 'SELECT '''+@POrderID+''' as N''POrderID'', '''+convert(nvarchar(25),@Date28,101)+''' AS N''Date'' '
				--CONTINUE
			END
        END
    	IF @Date27 IS NOT NULL 
        BEGIN
        	IF  Convert(Date,@Date27) < Convert(Date,GETDATE()) AND 
        	(Isnull(@Quantity01,0) + Isnull(@Quantity02,0) + Isnull(@Quantity03,0)+ Isnull(@Quantity04,0) + Isnull(@Quantity05,0) + Isnull(@Quantity06,0)+Isnull(@Quantity07,0)+Isnull(@Quantity08,0)+Isnull(@Quantity09,0)+Isnull(@Quantity10,0)
        	+Isnull(@Quantity11,0)+Isnull(@Quantity12,0)+Isnull(@Quantity13,0)+Isnull(@Quantity14,0)+Isnull(@Quantity15,0)+Isnull(@Quantity16,0)+Isnull(@Quantity17,0)+Isnull(@Quantity18,0)+Isnull(@Quantity19,0)+Isnull(@Quantity20,0)
        	+Isnull(@Quantity21,0)+Isnull(@Quantity22,0)+Isnull(@Quantity23,0)+Isnull(@Quantity24,0)+Isnull(@Quantity25,0)+Isnull(@Quantity26,0)+Isnull(@Quantity27,0)) > ISNULL(@ActualQuantity,0)
        	BEGIN     	
				IF ISNULL(@sSQL,'') <> ''
					SET @sSQL  = @sSQL + 'Union
					'
				SET @sSQL = @sSQL + 'SELECT '''+@POrderID+''' as N''POrderID'', '''+convert(nvarchar(25),@Date27,101)+''' AS N''Date'' '
				--CONTINUE
			END
        END
    	IF @Date26 IS NOT NULL 
        BEGIN
        	IF  Convert(Date,@Date26) < Convert(Date,GETDATE()) AND 
        	(Isnull(@Quantity01,0) + Isnull(@Quantity02,0) + Isnull(@Quantity03,0)+ Isnull(@Quantity04,0) + Isnull(@Quantity05,0) + Isnull(@Quantity06,0)+Isnull(@Quantity07,0)+Isnull(@Quantity08,0)+Isnull(@Quantity09,0)+Isnull(@Quantity10,0)
        	+Isnull(@Quantity11,0)+Isnull(@Quantity12,0)+Isnull(@Quantity13,0)+Isnull(@Quantity14,0)+Isnull(@Quantity15,0)+Isnull(@Quantity16,0)+Isnull(@Quantity17,0)+Isnull(@Quantity18,0)+Isnull(@Quantity19,0)+Isnull(@Quantity20,0)
        	+Isnull(@Quantity21,0)+Isnull(@Quantity22,0)+Isnull(@Quantity23,0)+Isnull(@Quantity24,0)+Isnull(@Quantity25,0)+Isnull(@Quantity26,0)) > ISNULL(@ActualQuantity,0)
        	BEGIN     	
				IF ISNULL(@sSQL,'') <> ''
					SET @sSQL  = @sSQL + 'Union
					'
				SET @sSQL = @sSQL + 'SELECT '''+@POrderID+''' as N''POrderID'', '''+convert(nvarchar(25),@Date26,101)+''' AS N''Date'' '
				--CONTINUE
			END
        END
    	IF @Date25 IS NOT NULL 
        BEGIN
        	IF  Convert(Date,@Date25) < Convert(Date,GETDATE()) AND 
        	(Isnull(@Quantity01,0) + Isnull(@Quantity02,0) + Isnull(@Quantity03,0)+ Isnull(@Quantity04,0) + Isnull(@Quantity05,0) + Isnull(@Quantity06,0)+Isnull(@Quantity07,0)+Isnull(@Quantity08,0)+Isnull(@Quantity09,0)+Isnull(@Quantity10,0)
        	+Isnull(@Quantity11,0)+Isnull(@Quantity12,0)+Isnull(@Quantity13,0)+Isnull(@Quantity14,0)+Isnull(@Quantity15,0)+Isnull(@Quantity16,0)+Isnull(@Quantity17,0)+Isnull(@Quantity18,0)+Isnull(@Quantity19,0)+Isnull(@Quantity20,0)
        	+Isnull(@Quantity21,0)+Isnull(@Quantity22,0)+Isnull(@Quantity23,0)+Isnull(@Quantity24,0)+Isnull(@Quantity25,0)) > ISNULL(@ActualQuantity,0)
        	BEGIN     	
				IF ISNULL(@sSQL,'') <> ''
					SET @sSQL  = @sSQL + 'Union
					'
				SET @sSQL = @sSQL + 'SELECT '''+@POrderID+''' as N''POrderID'', '''+convert(nvarchar(25),@Date25,101)+''' AS N''Date'' '
				--CONTINUE
			END
        END
    	IF @Date24 IS NOT NULL 
        BEGIN
        	IF  Convert(Date,@Date24) < Convert(Date,GETDATE()) AND 
        	(Isnull(@Quantity01,0) + Isnull(@Quantity02,0) + Isnull(@Quantity03,0)+ Isnull(@Quantity04,0) + Isnull(@Quantity05,0) + Isnull(@Quantity06,0)+Isnull(@Quantity07,0)+Isnull(@Quantity08,0)+Isnull(@Quantity09,0)+Isnull(@Quantity10,0)
        	+Isnull(@Quantity11,0)+Isnull(@Quantity12,0)+Isnull(@Quantity13,0)+Isnull(@Quantity14,0)+Isnull(@Quantity15,0)+Isnull(@Quantity16,0)+Isnull(@Quantity17,0)+Isnull(@Quantity18,0)+Isnull(@Quantity19,0)+Isnull(@Quantity20,0)
        	+Isnull(@Quantity21,0)+Isnull(@Quantity22,0)+Isnull(@Quantity23,0)+Isnull(@Quantity24,0)) > ISNULL(@ActualQuantity,0)
        	BEGIN     	
				IF ISNULL(@sSQL,'') <> ''
					SET @sSQL  = @sSQL + 'Union
					'
				SET @sSQL = @sSQL + 'SELECT '''+@POrderID+''' as N''POrderID'', '''+convert(nvarchar(25),@Date24,101)+''' AS N''Date'' '
				--CONTINUE
			END
        END
        IF @Date23 IS NOT NULL 
        BEGIN
        	IF  Convert(Date,@Date23) < Convert(Date,GETDATE()) AND 
        	(Isnull(@Quantity01,0) + Isnull(@Quantity02,0) + Isnull(@Quantity03,0)+ Isnull(@Quantity04,0) + Isnull(@Quantity05,0) + Isnull(@Quantity06,0)+Isnull(@Quantity07,0)+Isnull(@Quantity08,0)+Isnull(@Quantity09,0)+Isnull(@Quantity10,0)
        	+Isnull(@Quantity11,0)+Isnull(@Quantity12,0)+Isnull(@Quantity13,0)+Isnull(@Quantity14,0)+Isnull(@Quantity15,0)+Isnull(@Quantity16,0)+Isnull(@Quantity17,0)+Isnull(@Quantity18,0)+Isnull(@Quantity19,0)+Isnull(@Quantity20,0)
        	+Isnull(@Quantity21,0)+Isnull(@Quantity22,0)+Isnull(@Quantity23,0)) > ISNULL(@ActualQuantity,0)
        	BEGIN     	
				IF ISNULL(@sSQL,'') <> ''
					SET @sSQL  = @sSQL + 'Union
					'
				SET @sSQL = @sSQL + 'SELECT '''+@POrderID+''' as N''POrderID'', '''+convert(nvarchar(25),@Date23,101)+''' AS N''Date'' '
				--CONTINUE
			END
        END	
        IF @Date22 IS NOT NULL 
        BEGIN
        	IF  Convert(Date,@Date22) < Convert(Date,GETDATE()) AND 
        	(Isnull(@Quantity01,0) + Isnull(@Quantity02,0) + Isnull(@Quantity03,0)+ Isnull(@Quantity04,0) + Isnull(@Quantity05,0) + Isnull(@Quantity06,0)+Isnull(@Quantity07,0)+Isnull(@Quantity08,0)+Isnull(@Quantity09,0)+Isnull(@Quantity10,0)
        	+Isnull(@Quantity11,0)+Isnull(@Quantity12,0)+Isnull(@Quantity13,0)+Isnull(@Quantity14,0)+Isnull(@Quantity15,0)+Isnull(@Quantity16,0)+Isnull(@Quantity17,0)+Isnull(@Quantity18,0)+Isnull(@Quantity19,0)+Isnull(@Quantity20,0)
        	+Isnull(@Quantity21,0)+Isnull(@Quantity22,0)) > ISNULL(@ActualQuantity,0)
        	BEGIN     	
				IF ISNULL(@sSQL,'') <> ''
					SET @sSQL  = @sSQL + 'Union
					'
				SET @sSQL = @sSQL + 'SELECT '''+@POrderID+''' as N''POrderID'', '''+convert(nvarchar(25),@Date22,101)+''' AS N''Date'' '
				--CONTINUE
			END
        END
        IF @Date21 IS NOT NULL 
        BEGIN
        	IF  Convert(Date,@Date21) < Convert(Date,GETDATE()) AND 
        	(Isnull(@Quantity01,0) + Isnull(@Quantity02,0) + Isnull(@Quantity03,0)+ Isnull(@Quantity04,0) + Isnull(@Quantity05,0) + Isnull(@Quantity06,0)+Isnull(@Quantity07,0)+Isnull(@Quantity08,0)+Isnull(@Quantity09,0)+Isnull(@Quantity10,0)
        	+Isnull(@Quantity11,0)+Isnull(@Quantity12,0)+Isnull(@Quantity13,0)+Isnull(@Quantity14,0)+Isnull(@Quantity15,0)+Isnull(@Quantity16,0)+Isnull(@Quantity17,0)+Isnull(@Quantity18,0)+Isnull(@Quantity19,0)+Isnull(@Quantity20,0)
        	+Isnull(@Quantity21,0)) > ISNULL(@ActualQuantity,0)
        	BEGIN     	
				IF ISNULL(@sSQL,'') <> ''
					SET @sSQL  = @sSQL + 'Union
					'
				SET @sSQL = @sSQL + 'SELECT '''+@POrderID+''' as N''POrderID'', '''+convert(nvarchar(25),@Date21,101)+''' AS N''Date'' '
				--CONTINUE
			END
        END
 
------ Date11 --> Date20        
    	IF @Date20 IS NOT NULL 
        BEGIN
        	IF  Convert(Date,@Date20) < Convert(Date,GETDATE()) AND 
        	(Isnull(@Quantity01,0) + Isnull(@Quantity02,0) + Isnull(@Quantity03,0)+ Isnull(@Quantity04,0) + Isnull(@Quantity05,0) + Isnull(@Quantity06,0)+Isnull(@Quantity07,0)+Isnull(@Quantity08,0)+Isnull(@Quantity09,0)+Isnull(@Quantity10,0)
        	+Isnull(@Quantity11,0)+Isnull(@Quantity12,0)+Isnull(@Quantity13,0)+Isnull(@Quantity14,0)+Isnull(@Quantity15,0)+Isnull(@Quantity16,0)+Isnull(@Quantity17,0)+Isnull(@Quantity18,0)+Isnull(@Quantity19,0)+Isnull(@Quantity20,0)) > ISNULL(@ActualQuantity,0)
        	BEGIN     	
				IF ISNULL(@sSQL,'') <> ''
					SET @sSQL  = @sSQL + 'Union
					'
				SET @sSQL = @sSQL + 'SELECT '''+@POrderID+''' as N''POrderID'', '''+convert(nvarchar(25),@Date20,101)+''' AS N''Date'' '
				--CONTINUE
			END
        END
    	IF @Date19 IS NOT NULL 
        BEGIN
        	IF  Convert(Date,@Date19) < Convert(Date,GETDATE()) AND 
        	(Isnull(@Quantity01,0) + Isnull(@Quantity02,0) + Isnull(@Quantity03,0)+ Isnull(@Quantity04,0) + Isnull(@Quantity05,0) + Isnull(@Quantity06,0)+Isnull(@Quantity07,0)+Isnull(@Quantity08,0)+Isnull(@Quantity09,0)+Isnull(@Quantity10,0)
        	+Isnull(@Quantity11,0)+Isnull(@Quantity12,0)+Isnull(@Quantity13,0)+Isnull(@Quantity14,0)+Isnull(@Quantity15,0)+Isnull(@Quantity16,0)+Isnull(@Quantity17,0)+Isnull(@Quantity18,0)+Isnull(@Quantity19,0)) > ISNULL(@ActualQuantity,0)
        	BEGIN     	
				IF ISNULL(@sSQL,'') <> ''
					SET @sSQL  = @sSQL + 'Union
					'
				SET @sSQL = @sSQL + 'SELECT '''+@POrderID+''' as N''POrderID'', '''+convert(nvarchar(25),@Date19,101)+''' AS N''Date'' '
				--CONTINUE
			END
        END
    	IF @Date18 IS NOT NULL 
        BEGIN
        	IF  Convert(Date,@Date18) < Convert(Date,GETDATE()) AND 
        	(Isnull(@Quantity01,0) + Isnull(@Quantity02,0) + Isnull(@Quantity03,0)+ Isnull(@Quantity04,0) + Isnull(@Quantity05,0) + Isnull(@Quantity06,0)+Isnull(@Quantity07,0)+Isnull(@Quantity08,0)+Isnull(@Quantity09,0)+Isnull(@Quantity10,0)
        	+Isnull(@Quantity11,0)+Isnull(@Quantity12,0)+Isnull(@Quantity13,0)+Isnull(@Quantity14,0)+Isnull(@Quantity15,0)+Isnull(@Quantity16,0)+Isnull(@Quantity17,0)+Isnull(@Quantity18,0)) > ISNULL(@ActualQuantity,0)
        	BEGIN     	
				IF ISNULL(@sSQL,'') <> ''
					SET @sSQL  = @sSQL + 'Union
					'
				SET @sSQL = @sSQL + 'SELECT '''+@POrderID+''' as N''POrderID'', '''+convert(nvarchar(25),@Date18,101)+''' AS N''Date'' '
				--CONTINUE
			END
        END
    	IF @Date17 IS NOT NULL 
        BEGIN
        	IF  Convert(Date,@Date17) < Convert(Date,GETDATE()) AND 
        	(Isnull(@Quantity01,0) + Isnull(@Quantity02,0) + Isnull(@Quantity03,0)+ Isnull(@Quantity04,0) + Isnull(@Quantity05,0) + Isnull(@Quantity06,0)+Isnull(@Quantity07,0)+Isnull(@Quantity08,0)+Isnull(@Quantity09,0)+Isnull(@Quantity10,0)
        	+Isnull(@Quantity11,0)+Isnull(@Quantity12,0)+Isnull(@Quantity13,0)+Isnull(@Quantity14,0)+Isnull(@Quantity15,0)+Isnull(@Quantity16,0)+Isnull(@Quantity17,0)) > ISNULL(@ActualQuantity,0)
        	BEGIN     	
				IF ISNULL(@sSQL,'') <> ''
					SET @sSQL  = @sSQL + 'Union
					'
				SET @sSQL = @sSQL + 'SELECT '''+@POrderID+''' as N''POrderID'', '''+convert(nvarchar(25),@Date17,101)+''' AS N''Date'' '
				--CONTINUE
			END
        END
    	IF @Date16 IS NOT NULL 
        BEGIN
        	IF  Convert(Date,@Date16) < Convert(Date,GETDATE()) AND 
        	(Isnull(@Quantity01,0) + Isnull(@Quantity02,0) + Isnull(@Quantity03,0)+ Isnull(@Quantity04,0) + Isnull(@Quantity05,0) + Isnull(@Quantity06,0)+Isnull(@Quantity07,0)+Isnull(@Quantity08,0)+Isnull(@Quantity09,0)+Isnull(@Quantity10,0)
        	+Isnull(@Quantity11,0)+Isnull(@Quantity12,0)+Isnull(@Quantity13,0)+Isnull(@Quantity14,0)+Isnull(@Quantity15,0)+Isnull(@Quantity16,0)) > ISNULL(@ActualQuantity,0)
        	BEGIN     	
				IF ISNULL(@sSQL,'') <> ''
					SET @sSQL  = @sSQL + 'Union
					'
				SET @sSQL = @sSQL + 'SELECT '''+@POrderID+''' as N''POrderID'', '''+convert(nvarchar(25),@Date16,101)+''' AS N''Date'' '
				--CONTINUE
			END
        END
    	IF @Date15 IS NOT NULL 
        BEGIN
        	IF  Convert(Date,@Date15) < Convert(Date,GETDATE()) AND 
        	(Isnull(@Quantity01,0) + Isnull(@Quantity02,0) + Isnull(@Quantity03,0)+ Isnull(@Quantity04,0) + Isnull(@Quantity05,0) + Isnull(@Quantity06,0)+Isnull(@Quantity07,0)+Isnull(@Quantity08,0)+Isnull(@Quantity09,0)+Isnull(@Quantity10,0)
        	+Isnull(@Quantity11,0)+Isnull(@Quantity12,0)+Isnull(@Quantity13,0)+Isnull(@Quantity14,0)+Isnull(@Quantity15,0)) > ISNULL(@ActualQuantity,0)
        	BEGIN     	
				IF ISNULL(@sSQL,'') <> ''
					SET @sSQL  = @sSQL + 'Union
					'
				SET @sSQL = @sSQL + 'SELECT '''+@POrderID+''' as N''POrderID'', '''+convert(nvarchar(25),@Date15,101)+''' AS N''Date'' '
				--CONTINUE
			END
        END
    	IF @Date14 IS NOT NULL 
        BEGIN
        	IF  Convert(Date,@Date14) < Convert(Date,GETDATE()) AND  
        	(Isnull(@Quantity01,0) + Isnull(@Quantity02,0) + Isnull(@Quantity03,0)+ Isnull(@Quantity04,0) + Isnull(@Quantity05,0) + Isnull(@Quantity06,0)+Isnull(@Quantity07,0)+Isnull(@Quantity08,0)+Isnull(@Quantity09,0)+Isnull(@Quantity10,0)
        	+Isnull(@Quantity11,0)+Isnull(@Quantity12,0)+Isnull(@Quantity13,0)+Isnull(@Quantity14,0)) > ISNULL(@ActualQuantity,0)
        	BEGIN     	
				IF ISNULL(@sSQL,'') <> ''
					SET @sSQL  = @sSQL + 'Union
					'
				SET @sSQL = @sSQL + 'SELECT '''+@POrderID+''' as N''POrderID'', '''+convert(nvarchar(25),@Date14,101)+''' AS N''Date'' '
				--CONTINUE
			END
        END
        IF @Date13 IS NOT NULL 
        BEGIN
        	IF  Convert(Date,@Date13) < Convert(Date,GETDATE()) AND  
        	(Isnull(@Quantity01,0) + Isnull(@Quantity02,0) + Isnull(@Quantity03,0)+ Isnull(@Quantity04,0) + Isnull(@Quantity05,0) + Isnull(@Quantity06,0)+Isnull(@Quantity07,0)+Isnull(@Quantity08,0)+Isnull(@Quantity09,0)+Isnull(@Quantity10,0)
        	+Isnull(@Quantity11,0)+Isnull(@Quantity12,0)+Isnull(@Quantity13,0)) > ISNULL(@ActualQuantity,0)
        	BEGIN     	
				IF ISNULL(@sSQL,'') <> ''
					SET @sSQL  = @sSQL + 'Union
					'
				SET @sSQL = @sSQL + 'SELECT '''+@POrderID+''' as N''POrderID'', '''+convert(nvarchar(25),@Date13,101)+''' AS N''Date'' '
				--CONTINUE
			END
        END	
        IF @Date12 IS NOT NULL 
        BEGIN
        	IF  Convert(Date,@Date12) < Convert(Date,GETDATE()) AND  
        	(Isnull(@Quantity01,0) + Isnull(@Quantity02,0) + Isnull(@Quantity03,0)+ Isnull(@Quantity04,0) + Isnull(@Quantity05,0) + Isnull(@Quantity06,0)+Isnull(@Quantity07,0)+Isnull(@Quantity08,0)+Isnull(@Quantity09,0)+Isnull(@Quantity10,0)
        	+Isnull(@Quantity11,0)+Isnull(@Quantity12,0)) > ISNULL(@ActualQuantity,0)
        	BEGIN     	
				IF ISNULL(@sSQL,'') <> ''
					SET @sSQL  = @sSQL + 'Union
					'
				SET @sSQL = @sSQL + 'SELECT '''+@POrderID+''' as N''POrderID'', '''+convert(nvarchar(25),@Date12,101)+''' AS N''Date'' '
				--CONTINUE
			END
        END
        IF @Date11 IS NOT NULL 
        BEGIN
        	IF  Convert(Date,@Date11) < Convert(Date,GETDATE()) AND 
        	(Isnull(@Quantity01,0) + Isnull(@Quantity02,0) + Isnull(@Quantity03,0)+ Isnull(@Quantity04,0) + Isnull(@Quantity05,0) + Isnull(@Quantity06,0)+Isnull(@Quantity07,0)+Isnull(@Quantity08,0)+Isnull(@Quantity09,0)+Isnull(@Quantity10,0)+Isnull(@Quantity11,0)) > ISNULL(@ActualQuantity,0)
        	BEGIN     	
				IF ISNULL(@sSQL,'') <> ''
					SET @sSQL  = @sSQL + 'Union
					'
				SET @sSQL = @sSQL + 'SELECT '''+@POrderID+''' as N''POrderID'', '''+convert(nvarchar(25),@Date11,101)+''' AS N''Date'' '
				--CONTINUE
			END
        END

----- Date10 --> Date01
    	IF @Date10 IS NOT NULL 
        BEGIN
        	IF  Convert(Date,@Date10) < Convert(Date,GETDATE()) AND 
        	(Isnull(@Quantity01,0) + Isnull(@Quantity02,0) + Isnull(@Quantity03,0)+ Isnull(@Quantity04,0) + Isnull(@Quantity05,0) + Isnull(@Quantity06,0)+Isnull(@Quantity07,0)+Isnull(@Quantity08,0)+Isnull(@Quantity09,0)+Isnull(@Quantity10,0)) > ISNULL(@ActualQuantity,0)
        	BEGIN     	
				IF ISNULL(@sSQL,'') <> ''
					SET @sSQL  = @sSQL + 'Union
					'
				SET @sSQL = @sSQL + 'SELECT '''+@POrderID+''' as N''POrderID'', '''+convert(nvarchar(25),@Date10,101)+''' AS N''Date'' '
				--CONTINUE
			END
        END
    	IF @Date09 IS NOT NULL 
        BEGIN
        	IF  Convert(Date,@Date09) < Convert(Date,GETDATE()) AND 
        	(Isnull(@Quantity01,0) + Isnull(@Quantity02,0) + Isnull(@Quantity03,0)+ Isnull(@Quantity04,0) + Isnull(@Quantity05,0) + Isnull(@Quantity06,0)+Isnull(@Quantity07,0)+Isnull(@Quantity08,0)+Isnull(@Quantity09,0)) > ISNULL(@ActualQuantity,0)
        	BEGIN     	
				IF ISNULL(@sSQL,'') <> ''
					SET @sSQL  = @sSQL + 'Union
					'
				SET @sSQL = @sSQL + 'SELECT '''+@POrderID+''' as N''POrderID'', '''+convert(nvarchar(25),@Date09,101)+''' AS N''Date'' '
				--CONTINUE
			END
        END
    	IF @Date08 IS NOT NULL 
        BEGIN
        	IF  Convert(Date,@Date08) < Convert(Date,GETDATE()) AND 
        	(Isnull(@Quantity01,0) + Isnull(@Quantity02,0) + Isnull(@Quantity03,0)+ Isnull(@Quantity04,0) + Isnull(@Quantity05,0) + Isnull(@Quantity06,0)+Isnull(@Quantity07,0)+Isnull(@Quantity08,0)) > ISNULL(@ActualQuantity,0)
        	BEGIN     	
				IF ISNULL(@sSQL,'') <> ''
					SET @sSQL  = @sSQL + 'Union
					'
				SET @sSQL = @sSQL + 'SELECT '''+@POrderID+''' as N''POrderID'', '''+convert(nvarchar(25),@Date08,101)+''' AS N''Date'' '
				--CONTINUE
			END
        END
    	IF @Date07 IS NOT NULL 
        BEGIN
        	IF  Convert(Date,@Date07) < Convert(Date,GETDATE()) AND 
        	(Isnull(@Quantity01,0) + Isnull(@Quantity02,0) + Isnull(@Quantity03,0)+ Isnull(@Quantity04,0) + Isnull(@Quantity05,0) + Isnull(@Quantity06,0)+Isnull(@Quantity07,0)) > ISNULL(@ActualQuantity,0)
        	BEGIN     	
				IF ISNULL(@sSQL,'') <> ''
					SET @sSQL  = @sSQL + 'Union
					'
				SET @sSQL = @sSQL + 'SELECT '''+@POrderID+''' as N''POrderID'', '''+convert(nvarchar(25),@Date07,101)+''' AS N''Date'' '
				--CONTINUE
			END
        END
    	IF @Date06 IS NOT NULL 
        BEGIN
        	IF  Convert(Date,@Date06) < Convert(Date,GETDATE()) AND 
        	(Isnull(@Quantity01,0) + Isnull(@Quantity02,0) + Isnull(@Quantity03,0)+ Isnull(@Quantity04,0) + Isnull(@Quantity05,0) + Isnull(@Quantity06,0)) > ISNULL(@ActualQuantity,0)
        	BEGIN     	
				IF ISNULL(@sSQL,'') <> ''
					SET @sSQL  = @sSQL + 'Union
					'
				SET @sSQL = @sSQL + 'SELECT '''+@POrderID+''' as N''POrderID'', '''+convert(nvarchar(25),@Date06,101)+''' AS N''Date'' '
				--CONTINUE
			END
        END
    	IF @Date05 IS NOT NULL 
        BEGIN
        	IF  Convert(Date,@Date05) < Convert(Date,GETDATE()) AND (Isnull(@Quantity01,0) + Isnull(@Quantity02,0) + Isnull(@Quantity03,0)+ Isnull(@Quantity04,0) + Isnull(@Quantity05,0)) > ISNULL(@ActualQuantity,0)
        	BEGIN     	
				IF ISNULL(@sSQL,'') <> ''
					SET @sSQL  = @sSQL + 'Union
					'
				SET @sSQL = @sSQL + 'SELECT '''+@POrderID+''' as N''POrderID'', '''+convert(nvarchar(25),@Date05,101)+''' AS N''Date'' '
				--CONTINUE
			END
        END
    	IF @Date04 IS NOT NULL 
        BEGIN
        	IF  Convert(Date,@Date04) < Convert(Date,GETDATE()) AND (Isnull(@Quantity01,0) + Isnull(@Quantity02,0) + Isnull(@Quantity03,0) + Isnull(@Quantity04,0)) > ISNULL(@ActualQuantity,0)
        	BEGIN     	
				IF ISNULL(@sSQL,'') <> ''
					SET @sSQL  = @sSQL + 'Union
					'
				SET @sSQL = @sSQL + 'SELECT '''+@POrderID+''' as N''POrderID'', '''+convert(nvarchar(25),@Date04,101)+''' AS N''Date'' '
				--CONTINUE
			END
        END
        IF @Date03 IS NOT NULL 
        BEGIN
        	
        	IF  Convert(Date,@Date03) < Convert(Date,GETDATE()) AND (Isnull(@Quantity01,0) + Isnull(@Quantity02,0) + Isnull(@Quantity03,0)) > ISNULL(@ActualQuantity,0)
        	BEGIN     	
				IF ISNULL(@sSQL,'') <> ''
					SET @sSQL  = @sSQL + 'Union
					'
				SET @sSQL = @sSQL + 'SELECT '''+@POrderID+''' as N''POrderID'', '''+convert(nvarchar(25),@Date03,101)+''' AS N''Date'' '
				--CONTINUE
        	END
        	
        END
        IF @Date02 IS NOT NULL 
        BEGIN
        	IF  Convert(Date,@Date02) < Convert(Date,GETDATE()) AND (Isnull(@Quantity01,0) + Isnull(@Quantity02,0)) > ISNULL(@ActualQuantity,0)
        	BEGIN     	
				IF ISNULL(@sSQL,'') <> ''
					SET @sSQL  = @sSQL + 'Union
					'
				SET @sSQL = @sSQL + 'SELECT '''+@POrderID+''' as N''POrderID'', '''+convert(nvarchar(25),@Date02,101)+''' AS N''Date'' '
				--CONTINUE
			END
        END
        IF @Date01 IS NOT NULL 
        BEGIN
        	IF  Convert(Date,@Date01) < Convert(Date,GETDATE()) AND Isnull(@Quantity01,0) > ISNULL(@ActualQuantity,0)
        	BEGIN     	
				IF ISNULL(@sSQL,'') <> ''
					SET @sSQL  = @sSQL + 'Union
					'
				SET @sSQL = @sSQL + 'SELECT '''+@POrderID+''' as N''POrderID'', '''+convert(nvarchar(25),@Date01,101)+''' AS N''Date'' '
				--CONTINUE
			END
        END        
										
        FETCH NEXT FROM @Cur INTO @POrderID, @ActualQuantity, @EndQuantity, @Quantity01, @Quantity02, @Quantity03, @Quantity04, @Quantity05, @Quantity06, @Quantity07, @Quantity08, @Quantity09, @Quantity10, 
	@Quantity11, @Quantity12, @Quantity13, @Quantity14, @Quantity15, @Quantity16, @Quantity17, @Quantity18, @Quantity19, @Quantity20, 
	@Quantity21, @Quantity22, @Quantity23, @Quantity24, @Quantity25, @Quantity26, @Quantity27, @Quantity28, @Quantity29, @Quantity30, 
	@Date01, @Date02, @Date03, @Date04, @Date05, @Date06, @Date07, @Date08, @Date09, @Date10,
	@Date11, @Date12, @Date13, @Date14, @Date15, @Date16, @Date17, @Date18, @Date19, @Date20,
	@Date21, @Date22, @Date23, @Date24, @Date25, @Date26, @Date27, @Date28, @Date29, @Date30
    END
CLOSE @Cur	

--PRINT @sSQL
IF ISNULL(@sSQL,'') <> ''
	SET @sSQL1  = 'SELECT POrderID, CONVERT(DATETIME,MIN(Date),120) as N''Date'' FROM ('+@sSQL+') as A 
				   GROUP BY POrderID'
--PRINT @sSQL1
EXEC (@sSQL1)	

*/

SELECT	OT3002.InventoryID, OT3001.POrderID, 
		Isnull(OV2902.ActualQuantity,0) AS ActualQuantity, OV2902.EndQuantity, 
		OT3002.TransactionID,
		OT3002.Quantity01, OT3002.Quantity02, OT3002.Quantity03, OT3002.Quantity04, 
		OT3002.Quantity05, OT3002.Quantity06, OT3002.Quantity07, OT3002.Quantity08, OT3002.Quantity09, OT3002.Quantity10, 
		OT3002.Quantity11, OT3002.Quantity12, OT3002.Quantity13, OT3002.Quantity14, OT3002.Quantity15, OT3002.Quantity16, OT3002.Quantity17, OT3002.Quantity18, 
		OT3002.Quantity19, OT3002.Quantity20, 
		OT3002.Quantity21, OT3002.Quantity22, OT3002.Quantity23, OT3002.Quantity24, OT3002.Quantity25, OT3002.Quantity26, OT3002.Quantity27, OT3002.Quantity28, 
		OT3002.Quantity29, OT3002.Quantity30, 
		OT3003.Date01, OT3003.Date02, OT3003.Date03, OT3003.Date04, OT3003.Date05, OT3003.Date06, OT3003.Date07, OT3003.Date08, OT3003.Date09, OT3003.Date10,
		OT3003.Date11, OT3003.Date12, OT3003.Date13, OT3003.Date14, OT3003.Date15, OT3003.Date16, OT3003.Date17, OT3003.Date18, OT3003.Date19, OT3003.Date20,
		OT3003.Date21, OT3003.Date22, OT3003.Date23, OT3003.Date24, OT3003.Date25, OT3003.Date26, OT3003.Date27, OT3003.Date28, OT3003.Date29, OT3003.Date30,		
		COnvert (Decimal(28,8),0) AS QUTY,
		Convert(Datetime,'1900-01-01') AS MAXDAY
INTO #OT3003_AT3206_AG
FROM OT3003 WITH (NOLOCK)
LEFT JOIN OT3001 WITH (NOLOCK) ON OT3001.DivisionID = OT3003.DivisionID AND OT3001.POrderID = OT3003.POrderID
LEFT JOIN OT3002 WITH (NOLOCK) ON OT3002.DivisionID = OT3001.DivisionID AND OT3002.POrderID = OT3001.POrderID
Inner Join AT1302 WITH (NOLOCK) on AT1302.InventoryID = OT3002.InventoryID and AT1302.DivisionID IN ('@@@', OT3002.DivisionID)
LEFT JOIN OV2902 ON OV2902.DivisionID = OT3002.DivisionID AND OV2902.POrderID = OT3002.POrderID AND OV2902.TransactionID = OT3002.TransactionID
WHERE OT3001.DivisionID = @DivisionID
	AND OrderType = 0	 
	AND OT3002.Finish = 0 
	AND Isnull (AT1302.IsStocked,0) = 1 
	AND OV2902.EndQuantity > 0
	AND OT3001.POrderID LIKE CASE WHEN Isnull(@POrderID,'') = '' THEN '%' ELSE @POrderID END 



DECLARE @i int, @n int,
@si varchar(2), @Sql Nvarchar(2000)

SELECT @i = 1, @n = 30

WHILE (@i <=@n)
BEGIN
	select @si = case when @i < 10 then '0'+Convert(varchar(1),@i) else convert(varchar(2),@i) end
	
	set @sql = N'

	Update #OT3003_AT3206_AG
	Set QUTY = isnull(QUTY,0) + Isnull(Quantity'+@si+',0)
	Where Date'+@si+' <= GetDate()



	Update #OT3003_AT3206_AG
	Set MAXDAY = Date'+@si+'
	Where Datediff (d,Date'+@si+',GetDate()) < Datediff (d,MAXDAY,GetDate()) 
	and Date'+@si+' <= GetDate()
	'
	--print (@sql)
	exec(@sql)

	set @i = @i + 1
END

SELECT distinct POrderID, MAXDAY as Date 
FROM #OT3003_AT3206_AG 
WHERE isnull(QUTY,0) > isnull(ActualQuantity,0)


DROP TABLE #OT3003_AT3206_AG 

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
