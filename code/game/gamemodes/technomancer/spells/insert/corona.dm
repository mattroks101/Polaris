/datum/technomancer/spell/corona
	name = "Corona"
	desc = "Causes the victim to glow very brightly, which while harmless in itself, makes it easier for them to be hit.  The \
	bright glow also makes it very difficult to be stealthy.  The effect lasts for one minute."
	spell_power_desc = "Enemies become even easier to hit."
	cost = 50
	obj_path = /obj/item/weapon/spell/insert/corona
	ability_icon_state = "tech_corona"
	category = SUPPORT_SPELLS

/obj/item/weapon/spell/insert/corona
	name = "corona"
	desc = "How brillient!"
	icon_state = "radiance"
	cast_methods = CAST_RANGED
	aspect = ASPECT_LIGHT
	light_color = "#D9D900"
	spell_light_intensity = 5
	spell_light_range = 3
	inserting = /obj/item/weapon/inserted_spell/corona


/obj/item/weapon/inserted_spell/corona
	var/evasion_reduction = 2 // We store this here because spell power may change when the spell expires.

/obj/item/weapon/inserted_spell/corona/on_insert()
	spawn(1)
		if(isliving(host))
			var/mob/living/L = host
			evasion_reduction = round(2 * spell_power_at_creation, 1)
			L.evasion -= evasion_reduction
			L.visible_message("<span class='warning'>You start to glow very brightly!</span>")
			spawn(1 MINUTE)
				if(src)
					on_expire()

/obj/item/weapon/inserted_spell/corona/on_expire()
	if(isliving(host))
		var/mob/living/L = host
		L.evasion += evasion_reduction
		L << "<span class='notice'>Your glow has ended.</span>"
		..()