/datum/emote/human/laugh
	key = "laugh"

	message_1p = "Вы смеётесь."
	message_3p = "смеётся."

	message_impaired_production = "беззвучно смеется."
	message_impaired_reception = "Вы видите, как кто-то открывает и закрывает рот, улыбаясь."

	message_miming = "изображает смех."
	message_muzzled = "слегка хихикает."

	message_type = SHOWMSG_AUDIO

	age_variations = TRUE

	state_checks = list(
		EMOTE_STATE(is_stat, CONSCIOUS)
	)

/datum/emote/human/laugh/get_sound(mob/living/carbon/human/user, intentional)
	var/static/list/laugh_by_gender_species = list(
		"[SKRELL][FEMALE]" = SOUNDIN_LAUGH_SKRELL_FEMALE,
		"[SKRELL][MALE]" = SOUNDIN_LAUGH_SKRELL_MALE,
	)

	var/g = user.gender == FEMALE ? FEMALE : MALE
	var/hash = "[user.get_species()][g]"

	if(laugh_by_gender_species[hash])
		return laugh_by_gender_species[hash]

	if(g == FEMALE)
		return pick(SOUNDIN_LAUGH_FEMALE)

	return pick(SOUNDIN_LAUGH_MALE)


/datum/emote/human/giggle
	key = "giggle"

	message_1p = "Вы хихикаете."
	message_3p = "хихикает."

	message_impaired_production = "слегка улыбается и беззвучно хихикает."
	message_impaired_reception = "Вы видите, как кто-то слегка открывает и закрывает рот, улыбаясь."

	message_miming = "кажется, хихикает."
	message_muzzled = "слегка хихикает."

	message_type = SHOWMSG_AUDIO

	state_checks = list(
		EMOTE_STATE(is_stat, CONSCIOUS),
	)


/datum/emote/human/grunt
	key = "grunt"

	message_1p = "Вы кряхтите"
	message_3p = "кряхтит."

	message_impaired_production = "корчится и слегка вздыхает."
	message_impaired_reception = "Вы видите, как кто-то стискивает зубы."

	message_miming = "кажется, кряхтит."
	message_muzzled = "беззвучно кряхтит!"

	message_type = SHOWMSG_AUDIO

	cloud = "cloud-pain"

	state_checks = list(
		EMOTE_STATE(is_stat, CONSCIOUS),
		EMOTE_STATE(is_intentional_or_species_no_flag, NO_PAIN),
	)

/datum/emote/human/grunt/get_sound(mob/living/carbon/human/user, intentional)
	return pick(user.gender == FEMALE ? SOUNDIN_FEMALE_LIGHT_PAIN : SOUNDIN_MALE_LIGHT_PAIN)

/datum/emote/human/grunt/do_emote(mob/living/carbon/human/user, emote_key, intentional)
	. = ..()
	user.add_combo_value_all(10)


/datum/emote/human/groan
	key = "groan"

	message_1p = "Вы стонете."
	message_3p = "стонет."

	message_impaired_production = "корчится и слегка вздыхает."
	message_impaired_reception = "Вы видите, как кто-то слегка приоткрывает рот."

	message_miming = "похоже, больно."
	message_muzzled = "издает слабый звук."

	message_type = SHOWMSG_AUDIO

	cloud = "cloud-pain"

	state_checks = list(
		EMOTE_STATE(is_stat, CONSCIOUS),
		EMOTE_STATE(is_intentional_or_species_no_flag, NO_PAIN),
	)

/datum/emote/human/groan/get_sound(mob/living/carbon/human/user, intentional)
	if(user.get_species() != SKRELL && HAS_TRAIT(src, TRAIT_LOW_PAIN_THRESHOLD) && prob(66))
		return pick(user.gender == FEMALE ? SOUNDIN_FEMALE_WHINER_PAIN : SOUNDIN_MALE_WHINER_PAIN)

	return pick(user.gender == FEMALE ? SOUNDIN_FEMALE_PASSIVE_PAIN : SOUNDIN_MALE_PASSIVE_PAIN)

/datum/emote/human/groan/do_emote(mob/living/carbon/human/user, emote_key, intentional)
	. = ..()
	user.add_combo_value_all(10)


/datum/emote/human/scream
	key = "scream"

	message_1p = "Вы кричите."
	message_3p = "кричит."

	message_impaired_production = "сильно щурится и широко открывает рот."
	message_impaired_reception = "Вы видите, как кто-то открывает рот и сильно дышит."

	message_miming = "кажется, кричит."
	message_muzzled = "издаёт громкий шум!"

	message_type = SHOWMSG_AUDIO

	cloud = "cloud-scream"

	state_checks = list(
		EMOTE_STATE(is_stat, CONSCIOUS),
		EMOTE_STATE(is_intentional_or_species_no_flag, NO_PAIN),
	)

/datum/emote/human/scream/get_sound(mob/living/carbon/human/user, intentional)
	return pick(user.gender == FEMALE ? SOUNDIN_FEMALE_HEAVY_PAIN : SOUNDIN_MALE_HEAVY_PAIN)

/datum/emote/human/scream/do_emote(mob/living/carbon/human/user, emote_key, intentional)
	. = ..()
	user.add_combo_value_all(10)


/datum/emote/human/cough
	key = "cough"

	message_1p = "Вы кашляете."
	message_3p = "кашляет."

	message_impaired_production = "сильно судорожит."
	message_impaired_reception = "Вы видите, как кто-то двигает лицом вперед, когда открывает и закрывает рот!"

	message_miming = "разыгрывает кашель."
	message_muzzled = "кажется, кашляет."

	message_type = SHOWMSG_AUDIO

	state_checks = list(
		EMOTE_STATE(is_stat, CONSCIOUS),
		EMOTE_STATE(is_intentional_or_species_no_flag, NO_BREATHE),
	)

/datum/emote/human/cough/get_sound(mob/living/carbon/human/user, intentional)
	return pick(user.gender == FEMALE ? SOUNDIN_FBCOUGH : SOUNDIN_MBCOUGH)


/datum/emote/human/hiccup
	key = "hiccup"

	message_1p = "Вы икаете."
	message_3p = "икает."

	message_impaired_production = "издаёт тихий звук."
	message_impaired_reception = "Вы видите, как у кого-то внезапно начинается судорога при открытии рта."

	message_miming = "икает."
	message_muzzled = "издаёт тихий звук."

	message_type = SHOWMSG_AUDIO

	sound = 'sound/voice/hiccup.ogg'

	state_checks = list(
		EMOTE_STATE(is_stat, CONSCIOUS),
		EMOTE_STATE(is_intentional_or_species_no_flag, NO_BREATHE),
	)


/datum/emote/human/choke
	key = "choke"

	message_1p = "Вы задыхаетесь."
	message_3p = "задыхается."

	message_impaired_production = "издаёт тихий звук."
	message_impaired_reception = "Вы видите, как кто-то отчаянно хватается за горло."

	message_miming = "задыхается."
	message_muzzled = "издаёт тихий звук."

	message_type = SHOWMSG_AUDIO

	state_checks = list(
		EMOTE_STATE(is_stat, CONSCIOUS),
		EMOTE_STATE(is_present_bodypart, BP_HEAD),
		EMOTE_STATE(is_intentional_or_species_no_flag, NO_BREATHE),
	)

	cloud = "cloud-gasp"


/datum/emote/human/snore
	key = "snore"

	message_1p = "Вы храпите."
	message_3p = "храпит."

	message_impaired_production = "издаёт тихий звук."
	message_impaired_reception = "Вы видите, как кто-то широко открывает рот, чтобы сделать вдох."

	message_miming = "храпит."
	message_muzzled = "издаёт тихий звук."

	message_type = SHOWMSG_AUDIO

	state_checks = list(
		EMOTE_STATE(is_stat, CONSCIOUS),
		EMOTE_STATE(is_intentional_or_species_no_flag, NO_BREATHE),
	)


// TO-DO: make so intentional sniffing reveals how a reagent solution held in hand smells?
/datum/emote/human/sniff
	key = "sniff"

	message_1p = "Вы принюхиваетесь."
	message_3p = "принюхивается."

	message_impaired_production = "принюхивается."
	message_impaired_reception = "Вы видите, как кто-то принюхивается."

	message_miming = "принюхивается."
	message_muzzled = "издаёт тихий звук."

	message_type = SHOWMSG_AUDIO

	state_checks = list(
		EMOTE_STATE(is_stat, CONSCIOUS),
	)


/datum/emote/human/sneeze
	key = "sneeze"

	message_1p = "Вы чихаете."
	message_3p = "чихает."

	message_impaired_production = "издаёт громкий звук."
	message_impaired_reception = "Вы видите, как кто-то чихает."

	message_miming = "чихает."
	message_muzzled = "издаёт громкий звук."

	message_type = SHOWMSG_AUDIO

	state_checks = list(
		EMOTE_STATE(is_stat, CONSCIOUS),
		EMOTE_STATE(is_present_bodypart, BP_HEAD),
	)


/datum/emote/human/gasp
	key = "gasp"

	message_1p = "Ты задыхаешься!"
	message_3p = "задыхается!"

	message_impaired_production = "пытается дышать!"
	message_impaired_reception = "Вы видите, как кто-то пытается дышать!"

	message_miming = "кажется, задыхается!"
	message_muzzled = "издаёт тихий звук."

	message_type = SHOWMSG_AUDIO

	state_checks = list(
		EMOTE_STATE(is_stat, CONSCIOUS),
		EMOTE_STATE(is_present_bodypart, BP_HEAD),
		EMOTE_STATE(is_intentional_or_species_no_flag, NO_BREATHE),
	)

	cloud = "cloud-gasp"


/datum/emote/human/sigh
	key = "sigh"

	message_1p = "Вы вздыхаете."
	message_3p = "вздыхает."

	message_impaired_production = "издаёт тихий звук."
	message_impaired_reception = "Вы видите, что кто-то открывает рот."

	message_miming = "вздыхает."
	message_muzzled = "издаёт тихий звук."

	message_type = SHOWMSG_AUDIO

	state_checks = list(
		EMOTE_STATE(is_stat, CONSCIOUS),
		EMOTE_STATE(is_intentional_or_species_no_flag, NO_EMOTION),
	)


/datum/emote/human/mumble
	key = "mumble"

	message_1p = "Вы бормочите."
	message_3p = "бормочит."

	message_impaired_production = "издаёт тихий звук."
	message_impaired_reception = "Вы видите, как кто-то открывает и закрывает рот."

	message_miming = "вздыхает."
	message_muzzled = "делает раздраженное лицо."

	message_type = SHOWMSG_AUDIO

	state_checks = list(
		EMOTE_STATE(is_stat, CONSCIOUS),
		EMOTE_STATE(is_intentional_or_species_no_flag, NO_EMOTION),
	)


/datum/emote/human/hmm_think
	key = "hmm"

	message_1p = "Хмм..."
	message_3p = "задумчиво мычит..."

	message_impaired_production = "задумчиво мычит..."
	message_impaired_reception = "Вы видите, как кто-то задумчиво чешет подбородок..."

	message_miming = "разыгрывает мышление..."
	message_muzzled = "задумчиво и тихо мычит..."

	message_type = SHOWMSG_AUDIO

	age_variations = TRUE

	state_checks = list(
		EMOTE_STATE(is_stat, CONSCIOUS)
	)

/datum/emote/human/hmm_think/get_sound(mob/living/carbon/human/user, intentional)
	return pick(user.gender == FEMALE ? SOUNDIN_HMM_THINK_FEMALE : SOUNDIN_HMM_THINK_MALE)


/datum/emote/human/hmm_question
	key = "hmm?"

	message_1p = "Хмм..?"
	message_3p = "вопросительно мычит..."

	message_impaired_production = "вопросительно мычит..."
	message_impaired_reception = "Вы видите, как кто-то вопросительно приподнимает брови..."

	message_miming = "вопросительно приподнимает брови..."
	message_muzzled = "тихо и вопросительно бормочет..."

	message_type = SHOWMSG_AUDIO

	age_variations = TRUE

	state_checks = list(
		EMOTE_STATE(is_stat, CONSCIOUS)
	)

/datum/emote/human/hmm_question/get_sound(mob/living/carbon/human/user, intentional)
	return pick(user.gender == FEMALE ? SOUNDIN_HMM_QUESTION_FEMALE : SOUNDIN_HMM_QUESTION_MALE)


/datum/emote/human/hmm_excited
	key = "hmm!"

	message_1p = "Хмм!"
	message_3p = "возбуждённо мычит!"

	message_impaired_production = "возбуждённо мычит!"
	message_impaired_reception = "Вы видите, как кто-то взволнованно приподымает брови!"

	message_miming = "взволнованно приподымает брови!"
	message_muzzled = "возбуждённо и тихо мычит!"

	message_type = SHOWMSG_AUDIO

	age_variations = TRUE

	state_checks = list(
		EMOTE_STATE(is_stat, CONSCIOUS)
	)

/datum/emote/human/hmm_excited/get_sound(mob/living/carbon/human/user, intentional)
	return pick(user.gender == FEMALE ? SOUNDIN_HMM_EXCLAIM_FEMALE : SOUNDIN_HMM_EXCLAIM_MALE)


/datum/emote/human/woo
	key = "woo"

	message_1p = "Вуууу!"
	message_3p = "восторжено кричит!"

	message_impaired_production = "восторжено кричит!"
	message_impaired_reception = "Вы видете, как кто-то восторжено кричит!"

	message_miming = "изображает восторг!"
	message_muzzled = "выглядит восторженно."

	message_type = SHOWMSG_AUDIO

	age_variations = TRUE

	state_checks = list(
		EMOTE_STATE(is_stat, CONSCIOUS)
	)

/datum/emote/human/woo/get_sound(mob/living/carbon/human/user, intentional)
	return pick(user.gender == FEMALE ? SOUNDIN_WOO_FEMALE : SOUNDIN_WOO_MALE)
