dofile(lfs.writedir()..'Scripts/DCSDTC/commonFunctions.lua')

function DTC_F16CM_GetDED()
	return DTC_ParseDisplay(6)
end

function DTC_F16CM_GetLeftMFD()
	return DTC_ParseDisplay(4)
end

function DTC_F16CM_GetRightMFD()
	return DTC_ParseDisplay(5)
end

function DTC_F16CM_CheckCondition_HARM()
	local table = DTC_F16CM_GetDED();
	local str = table["Misc Item 0 Name"];
	if str == "HARM" then
		return true
	end
	return false
end

function DTC_F16CM_CheckCondition_NotInAAMode()
	local table = DTC_F16CM_GetDED();
	local str = table["Master_mode"];
	if str == "A-A" then
		return true
	end
	return false
end

function DTC_F16CM_CheckCondition_NotInAGMode()
	local table = DTC_F16CM_GetDED();
	local str = table["Master_mode"];
	if str == "A-G" then
		return true
	end
	return false
end

function DTC_F16CM_CheckCondition_HTSAllNotSelected(mfd)
	local mfdTable;

	if mfd == "left" then
		mfdTable = DTC_F16CM_GetLeftMFD();
	else
		mfdTable = DTC_F16CM_GetRightMFD();
	end

	local str = mfdTable["ALL Table. Root. Unic ID: _id:178. Text"];
	if str == "ALL" then
		return true
	end
	return false
end

function DTC_F16CM_CheckCondition_HTSOnDED()
	local table = DTC_F16CM_GetDED();
	local str = table["Misc Item E Name"];
	if str == "HTS" then
		return true
	end
	return false
end

function DTC_F16CM_CheckCondition_HTSOnMFD(mfd)
	local mfdTable;

	if mfd == "left" then
		mfdTable = DTC_F16CM_GetLeftMFD();
	else
		mfdTable = DTC_F16CM_GetRightMFD();
	end
	local str = table["HAD_OFF_Lable_name"];
	if str == "HAD" then
		return false
	end
	return true
end

function DTC_F16CM_CheckCondition_BullseyeNotSelected()
	local table = DTC_F16CM_GetDED();
	local str = table["BULLSEYE LABEL"];
	if str == "BULLSEYE" then
		return true
	end
	return false
end

function DTC_F16CM_CheckCondition_BullseyeSelected()
	local table = DTC_F16CM_GetDED();
	local str = table["BULLSEYE LABEL_inv"];
	if str == "BULLSEYE" then
		return true
	end
	return false
end

function DTC_F16CM_CheckCondition_TACANBandX()
	local table = DTC_F16CM_GetDED();
	local str = table["TCN BAND XY"];
	if str == "X" then
		return true
	end
	return false
end

function DTC_F16CM_CheckCondition_TACANBandY()
	local table = DTC_F16CM_GetDED();
	local str = table["TCN BAND XY"];
	if str == "Y" then
		return true
	end
	return false
end

function DTC_F16CM_CheckCondition_VIP_TO_TGT_NotSelected()
	local table = DTC_F16CM_GetDED();
	local str1 = table["Visual initial point to TGT Label"] or "";
	local str2 = table["Visual initial point to TGT Label_inv"] or "";
	if (str1 == "VIP-TO-TGT") or (str2 == "VIP-TO-TGT") then
		return false
	end
	return true
end

function DTC_F16CM_CheckCondition_VIP_TO_TGT_NotHighlighted()
	local table = DTC_F16CM_GetDED();
	local str = table["Visual initial point to TGT Label"];
	if str == "VIP-TO-TGT" then
		return true
	end
	return false
end

function DTC_F16CM_CheckCondition_VIP_TO_PUP_NotHighlighted()
	local table = DTC_F16CM_GetDED();
	local str = table["Visual initial point to TGT Label"];
	if str == "VIP-TO-PUP" then
		return true
	end
	return false
end

function DTC_F16CM_CheckCondition_TGT_TO_VRP_NotSelected()
	local table = DTC_F16CM_GetDED();
	local str1 = table["Target to VRP Label"] or "";
	local str2 = table["Target to VRP Label_inv"] or "";
	if (str1 == "TGT-TO-VRP") or (str2 == "TGT-TO-VRP") then
		return false
	end
	return true
end

function DTC_F16CM_CheckCondition_TGT_TO_VRP_NotHighlighted()
	local table = DTC_F16CM_GetDED();
	local str = table["Target to VRP Label"];
	if str == "TGT-TO-VRP" then
		return true
	end
	return false
end

function DTC_F16CM_CheckCondition_TGT_TO_PUP_NotHighlighted()
	local table = DTC_F16CM_GetDED();
	local str = table["Target to VRP Label"];
	if str == "TGT-TO-PUP" then
		return true
	end
	return false
end

function DTC_F16CM_CheckCondition(condition)
	if condition == "NOT_IN_AA" then
		return DTC_F16CM_CheckCondition_NotInAAMode();
	elseif condition == "NOT_IN_AG" then
		return DTC_F16CM_CheckCondition_NotInAGMode();
	elseif condition == "HARM" then
		return DTC_F16CM_CheckCondition_HARM();
	elseif condition == "HTS_DED" then
		return DTC_F16CM_CheckCondition_HTSOnDED();
	elseif condition == "LMFD_HTS" then
		return DTC_F16CM_CheckCondition_HTSOnMFD("left");
	elseif condition == "RMFD_HTS" then
		return DTC_F16CM_CheckCondition_HTSOnMFD("right");
	elseif condition == "LMFD_HTS_ALL_NOT_SELECTED" then
		return DTC_F16CM_CheckCondition_HTSAllNotSelected("left");
	elseif condition == "RMFD_HTS_ALL_NOT_SELECTED" then
		return DTC_F16CM_CheckCondition_HTSAllNotSelected("right");
	elseif condition == "BULLS_NOT_SELECTED" then
		return DTC_F16CM_CheckCondition_BullseyeNotSelected();
	elseif condition == "BULLS_SELECTED" then
		return DTC_F16CM_CheckCondition_BullseyeSelected();
	elseif condition == "TACAN_BAND_X" then
		return DTC_F16CM_CheckCondition_TACANBandX();
	elseif condition == "TACAN_BAND_Y" then
		return DTC_F16CM_CheckCondition_TACANBandY();
	elseif condition == "VIP_TO_TGT_NOT_SELECTED" then
		return DTC_F16CM_CheckCondition_VIP_TO_TGT_NotSelected();
	elseif condition == "VIP_TO_TGT_NOT_HIGHLIGHTED" then
		return DTC_F16CM_CheckCondition_VIP_TO_TGT_NotHighlighted();
	elseif condition == "VIP_TO_PUP_NOT_HIGHLIGHTED" then
		return DTC_F16CM_CheckCondition_VIP_TO_PUP_NotHighlighted();
	elseif condition == "TGT_TO_VRP_NOT_SELECTED" then
		return DTC_F16CM_CheckCondition_TGT_TO_VRP_NotSelected();
	elseif condition == "TGT_TO_VRP_NOT_HIGHLIGHTED" then
		return DTC_F16CM_CheckCondition_TGT_TO_VRP_NotHighlighted();
	elseif condition == "TGT_TO_PUP_NOT_HIGHLIGHTED" then
		return DTC_F16CM_CheckCondition_TGT_TO_PUP_NotHighlighted();
	else
		return false
	end
end

function DTC_F16CM_AfterNextFrame(params)
	local mainPanel = GetDevice(0);
	local wxButton = mainPanel:get_argument_value(187);
	local flirIncDec = mainPanel:get_argument_value(188);

	if wxButton == 1 then params["uploadCommand"] = "1" end
	if flirIncDec == 1 then params["showDTCCommand"] = "1" end
	if flirIncDec == -1 then params["hideDTCCommand"] = "1" end

	--DTC_DebugDisplay(DTC_F16CM_GetDED())
end