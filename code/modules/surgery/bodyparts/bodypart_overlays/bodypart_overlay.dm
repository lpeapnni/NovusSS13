///Bodypart ovarlay datum. These can be added to any limb to give them a proper overlay, that'll even stay if the limb gets removed
///This is the abstract parent, don't use it!!
/datum/bodypart_overlay
	///Required bodytypes for this overlay to actually draw on a given limb
	var/required_bodytypes = BODYTYPE_HUMANOID
	///Sometimes we need multiple layers, for like the back, middle and front of the person (EXTERNAL_FRONT, EXTERNAL_ADJACENT, EXTERNAL_BEHIND)
	var/layers
	///List of all possible layers. Used for looping through in drawing
	var/static/list/all_layers = list(EXTERNAL_FRONT, EXTERNAL_ADJACENT, EXTERNAL_BEHIND)

///Wrapper for getting the proper overlays, colored and everything
/datum/bodypart_overlay/proc/get_overlays(layer, obj/item/bodypart/limb)
	RETURN_TYPE(/list)
	. = list()
	layer = bitflag_to_layer(layer)
	var/image/primary_image = get_image(layer, limb)
	color_image(primary_image, layer, limb)
	. += primary_image
	return .

///Generate the image. Needs to be overriden
/datum/bodypart_overlay/proc/get_image(layer, obj/item/bodypart/limb)
	CRASH("Get image needs to be overridden")

///Color the image
/datum/bodypart_overlay/proc/color_image(image/overlay, layer, obj/item/bodypart/limb)
	return

///Called on being added to a limb
/datum/bodypart_overlay/proc/added_to_limb(obj/item/bodypart/limb)
	return

///Called on being removed from a limb
/datum/bodypart_overlay/proc/removed_from_limb(obj/item/bodypart/limb)
	return

///Use this to change the appearance (and yes you must overwrite hahahahahah) (or dont use this, I just dont want people directly changing the image)
/datum/bodypart_overlay/proc/set_appearance()
	CRASH("Update appearance needs to be overridden")

/**This exists so sprite accessories can still be per-layer without having to include that layer's
*  number in their sprite name, which causes issues when those numbers change.
*/
/datum/bodypart_overlay/proc/mutant_bodyparts_layertext(layer)
	switch(layer)
		if(-BODY_BEHIND_LAYER)
			return "BEHIND"
		if(-BODY_ADJ_LAYER)
			return "ADJ"
		if(-BODY_FRONT_LAYER)
			return "FRONT"
	return layer

///Converts a bitflag to the right layer. I'd love to make this a static index list, but byond made an attempt on my life when i did
/datum/bodypart_overlay/proc/bitflag_to_layer(layer)
	switch(layer)
		if(EXTERNAL_BEHIND)
			return -BODY_BEHIND_LAYER
		if(EXTERNAL_ADJACENT)
			return -BODY_ADJ_LAYER
		if(EXTERNAL_FRONT)
			return -BODY_FRONT_LAYER
	return layer

///Check whether we can draw the overlays on a limb. Some oddball limbs are fundamentally incompatible with certain goofy overlays.
/datum/bodypart_overlay/proc/can_draw_on_bodypart(obj/item/bodypart/ownerlimb)
	return (ownerlimb.bodytype & required_bodytypes)

///Check whether we can draw the overlays on a human. You generally don't want lizard snouts to draw over an EVA suit.
/datum/bodypart_overlay/proc/can_draw_on_body(obj/item/bodypart/ownerlimb, mob/living/carbon/human/owner)
	return TRUE

///Colorizes the limb it's inserted to, if required.
/datum/bodypart_overlay/proc/override_color(rgb_value)
	CRASH("External organ color set to override with no override proc.")

///Generate a unique identifier to cache with. If you change something about the image, but the icon cache stays the same, it'll simply pull the unchanged image out of the cache
/datum/bodypart_overlay/proc/generate_icon_cache()
	return list()
