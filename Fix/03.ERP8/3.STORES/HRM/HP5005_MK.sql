IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP5005_MK]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[HP5005_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


----Created by: Vo Thanh Huong
----Created date: 20/08/2004
----purpose: Tinh cac khoan giam tru duoc ket chuyen -----duoc goi tu HP5000, chua xu ly cac khoan giam tru tinh bang loai tien te khac VND
--- Modify on 08/01/2014 by Bảo Anh: Cải thiện tốc độ (câu tạo cursor không join HT2461, dùng biến kiểu table thay cho HV5555)
--- Modify on 08/06/2016 by Bảo Anh: Cải thiện tốc độ (chỉ update khoản giảm trừ đang tính, không update hết)
--- Modify on 01/03/2017 by Phương Thảo: Cải tiến tốc độ (bỏ vòng lặp)
/********************************************
'* Edited by: [GS] [Minh Lâm] [02/08/2010]
'********************************************/
CREATE PROCEDURE [dbo].[HP5005_MK]
       @PayrollMethodID nvarchar(50) ,
       @DivisionID nvarchar(50) ,
       @TranMonth int ,
       @TranYear int ,
       @SubID nvarchar(50) ,
       @Orders int ,
       @SourceFieldName nvarchar(250) ,
       @SourceTableName nvarchar(250) ,
       @DepartmentID1 AS nvarchar(50) ,
       @TeamID1 AS nvarchar(50)
AS
DECLARE
        @sSQL nvarchar(4000) ,
        @SalaryAmount decimal(28,8) ,
        @cur cursor ,
        @TransactionID nvarchar(50) ,
        @EmployeeID nvarchar(50) ,
        @DepartmentID nvarchar(50) ,
        @TeamID nvarchar(50)
        
Declare @ST Table(SalaryAmount decimal(28,8))


IF ( Isnull(@SourceFieldName , '') NOT LIKE '' ) AND ( Isnull(@SourceTableName , '') NOT LIKE '' )
BEGIN							
    SET @sSQL = '
	SELECT  T1.DivisionID, T1.EmployeeID, Sum(Isnull(T1.' + @SourceFieldName + ', 0)) as SalaryAmount		
	INTO #HP5005_MK_SubAmount 
	FROM ' + @SourceTableName + ' T1
	INNER JOIN HT3400 T2 ON T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID AND T1.TranMonth = T2.TranMonth AND T1.TranYear = T2.TranYear
	WHERE T1.DivisionID = ''' + @DivisionID + ''' 		
		AND T1.DepartmentID LIKE ''' + @DepartmentID1 + ''' 
		AND	isnull(T1.TeamID, '''') LIKE ''' + isnull(@TeamID1 , '') + ''' 
		AND T1.TranMonth = ' + str(@TranMonth) + ' 
		AND	T1.TranYear = ' + str(@TranYear) +'
	GROUP BY 	T1.DivisionID, T1.EmployeeID

	UPDATE T1 
	SET SubAmount' + (case when @Orders < 10 then '0' else '' end) + ltrim(@Orders) + ' = T2.SalaryAmount
	FROM HT3400 T1
	INNER JOIN  #HP5005_MK_SubAmount T2 ON  T1.DivisionID = T2.DivisionID AND T1.EmployeeID = T2.EmployeeID
	WHERE T1.DivisionID = ''' + @DivisionID + ''' 
	AND T1.PayrollMethodID = ''' + @PayrollMethodID + '''
	AND TranMonth = ' + str(@TranMonth) + ' 
	AND	TranYear = ' + str(@TranYear) +'

	'
	print @sSQL
	EXEC (@sSQL)
								
END
		
--IF @DepartmentID1 = '%'
--   BEGIN

   

--         SET @cur = CURSOR SCROLL KEYSET FOR SELECT
--                                                 HT34.TransactionID ,
--                                                 HT34.EmployeeID ,
--                                                 HT34.DepartmentID ,
--                                                 HT34.TeamID
--                                             FROM
--                                                 HT3400 HT34 ---LEFT JOIN HT2461 HT24
--                                             ---ON  HT34.EmployeeID = HT24.EmployeeID AND HT34.DivisionID = HT24.DivisionID AND HT34.DepartmentID = HT24.DepartmentID AND ISNull(HT34.TeamID , '') LIKE ISNull(HT24.TeamID , '') AND HT34.TranMonth = HT24.TranMonth AND HT34.TranYear = HT24.TranYear
--                                             WHERE
--                                                 HT34.PayrollMethodID = @PayrollMethodID AND HT34.TranMonth = @TranMonth AND HT34.TranYear = @TranYear AND HT34.DivisionID = @DivisionID AND HT34.DepartmentID like @DepartmentID1 and Isnull(HT34.TeamID,'') like @TeamID1
--         OPEN @cur
--         FETCH next FROM @cur INTO @TransactionID,@EmployeeID,@DepartmentID,@TeamID
--         WHILE @@FETCH_STATUS = 0
--               BEGIN
--                     SET @SalaryAmount = 0
--                     IF ( Isnull(@SourceFieldName , '') NOT LIKE '' ) AND ( Isnull(@SourceTableName , '') NOT LIKE '' )
--                        BEGIN							
--                            SET @sSQL = 'Select  Sum(Isnull(' + @SourceFieldName + ', 0)) as SalaryAmount		 
--											From ' + @SourceTableName + '
--											Where DivisionID = ''' + @DivisionID + ''' and 
--												EmployeeID  = ''' + @EmployeeID + ''' and 
--												DepartmentID = ''' + @DepartmentID + ''' and
--												isnull(TeamID, '''') = ''' + isnull(@TeamID , '') + ''' and 
--												TranMonth = ' + str(@TranMonth) + ' and
--												TranYear = ' + str(@TranYear)

--                            Insert into @ST(SalaryAmount) EXEC(@sSQL)
--							SELECT @SalaryAmount = SalaryAmount from @ST

							
--							SET @sSQL = 'UPDATE HT3400 SET SubAmount' + (case when @Orders < 10 then '0' else '' end) + ltrim(@Orders) + ' = ' + ltrim(@SalaryAmount) + '
--									WHERE DivisionID = ''' + @DivisionID + ''' AND PayrollMethodID = ''' + @PayrollMethodID + ''' AND TransactionID = ''' + @TransactionID + ''''
							
--							EXEC(@sSQL)
								
--                            FETCH next FROM @cur INTO @TransactionID,@EmployeeID,@DepartmentID,@TeamID
--                        END
--               END
--         CLOSE @cur

--   END
--ELSE -------------------------------------------------@DepartmentID1<>'%'----------------------------------------

--   BEGIN

--         SET @cur = CURSOR SCROLL KEYSET FOR SELECT
--                                                 HT34.TransactionID ,
--                                                 HT34.EmployeeID ,
--                                                 HT34.DepartmentID ,
--                                                 HT34.TeamID
--                                             FROM
--                                                 HT3400 HT34 ---LEFT JOIN HT2461 HT24
--                                             ---ON  HT34.EmployeeID = HT24.EmployeeID AND HT34.DivisionID = HT24.DivisionID AND HT34.DepartmentID = HT24.DepartmentID AND ISNull(HT34.TeamID , '') LIKE ISNull(HT24.TeamID , '') AND HT34.TranMonth = HT24.TranMonth AND HT34.TranYear = HT24.TranYear
--                                             WHERE
--                                                 HT34.PayrollMethodID = @PayrollMethodID AND HT34.TranMonth = @TranMonth AND HT34.TranYear = @TranYear AND HT34.DivisionID = @DivisionID AND HT34.DepartmentID LIKE @DepartmentID1 AND IsNull(HT34.TeamID , '') LIKE IsNull(@TeamID1 , '')
--												 --AND HT34.DepartmentID IN ( SELECT
--													--							DepartmentID
--													--						FROM
--													--							HT5004
--													--						WHERE
--													--							PayrollMethodID = @PayrollMethodID )

--         OPEN @cur
--         FETCH next FROM @cur INTO @TransactionID,@EmployeeID,@DepartmentID,@TeamID
--         WHILE @@FETCH_STATUS = 0
--               BEGIN
--                     SET @SalaryAmount = 0
--                     IF ( Isnull(@SourceFieldName , '') NOT LIKE '' ) AND ( Isnull(@SourceTableName , '') NOT LIKE '' )
--                        BEGIN							
--							SET @sSQL = 'Select round(Sum(Isnull(' + @SourceFieldName + ', 0)),0) as SalaryAmount		 
--											From ' + @SourceTableName + '
--											Where DivisionID = ''' + @DivisionID + ''' and 
--												DepartmentID = ''' + @DepartmentID1 + ''' and 
--												IsNull(TeamID,'''') like  ''' + @TeamID1 + ''' and 
--												EmployeeID  = ''' + @EmployeeID + ''' and
--												TranMonth = ' + str(@TranMonth) + ' and
--												TranYear = ' + str(@TranYear)
--							Insert into @ST(SalaryAmount) EXEC(@sSQL)
--							SELECT @SalaryAmount = SalaryAmount from @ST
								
--							SET @sSQL = 'UPDATE HT3400 SET SubAmount' + (case when @Orders < 10 then '0' else '' end) + ltrim(@Orders) + ' = ' + ltrim(@SalaryAmount) + '
--									WHERE DivisionID = ''' + @DivisionID + ''' AND PayrollMethodID = ''' + @PayrollMethodID + ''' AND TransactionID = ''' + @TransactionID + ''''
							
--							EXEC(@sSQL)

--							FETCH next FROM @cur INTO @TransactionID,@EmployeeID,@DepartmentID,@TeamID
--                        END
--               END
--         CLOSE @cur

--   END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
