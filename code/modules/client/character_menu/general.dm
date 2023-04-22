/datum/preferences/proc/ShowGeneral(mob/user)
	var/datum/species/specie_obj = all_species[species]
	. =  "<table cellspacing='0' width='100%'>"	//Main body table start
	. += 	"<tr>"
	. += 		"<td width='340px' height='320px' style='padding-left:25px'>"

	//General
	. += 			"<table width='100%' cellpadding='5' cellspacing='0'>"	//General table start
	. += 				"<tr valign='top'>"
	. += 					"<td colspan='2'>"
	. += 						"<b>Имя:</b> "
	. += 						"<a href='?_src_=prefs;preference=name;task=input'><b>[real_name]</b></a>"
	. += 						"<br>(<a href='?_src_=prefs;preference=name;task=random'>Случайное имя</a>)"
	. += 						"<br>(<a href='?_src_=prefs;preference=name'>Всегда случайное имя: [be_random_name ? "Да" : "Нет"]</a>)"
	. += 						"<br><b>Пол:</b> <a href='?_src_=prefs;preference=gender'><b>[gender == MALE ? "Мужской" : "Женский"]</b></a>"
	. += 						"<br><b>Возраст:</b> <a href='?_src_=prefs;preference=age;task=input'>[age]</a>"
	. += 						"<br><b>Рост:</b> <a href='?_src_=prefs;preference=height;task=input'>[height]</a>"
	. += 						"<br><b>Случайный слот персонажа:</b> <a href='?_src_=prefs;preference=randomslot'><b>[randomslot ? "Да" : "Нет"]</b></a>"
	. += 						"<hr>"
	. += 					"</td>"
	. += 				"</tr>"

	//Character setup menu
	. += 				"<tr>"
	. += 					"<td>"
	. += 						"<center>"
	. += 						"<b>Настройка персонажа</b>"
	. += 						"<br>"
	. += 						"[submenu_type=="body"?"<b>Тело</b>":"<a href=\"byond://?src=\ref[user];preference=body\">Тело</a>"] - "
	. += 						"[submenu_type=="organs"?"<b>Органы</b>":"<a href=\"byond://?src=\ref[user];preference=organs\">Органы</a>"] - "
	. += 						"[submenu_type=="appearance"?"<b>Внешность</b>":"<a href=\"byond://?src=\ref[user];preference=appearance\">Внешность</a>"] - "
	. += 						"[submenu_type=="gear"?"<b>Одежда</b>":"<a href=\"byond://?src=\ref[user];preference=gear\">Одежда</a>"]"
	. += 						"</center>"
	. += 						"<br>"
	. += 						"<table border width='100%' background='opacity7.png' bordercolor='5A6E7D' cellspacing='0'>"	//Submenu table start
	. += 							"<tr valign='top'>"
	. += 								"<td height='180px'>"

	switch(submenu_type)	//Submenu
		//Body
		if("body")
			. += "Тело: <a href='?_src_=prefs;preference=all;task=random'>&reg;</a>"
			. += "<br>Раса: <a href='byond://?src=\ref[user];preference=species;task=input'>[species]</a>"
			. += "<br>Второй язык: <a href='byond://?src=\ref[user];preference=language;task=input'>[language]</a>"
			if(!specie_obj.flags[NO_BLOOD])
				. += "<br>Тип крови: <a href='byond://?src=\ref[user];preference=b_type;task=input'>[b_type]</a>"
			if(specie_obj.flags[HAS_SKIN_TONE])
				. += "<br>Цвет кожи: <a href='?_src_=prefs;preference=s_tone;task=input'>[-s_tone + 35]/220</a>"

		//Organs
		if("organs")
			. += "Конечности и внутренние органы: <a href='byond://?src=\ref[user];preference=organs;task=input'>Настроить</a>"

			//(display limbs below)
			var/ind = 0
			for(var/name in organ_data)
				//world << "[ind] \ [organ_data.len]"
				var/status = organ_data[name]
				var/organ_name = parse_zone(name)
				switch(name)
					if(BP_L_ARM)
						organ_name = "Левая рука"
					if(BP_R_ARM)
						organ_name = "Правая рука"
					if(BP_L_LEG)
						organ_name = "Левая нога"
					if(BP_R_LEG)
						organ_name = "Правая нога"
					if(O_HEART)
						organ_name = "Сердце"
					if(O_EYES)
						organ_name = "Глаза"

				if(status == "cyborg")
					++ind
					. += "<li>Механический протез - [organ_name]</li>"
				else if(status == "amputated")
					++ind
					. += "<li>Ампутировано - [organ_name]</li>"
				else if(status == "mechanical")
					++ind
					. += "<li>Механика - [organ_name]</li>"
				else if(status == "assisted")
					++ind
					switch(organ_name)
						if("heart")
							. += "<li>[organ_name]  с кардиостимулятором</li>"
						if("eyes")
							. += "<li>[organ_name] с наложением сетчатки</li>"
						else
							. += "<li>[organ_name] с механической поддержкой</li>"
			if(species == IPC)
				. += "<br>Голова: <a href='byond://?src=\ref[user];preference=ipc_head;task=input'>[ipc_head]</a>"

			if(!ind)
				. += "<br>\[...\]"
		//Appearance
		if("appearance")
			if(species == IPC)
				. += "<b>Экран СПУ</b>"
			else
				. += "<b>Волосы</b>"
			. += "<br>"
			if(specie_obj.flags[HAS_HAIR_COLOR])
				. += "<a href='?_src_=prefs;preference=hair;task=input'>Цвет</a> [color_square(r_hair, g_hair, b_hair)]"
				. += " Причёска: <a class='white' href='?_src_=prefs;preference=h_style_left;task=input'><</a> <a class='white' href='?_src_=prefs;preference=h_style_right;task=input'>></a> <a href='?_src_=prefs;preference=h_style;task=input'>[h_style]</a><br>"
				. += "<b>Gradient</b>"
				. += "<br><a href='?_src_=prefs;preference=grad_color;task=input'>Цвет</a> [color_square(r_grad, g_grad, b_grad)] "
				. += " Стиль: <a class='white' href='?_src_=prefs;preference=grad_style_left;task=input'><</a> <a class='white' href='?_src_=prefs;preference=grad_style_right;task=input'>></a> <a href='?_src_=prefs;preference=grad_style;task=input'>[grad_style]</a><br>"
			else
				. += " Стиль: <a class='white' href='?_src_=prefs;preference=h_style_left;task=input'><</a> <a class='white' href='?_src_=prefs;preference=h_style_right;task=input'>></a> <a href='?_src_=prefs;preference=h_style;task=input'>[h_style]</a><br>"
			. += "<b>Борода</b>"
			. += "<br><a href='?_src_=prefs;preference=facial;task=input'>Цвет</a> [color_square(r_facial, g_facial, b_facial)]"
			. += " Стиль: <a class='white' href='?_src_=prefs;preference=f_style_left;task=input'><</a> <a class='white' href='?_src_=prefs;preference=f_style_right;task=input'>></a> <a href='?_src_=prefs;preference=f_style;task=input'>[f_style]</a><br>"
			. += "<b>Глаза</b>"
			. += "<br><a href='?_src_=prefs;preference=eyes;task=input'>Цвет</a> [color_square(r_eyes, g_eyes, b_eyes)]<br>"

			if(specie_obj.flags[HAS_SKIN_COLOR])
				. += "<b>Цвет тела</b>"
				. += "<br><a href='?_src_=prefs;preference=skin;task=input'>Цвет</a> [color_square(r_skin, g_skin, b_skin)]"

		//Gear
		if("gear")
			. += "<b>Одежда:</b><br>"
			if(specie_obj.flags[HAS_UNDERWEAR])
				if(gender == MALE)
					. += "Нижнее белье: <a href ='?_src_=prefs;preference=underwear;task=input'>[underwear_m[underwear]]</a><br>"
				else
					. += "Нижнее белье: <a href ='?_src_=prefs;preference=underwear;task=input'>[underwear_f[underwear]]</a><br>"
				. += "Майка: <a href='?_src_=prefs;preference=undershirt;task=input'>[undershirt_t[undershirt]]</a><br>"
				. += "Носки: <a href='?_src_=prefs;preference=socks;task=input'>[socks_t[socks]]</a><br>"
			. += "Тип сумки: <a href ='?_src_=prefs;preference=bag;task=input'>[backbaglist[backbag]]</a><br>"
			. += "Юбочная униформа: <a href ='?_src_=prefs;preference=use_skirt;task=input'>[use_skirt ? "Да" : "Нет"]</a>"

	. += 								"</td>"
	. += 							"</tr>"
	. += 						"</table>"	//Submenu table end
	. += 					"</td>"
	. += 				"</tr>"

	. += 			"</table>"	//General table end
	. += 		"</td>"

	. += 		"<td width='300px' height='300px' valign='top'>"
	. += 			"<table width='100%' cellpadding='5'>"	//Backstory table start
	. += 				"<tr>"
	. += 					"<td>"

	//Backstory
	. += 						"<b>Основная информация:</b>"
	. += 						"<br>Отношение с НаноТрейзен: <a href ='?_src_=prefs;preference=nt_relation;task=input'>[nanotrasen_relation]</a>"
	. += 						"<br>Родная система: <a href='byond://?src=\ref[user];preference=home_system;task=input'>[home_system]</a>"
	. += 						"<br>Гражданство: <a href='byond://?src=\ref[user];preference=citizenship;task=input'>[citizenship]</a>"
	. += 						"<br>Фракция: <a href='byond://?src=\ref[user];preference=faction;task=input'>[faction]</a>"
	. += 						"<br>Религия: <a href='byond://?src=\ref[user];preference=religion;task=input'>[religion]</a>"
	if(species == VOX)
		. += 						"<br>Ранг: <a href='byond://?src=\ref[user];preference=vox_rank;task=input'>[vox_rank]</a>"
	. += 						"<br>"

	if(jobban_isbanned(user, "Records"))
		. += 					"<br><b>Вам запрещено использовать записи персонажей.</b><br>"
	else
		. += 					"<br><b>Записи:</b>"
		. += 					"<br>Медицинские записи:"
		. += 					" <a href=\"byond://?src=\ref[user];preference=records;task=med_record\">[length(med_record)>0?"[copytext_char(med_record, 1, 3)]...":"\[...\]"]</a>"
		. += 					"<br>Записи безопасности:"
		. += 					" <a href=\"byond://?src=\ref[user];preference=records;task=sec_record\">[length(sec_record)>0?"[copytext_char(sec_record, 1, 3)]...":"\[...\]"]</a>"
		. += 					"<br>Записи о занятости:"
		. += 					" <a href=\"byond://?src=\ref[user];preference=records;task=gen_record\">[length(gen_record)>0?"[copytext_char(gen_record, 1, 3)]...":"\[...\]"]</a>"

	. += 						"<br><br>"

	. += 						"<b>Внешность:</b>"
	. += 						" <a href='byond://?src=\ref[user];preference=flavor_text;task=input'>[length(flavor_text)>0?"[copytext_char(flavor_text, 1, 3)]...":"\[...\]"]</a>"
	. += 					"</td>"
	. += 				"</tr>"
	. += 			"</table>"	//Backstory table end
	. += 		"</td>"
	. += 	"</tr>"
	. += "</table>"	//Main body table end

/proc/color_square(red, green, blue, hex)
	var/color = hex ? hex : "#[num2hex(red, 2)][num2hex(green, 2)][num2hex(blue, 2)]"
	return "<font face='fixedsys' size='3' color='[color]'><table border cellspacing='0' style='display:inline;' bgcolor='[color]'><tr><td width='20' height='15'></td></tr></table></font>"

/datum/preferences/proc/process_link_general(mob/user, list/href_list)
	switch(href_list["preference"])
		if("records")
			switch(href_list["task"])
				if("med_record")
					var/medmsg = sanitize(input(usr,"Введите свои медицинские записи.","Медицинские записи",input_default(med_record)) as message, MAX_PAPER_MESSAGE_LEN, extra = FALSE)

					if(medmsg != null)
						med_record = medmsg

				if("sec_record")
					var/secmsg = sanitize(input(usr,"Введите свои примечания безопасности.","Записи безопасности",input_default(sec_record)) as message, MAX_PAPER_MESSAGE_LEN, extra = FALSE)

					if(secmsg != null)
						sec_record = secmsg

				if("gen_record")
					var/genmsg = sanitize(input(usr,"Введите свои заметки о трудоустройстве.","Записи о занятости",input_default(gen_record)) as message, MAX_PAPER_MESSAGE_LEN, extra = FALSE)

					if(genmsg != null)
						gen_record = genmsg

	var/datum/species/specie_obj = all_species[species]

	switch(href_list["task"])
		if("random")
			switch(href_list["preference"])
				if("name")
					real_name = random_name(gender)
				if("age")
					age = rand(specie_obj.min_age, specie_obj.max_age)
				if("height")
					height = HUMANHEIGHT_MEDIUM
				if("hair")
					r_hair = rand(0,255)
					g_hair = rand(0,255)
					b_hair = rand(0,255)
				if("h_style")
					h_style = random_hair_style(gender, species, ipc_head)
				if("facial")
					r_facial = rand(0,255)
					g_facial = rand(0,255)
					b_facial = rand(0,255)
				if("f_style")
					f_style = random_facial_hair_style(gender, species)
				if("underwear")
					if(gender == MALE)
						underwear = rand(1, underwear_m.len)
					else
						underwear = rand(1, underwear_f.len)
				if("undershirt")
					undershirt = rand(1,undershirt_t.len)
				if("socks")
					socks = rand(1,socks_t.len)
				if("eyes")
					r_eyes = rand(0,255)
					g_eyes = rand(0,255)
					b_eyes = rand(0,255)
				if("s_tone")
					s_tone = random_skin_tone()
				if("s_color")
					r_skin = rand(0,255)
					g_skin = rand(0,255)
					b_skin = rand(0,255)
				if("bag")
					backbag = rand(1, backbaglist.len)
				if("use_skirt")
					use_skirt = pick(TRUE, FALSE)
				if("all")
					randomize_appearance_for()	//no params needed
		if("input")
			switch(href_list["preference"])
				if("name")
					var/new_name = sanitize_name(input(user, "Введите имя персонажа:", "Имя персонажа", real_name) as text|null)
					if(new_name)
						real_name = new_name
					else
						to_chat(user, "<font color='red'>Ошибка. Ваше имя должно содержать не менее 2-х и не более [MAX_NAME_LEN] символов. Он может содержать только символы A-Z, a-z, -, ' и .</font>")

				if("age")
					var/new_age = input(user, "Введите возраст персонажа:\n([specie_obj.min_age]-[specie_obj.max_age])", "Возраст персонажа", age) as num|null
					if(new_age)
						age = max(min( round(text2num(new_age)), specie_obj.max_age), specie_obj.min_age)

				if("height")
					var/new_height = input(user, "Выберите рост персонажа:", "Рост персонажа", height) as null|anything in heights_list
					if(new_height)
						height = new_height

				if("species")
					var/list/new_species = list(HUMAN)
					var/prev_species = species
					var/whitelisted = 0

					if(config.usealienwhitelist) //If we're using the whitelist, make sure to check it!
						for(var/S in whitelisted_species)
							if(is_alien_whitelisted(user,S))
								new_species += S
								whitelisted = 1
						if(!whitelisted)
							tgui_alert(user, "Вы не можете изменить расу, так как вы должны быть внесены в белый список. Если вы хотите попасть в белый список, проверьте наш форум.")
					else //Not using the whitelist? Aliens for everyone!
						new_species = whitelisted_species

					species = input("Выберите расу", "Выбор", prev_species) in new_species

					if(prev_species != species)
						f_style = random_facial_hair_style(gender, species)
						h_style = random_hair_style(gender, species, ipc_head)
						ResetJobs()
						UpdateAllowedQuirks()
						ResetQuirks()
						if(language && language != "None")
							var/datum/language/lang = all_languages[language]
							if(!(species in lang.allowed_speak))
								language = "None"

				if("language")
					var/list/new_languages = list("None")
					var/datum/species/S = all_species[species]
					for(var/L in all_languages)
						var/datum/language/lang = all_languages[L]
						if(!(lang.flags & RESTRICTED) && (S.name in lang.allowed_speak))
							new_languages += lang.name

					language = input("Выберите второй язык персонажа", "Выбор", language) in new_languages

				if("b_type")
					if(specie_obj.flags[NO_BLOOD])
						return
					var/new_b_type = input(user, "Выберите тип крови персонажа:", "Тип крови", b_type) as null|anything in list( "A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-" )
					if(new_b_type)
						b_type = new_b_type

				if("hair")
					if(!specie_obj.flags[HAS_HAIR_COLOR])
						return
					var/new_hair = input(user, "Выберите цвет волос персонажа:", "Цвет волос персонажа", rgb(r_hair, g_hair, b_hair)) as color|null
					if(new_hair)
						r_hair = hex2num(copytext(new_hair, 2, 4))
						g_hair = hex2num(copytext(new_hair, 4, 6))
						b_hair = hex2num(copytext(new_hair, 6, 8))

				if("h_style")
					var/list/valid_hairstyles = get_valid_styles_from_cache(hairs_cache)
					var/new_h_style = input(user, "Выберите причёску:", "Причёска персонажа", h_style) as null|anything in valid_hairstyles
					if(new_h_style)
						h_style = new_h_style

				if("h_style_left")
					var/list/valid_hairstyles = get_valid_styles_from_cache(hairs_cache)
					h_style = valid_hairstyles[h_style][LEFT]

				if("h_style_right")
					var/list/valid_hairstyles = get_valid_styles_from_cache(hairs_cache)
					h_style = valid_hairstyles[h_style][RIGHT]

				if("grad_color")
					if(!specie_obj.flags[HAS_HAIR_COLOR])
						return
					var/new_grad = input(user, "Выберите второй цвет причёски:", "Цвет градиента", rgb(r_grad, g_grad, b_grad)) as color|null
					if(new_grad)
						r_grad = hex2num(copytext(new_grad, 2, 4))
						g_grad = hex2num(copytext(new_grad, 4, 6))
						b_grad = hex2num(copytext(new_grad, 6, 8))

				if("grad_style")
					var/list/valid_gradients = hair_gradients
					var/new_grad_style = input(user, "Выберите стиль градиента:", "Градиент причёски", grad_style) as null|anything in valid_gradients
					if(new_grad_style)
						grad_style = new_grad_style

				if("grad_style_left")
					var/list/valid_gradients = hair_gradients
					var/grad_style_num = get_left_right_style_num(LEFT, valid_gradients, grad_style)
					grad_style = valid_gradients[grad_style_num]

				if("grad_style_right")
					var/list/valid_gradients = hair_gradients
					var/grad_style_num = get_left_right_style_num(RIGHT, valid_gradients, grad_style)
					grad_style = valid_gradients[grad_style_num]

				if("facial")
					var/new_facial = input(user, "Выберите цвет бороды:", "Цвет бороды", rgb(r_facial, g_facial, b_facial)) as color|null
					if(new_facial)
						r_facial = hex2num(copytext(new_facial, 2, 4))
						g_facial = hex2num(copytext(new_facial, 4, 6))
						b_facial = hex2num(copytext(new_facial, 6, 8))

				if("f_style")
					var/list/valid_facialhairstyles = get_valid_styles_from_cache(facial_hairs_cache)
					var/new_f_style = input(user, "Выберите бороду:", "Борода персонажа", f_style) as null|anything in valid_facialhairstyles
					if(new_f_style)
						f_style = new_f_style

				if("f_style_left")
					var/list/valid_facialhairstyles = get_valid_styles_from_cache(facial_hairs_cache)
					f_style = valid_facialhairstyles[f_style][LEFT]

				if("f_style_right")
					var/list/valid_facialhairstyles = get_valid_styles_from_cache(facial_hairs_cache)
					f_style = valid_facialhairstyles[f_style][RIGHT]

				if("underwear")
					if(!specie_obj.flags[HAS_UNDERWEAR])
						return
					var/list/underwear_options
					if(gender == MALE)
						underwear_options = underwear_m
					else
						underwear_options = underwear_f

					var/new_underwear = input(user, "Выберите нижнее бельё:", "Предпочтения персонажа", underwear_options[underwear]) as null|anything in underwear_options
					if(new_underwear)
						underwear = underwear_options.Find(new_underwear)

				if("undershirt")
					var/list/undershirt_options
					undershirt_options = undershirt_t

					var/new_undershirt = input(user, "Выберите майку:", "Предпочтения персонажа", undershirt_options[undershirt]) as null|anything in undershirt_options
					if (new_undershirt)
						undershirt = undershirt_options.Find(new_undershirt)
				if("socks")
					var/list/socks_options
					socks_options = socks_t
					var/new_socks = input(user, "Выберите носки:", "Предпочтения персонажа", socks_options[socks]) as null|anything in socks_options
					if(new_socks)
						socks = socks_options.Find(new_socks)

				if("eyes")
					var/new_eyes = input(user, "Выберите цвет глаз:", "Предпочтения персонажа", rgb(r_eyes, g_eyes, b_eyes)) as color|null
					if(new_eyes)
						r_eyes = hex2num(copytext(new_eyes, 2, 4))
						g_eyes = hex2num(copytext(new_eyes, 4, 6))
						b_eyes = hex2num(copytext(new_eyes, 6, 8))

				if("s_tone")
					if(!specie_obj.flags[HAS_SKIN_TONE])
						return
					var/new_s_tone = input(user, "Выберите цвет кожи:\n(Light 1 - 220 Dark)", "Предпочтения персонажа", 35 - s_tone ) as num|null
					if(new_s_tone)
						s_tone = 35 - max(min( round(new_s_tone), 220),1)

				if("skin")
					if(!specie_obj.flags[HAS_SKIN_COLOR])
						return
					var/new_skin = input(user, "Выберите цвет кожи: ", "Предпочтения персонажа", rgb(r_skin, g_skin, b_skin)) as color|null
					if(new_skin)
						r_skin = hex2num(copytext(new_skin, 2, 4))
						g_skin = hex2num(copytext(new_skin, 4, 6))
						b_skin = hex2num(copytext(new_skin, 6, 8))

				if("bag")
					var/new_backbag = input(user, "Выберите тип сумки:", "Предпочтения персонажа", backbaglist[backbag]) as null|anything in backbaglist
					if(new_backbag)
						backbag = backbaglist.Find(new_backbag)

				if("use_skirt")
					use_skirt = !use_skirt

				if("nt_relation")
					var/new_relation = input(user, "Выберите отношение к НаноТрейзен. Обратите внимание, что это отражает то, что другие могут узнать о вашем персонаже, изучив ваше прошлое, а не то, что ваш персонаж думает на самом деле.", "Отношение НаноТрейзен", nanotrasen_relation) as null|anything in list("Лояльный", "Поддерживающий", "Нейтральный", "Скептически настроенный", "Настроенный против")
					if(new_relation)
						nanotrasen_relation = new_relation

				if("home_system")
					var/choice = input(user, "Выберите родную систему персонажа.", "Родная система", home_system) as null|anything in home_system_choices + list("Нет","Другое") + home_system
					if(!choice)
						return
					if(choice == "Other")
						var/raw_choice = sanitize_name(input(user, "Введите родную систему персонажа.", "Родная система", home_system) as text|null)
						if(raw_choice)
							home_system = raw_choice
						else
							to_chat(user, "<font color='red'>Ошибка. Название должно содержать не менее 2-х и не более [MAX_NAME_LEN] символов. Он может содержать только символы A-Z, a-z, -, ' и .</font>")
						return
					home_system = choice

				if("citizenship")
					var/choice = input(user, "Выберите текущее гражданство персонажа.", "Гражданство", citizenship) as null|anything in citizenship_choices + list("Нет","Другое") + citizenship
					if(!choice)
						return
					if(choice == "Other")
						var/raw_choice = sanitize_name(input(user, "Введите текущее гражданство персонажа.", "Гражданство", citizenship) as text|null)
						if(raw_choice)
							citizenship = raw_choice
						else
							to_chat(user, "<font color='red'>Ошибка. Название должно содержать не менее 2-х и не более [MAX_NAME_LEN] символов. Он может содержать только символы A-Z, a-z, -, ' и .</font>")
						return
					citizenship = choice

				if("faction")
					var/choice = input(user, "Выберите фракцию, на котороую работает персонаж.", "Фракция", faction) as null|anything in faction_choices + list("Нет","Другое") + faction
					if(!choice)
						return
					if(choice == "Other")
						var/raw_choice = sanitize_name(input(user, "Введите фракцию.", "Фракция", faction) as text|null)
						if(raw_choice)
							faction = raw_choice
						else
							to_chat(user, "<font color='red'>Ошибка. Название должно содержать не менее 2-х и не более [MAX_NAME_LEN] символов. Он может содержать только символы A-Z, a-z, -, ' и .</font>")
						return
					faction = choice

				if("religion")
					var/choice = input(user, "Выберите религию персонажа.", "Религия", religion) as null|anything in religion_choices + list("Нет","Другое") + religion
					if(!choice)
						return
					if(choice == "Other")
						var/raw_choice = sanitize_name(input(user, "Введите религию.", "Религия", religion) as text|null)
						if(raw_choice)
							religion = raw_choice
						else
							to_chat(user, "<font color='red'>Ошибка. Название должно содержать не менее 2-х и не более [MAX_NAME_LEN] символов. Он может содержать только символы A-Z, a-z, -, ' и .</font>")
						return
					religion = choice

				if("vox_rank")
					var/choice = input(user, "Выберите ранг своего вокса.", "Ранг", vox_rank) as null|anything in rank_choices
					if(!choice)
						return
					vox_rank = choice

				if("flavor_text")
					var/msg = sanitize(input(usr,"Введите внешность. Она будет показывается, когда игрок 'посмотрит' на вашего персонажа.","Внешность", input_default(flavor_text)) as message)

					if(msg != null)
						flavor_text = msg

				if("organs")
					var/menu_type = input(user, "Menu") as null|anything in list("Конечности", "Органы")
					if(!menu_type) return

					switch(menu_type)
						if("Конечности")
							var/limb_name = input(user, "Какую конечность вы хотите изменить?") as null|anything in list("Левая нога", "Правая нога", "Левая рука", "Правая рука")
							if(!limb_name) return

							var/limb = null
							switch(limb_name)
								if("Левая нога")
									limb = BP_L_LEG
								if("Правая нога")
									limb = BP_R_LEG
								if("Левая рука")
									limb = BP_L_ARM
								if("Правая рука")
									limb = BP_R_ARM

							var/new_state = input(user, "В каком состоянии вы хотите видеть конечность?") as null|anything in list("Обычная","Ампутированная","Протез")
							if(!new_state) return

							switch(new_state)
								if("Обычная")
									organ_data[limb] = null
								if("Ампутированная")
									organ_data[limb] = "amputated"
								if("Протез")
									organ_data[limb] = "cyborg"

						if("Органы")
							var/organ_name = input(user, "Какой орган вы хотите изменить?") as null|anything in list("Сердце", "Глаза")
							if(!organ_name) return

							var/organ = null
							switch(organ_name)
								if("Сердце")
									organ = O_HEART
								if("Глаза")
									organ = O_EYES

							var/new_state = input(user, "В каком состоянии вы хотите видеть орган?") as null|anything in list("Обычный", "Вспомогательный", "Механический")
							if(!new_state) return

							switch(new_state)
								if("Обычный")
									organ_data[organ] = null
								if("Вспомогательный")
									organ_data[organ] = "assisted"
								if("Механический")
									organ_data[organ] = "mechanical"
				// Choosing a head for an IPC
				if("ipc_head")
					var/list/ipc_heads = list("Обычная", "Пришелец", "Двойная", "Столб", "Человек")
					ipc_head = input("Выберите тип головы", "Тип головы", null) in ipc_heads
					h_style = random_hair_style(gender, species, ipc_head)

		else
			switch(href_list["preference"])
				if("gender")
					if(gender == MALE)
						gender = FEMALE
					else
						gender = MALE

					f_style = random_facial_hair_style(gender, species)
					h_style = random_hair_style(gender, species, ipc_head)

				if("randomslot")
					randomslot = !randomslot

				if("name")
					be_random_name = !be_random_name

				if("body")
					submenu_type = "body"

				if("organs")
					submenu_type = "organs"

				if("appearance")
					submenu_type = "appearance"

				if("gear")
					submenu_type = "gear"

/datum/preferences/proc/get_valid_styles_from_cache(list/styles_cache)
	var/hash = "[species][gender][species == IPC ? ipc_head : ""]"
	return styles_cache[hash] || list()

/proc/get_valid_styles_from_cache(styles_cache, species, gender, ipc_head = "Обычная")
	var/hash = "[species][gender][species == IPC ? ipc_head : ""]"
	return styles_cache[hash] || list()

/datum/preferences/proc/get_left_right_style_num(direction, list/styles_list, style)
	var/style_num = styles_list.Find(style)
	switch(direction)
		if(LEFT)
			style_num = (style_num != 1) ? style_num - 1 : styles_list.len
		if(RIGHT)
			style_num = (style_num != styles_list.len) ? style_num + 1 : 1
	return style_num
