/obj/item/weapon/gun/projectile/automatic/pistol
	name = "pistol"
	can_be_holstered = TRUE
	w_class = SIZE_SMALL

/obj/item/weapon/gun/projectile/automatic/pistol/silenced
	name = "silenced pistol"
	desc = "Небольшой, бесшумный, легко скрываемый пистолет. Использует патроны 45-го калибра."
	icon_state = "silenced_pistol"
	item_state = "gun"
	silenced = 1
	origin_tech = "combat=2;materials=2;syndicate=8"
	initial_mag = /obj/item/ammo_box/magazine/silenced_pistol
	suitable_mags = list(/obj/item/ammo_box/magazine/silenced_pistol, /obj/item/ammo_box/magazine/silenced_pistol/nonlethal)
	fire_sound = 'sound/weapons/guns/gunshot_silencer.ogg'

/obj/item/weapon/gun/projectile/automatic/pistol/silenced/nonlethal
	name = "silenced pistol NL"
	icon_state = "silenced_pistol_nl"
	initial_mag = /obj/item/ammo_box/magazine/silenced_pistol/nonlethal

/obj/item/weapon/gun/projectile/automatic/pistol/glock
	name = "G17"
	desc = "Полуавтоматический служебный пистолет калибра 9х19 мм. Предназначен для профессионалов."
	icon_state = "9mm_glock"
	item_state = "9mm_glock"
	origin_tech = "combat=2;materials=2"
	initial_mag = /obj/item/ammo_box/magazine/glock/rubber
	suitable_mags = list(/obj/item/ammo_box/magazine/glock, /obj/item/ammo_box/magazine/glock/rubber, /obj/item/ammo_box/magazine/glock/extended, /obj/item/ammo_box/magazine/glock/extended/rubber)
	fire_sound = 'sound/weapons/guns/gunshot_light.ogg'
	can_be_silenced = TRUE

/obj/item/weapon/gun/projectile/automatic/pistol/glock/spec
	name = "G17 GEN3"
	icon_state = "9mm_glock_spec"
	item_state = "9mm_glock_spec"
	initial_mag = /obj/item/ammo_box/magazine/glock/extended/rubber

/obj/item/weapon/gun/projectile/automatic/pistol/deagle
	name = "desert eagle"
	desc = "Надежный убойный пистолет, использующий патроны калибра .50 AE."
	icon_state = "deagle"
	item_state = "deagle"
	force = 14.0
	initial_mag = /obj/item/ammo_box/magazine/deagle
	suitable_mags = list(/obj/item/ammo_box/magazine/deagle, /obj/item/ammo_box/magazine/deagle/weakened)
	fire_sound = 'sound/weapons/guns/gunshot_heavy.ogg'

/obj/item/weapon/gun/projectile/automatic/pistol/deagle/gold
	desc = "Позолоченный пистолет, сделанный лучшими марсианскими оружейниками. Использует патроны калибра .50 AE."
	icon_state = "deagleg"
	item_state = "deagleg"

/obj/item/weapon/gun/projectile/automatic/pistol/deagle/weakened
	initial_mag = /obj/item/ammo_box/magazine/deagle/weakened

/obj/item/weapon/gun/projectile/automatic/pistol/deagle/weakened/gold
	desc = "Позолоченный пистолет, сделанный лучшими марсианскими оружейниками. Использует патроны калибра .50 AE."
	icon_state = "deagleg"
	item_state = "deagleg"

/obj/item/weapon/gun/projectile/automatic/pistol/stechkin
	name = "Stechkin pistol"
	desc = "Небольшой, легко скрываемый пистолет. Использует патроны калибра 9 мм."
	icon_state = "stechkin"
	item_state = "9mm_glock"
	w_class = SIZE_TINY
	silenced = FALSE
	origin_tech = "combat=2;materials=2;syndicate=2"
	initial_mag = /obj/item/ammo_box/magazine/stechkin
	suitable_mags = list(/obj/item/ammo_box/magazine/stechkin, /obj/item/ammo_box/magazine/stechkin/extended)
	can_be_silenced = TRUE
	fire_delay = 3
	spread_increase = 0.5
	spread_max = 1.5

/obj/item/weapon/gun/projectile/automatic/pistol/stechkin/atom_init()
	. = ..()
	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/weapon/gun/projectile/automatic/pistol/colt1911
	desc = "Дешевая марсианская подделка Colt M1911. Использует менее смертоносные патроны 45-го калибра."
	name = "Colt M1911"
	icon_state = "colt"
	item_state = "colt"
	initial_mag = /obj/item/ammo_box/magazine/colt/rubber
	suitable_mags = list(/obj/item/ammo_box/magazine/colt/rubber, /obj/item/ammo_box/magazine/colt)
	fire_sound = 'sound/weapons/guns/gunshot_colt1911.ogg'
	can_be_silenced = TRUE

/obj/item/weapon/gun/projectile/automatic/pistol/colt1911/dungeon
	desc = "Полуавтоматический пистолет с магазином под патрон .45 ACP, работающий в автоматическом режиме с отдачей ствола."
	initial_mag = /obj/item/ammo_box/magazine/colt

/obj/item/weapon/gun/projectile/revolver/doublebarrel/derringer
	name = "Derringer"
	desc = "Небольшой карманный пистолет и ваш лучший друг. Выпускается компанией Hephaestus Industries без особых изменений по сравнению с ранними образцами. Калибр .38."
	icon_state = "derringer"
	item_state = null
	w_class = SIZE_TINY
	two_hand_weapon = FALSE
	force = 2
	flags =  CONDUCT
	slot_flags = SLOT_FLAGS_BELT
	origin_tech = "combat=1;materials=1"
	initial_mag = /obj/item/ammo_box/magazine/internal/cylinder/dualshot/derringer
	can_be_holstered = TRUE
	can_be_shortened = FALSE
	fire_sound = 'sound/weapons/guns/gunshot_derringer.ogg'
	recoil = 2

/obj/item/weapon/gun/projectile/revolver/doublebarrel/derringer/syndicate
	name = "Oppressor"
	desc = "Выдается агентам Синдиката, не представляющим особой ценности для Командования. По крайней мере, название звучит круто. Калибр .357 Магнум."
	icon_state = "synderringer"
	force = 5
	initial_mag = /obj/item/ammo_box/magazine/internal/cylinder/dualshot/derringer/syndicate
	recoil = 3
	fire_sound = 'sound/weapons/guns/gunshot_heavy.ogg'

/obj/item/weapon/gun/projectile/automatic/pistol/wjpp
	name = "W&J PP"
	desc = "Самозарядный 9-мм пистолет двойного действия, популярный среди полицейских и частных охранников благодаря своей надежности, скрытности и дешевизне."
	icon_state = "wjpp"
	item_state = "wjpp"
	origin_tech = "combat=1;materials=1"
	initial_mag = /obj/item/ammo_box/magazine/wjpp/rubber
	suitable_mags = list(/obj/item/ammo_box/magazine/wjpp, /obj/item/ammo_box/magazine/wjpp/rubber)
	fire_sound = 'sound/weapons/guns/gunshot_light.ogg'
	can_be_holstered = TRUE
	recoil = 1.5

/obj/item/weapon/gun/projectile/automatic/pistol/peashooter
	name = "Peashooter"
	desc = "Горохострел. Стреляет горохом."
	cases = list("горохострел", "горохострела", "горохострелу", "горохострел", "горохострелом", "горохостреле")
	icon_state = "peashooter"
	item_state = "peashooter"
	origin_tech = "combat=1;materials=1"
	initial_mag = /obj/item/ammo_box/magazine/pea
	suitable_mags = list(/obj/item/ammo_box/magazine/pea)
	can_be_holstered = TRUE

/obj/item/weapon/gun/projectile/automatic/pistol/peashooter/update_icon()
	if(magazine.ammo_count() < 6)
		icon_state = "[initial(icon_state)]-[magazine.ammo_count()]"

/obj/item/weapon/gun/projectile/automatic/pistol/peashooter/attack_self(mob/living/user)
	to_chat(user, "<span class='notice'>Вы не можете вынуть горох из [CASE(src, GENITIVE_CASE)].</span>")
	return

/obj/item/weapon/gun/projectile/automatic/pistol/peashooter/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/weapon/lighter/zippo))
		new /obj/item/weapon/gun/projectile/automatic/pistol/peashooter/in_fire(user.loc)
		to_chat(user, "<span class='notice'>Горохострел обвил зажигалку намертво. Кажется, её уже не вытащить.</span>")
		qdel(I)
		qdel(src)
	else
		return ..()

/obj/item/weapon/gun/projectile/automatic/pistol/peashooter/in_fire
	name = "Peashooter"
	desc = "Горохострел. Стреляет горохом. У самого кончика стручка закреплена горящая зажигалка."
	cases = list("горохострел", "горохострела", "горохострелу", "горохострел", "горохострелом", "горохостреле")
	icon_state = "peashooter_in_fire"
	item_state = "peashooter_in_fire"
	origin_tech = "combat=1;materials=1"
	initial_mag = /obj/item/ammo_box/magazine/pea/in_fire
	suitable_mags = list(/obj/item/ammo_box/magazine/pea/in_fire)
	can_be_holstered = TRUE

/obj/item/weapon/gun/projectile/automatic/pistol/peashooter/in_fire/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/weapon/lighter/zippo))
		to_chat(user, "<span class='notice'>Горохострел игнорирует любые попытки добавить ещё одну зажигалку.</span>")
	else
		return

/obj/item/weapon/gun/projectile/automatic/pistol/peashooter/virus
	name = "Virus Peashooter"
	desc = "Горохострел Гиббингтоский. Стреляет особо большим горохом. У самого кончика стручка закреплена горящая зажигалка."
	cases = list("горохострел", "горохострела", "горохострелу", "горохострел", "горохострелом", "горохостреле")
	icon_state = "peashooter_virus"
	item_state = "peashooter_virus"
	origin_tech = "combat=1;materials=1"
	initial_mag = /obj/item/ammo_box/magazine/pea/virus
	suitable_mags = list(/obj/item/ammo_box/magazine/pea/virus)
	can_be_holstered = TRUE

/obj/item/weapon/gun/projectile/automatic/pistol/peashooter/virus/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/weapon/lighter/zippo))
		new /obj/item/weapon/gun/projectile/automatic/pistol/peashooter/virus/in_fire(user.loc)
		to_chat(user, "<span class='notice'>Горохострел обвил зажигалку намертво. Кажется, её уже не вытащить.</span>")
		qdel(I)
		qdel(src)
	else
		return ..()

/obj/item/weapon/gun/projectile/automatic/pistol/peashooter/virus/in_fire
	name = "Virus Peashooter"
	desc = "Горохострел Гиббингтоский. Стреляет особо большим горохом."
	cases = list("горохострел", "горохострела", "горохострелу", "горохострел", "горохострелом", "горохостреле")
	icon_state = "peashooter_virus_in_fire"
	item_state = "peashooter_virus_in_fire"
	origin_tech = "combat=1;materials=1"
	initial_mag = /obj/item/ammo_box/magazine/pea/virus/in_fire
	suitable_mags = list(/obj/item/ammo_box/magazine/pea/virus/in_fire)
	can_be_holstered = TRUE

/obj/item/weapon/gun/projectile/automatic/pistol/peashooter/virus/in_fire/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/weapon/lighter/zippo))
		to_chat(user, "<span class='notice'>Горохострел игнорирует любые попытки добавить ещё одну зажигалку.</span>")
	else
		return
