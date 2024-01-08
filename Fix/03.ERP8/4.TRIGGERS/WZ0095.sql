IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WZ0095]') AND OBJECTPROPERTY(ID, N'IsTrigger') = 1)
DROP TRIGGER [DBO].[WZ0095]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
go
CREATE TRIGGER [dbo].[WZ0095] ON [dbo].[WT0095]
AFTER UPDATE
AS
BEGIN
    IF UPDATE(IsCheck) 
    BEGIN
        UPDATE s
        SET ApproveWaveStatusID = CASE w.IsCheck
                                    WHEN 1 THEN '1'
                                    WHEN 0 THEN '0'                               
                                 END,
            ApproveCutRollStatusID = CASE w.IsCheck
                                        WHEN 1 THEN '1'
                                        WHEN 0 THEN '0'                       
                                     END,
            StatusID = CASE w.IsCheck
                           WHEN 1 THEN '1'
                           WHEN 0 THEN '0'                 
                       END
        FROM SOT2080 s
        INNER JOIN inserted w ON s.VoucherNo = w.RefNo01
        WHERE w.DivisionID = 'MT'
    END
END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO