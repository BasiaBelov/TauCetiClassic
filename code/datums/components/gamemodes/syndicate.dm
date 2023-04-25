/datum/component/gamemode/syndicate
	// Uplink
	var/list/uplink_items_bought = list() //migrated from mind, used in GetScoreboard()
	var/total_TC = 0
	var/spent_TC = 0
	var/uplink_uses
	var/uplink_type = "traitor"

	// Dont uplink
	var/syndicate_awareness = SYNDICATE_UNAWARE
	var/list/datum/stat/uplink_purchase/uplink_purchases = list()

/datum/component/gamemode/syndicate/Initialize(crystals, type)
	..()
	uplink_uses = crystals
	uplink_type = type


/datum/component/gamemode/syndicate/Destroy()
	return ..()

/datum/component/gamemode/syndicate/proc/get_current()
	var/datum/role/role = parent
	var/mob/living/carbon/human/traitor_mob = role.antag.current
	if(!traitor_mob)
		return

	return traitor_mob

/datum/component/gamemode/syndicate/proc/give_uplink()
	var/mob/traitor_mob = get_current()
	if(!traitor_mob)
		return

	// find a radio! toolbox(es), backpack, belt, headset
	var/loc = ""
	var/obj/item/R //Hide the uplink in a PDA if available, otherwise radio

	if(traitor_mob.client.prefs.uplinklocation == "Headset")
		R = locate(/obj/item/device/radio) in traitor_mob.contents
		if(!R)
			R = locate(/obj/item/device/pda) in traitor_mob.contents
			to_chat(traitor_mob, "Не удалось найти наушник. Поэтому мы установили секретный магазин в ваш ПДА!")
		if (!R)
			to_chat(traitor_mob, "К сожалению, ни в наушник, ни ПДА не удалось установить секретный магазин АнтагКорп...")

	else if(traitor_mob.client.prefs.uplinklocation == "PDA")
		R = locate(/obj/item/device/pda) in traitor_mob.contents
		if(!R)
			R = locate(/obj/item/device/radio) in traitor_mob.contents
			to_chat(traitor_mob, "Не удалось найти ПДА. Поэтому мы установили секретный магазин в ваш наушник!")
		if (!R)
			to_chat(traitor_mob, "К сожалению, ни в наушник, ни ПДА не удалось установить секретный магазин АнтагКорп...")

	else if(traitor_mob.client.prefs.uplinklocation == "Intercom")
		var/list/station_intercom_list = list()
		for(var/obj/item/device/radio/intercom/I as anything in intercom_list)
			if(is_station_level(I.z))
				station_intercom_list += I

		if(station_intercom_list.len)
			R = pick(station_intercom_list)
		if(!R)
			R = locate(/obj/item/device/radio) in traitor_mob.contents
			to_chat(traitor_mob, "Не удалось найти подходящий интерком, вместо него установили секретный магазин в ваш наушник!")
		if (!R)
			R = locate(/obj/item/device/pda) in traitor_mob.contents
			to_chat(traitor_mob, "Не удалось найти наушник. Поэтому мы установили секретный магазин в ваш ПДА!")
		if (!R)
			to_chat(traitor_mob, "К сожалению, ни в наушник, ни ПДА не удалось установить секретный магазин АнтагКорп...")

	else if(traitor_mob.client.prefs.uplinklocation == "None")
		to_chat(traitor_mob, "Вы решили не устанавливать секретный магазин АнтагКорп.")
		R = null

	else
		to_chat(traitor_mob, "Вы не выбрали местоположение своего секретного магазина в настройках антагониста! Переход по умолчанию на ПДА!")
		R = locate(/obj/item/device/pda) in traitor_mob.contents
		if (!R)
			R = locate(/obj/item/device/radio) in traitor_mob.contents
			to_chat(traitor_mob, "Не удалось найти ПДА. Поэтому мы установили секретный магазин в ваш наушник!")
		if (!R)
			to_chat(traitor_mob, "К сожалению, ни в наушник, ни ПДА не удалось установить секретный магазин АнтагКорп...")

	if (istype(R, /obj/item/device/radio))
		// generate list of radio freqs
		var/obj/item/device/radio/target_radio = R
		var/freq = 1441
		var/list/freqlist = list()
		while (freq <= 1489)
			if (freq < 1451 || freq > 1459)
				freqlist += freq
			freq += 2
			if ((freq % 2) == 0)
				freq += 1
		freq = freqlist[rand(1, freqlist.len)]
		var/obj/item/device/uplink/hidden/T = new(R)
		T.uses = uplink_uses
		target_radio.hidden_uplink = T
		target_radio.traitor_frequency = freq
		if(istype(target_radio, /obj/item/device/radio/intercom))
			to_chat(traitor_mob, "Секретный магазин АнтагКорп был установлен в [R.name] интерком в [get_area(R)]. Просто выберите частоту [format_frequency(freq)] для разблокировки магазина.")
			traitor_mob.mind.store_memory("<B>Радио частота:</B> [format_frequency(freq)] ([R.name] [get_area(R)].")
			target_radio.hidden_uplink.uses += 5
		else
			to_chat(traitor_mob, "Секретный магазин АнтагКорп был установлен в ваш [R.name] [loc]. Просто выберите частоту [format_frequency(freq)] для разблокировки магазина.")
			traitor_mob.mind.store_memory("<B>Радио частота:</B> [format_frequency(freq)] ([R.name] [loc]).")
		total_TC += target_radio.hidden_uplink.uses
		target_radio.hidden_uplink.uplink_type = uplink_type

	else if (istype(R, /obj/item/device/pda))
		// generate a passcode if the uplink is hidden in a PDA
		var/pda_pass = "[rand(100,999)] [pick("Alpha","Bravo","Delta","Omega")]"
		var/obj/item/device/uplink/hidden/T = new(R)
		T.uses = uplink_uses
		R.hidden_uplink = T
		var/obj/item/device/pda/P = R
		P.lock_code = pda_pass
		to_chat(traitor_mob, "В вашем [R.name] [loc] установлено портативное устройство для телепортации объектов. Просто введите код \"[pda_pass]\" в поле выбора мелодии звонка, чтобы разблокировать ее скрытые функции.")
		traitor_mob.mind.store_memory("<B>Код доступа:</B> [pda_pass] ([R.name] [loc]).")
		total_TC += R.hidden_uplink.uses
		R.hidden_uplink.uplink_type = uplink_type

/datum/component/gamemode/syndicate/proc/give_codewords()
	var/mob/traitor_mob = get_current()
	if(!traitor_mob)
		return

	var/code_words = 0
	if(prob(80))
		ASSERT(global.syndicate_code_phrase.len)
		to_chat(traitor_mob, "<u><b>Ваши работодатели проинформировали вас о кодовых словах, чтобы найти других агентов:</b></u>")
		var/code_phrase = "<b>Кодовые слова</b>: [codewords2string(global.syndicate_code_phrase)]"
		to_chat(traitor_mob, code_phrase)
		traitor_mob.mind.store_memory(code_phrase)
		syndicate_awareness = SYNDICATE_PHRASES

		code_words += 1

	if(prob(80))
		ASSERT(global.syndicate_code_response.len)
		var/code_response = "<b>Кодовые ответы</b>: [codewords2string(global.syndicate_code_response)]"
		to_chat(traitor_mob, code_response)
		traitor_mob.mind.store_memory(code_response)
		syndicate_awareness = SYNDICATE_RESPONSE

		code_words += 1

	switch(code_words)
		if(0)
			to_chat(traitor_mob, "К сожалению, Синдикат не предоставил вам кодовые слова...")
		if(1) // half
			to_chat(traitor_mob, "Используйте кодовые слова, предпочтительно в указанном порядке, во время обычного разговора, чтобы идентифицировать других агентов. Однако действуйте с осторожностью, поскольку каждый является потенциальным врагом.")
		if(2)
			syndicate_awareness = SYNDICATE_AWARE
			to_chat(traitor_mob, "Используйте кодовые слова, предпочтительно в указанном порядке, во время обычного разговора, чтобы идентифицировать других агентов. Однако действуйте с осторожностью, поскольку каждый является потенциальным врагом.")

/datum/component/gamemode/syndicate/proc/give_intel()
	var/mob/traitor_mob = get_current()
	if(!traitor_mob)
		return

	ASSERT(traitor_mob)
	give_codewords(traitor_mob)
	ASSERT(traitor_mob.mind)

/datum/component/gamemode/syndicate/proc/equip_traitor()
	var/mob/mob = get_current()
	if(!mob)
		return

	give_intel()

	if(!ishuman(mob))
		return
	var/mob/living/carbon/human/traitor_mob = mob

	if (traitor_mob.mind?.assigned_role == "Clown")
		to_chat(traitor_mob, "Ваше обучение позволило вам преодолеть свою шутовскую натуру, позволив вам владеть оружием, не причиняя себе вреда.")
		REMOVE_TRAIT(traitor_mob, TRAIT_CLUMSY, GENETIC_MUTATION_TRAIT)

	if(uplink_uses > 0)
		var/obj/item/device/uplink/hidden/guplink = find_syndicate_uplink(traitor_mob)
		if(!guplink)
			give_uplink()
		else
			guplink.uses = uplink_uses
			total_TC = uplink_uses

	var/datum/role/R = parent
	for(var/datum/objective/target/dehead/D in R.objectives.GetObjectives())
		var/obj/item/device/biocan/B = new (traitor_mob.loc)
		var/list/slots = list(
			"backpack" = SLOT_IN_BACKPACK,
			"left hand" = SLOT_L_HAND,
			"right hand" = SLOT_R_HAND,
		)
		var/where = traitor_mob.equip_in_one_of_slots(B, slots)
		traitor_mob.update_icons()
		if (!where)
			to_chat(traitor_mob, "К сожалению, Синдикат не смог предоставить вам новую банку для хранения голов.")
		else
			to_chat(traitor_mob, "Банка, наполненная биогелем, в вашем [where] поможет вам украсть голову вашей цели живой и неповрежденной.")

	// Tell them about people they might want to contact.
	var/mob/living/carbon/human/M = get_nt_opposed()
	if(M && M != traitor_mob)
		to_chat(traitor_mob, "Мы получили заслуживающие доверия сообщения о том, что [M.real_name], возможно, захочет помочь нашему делу. Если вам нужна помощь, подумайте о том, чтобы обратиться к этой персоне.")
		traitor_mob.mind.store_memory("<b>Потенциальный помощник</b>: [M.real_name]")

/datum/component/gamemode/syndicate/proc/take_uplink()
	var/mob/living/carbon/human/traitor_mob = get_current()
	if(!traitor_mob || !istype(traitor_mob))
		return

	var/obj/item/I = find_syndicate_uplink(traitor_mob)
	if(I?.hidden_uplink)
		QDEL_NULL(I.hidden_uplink)

/datum/component/gamemode/syndicate/OnPostSetup(datum/source, laterole)
	equip_traitor()

/datum/component/gamemode/syndicate/GetScoreboard(datum/source)
	if(total_TC)
		if(spent_TC)
			. += "<br><b>ТК осталось:</b> [total_TC - spent_TC]/[total_TC]"
			. += "<br><b>Инструменты, использованными предателем, были:</b>"
			for(var/entry in uplink_items_bought)
				. += "<br>[entry]"
		else
			. += "<br>Предатель был безупречным агентом в этом раунде (Не покупал ничего)"

/datum/component/gamemode/syndicate/extraPanelButtons(datum/source)
	var/datum/role/role = parent
	var/mob/living/carbon/human/traitor_mob = get_current()
	if(!traitor_mob || !istype(traitor_mob))
		return

	var/obj/item/device/uplink/hidden/guplink = find_syndicate_uplink(traitor_mob)
	if(guplink)
		. += " - <a href='?src=\ref[role];mind=\ref[role.antag];role=\ref[src];telecrystalsSet=1;'>Telecrystals: [guplink.uses](Set telecrystals)</a>"
		. += " - <a href='?src=\ref[role];mind=\ref[role.antag];role=\ref[src];removeuplink=1;'>(Remove uplink)</a>"
	else
		. = " - <a href='?src=\ref[role];mind=\ref[role.antag];role=\ref[src];giveuplink=1;'>(Give uplink)</a>"

/datum/component/gamemode/syndicate/RoleTopic(datum/source, href, href_list, datum/mind/M, admin_auth)
	if(!M || !M.current)
		return

	if(href_list["giveuplink"])
		give_uplink()

	if(href_list["telecrystalsSet"])
		var/obj/item/device/uplink/hidden/guplink = find_syndicate_uplink(M.current)
		var/amount = input("What would you like to set their crystal count to?", "Their current count is [guplink.uses]") as null|num
		if(!isnull(amount))
			if(guplink)
				var/diff = amount - guplink.uses
				guplink.uses = amount
				total_TC += diff

	if(href_list["removeuplink"])
		take_uplink(M.current)
		var/datum/role/role = parent
		role.antag.memory = null
		to_chat(M.current, "<span class='warning'>You have been stripped of your uplink.</span>")
