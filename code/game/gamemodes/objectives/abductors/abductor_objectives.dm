// OBJECTIVES
/datum/objective/experiment
//	dangerrating = 10
	target_amount = 6
	var/team

/datum/objective/experiment/New()
	explanation_text = "Проведите эксперимент на [target_amount] людях."

/datum/objective/experiment/check_completion()
	. = OBJECTIVE_LOSS
	var/ab_team = team
	for(var/obj/machinery/abductor/experiment/E in abductor_machinery_list)
		if(E.team == ab_team)
			if(E.all_points >= target_amount)
				return OBJECTIVE_WIN

/datum/objective/abductee
	completed = OBJECTIVE_WIN

/datum/objective/abductee/steal
	explanation_text = "Украдите всё"

/datum/objective/abductee/steal/New()
	var/target = pick(list("pets","lights","monkeys","fruits","shoes","bars of soap"))
	explanation_text += " [target]."

/datum/objective/abductee/capture
	explanation_text = "Захватить"

/datum/objective/abductee/capture/New()
	var/list/jobs = get_job_datums()
	for(var/datum/job/J in jobs)
		if(J.current_positions < 1)
			jobs -= J
	if(jobs.len > 0)
		var/datum/job/target = pick(jobs)
		explanation_text += " [target.title]."
	else
		explanation_text += " кого-то."

/datum/objective/abductee/shuttle
	explanation_text = "Вы должны сбежать со станции! Вызовите шаттл!"

/datum/objective/abductee/noclone
	explanation_text = "Не позволяйте никого клонировать."

/datum/objective/abductee/blazeit
	explanation_text = "Ваше тело должно быть улучшено. Принимайте столько лекарств, сколько сможете."

/datum/objective/abductee/yumyum
	explanation_text = "Вы голодны. Ешьте столько еды, сколько сможете найти."

/datum/objective/abductee/insane
	explanation_text = "Ты видишь ты видишь то, что они не могут ты видишь открытую дверь ты видишь ты видИшь ты ВИДишь ТЫ видииИИиишь ПОКАЖИ ИМ ВСЕ"

/datum/objective/abductee/cannotmove
	explanation_text = "Убедите людей, что у вас паралич нижних конечностей."

/datum/objective/abductee/deadbodies
	explanation_text = "Начать сбор трупов. Не убивайте людей, чтобы получить эти трупы."

/datum/objective/abductee/floors
	explanation_text = "Замените всю напольную плитку ковром, деревянными досками или травой."

/datum/objective/abductee/powerunlimited
	explanation_text = "Затопите сеть энергоснабжения станции таким количеством электроэнергии, какое только сможете."

/datum/objective/abductee/pristine
	explanation_text = "Убедитесь, что станция находится в абсолютно первозданном состоянии."

/datum/objective/abductee/window
	explanation_text = "Замените ВСЕ обычные окна на усиленные."

/datum/objective/abductee/nations
	explanation_text = "Обеспечьте процветание вашего отдела больше всего."

/datum/objective/abductee/abductception
	explanation_text = "Вы изменились навсегда. Найдите тех, кто сделал это с вами, и дайте им попробовать их собственное лекарство."

/datum/objective/abductee/ghosts
	explanation_text = "Проведите спиритический сеанс с духами загробной жизни."

/datum/objective/abductee/summon
	explanation_text = "Проведите ритуал вызова старшего бога."

/datum/objective/abductee/machine
	explanation_text = "Вы тайно являетесь андроидом. Взаимодействуйте с как можно большим количеством машин, чтобы увеличить свою собственную мощность."

/datum/objective/abductee/prevent
	explanation_text = "Вы были просветлены. Это знание не должно ускользнуть. Убедитесь, что никто другой не сможет стать просветленным."

/datum/objective/abductee/calling
	explanation_text = "Призови духа с другой стороны."

/datum/objective/abductee/calling/New()
	var/mob/dead/D = pick(dead_mob_list)
	if(D)
		explanation_text = "Вы знаете, что [D] погиб. Призови духа из царства духов."

/datum/objective/abductee/social_experiment
	explanation_text = "Это секретный социальный эксперимент, проводимый компанией НаноТрейзен. Убедите всех, что это правда."

/datum/objective/abductee/vr
	explanation_text = "Все это полностью виртуальная симуляция в подземном хранилище. Убедите всех вырваться из оков виртуальной реальности."

/datum/objective/abductee/pets
	explanation_text = "НаноТрейзен издевается над животными! Спасите столько, сколько сможете!"

/datum/objective/abductee/defect
	explanation_text = "Дефект от вашего работодателя."

/datum/objective/abductee/promote
	explanation_text = "Поднимитесь по корпоративной лестнице до самого верха!"

/datum/objective/abductee/science
	explanation_text = "Так много осталось нераскрытым. Загляни глубже в махинации вселенной."

/datum/objective/abductee/build
	explanation_text = "Расширьте станцию."

/datum/objective/abductee/pragnant
	explanation_text = "Вы беременны, и скоро роды. Найдите безопасное место для родов вашего ребенка."
