IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[HP5104]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP5104]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/********************************************
'* Edited by: [GS] [Minh Lâm] [02/08/2010]
'********************************************/
----Create by: Dang Le Bao Quynh; Date: 15/06/2006
----Puspose: Tinh khoan thu nhap tong hop
---- Modified by Bảo Thy on 07/12/2016: bổ sung 150 hệ số, 150 khoản thu nhập cho MEIKO
---- Modify on 01/03/2017 by Phương Thảo: Cải tiến tốc độ
---- Modify on 10/07/2018 by Bảo Anh: Where thêm PayrollMethodID khi lấy dữ liệu từ HT3400
---- Modify on 03/07/2019 by Kim Thư: Bổ sung kiểm tra mã khoản thu nhập để tránh bị lỗi khi convert
---- Modify on 11/07/2019 by Kim Thư: Sửa lỗi khoản thu nhập Type=B
---- Modify on 01/04/2022 by Nhật Thanh: Customize tính toán cho angel

CREATE PROCEDURE [dbo].[HP5104]
       @PayrollMethodID nvarchar(50) ,
       @TranMonth int ,
       @TranYear int ,
       @EmployeeID nvarchar(50) ,
       @IncomeID nvarchar(50) ,
       @IsIncome AS tinyint ,
       @DivisionID nvarchar(50) ,
       @DepartmentID nvarchar(50) ,
       @TeamID nvarchar(50) ,
       @TransactionID nvarchar(50) ,
       @BaseSalary decimal(28,8) OUTPUT
AS
DECLARE
        @ProcessIdentifier int ,
        @cur cursor ,
        @Amount decimal(28,8) ,
        @BaseSalaryCalculate decimal(28,8) ,
        @DetailIncomeID nvarchar(50) ,
        @DivisionK nvarchar(50) ,
        @Orders int ,
        @Type char(1) ,
        @SQL nvarchar(4000),
		@CustomerIndex INT,
		@Table VARCHAR(MAX),
		@Where NVARCHAR(MAX) = '',
		@TableHT2400 Varchar(50),
		@sTranMonth Varchar(2)

SELECT @CustomerIndex = CustomerName FROM CustomerIndex

SET NOCOUNT ON
SET @ProcessIdentifier = @@SPID
SET @Orders = 0
SET @BaseSalaryCalculate = 0

--- Tách bảng nghiệp vụ
SELECT @sTranMonth = CASE WHEN @TranMonth >9 THEN Convert(Varchar(2),@TranMonth) ELSE '0'+Convert(Varchar(1),@TranMonth) END

IF EXISTS (SELECT TOP 1 1 FROM AT0001 WITH (NOLOCK) WHERE IsSplitTable = 1)	
BEGIN
	SELECT @TableHT2400 = 'HT2400M'+@sTranMonth+Convert(Varchar(4),@TranYear)
END
ELSE
BEGIN
	SELECT @TableHT2400 = 'HT2400'
END


IF @IsIncome = 1
   BEGIN     
         SET @cur = CURSOR FOR SELECT
                                   HT5008.IncomeID ,                             
                                   HV1116.Type
                               FROM
                                   HT5008 INNER JOIN HV1116
                               ON  HT5008.IncomeID = HV1116.BaseSalaryFieldID
                               WHERE
                                   HT5008.GeneralIncomeID IN ( SELECT
                                                                   BaseSalaryField
                                                               FROM
                                                                   HT5005
                                                               WHERE
                                                                   IncomeID = @IncomeID AND PayrollMethodID = @PayrollMethodID AND DivisionID = @DivisionID )
  
   END
   
ELSE
   BEGIN 
         SET @cur = CURSOR FOR SELECT
                                   HT5008.IncomeID ,
                                   HV1116.Type
                               FROM
                                   HT5008 INNER JOIN HV1116 
                               ON  HT5008.IncomeID = HV1116.BaseSalaryFieldID 
                               WHERE
                                   HT5008.GeneralIncomeID IN ( SELECT
                                                                   BaseSalaryField
                                                               FROM
                                                                   HT5006
                                                               WHERE
                                                                   SubID = @IncomeID AND PayrollMethodID = @PayrollMethodID AND DivisionID = @DivisionID )
 
   END

--Tao bang tam -- Edit by Trong Khanh
 CREATE TABLE #HTTemp
 (  
	EmployeeID Varchar(50),
	ColumnName decimal(28,8)
 )  
     
OPEN @cur
FETCH NEXT FROM @cur INTO @DetailIncomeID,@Type

WHILE @@FETCH_STATUS = 0
      BEGIN  
		DECLARE @i INT
		SET @i=(SELECT ASCII(Right(Left(@DetailIncomeID,2),1))) -- kiểm tra ký tự thứ 2 của mã thu nhập là số hay chữ (mã khoản thu nhập khai báo ở HF0225)

		IF @i BETWEEN 48 AND 57 -- là số
		BEGIN
			IF (Left(@DetailIncomeID,1) ='I' AND CONVERT(DECIMAL(28,8),stuff(@DetailIncomeID,1,1,'')) > 30)
				OR (Left(@DetailIncomeID,1) ='C' AND CONVERT(DECIMAL(28,8),stuff(@DetailIncomeID,1,1,'')) > 25 )
			BEGIN
				IF @Type ='B' SET @Table = 'HT2499 T2 LEFT JOIN '+@TableHT2400+'  T1 ON T1.EmployeeID = T2.EmployeeID AND T1.TranMonth = T2.TranMonth AND T1.TranYear = T2.TranYear'
				IF @Type ='I' SET @Table = 'HT3499 T2 LEFT JOIN HT3400 T1 ON T1.TransactionID = T2.TransactionID'
			END
			ELSE
			BEGIN
				IF @Type ='B' SET @Table = ''+@TableHT2400+'  T1'
				IF @Type ='I' SET @Table = 'HT3400 T1 '
				SET @Where = CASE WHEN @DepartmentID <> '%' THEN 'AND T1.DepartmentID = ''' + @DepartmentID + ''' ' ELSE '' END
				+CASE WHEN @TeamID <> '%' THEN 'AND isnull(T1.TeamID,''' + '%' + ''') = ''' + isnull(@TeamID , '%') + ''' ' ELSE '' END
				+CASE WHEN @EmployeeID <> '%' THEN 'AND T1.EmployeeID LIKE '''+@EmployeeID+''' ' ELSE '' END
			END
		END
		ELSE
		BEGIN
			IF @Type ='B' SET @Table = ''+@TableHT2400+'  T1'
			IF @Type ='I' SET @Table = 'HT3400 T1 '
			SET @Where = CASE WHEN @DepartmentID <> '%' THEN 'AND T1.DepartmentID = ''' + @DepartmentID + ''' ' ELSE '' END
			+CASE WHEN @TeamID <> '%' THEN 'AND isnull(T1.TeamID,''' + '%' + ''') = ''' + isnull(@TeamID , '%') + ''' ' ELSE '' END
			+CASE WHEN @EmployeeID <> '%' THEN 'AND T1.EmployeeID LIKE '''+@EmployeeID+''' ' ELSE '' END
		END
		
        IF @Type = 'B'
        BEGIN    
            SET @SQL = 'INSERT INTO #HTTemp 
						SELECT T1.EmployeeID, isnull(' + @DetailIncomeID + ',0)  AS ColumnName  
						FROM '+@Table+' WHERE T1.DivisionID = '''+@DivisionID+''' 								  
						AND T1.TranMonth=' + STR(@TranMonth) + ' AND T1.TranYear=' + STR(@TranYear) + ' '+@Where+' '
			
            EXEC ( @SQL )
			
		--SET @Amount=(SELECT ColumnName FROM HD5104)
		--SET @BaseSalaryCalculate=@BaseSalaryCalculate + Isnull(@Amount,0)
        END
        IF @Type = 'I'
		BEGIN  
				IF  (CONVERT(DECIMAL(28,8),stuff(@DetailIncomeID,1,1,'')) > 99             )
					SET @SQL = 'INSERT INTO #HTTemp 
								SELECT T1.EmployeeID, isnull(Income' + RIGHT(@DetailIncomeID , 3) + ',0)  AS ColumnName 
								FROM '+@Table+' WHERE  T1.DivisionID = '''+@DivisionID+''' 
								AND T1.TranMonth=' + STR(@TranMonth) + ' AND T1.TranYear=' + STR(@TranYear) + '
								AND T1.PayrollMethodID like ''' + @PayrollMethodID + ''' 
								'+@Where+''
				ELSE
				BEGIN
					IF CONVERT(DECIMAL(28,8),stuff(@DetailIncomeID,1,1,'')) < 100    
						SET @SQL = 'INSERT INTO #HTTemp 
									SELECT T1.EmployeeID, isnull(Income' + RIGHT(@DetailIncomeID , 2) + ',0)  AS ColumnName 
									FROM '+@Table+' WHERE  T1.DivisionID = '''+@DivisionID+''' 
									AND T1.TranMonth=' + STR(@TranMonth) + ' AND T1.TranYear=' + STR(@TranYear) + '
									AND T1.PayrollMethodID like ''' + @PayrollMethodID + ''' 
									'+@Where+''
				END
                EXEC ( @SQL )                   
					--print @DetailIncomeID + @SQL
				--SET  @Amount= (SELECT ColumnName FROM HD5104)
				--SET @BaseSalaryCalculate=@BaseSalaryCalculate + Isnull(@Amount,0)
        END
         PRINT @SQL     
FETCH NEXT FROM @cur INTO @DetailIncomeID,@Type    
    
      END

CLOSE @cur
DEALLOCATE @cur


if @CustomerIndex =57 
begin
	SET @Amount = ( SELECT
						sum(ColumnName)
					FROM
						#HTTemp )
	SET @BaseSalary = Isnull(@Amount , 0)
end
else
begin
	UPDATE  T1
	SET		T1.BaseSalary = T2.ColumnName
	FROM #HP5103_HT3400 T1
	INNER JOIN 
	( SELECT EmployeeID, sum(ColumnName) AS ColumnName
	  FROM   #HTTemp 
	  GROUP BY EmployeeID
	  ) T2 ON T1.EmployeeID = T2.EmployeeID
end
--SET @Amount = ( SELECT
--                    sum(ColumnName)
--                FROM
--                    #HTTemp )
--SET @BaseSalary = Isnull(@Amount , 0)

--Xoa Bang tam
DROP TABLE #HTTemp

SET NOCOUNT OFF



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

