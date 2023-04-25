/datum/objective/silence
	explanation_text = "Не позволяйте никому сбежать со станции. Разрешайте вызывать шаттл только тогда, когда все будут мертвы и ваша история останется единой."

/datum/objective/silence/check_completion()
	if(SSshuttle.location<2)
		return OBJECTIVE_LOSS

	for(var/mob/living/player in player_list)
		if(player == owner.current)
			continue
		if(player.mind)
			if(player.stat != DEAD)
				var/turf/T = get_turf(player)
				if(!T)	continue
				switch(T.loc.type)
					if(/area/shuttle/escape/centcom, /area/shuttle/escape_pod1/centcom, /area/shuttle/escape_pod2/centcom, /area/shuttle/escape_pod3/centcom, /area/shuttle/escape_pod4/centcom)
						return OBJECTIVE_LOSS
	return OBJECTIVE_WIN
