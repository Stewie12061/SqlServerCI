IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP1242]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].CIP1242
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--<summary>
--- Load danh sách đối tượng của đợt khuyến mãi
--<history>
--- Created on 20/03/2023 by Anh Đô

CREATE PROC CIP1242
			@APKMaster			VARCHAR(50),
			@TbBusinessParent	VARCHAR(50),
			@PageNumber			INT = 1,
			@PageSize			INT = 25
AS
BEGIN
	DECLARE @sSql NVARCHAR(MAX)
	
	SET @sSql = N'
		SELECT
			  A1.DivisionID 
			, A1.APK
			, M.APKParent AS APKMaster
			, A1.ObjectID AS AccountID
			, A1.ObjectName AS AccountName
			, A1.Address
			, A1.Email
			, A1.Tel
		INTO #Tmp
		FROM CIT0088 M WITH (NOLOCK)
		LEFT JOIN AT1202 A1 WITH (NOLOCK) ON A1.ObjectID = M.BusinessChild
		WHERE M.APKParent = '''+ @APKMaster +''' AND M.TableBusinessParent = '''+ @TbBusinessParent +'''

		SELECT 
			  ROW_NUMBER() OVER (ORDER BY t.AccountID) AS RowNum
			, COUNT(*) OVER () AS TotalRow
			, t.*
		FROM #Tmp t
		ORDER BY t.AccountID
		OFFSET ' + STR((@PageNumber-1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '

	PRINT(@sSql)
	EXEC(@sSql)
END		

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
