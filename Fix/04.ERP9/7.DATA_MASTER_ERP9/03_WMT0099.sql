-- Created by Khả Vi on 05/03/2018
-- Add dữ liệu vào bảng Master Module ASOFT- WM
-- Modified by on
DELETE WMT0099
-----------------------------------------Cấp quản lý vị trí (LevelID)-------------------------------------
INSERT [dbo].[WMT0099] ([CodeMaster], [ID], [Orders], [Description], [DescriptionE], [Disabled], [Inherit]) VALUES ('Level', 'Level1', 1, N'Cấp 1', N'Level 1', 0, NULL)
INSERT [dbo].[WMT0099] ([CodeMaster], [ID], [Orders], [Description], [DescriptionE], [Disabled], [Inherit]) VALUES ('Level', 'Level2', 2, N'Cấp 2', N'Level 2', 0, NULL)
INSERT [dbo].[WMT0099] ([CodeMaster], [ID], [Orders], [Description], [DescriptionE], [Disabled], [Inherit]) VALUES ('Level', 'Level3', 3, N'Cấp 3', N'Level 3', 0, NULL)
INSERT [dbo].[WMT0099] ([CodeMaster], [ID], [Orders], [Description], [DescriptionE], [Disabled], [Inherit]) VALUES ('Level', 'Level4', 4, N'Cấp 4', N'level 4', 0, NULL)

-----------------------------------------Disabled-------------------------------------
INSERT [dbo].[WMT0099] ([CodeMaster], [ID], [Orders], [Description], [DescriptionE], [Disabled], [Inherit]) VALUES ('Disabled', '0', 1, N'Không', N'No', 0, NULL)
INSERT [dbo].[WMT0099] ([CodeMaster], [ID], [Orders], [Description], [DescriptionE], [Disabled], [Inherit]) VALUES ('Disabled', '1', 2, N'Có', N'Yes', 0, NULL)

-----------------------------------------Trạng thái xác nhận-------------------------------------
INSERT [dbo].[WMT0099] ([CodeMaster], [ID], [Orders], [Description], [DescriptionE], [Disabled], [Inherit]) VALUES ('ConfirmStatus', '1', 1, N'Xác nhận', N'Confirm', 0, NULL)
INSERT [dbo].[WMT0099] ([CodeMaster], [ID], [Orders], [Description], [DescriptionE], [Disabled], [Inherit]) VALUES ('ConfirmStatus', '2', 2, N'Từ chối', N'Deny', 0, NULL)

-----------------------------------------Loại chứng từ kho-----------------------------------------------------
INSERT [dbo].[WMT0099] ([CodeMaster], [ID], [Orders], [Description], [DescriptionE], [Disabled], [Inherit]) VALUES ('RequestVoucher', '1', 1, N'Phiếu yêu cầu nhập kho', N'ImportRequestVoucher', 0, NULL)
INSERT [dbo].[WMT0099] ([CodeMaster], [ID], [Orders], [Description], [DescriptionE], [Disabled], [Inherit]) VALUES ('RequestVoucher', '2', 2, N'Phiếu yêu cầu xuất kho', N'ExportRequestVoucher', 0, NULL)
INSERT [dbo].[WMT0099] ([CodeMaster], [ID], [Orders], [Description], [DescriptionE], [Disabled], [Inherit]) VALUES ('RequestVoucher', '3', 3, N'Phiếu yêu cầu vận chuyển nội bộ', N'TransferRequestVoucher', 0, NULL)

-----------------------------------------Trạng thái duyệt-------------------------------------
INSERT [dbo].[WMT0099] ([CodeMaster], [ID], [Orders], [Description], [DescriptionE], [Disabled], [Inherit]) VALUES ('ApproveStatus', '0', 1, N'Chưa duyệt', N'UnApproved', 0, NULL)
INSERT [dbo].[WMT0099] ([CodeMaster], [ID], [Orders], [Description], [DescriptionE], [Disabled], [Inherit]) VALUES ('ApproveStatus', '1', 2, N'Đã duyệt', N'Approved', 0, NULL)

