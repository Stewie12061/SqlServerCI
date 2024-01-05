IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SP0010]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SP0010]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Grid Form thiết lập xét duyệt SF0010: Danh sách điều kiện đã thiết lập/ chưa thiết lập
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 18/12/2018z by Bảo Anh
----Modified on 04/07/2019 by Như Hàn: Sửa để không hiển thị dòng null khi load lên màn hình thiết lập
-- <Example>
---- 
/*
	SP0010 @DivisionID='NTY',@TypeID='DXP',@TableID='OOT1000',@ColumnID='AbsentTypeID',@ColumnName='Description'

*/

CREATE PROCEDURE dbo.SP0010
(	
	@DivisionID VARCHAR(50),
	@TypeID VARCHAR(50),
	@TableID VARCHAR(50),
	@ColumnID VARCHAR(50),
	@ColumnName VARCHAR(50)
)
AS
DECLARE @SQL1 VARCHAR(MAX)

SET @SQL1 = '
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
		AND ST0010.TypeID = ''' + @TypeID + ''' AND (ST0010.ID Is not null AND ST0010.IsAppCondition = 1)
	) KQ
	ORDER BY IsSetting, ID'

EXEC(@SQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
