/obj/effect/proc_holder/changeling/chemicalsynth
	name = "Rapid Chemical-Synthesis"
	desc = "Мы можем найти лучший способ выработки химикатов."
	helptext = "Удваивает скорость, выработки химикатов."
	genomecost = 2
	chemical_cost = -1

/obj/effect/proc_holder/changeling/chemicalsynth/on_purchase(mob/user)
	..()
	var/datum/role/changeling/changeling = user.mind.GetRoleByType(/datum/role/changeling)
	changeling.chem_recharge_rate *= 2
