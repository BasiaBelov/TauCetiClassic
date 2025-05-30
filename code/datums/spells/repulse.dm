/obj/effect/proc_holder/spell/aoe_turf/repulse
	name = "Репульс"
	desc = "Заклинание отбрасывает все вещи и людей от вас подальше."
	charge_max = 200
	clothes_req = 1
	invocation = "GITTAH WEIGH"
	invocation_type = "shout"
	range = 5
	selection_type = "view"
	sound = 'sound/magic/Repulse.ogg'
	var/maxthrow = 5
	action_icon_state = "repulse"

/obj/effect/proc_holder/spell/aoe_turf/repulse/cast(list/targets, mob/user = usr)
	var/list/thrownatoms = list()
	var/atom/throwtarget
	var/distfromcaster
	for(var/turf/T in targets) //Done this way so things don't get thrown all around hilariously.
		for(var/atom/movable/AM in T)
			thrownatoms += AM

	for(var/atom/movable/AM in thrownatoms)
		if(AM == user || AM.anchored)
			continue

		if(ishuman(AM)) // AIR_FLOW_PROTECT defends a human from repulse
			var/mob/living/carbon/human/H = AM
			if(H.shoes && (H.shoes.flags & AIR_FLOW_PROTECT))
				continue
			if(H.wear_suit && (H.wear_suit.flags & AIR_FLOW_PROTECT))
				continue

		throwtarget = get_edge_target_turf(user, get_dir(user, get_step_away(AM, user)))
		distfromcaster = get_dist(user, AM)
		if(distfromcaster == 0)
			if(isliving(AM))
				var/mob/living/M = AM
				M.Stun(2)
				M.Weaken(5)
				M.adjustBruteLoss(5)
				to_chat(M, "<span class='userdanger'>You're slammed into the floor by [user]!</span>")
		else
			new /obj/effect/effect/sparks(get_turf(AM)) //created sparkles will disappear on their own
			if(isliving(AM))
				var/mob/living/M = AM
				M.Stun(1)
				M.Weaken(2)
				to_chat(M, "<span class='userdanger'>You're thrown back by [user]!</span>")
			AM.throw_at(throwtarget, ((clamp((maxthrow - (clamp(distfromcaster - 2, 0, distfromcaster))), 3, maxthrow))), 1, user)//So stuff gets tossed around at the same time.
