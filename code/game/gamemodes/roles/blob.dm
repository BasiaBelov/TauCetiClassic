/datum/role/blob_overmind
	name = BLOBOVERMIND
	id = BLOBOVERMIND
	required_pref = ROLE_BLOB
	logo_state = "blob-logo"
	greets = list(GREET_DEFAULT,GREET_CUSTOM)

	disallow_job = TRUE

/datum/role/blob_overmind/cerebrate
	name = BLOBCEREBRATE
	id = BLOBCEREBRATE
	logo_state = "cerebrate-logo"

/datum/role/blob_overmind/OnPostSetup(laterole)
	. = ..()
	var/wait_time = rand(INTERCEPT_TIME_LOW, INTERCEPT_TIME_HIGH)
	var/time_to_stage1 = wait_time
	var/time_to_stage2 = wait_time * 2
	var/time_to_stage3 = wait_time * 2 + wait_time / 2

	addtimer(CALLBACK(src, .proc/stage1), time_to_stage1)
	addtimer(CALLBACK(src, .proc/stage2), time_to_stage2)
	addtimer(CALLBACK(src, .proc/stage3), time_to_stage3)

/datum/role/blob_overmind/proc/stage1()
	if(!antag.current)
		return

	to_chat(antag.current, "<span class='alert'>Вы чувствуете усталость и раздутость.</span>")

/datum/role/blob_overmind/proc/stage2()
	if(!antag.current)
		return

	to_chat(antag.current, "<span class='alert'>Вы чувствуете, что вот-вот лопнете.</span>")

/datum/role/blob_overmind/proc/stage3()
	if(!antag.current)
		return

	burst()

/datum/role/blob_overmind/proc/burst()
	if(isovermind(antag.current))
		return

	var/client/blob_client = null
	var/turf/location = null

	if(isliving(antag.current))
		var/mob/living/C = antag.current
		if(directory[ckey(antag.key)])
			blob_client = directory[ckey(antag.key)]
			location = get_turf(C)
			if(!is_station_level(location.z) || isspaceturf(location))
				location = null
			C.gib()

	if(blob_client && location)
		new /obj/structure/blob/core(location, blob_client, 200, 3)
	Drop()

/datum/role/blob_overmind/Greet(greeting,custom)
	if(!..())
		return FALSE
	if(isovermind(antag.current))
		return FALSE

	to_chat(antag.current, "<span class='warning'>Ваше тело готово породить новое ядро Блоба, которое съест эту станцию.</span>")
	to_chat(antag.current, "<span class='warning'>Найдите хорошее место для создания ядра, а затем возьмите станцию под свой контроль и сокрушите её!</span>")
	to_chat(antag.current, "<span class='warning'>Когда вы найдете местоположение, подождите, пока вы не появитесь; это произойдет автоматически, и вы не сможете ускорить процесс.</span>")
	to_chat(antag.current, "<span class='warning'>Если вы выйдете за пределы станции, то вы умрете; убедитесь, что в вашем местоположении достаточно места роста.</span>")

	return TRUE

/datum/role/blobbernaut
	name = BLOBBERNAUT
	id = BLOBBERNAUT
	required_pref = ROLE_BLOB
	logo_state = "blob-logo"
	greets = list(GREET_DEFAULT,GREET_CUSTOM)

	disallow_job = TRUE
