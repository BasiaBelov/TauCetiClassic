var/global/list/possible_items_for_steal = list()

#define ADD_TO_POIFS_LIST(type) ADD_TO_GLOBAL_LIST(type, possible_items_for_steal)
ADD_TO_POIFS_LIST(/obj/item/weapon/gun/energy/laser/selfcharging/captain)
ADD_TO_POIFS_LIST(/obj/item/weapon/hand_tele)
ADD_TO_POIFS_LIST(/obj/item/weapon/tank/jetpack/oxygen)
ADD_TO_POIFS_LIST(/obj/item/clothing/under/rank/captain)
ADD_TO_POIFS_LIST(/obj/item/device/aicard)
ADD_TO_POIFS_LIST(/obj/item/blueprints)
ADD_TO_POIFS_LIST(/obj/item/clothing/suit/space/nasavoid)
ADD_TO_POIFS_LIST(/obj/item/weapon/tank)
ADD_TO_POIFS_LIST(/obj/item/slime_extract)
ADD_TO_POIFS_LIST(/obj/item/weapon/reagent_containers/food/snacks/meat/corgi)
ADD_TO_POIFS_LIST(/obj/item/clothing/under/rank/research_director)
ADD_TO_POIFS_LIST(/obj/item/clothing/under/rank/chief_engineer)
ADD_TO_POIFS_LIST(/obj/item/clothing/under/rank/chief_medical_officer)
ADD_TO_POIFS_LIST(/obj/item/clothing/under/rank/head_of_security)
ADD_TO_POIFS_LIST(/obj/item/clothing/under/rank/head_of_personnel)
ADD_TO_POIFS_LIST(/obj/item/weapon/reagent_containers/hypospray/cmo)
ADD_TO_POIFS_LIST(/obj/item/weapon/pinpointer)
ADD_TO_POIFS_LIST(/obj/item/clothing/suit/armor/laserproof)
ADD_TO_POIFS_LIST(/obj/item/weapon/reagent_containers/spray/extinguisher/golden)
ADD_TO_POIFS_LIST(/obj/item/weapon/gun/energy/gun/nuclear)
ADD_TO_POIFS_LIST(/obj/item/weapon/pickaxe/drill/diamond_drill)
ADD_TO_POIFS_LIST(/obj/item/weapon/storage/backpack/holding)
ADD_TO_POIFS_LIST(/obj/item/weapon/stock_parts/cell/hyper)
ADD_TO_POIFS_LIST(/obj/item/stack/sheet/mineral/diamond)
ADD_TO_POIFS_LIST(/obj/item/stack/sheet/mineral/gold)
ADD_TO_POIFS_LIST(/obj/item/stack/sheet/mineral/uranium)
#undef ADD_TO_POIFS_LIST

/datum/objective/steal
	var/obj/item/steal_target
	var/target_name

	var/static/possible_items[] = list(
		"старый лазерный пистолет капитана (captain's antique laser gun)" = /obj/item/weapon/gun/energy/laser/selfcharging/captain,
		"ручной телепортер (hand teleporter)" = /obj/item/weapon/hand_tele,
		"капитанский джетпак (captain's jetpack)" = /obj/item/weapon/tank/jetpack/oxygen,
		"капитанскую униформу (captain's jumpsuit)" = /obj/item/clothing/under/rank/captain,
		"работающий ИИ" = /obj/item/device/aicard,
		"чертежи станции (station blueprints)" = /obj/item/blueprints,
		"космический костюм НАС (nasa voidsuit)" = /obj/item/clothing/suit/space/nasavoid,
		"28 молей форона (полный бак) (28 moles of phoron)" = /obj/item/weapon/tank,
		"образец экстракта слайма (slime extract)" = /obj/item/slime_extract,
		"кусочек мяса корги (corgi meat)" = /obj/item/weapon/reagent_containers/food/snacks/meat/corgi,
		"униформу директора научного отдела (research director's jumpsuit)" = /obj/item/clothing/under/rank/research_director,
		"униформу главного инженера (chief engineer's jumpsuit)" = /obj/item/clothing/under/rank/chief_engineer,
		"униформу главного врача (chief medical officer's jumpsuit)" = /obj/item/clothing/under/rank/chief_medical_officer,
		"униформу главы службы безопасности (head of security's jumpsuit)" = /obj/item/clothing/under/rank/head_of_security,
		"униформу главы персонала (head of personnel's jumpsuit)" = /obj/item/clothing/under/rank/head_of_personnel,
		"гипоспрей (hypospray)" = /obj/item/weapon/reagent_containers/hypospray/cmo,
		"пинпойтер капитана (captain's pinpointer)" = /obj/item/weapon/pinpointer,
		"абляционный бронежилет (ablative armor vest)" = /obj/item/clothing/suit/armor/laserproof,
		"золотой огнетушитель (golden fire extinguisher)" = /obj/item/weapon/reagent_containers/spray/extinguisher/golden,
	)

	var/static/possible_items_special[] = list(
		/*"nuclear authentication disk" = /obj/item/weapon/disk/nuclear,*///Broken with the change to nuke disk making it respawn on z level change.
		"ядерную пушку (nuclear gun)" = /obj/item/weapon/gun/energy/gun/nuclear,
		"алмазную дрель (diamond drill)" = /obj/item/weapon/pickaxe/drill/diamond_drill,
		"сумку для хранения (bag of holding)" = /obj/item/weapon/storage/backpack/holding,
		"аккумулятор повышенной емкости (hyper-capacity cell)" = /obj/item/weapon/stock_parts/cell/hyper,
		"10 алмазов (diamonds)" = /obj/item/stack/sheet/mineral/diamond,
		"50 золотых слитков (gold bars)" = /obj/item/stack/sheet/mineral/gold,
		"25 очищенного урана (refined uranium bars)" = /obj/item/stack/sheet/mineral/uranium,
	)

/datum/objective/steal/proc/set_target(item_name)
	target_name = item_name
	steal_target = possible_items[target_name]
	if (!steal_target )
		steal_target = possible_items_special[target_name]
	explanation_text = "Украдите [target_name]."
	return steal_target


/datum/objective/steal/find_target()
	set_target(pick(possible_items))
	return TRUE

/datum/objective/steal/select_target()
	var/list/possible_items_all = possible_items+possible_items_special+"custom"
	var/new_target = input("Select target:", "Objective target", steal_target) as null|anything in possible_items_all
	if (!new_target)
		return FALSE
	if (new_target == "custom")
		var/obj/item/custom_target = input("Select type:","Type") as null|anything in typesof(/obj/item)
		if (!custom_target)
			return FALSE
		var/tmp_obj = new custom_target
		var/custom_name = tmp_obj:name
		qdel(tmp_obj)
		custom_name = sanitize_safe(input("Enter target name:", "Objective target", input_default(custom_name)) as text|null)
		if (!custom_name)
			return FALSE
		target_name = custom_name
		steal_target = custom_target
		explanation_text = "Украдите [target_name]."
	else
		set_target(new_target)
	auto_target = FALSE
	return TRUE

/datum/objective/steal/check_completion()
	if(!steal_target || !owner.current)	return OBJECTIVE_LOSS
	if(!isliving(owner.current))	return OBJECTIVE_LOSS
	var/list/all_items = owner.current.GetAllContents()
	switch (target_name)
		if("28 молей форона (полный бак) (28 moles of phoron)" ,"10 алмазов (diamonds)","50 золотых слитков (gold bars)","25 очищенного урана (refined uranium bars)")
			var/target_amount = text2num(target_name)//Non-numbers are ignored.
			var/found_amount = 0.0//Always starts as zero.

			for(var/obj/item/I in all_items) //Check for phoron tanks
				if(istype(I, steal_target))
					found_amount += (target_name == "28 молей форона (полный бак) (28 moles of phoron)" ? (I:air_contents:gas["phoron"]) : (I:amount))
			return found_amount>=target_amount

		if("50 монет (в сумке)")
			var/obj/item/weapon/moneybag/B = locate() in all_items

			if(B)
				var/target = text2num(target_name)
				var/found_amount = 0.0
				for(var/obj/item/weapon/coin/C in B)
					found_amount++
				return found_amount>=target

		if("работающий ИИ")
			for(var/obj/item/device/aicard/C in all_items) //Check for ai card
				for(var/mob/living/silicon/ai/M in C)
					if(isAI(M) && M.stat != DEAD) //See if any AI's are alive inside that card.
						return OBJECTIVE_WIN

			for(var/obj/item/clothing/suit/space/space_ninja/S in all_items) //Let an AI downloaded into a space ninja suit count
				if(S.AI && S.AI.stat != DEAD)
					return OBJECTIVE_WIN
			for(var/mob/living/silicon/ai/ai as anything in ai_list)
				if(ai.stat == DEAD)
					continue
				if(istype(ai.loc, /turf))
					var/area/check_area = get_area(ai)
					if(istype(check_area, /area/shuttle/escape/centcom))
						return OBJECTIVE_WIN
					if(istype(check_area, /area/shuttle/escape_pod1/centcom))
						return OBJECTIVE_WIN
					if(istype(check_area, /area/shuttle/escape_pod2/centcom))
						return OBJECTIVE_WIN
					if(istype(check_area, /area/shuttle/escape_pod3/centcom))
						return OBJECTIVE_WIN
					if(istype(check_area, /area/shuttle/escape_pod4/centcom))
						return OBJECTIVE_WIN
		else

			for(var/obj/I in all_items) //Check for items
				if(istype(I, steal_target))
					return OBJECTIVE_WIN
	return OBJECTIVE_LOSS
