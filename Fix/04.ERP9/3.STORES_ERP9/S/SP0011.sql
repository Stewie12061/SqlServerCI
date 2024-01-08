IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SP0011]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SP0011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Form thiết lập xét duyệt SF0010
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 18/12/2018z by Bảo Anh
----Editted on 26/03/2019 by Hoàng Vũ: Sửa theo yêu cầu Dev chỉ trả ra 1 dataset và distinct
----Editted on 22/05/2019 by Như Hàn: Sửa lại cách trả dữ liệu cũ
----Editted on 20/11/2023 by Thanh Lượng: Customize thêm trường SameLevels,IsSameLevels (KH GREE).
-- <Example>
---- 
/*
	SP0011 @DivisionID='NTY',@TypeID='DXP'

*/

CREATE PROCEDURE dbo.SP0011
(	
	@DivisionID VARCHAR(50),
	@TypeID VARCHAR(50)
)
AS
DECLARE @SQL1 VARCHAR(MAX),	--- Trả ra loại điều kiện áp dụng, số cấp và điều kiện xét duyệt cho mỗi cấp
		@SQL2 VARCHAR(MAX),	--- Trả ra danh sách lưới ở tab "Chưa thiết lập" 
		@SQL3 VARCHAR(MAX),	--- Trả ra danh sách lưới ở tab "Đã thiết lập"
		@ConditionTypeID VARCHAR(50),
		@ColumnID VARCHAR(50),
		@ColumnName VARCHAR(50),
		@TableID VARCHAR(50),
		@CustomerName VARCHAR(50)

SET @CustomerName = (Select CustomerName From CustomerIndex)

SELECT TOP 1 @ConditionTypeID = ConditionTypeID
FROM ST0010 WITH (NOLOCK)
WHERE DivisionID = @DivisionID AND TypeID = @TypeID

SELECT @ColumnID = ColumnID, @ColumnName = ColumnName, @TableID = TableID
FROM SV0010
WHERE TransactionTypeID = 'CONDList' AND TypeID = @ConditionTypeID

SET @SQL1 = '
SELECT	Distinct TypeID, Levels, CASE WHEN '+@CustomerName+' = 162 THEN SameLevels END as SameLevels, CASE WHEN '+@CustomerName+' = 162 THEN IsSameLevels END as IsSameLevels,
ST0010.DirectionTypeID, ConditionTypeID, IsApplyCondition
		--, CASE WHEN ISNULL(ConditionTypeID,'''') = '''' THEN 0 ELSE 1 END AS IsApplyCondition
		, LevelNo, ConditionFrom, ConditionTo, ST0010.IsAppCondition, ST0010.DataTypeID, ST0099.Description AS DataTypeName
FROM ST0010 WITH (NOLOCK)
LEFT JOIN ST0099 WITH (NOLOCK) ON ST0010.DataTypeID = ST0099.ID AND ST0099.CodeMaster = ''DataType''
WHERE ST0010.DivisionID = ''' + @DivisionID + ''' AND ST0010.TypeID = ''' + @TypeID + ''''

IF ISNULL(@TableID,'') = ''
BEGIN
	SET @SQL2 = 'SELECT NULL AS Orders, NULL AS ID, NULL AS Name, NULL AS IsSetting'
END
ELSE
BEGIN
	SET @SQL2 = '
	SELECT * FROM
	(
	SELECT	ROW_NUMBER() OVER (ORDER BY ' + @ColumnID + ') AS Orders,
			A.' + @ColumnID + ' AS ID, A.' + @ColumnName + ' AS Name, 0 AS IsSetting
	FROM ' + @TableID + ' A WITH (NOLOCK)
	WHERE A.DivisionID IN (''@@@'',''' + @DivisionID + ''') AND A.Disabled = 0
		AND NOT EXISTS (SELECT TOP 1 1 FROM ST0010 WITH (NOLOCK) WHERE DivisionID = ''' + @DivisionID + '''
					AND ID = A.' + @ColumnID + ' AND TypeID = ''' + @TypeID + ''')

	UNION ALL
	SELECT	ROW_NUMBER() OVER (ORDER BY ST0010.ID) AS Orders,
			ST0010.ID, A.' + @ColumnName + ' AS Name, 1 AS IsSetting
	FROM ST0010 WITH (NOLOCK)
	LEFT JOIN ' + @TableID + ' A WITH (NOLOCK) ON A.DivisionID IN (''@@@'',''' + @DivisionID + ''') AND A.' + @ColumnID + ' = ST0010.ID
	WHERE ST0010.DivisionID = ''' + @DivisionID + '''
		AND ST0010.TypeID = ''' + @TypeID + '''
	) KQ
	ORDER BY IsSetting, ID'
END

EXEC(@SQL1)
EXEC(@SQL2)
--Print (@SQL1)
--Print (@SQL2)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
