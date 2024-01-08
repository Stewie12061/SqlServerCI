IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[HP2401_MK]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[HP2401_MK]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



----Created by: Vo Thanh Huong, date: 06/09/2004
----purpose: Luu ch?m công ngày khi thêm m?i
--- Modify on 04/08/2013 by Bao Anh: Bo sung tinh so cong theo dieu kien (Hung Vuong)
--- Modify on 20/05/2014 by Tri Thien: Cho phép ghi đè dữ liệu chấm công khi import
--- Modified on 28/12/2016 by Bao Thy: tách bảng HT2400, HT2401 (MEIKO)
/********************************************
'* Edited by: [GS] [Mỹ Tuyền] [30/07/2010]
'********************************************/

CREATE PROCEDURE [dbo].[HP2401_MK] 	@DivisionID as nvarchar(50),
				@DepartmentID as nvarchar(50),
				@TeamID as nvarchar(50),
				@EmployeeID as nvarchar(50),
				@TranMonth as int,
				@TranYear as int,
				@FromDate as datetime,
				@ToDate as datetime,
				@AbsentTypeID as nvarchar(50),
				@AbsentAmount as decimal(28,8),
				@CreateUserID as nvarchar(50)

AS
DECLARE 	@sSQL as nvarchar(4000),
			@cur as cursor,
			@i as int,
			@j as int,
			@AbsentDate as datetime,
			@TeamID1 nvarchar(50),
			@BeginDate datetime,
			@EndDate datetime,
			@IsCondition tinyint,
			@ConditionCode nvarchar(4000),
			@ConditionAmount decimal(28,8),
			@TableHT2400 VARCHAR(50),
			@TableHT2401 VARCHAR(50),
			@sTranMonth VARCHAR(2),
			@sSQL01 NVARCHAR(MAX)=''

Set @ConditionAmount = 0


Select @BeginDate = BeginDate,  @EndDate = EndDate
From HT9999 
Where DivisionID = @DivisionID and
	TranMonth = @TranMonth and
	TranYear = @TranYear

SELECT @sTranMonth = CASE WHEN @TranMonth >9 THEN Convert(Varchar(2),@TranMonth) ELSE '0'+Convert(Varchar(1),@TranMonth) END

IF EXISTS (SELECT TOP 1 1 FROM AT0001 WITH (NOLOCK) WHERE IsSplitTable = 1)	
BEGIN
	SELECT  @TableHT2400 = 'HT2400M'+@sTranMonth+Convert(Varchar(4),@TranYear)
	SELECT  @TableHT2401 = 'HT2401M'+@sTranMonth+Convert(Varchar(4),@TranYear)
END
ELSE
BEGIN
	SELECT  @TableHT2400 = 'HT2400',
			@TableHT2401 = 'HT2401'
END

--- Bo sung tinh so cong theo dieu kien duoc thiet lap trong danh muc loai cong ngay (yeu cau cua Hung Vuong)
SELECT
     @IsCondition = IsCondition ,
     @ConditionCode = ConditionCode
FROM
     HT1013
WHERE
     DivisionID = @DivisionID AND AbsentTypeID = @AbsentTypeID

IF @IsCondition = 1 and ISNULL(@ConditionCode,'') <> ''
	BEGIN
		EXEC HP5556 @AbsentAmount , @ConditionCode , @ConditionAmount OUTPUT
		SET @AbsentAmount = @ConditionAmount
	END
	 
Set @sSQL = '
Select DivisionID, DepartmentID, TeamID, EmployeeID
From '+@TableHT2400+'
Where DivisionID = ''' + @DivisionID + ''' and
	DepartmentID like ''' + @DepartmentID + ''' and
	isnull(TeamID,'''') like ''' + @TeamID + ''' and
	EmployeeID like ''' + @EmployeeID + ''' and 
	TranYear = ' + cast(@TranYear as nvarchar(4)) + ' and TranMonth = ' + cast(@TranMonth as nvarchar(2))

If not Exists (Select 1 From  sysObjects Where Xtype ='V' and Name ='HV2401')
	Exec(' Create view HV2401 as '+@sSQL)
Else
	Exec(' Alter view HV2401 as '+@sSQL)

Set @j = DATEDIFF(day, @FromDate, @ToDate) + 1

SET @cur = CURSOR SCROLL KEYSET FOR
		SELECT *
		FROM HV2401 where DivisionID = @DivisionID
	OPEN @cur
	FETCH NEXT FROM @cur INTO @DivisionID, @DepartmentID, @TeamID1, @EmployeeID

	WHILE @@FETCH_STATUS = 0
	  BEGIN
		Set @i = 1	
		Set @AbsentDate = @FromDate
		WHILE @i <= @j
			BEGIN	
				--IF not Exists(SELECT EmployeeID FROM HT2401 
				--			WHERE EmployeeID = @EmployeeID and 
				--					DivisionID = @DivisionID and 
				--					DepartmentID = @DepartmentID  and
				--					isnull(TeamID, '') = isnull(@TeamID1,'')	 and
				--					TranMonth=@TranMonth And TranYear=@TranYear and
				--					 AbsentDate = @AbsentDate and 
				--					AbsentTypeID = @AbsentTypeID)
				--IF exists (Select EmployeeID From HT2400
				--		WHERE EmployeeID = @EmployeeID and 
				--					DivisionID = @DivisionID and 
				--					DepartmentID = @DepartmentID and 
				--					isnull(TeamID, '')=  isnull(@TeamID1,'') and 
				--					TranMonth=@TranMonth And TranYear=@TranYear and
				--					@AbsentDate between isnull(FromDateTranFer, @BeginDate) and 
				--							isnull(ToDateTranfer, @EndDate))			  									
				--	Insert into HT2401 (AbsentDate, EmployeeID, DivisionID, TranMonth, TranYear, DepartmentID,
				--		TeamID, AbsentTypeID, AbsentAmount, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID)
				--	Values (@AbsentDate, @EmployeeID, @DivisionID, @TranMonth, @TranYear,
				--		@DepartmentID, @TeamID1, @AbsentTypeID, @AbsentAmount, getdate(),getdate(),
				--		@CreateUserID, @CreateUserID)

				-- Kiem tra ho so luong co ton tai hay khong
				SET @sSQL01 = '
				IF EXISTS (SELECT EmployeeID From '+@TableHT2400+'
						WHERE EmployeeID = '''+@EmployeeID+''' AND DivisionID = '''+@DivisionID+''' AND DepartmentID = '''+@DepartmentID+'''
						AND ISNULL(TeamID, '''')=  '''+ISNULL(@TeamID1,'')+''' AND TranMonth='+STR(@TranMonth)+' AND TranYear='+STR(@TranYear)+'
						AND '''+CONVERT(VARCHAR(10),@AbsentDate,120)+''' BETWEEN ISNULL(FromDateTranFer, '''+CONVERT(VARCHAR(10),@BeginDate,120)+''') AND ISNULL(ToDateTranfer, '''+CONVERT(VARCHAR(10),@EndDate,120)+'''))	
						BEGIN
							-- Kiem tra da ton tai thong tin cham cong nay chua
							--IF NOT EXISTS(	SELECT EmployeeID
							--                FROM HT2401 
							--				WHERE EmployeeID = @EmployeeID AND DivisionID = @DivisionID AND DepartmentID = @DepartmentID
							--					AND ISNULL(TeamID, '') = ISNULL(@TeamID1,'') AND TranMonth=@TranMonth AND TranYear=@TranYear 
							--					AND AbsentDate = @AbsentDate AND AbsentTypeID = @AbsentTypeID)
									-- Them moi du lieu cham cong neu chua ton tai
									Insert into '+@TableHT2401+' (AbsentDate, EmployeeID, DivisionID, TranMonth, TranYear, DepartmentID,
														TeamID, AbsentTypeID, AbsentAmount, CreateDate, LastModifyDate, CreateUserID, LastModifyUserID)
									Values ('''+CONVERT(VARCHAR(10),@AbsentDate,120)+''', '''+@EmployeeID+''', '''+@DivisionID+''', '+STR(@TranMonth)+', '+STR(@TranYear)+', 
									'''+@DepartmentID+''', '''+ISNULL(@TeamID1,'')+''', '''+@AbsentTypeID+''', '''+CONVERT(VARCHAR(50),@AbsentAmount)+''', getdate(),getdate(), '''+@CreateUserID+''', '''+@CreateUserID+''')
							--ELSE
							--	-- Cap nhat thong tin cham cong neu da ton tai
							--	UPDATE HT2401 
							--	SET AbsentAmount = @AbsentAmount, LastModifyDate = getdate(), LastModifyUserID = @CreateUserID
							--	WHERE EmployeeID = @EmployeeID AND DivisionID = @DivisionID AND DepartmentID = @DepartmentID
							--		AND ISNULL(TeamID, '') = ISNULL(@TeamID1,'') AND TranMonth=@TranMonth AND TranYear=@TranYear 
							--		AND AbsentDate = @AbsentDate AND AbsentTypeID = @AbsentTypeID 
						END
					'
					--PRINT (@sSQL01)
					EXEC (@sSQL01)
				SET @AbsentDate = DATEADD(day, 1, @AbsentDate)
				SET @i = @i + 1
			END

		FETCH NEXT FROM @cur INTO @DivisionID, @DepartmentID, @TeamID1, @EmployeeID
  	  END
	CLOSE @cur
	DEALLOCATE @cur


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

