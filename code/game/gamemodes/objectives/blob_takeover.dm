/datum/objective/blob_takeover
	explanation_text = "Мы должны расти. Заполнить эту станцию собой. Для этого достаточто X клеток."
	var/invade_tiles = 0

/datum/objective/blob_takeover/PostAppend()
	..()
	var/datum/faction/blob_conglomerate/F = faction
	if (!istype(F))
		return FALSE
	invade_tiles = F.blobwincount
	explanation_text = "Мы должны расти. Заполнить эту станцию собой. Для этого достаточто [invade_tiles] клеток."
	return TRUE

/datum/objective/blob_takeover/check_completion()
	if(blobs.len >= invade_tiles * 0.95)
		return OBJECTIVE_WIN
	return OBJECTIVE_LOSS
