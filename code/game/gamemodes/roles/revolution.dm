/datum/role/rev
	name = REV
	id = REV
	required_pref = ROLE_REV
	logo_state = "rev-logo"

	antag_hud_type = ANTAG_HUD_REV
	antag_hud_name = "hudrevolutionary"
	skillset_type = /datum/skillset/revolutionary

/datum/role/rev/CanBeAssigned(datum/mind/M)
	if(!..())
		return FALSE
	if(M.current.ismindprotect())
		return FALSE
	return TRUE

/datum/role/rev/OnPreSetup(greeting, custom)
	. = ..()
	SEND_SIGNAL(antag.current, COMSIG_ADD_MOOD_EVENT, "rev_convert", /datum/mood_event/rev)

/datum/role/rev/RemoveFromRole(datum/mind/M, msg_admins)
	SEND_SIGNAL(antag.current, COMSIG_CLEAR_MOOD_EVENT, "rev_convert")
	..()

/datum/role/rev/Greet(greeting, custom)
	. = ..()
	to_chat(antag.current, "<span class='warning'><FONT size = 3> Вы - Революционер! Помогите своему делу. Не причиняйте вреда своим собратьям-борцам за свободу. Вы можете идентифицировать своих товарищей по красным значкам \"R\" а своих лидеров - по синим значкам \"R\" Помогите им убить, захватить в плен или обратить головы в свою веру, чтобы выиграть революцию!</FONT></span>")

/datum/role/rev_leader
	name = HEADREV
	id = HEADREV
	required_pref = ROLE_REV
	logo_state = "rev_head-logo"

	restricted_jobs = list("Security Cadet", "Security Officer", "Warden", "Detective", "AI", "Cyborg","Captain", "Head of Personnel", "Head of Security", "Chief Engineer", "Research Director", "Chief Medical Officer", "Internal Affairs Agent", "Blueshield Officer")

	antag_hud_type = ANTAG_HUD_REV
	antag_hud_name = "hudheadrevolutionary"

	var/rev_cooldown = 0
	skillset_type = /datum/skillset/max
	moveset_type = /datum/combat_moveset/cqc

/datum/role/rev_leader/New()
	..()
	AddComponent(/datum/component/gamemode/syndicate, 1, "rev")

/datum/role/rev_leader/OnPostSetup(laterole)
	. = ..()
	antag.current.verbs += /mob/living/carbon/human/proc/RevConvert

	// Show each head revolutionary up to 3 candidates
	var/list/already_considered = list()
	for(var/i in 1 to 2)
		var/mob/rev_mob = antag.current
		already_considered += rev_mob
		// Tell them about people they might want to contact.
		var/mob/living/carbon/human/M = get_nt_opposed()
		if(M && !isrevhead(M) && !(M in already_considered))
			to_chat(rev_mob, "Мы получили заслуживающие доверия сообщения о том, что [M.real_name], возможно, захочет помочь нашему делу. Если вам нужна помощь, подумайте о том, чтобы связаться с этой персоной.")
			rev_mob.mind.store_memory("<b>Потенциальный сотрудник</b>: [M.real_name]")

/mob/living/carbon/human/proc/RevConvert()
	set name = "Rev-Convert"
	set category = "IC"

	if(!isrevhead(src))
		verbs -= /mob/living/carbon/human/proc/RevConvert
		return FALSE

	var/list/Possible = list()
	for(var/mob/living/carbon/human/P in oview(src))
		if(stat == CONSCIOUS && P.client && P.mind && (!isrev(P) || !isrevhead(P)))
			Possible += P
	if(!Possible.len)
		to_chat(src, "<span class='warning'>Похоже, здесь нет никого, кого вы могли бы конвертировать.</span>")
		return

	var/mob/living/carbon/human/M = input("Выберите человека для конвертации", "Да здравствует революция!", null) as mob in Possible
	if(!isrevhead(src))
		verbs -= /mob/living/carbon/human/proc/RevConvert
		return FALSE

	if(isrevhead(M) || isrev(M))
		to_chat(src, "<span class='bold warning'>[M] уже находится в вашей группе!</span>")
	else if(M.ismindprotect())
		to_chat(src, "<span class='bold warning'>[M] имеет имплан, защищающий разум. Перед конвертацией нужно избавиться от импланта!</span>")
	else if(jobban_isbanned(M, ROLE_REV) || jobban_isbanned(M, "Syndicate"))
		to_chat(src, "<span class='bold warning'>[M] находится в чёрном списке!</span>")
	else
		var/datum/role/rev_leader/lead = mind.GetRole(HEADREV)
		if(world.time < lead.rev_cooldown)
			to_chat(src, "<span class='warning'>Подождите пять секунд перед попыткой конвертации.</span>")
			return
		to_chat(src, "<span class='warning'>Предлагаем [M] присоединиться к нам...</span>")
		log_admin("[key_name(src)]) attempted to convert [M].")
		message_admins("<span class='warning'>[key_name_admin(src)] attempted to convert [M]. [ADMIN_JMP(src)]</span>")
		var/datum/faction/revolution/rev = lead.GetFaction()
		rev.convert_revolutionare_by_invite(M, src)
