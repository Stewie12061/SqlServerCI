IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HRMP2153]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HRMP2153]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Tổng hợp danh sách vào BlackList
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Huỳnh Thử, Date: 03/11/2020
----Update by: Huỳnh Thử, Date: 07/12/2020 -- Thay đổi TRIM thành LTRIM
----Update by: Huỳnh Thử, Date: 16/12/2020 -- LastModifyDate
-- <Example>
---- 
/*-- <Example>
    HRMP2152 @DivisionID = 'MK', @APK = 'ABCA3441-E076-4D28-88E5-04BF4480B9CB', @PageNumber = 1, @PageSize = 20
----*/
CREATE PROCEDURE [dbo].[HRMP2153]
AS
DECLARE @sSQL NVARCHAR (MAX),
		@VoucherNo NVARCHAR(50),
		@APK NVARCHAR(50),
		@Cur AS CURSOR,
		@AbsentTypeID NVARCHAR(50),
		@EmployeeID NVARCHAR(50),
		@AbsentAmount DECIMAL(28,8),
		--@TraMontInsert INT,
		--@TranYearInsert INT,
		@Operator NVARCHAR(50),
		@Value DECIMAL(28,8),
		@Description NVARCHAR(500),
		@DivisionID NVARCHAR(50),
		@TranMonth INT ,
		@TranYear INT ,
		@ListUserDelete NVARCHAR(MAX)
SELECT @DivisionID = DivisionID FROM AT0001
SET @TranMonth = MONTH(GETDATE())
SET @TranYear = YEAR(GETDATE())
SET @VoucherNo = 'DSBL/' +LTRIM(RTRIM(STR(@TranMonth)))+'/'+LTRIM(RTRIM(STR(@TranYear))+'/9999')
--SET @TraMontInsert = @TranMonth
--SET @TranYearInsert = @TranYear

	--IF(@TraMontInsert = 1)
	--BEGIN
	--	SET @TraMontInsert = 12
	--	SET @TranYearInsert = @TranYearInsert - 1
	--END
 --   ELSE
	--BEGIN
	--	SET @TraMontInsert = @TraMontInsert - 1
	--END 

	
	SELECT @APK = APK, @ListUserDelete = ListUserDelete FROM HRMT2150 WITH (NOLOCK) WHERE VoucherNo = @VoucherNo
	DELETE HRMT2151 WHERE ApkMaster = @APK
	--DELETE HRMT2150 WHERE Apk = @APK
	
	SELECT Value INTO #TempEmployeeID FROM dbo.StringSplit(@ListUserDelete, ',') 
		
		-- Thêm mới
		IF(ISNULL(@APK,'') = '')
		BEGIN
			   SET @APK = NEWID()
			   -- Insert master
				INSERT INTO HRMT2150 VALUES (@APK, @DivisionID,@VoucherNo,GETDATE(),@TranMonth,@TranYear,N'UNASSIGNED',getDate(),N'UNASSIGNED',getdate(),N'Tổng hợp',0,NULL)
				SELECT @APK = APK FROM HRMT2150 WITH (NOLOCK) WHERE VoucherNo = @VoucherNo
		END 
		ELSE -- Update LastModife
        BEGIN
            UPDATE HRMT2150 SET LastModifyDate = GETDATE() WHERE APK = @APK
        END
		
		SET @sSQL =''
			-- Vòng lặp theo thiết lập
			  SET @Cur = CURSOR SCROLL KEYSET FOR
			  SELECT ObjectID,FilterCondition,FilterContent,DescriptionDetail FROM ST2021 WITH (NOLOCK)
			  LEFT JOIN ST2020 WITH (NOLOCK) ON ST2020.APK = ST2021.APKMaster_ST2020
			  LEFT JOIN AT0099 WITH (NOLOCK) ON ST2020.TypeRules = AT0099.ID AND CodeMaster = 'TypeRules'
			  WHERE CONVERT(NVARCHAR(50),ST2020.EffectDate,111) <= CONVERT(NVARCHAR(50),GETDATE(),111)
			  AND CONVERT(NVARCHAR(50),GETDATE(),111) <= CONVERT(NVARCHAR(50),ST2020.ExpiryDate,111)  
			  
			  OPEN @Cur
			  FETCH NEXT FROM @Cur INTO  @AbsentTypeID, @Operator, @Value, @Description
			  WHILE @@Fetch_Status = 0 
			  BEGIN
				
			    --insert detail
				SET @sSQL += N'
					INSERT INTO HRMT2151 (DivisionID,APK,APKMaster,EmployeeID,DescriptionDetail,CreateUserID,CreateDate,LastModifyUserID,LastModifyDate)
					SELECT DivisionID,NEWID(),'''+@APK+''',EmployeeID,N'''+@Description+''',''UNASSIGNED'',GETDATE(),''UNASSIGNED'',GETDATE() 
					FROM HT2402 WITH (NOLOCK)
					WHERE AbsentTypeID = '''+@AbsentTypeID+''' AND AbsentAmount >= '+ STR(@Value)+' 
					AND TranMonth = '+STR(@TranMonth)+' AND TranYear = '+STR(@TranYear)+'
					AND EmployeeID NOT IN (select * From #TempEmployeeID)
				'
			
              FETCH NEXT FROM @Cur INTO  @AbsentTypeID, @Operator, @Value, @Description
			  END
			  CLOSE @Cur
			

EXEC (@sSQL)
PRINT (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
