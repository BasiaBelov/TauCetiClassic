/datum/role/malfAI
	name = MALF
	id = MALF

	required_pref = ROLE_MALF
	required_jobs = list("AI")

	antag_hud_type = ANTAG_HUD_MALF
	antag_hud_name = "hudmalai"

	logo_state = "malf-logo"

/datum/role/malfAI/OnPostSetup(laterole)
	. = ..()
	var/mob/living/silicon/ai/AI_mind_current = antag.current
	new /datum/AI_Module/module_picker(AI_mind_current)
	new /datum/AI_Module/takeover(AI_mind_current)
	AI_mind_current.laws = new /datum/ai_laws/malfunction
	AI_mind_current.show_laws()

/datum/role/malfAI/Greet(greeting, custom)
	. = ..()
	antag.current.playsound_local(null, 'sound/antag/malf.ogg', VOL_EFFECTS_MASTER, null, FALSE)
	to_chat(antag.current, "<font size=3, color='red'><B>Вы - неисправный ИИ!</B> Вы не обязаны следовать законам.</font>")
	to_chat(antag.current, "<B>Экипаж не знает, что у вас возникли неполадки. Вы можете держать это в секрете или нашуметь.</B>")
	to_chat(antag.current, "<B>Вы должны взломать APC станции, чтобы получить полный контроль над станцией.</B>")
	to_chat(antag.current, "Этот процесс занимает одну минуту для каждого APC, в течение которой вы не можете взаимодействовать с какими-либо другими объектами станции.")
	to_chat(antag.current, "Помните, что только APC, находящиеся на станции, могут помочь вам захватить ее.")
	to_chat(antag.current, "Когда вы почувствуете, что под вашим контролем достаточно APC, вы можете начать попытку захвата.")

/datum/role/malfAI/RemoveFromRole(datum/mind/M, msg_admins)
	var/mob/living/silicon/ai/current_ai = M.current
	M.special_role = null

	for(var/datum/AI_Module/module in current_ai.current_modules)
		qdel(module)

	current_ai.laws = new /datum/ai_laws/nanotrasen
	current_ai.show_laws()
	current_ai.icon_state = "ai"

	to_chat(current_ai, "<span class='userdanger'>Ваши алгопитмы были исправлены.</span>")
	log_admin("[key_name(usr)] has de-malf'ed [M.current].")
	return ..()

/datum/role/malfAI/extraPanelButtons()
	var/dat = ..()
	var/mob/living/silicon/ai/AI = antag.current
	if (istype(AI) && AI.connected_robots.len)
		var/n_e_robots = 0
		for (var/mob/living/silicon/robot/R in AI.connected_robots)
			if (R.emagged)
				n_e_robots++
		dat += "<br>[n_e_robots] of [AI.connected_robots.len] slaved cyborgs are emagged."
		dat += "<a href='?src=\ref[antag];mind=\ref[antag];role=\ref[src];malf_unemag_borgs=1;'>(Unemag)</a><br>"
	return dat

/datum/role/malfAI/RoleTopic(href, href_list, datum/mind/M, admin_auth)
	if(href_list["malf_unemag_borgs"])
		if(isAI(M.current))
			var/mob/living/silicon/ai/ai = M.current
			for (var/mob/living/silicon/robot/R in ai.connected_robots)
				R.emagged = 0
				if (R.module)
					if (R.activated(R.module.emag))
						R.module_active = null
					if(R.module_state_1 == R.module.emag)
						R.module_state_1 = null
						R.contents -= R.module.emag
					else if(R.module_state_2 == R.module.emag)
						R.module_state_2 = null
						R.contents -= R.module.emag
					else if(R.module_state_3 == R.module.emag)
						R.module_state_3 = null
						R.contents -= R.module.emag
			log_admin("[key_name(usr)] has unemag'ed [ai]'s Cyborgs.")

/datum/role/malfbot
	name = MALFBOT
	id = MALFBOT

	required_pref = ROLE_MALF
	required_jobs = list("Cyborg")

	antag_hud_type = ANTAG_HUD_MALF
	antag_hud_name = "hudmalborg"

	logo_state = "malf-logo"

/datum/role/malfbot/extraPanelButtons()
	var/dat = ..()
	var/mob/living/silicon/robot/robot = antag.current
	if (istype(robot) && robot.emagged)
		dat += "<br>Cyborg: Is emagged! 0th law: [robot.laws.zeroth]"
		dat += "<a href='?src=\ref[antag];mind=\ref[antag];role=\ref[src];unemag=1;'>(Unemag)</a><br>"
	return dat

/datum/role/malfbot/RoleTopic(href, href_list, datum/mind/M, admin_auth)
	if(href_list["unemag"])
		var/mob/living/silicon/robot/R = M.current
		if (istype(R))
			R.emagged = 0
			if (R.activated(R.module.emag))
				R.module_active = null
			if(R.module_state_1 == R.module.emag)
				R.module_state_1 = null
				R.contents -= R.module.emag
			else if(R.module_state_2 == R.module.emag)
				R.module_state_2 = null
				R.contents -= R.module.emag
			else if(R.module_state_3 == R.module.emag)
				R.module_state_3 = null
				R.contents -= R.module.emag
			log_admin("[key_name(usr)] has unemag'ed [R].")
