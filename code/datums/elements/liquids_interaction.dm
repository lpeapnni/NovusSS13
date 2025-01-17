///This element allows for items to interact with liquids on turfs.
/datum/component/liquids_interaction
	///Callback interaction called when the turf has some liquids on it
	var/datum/callback/interaction_callback

/datum/component/liquids_interaction/Initialize(on_interaction_callback)
	. = ..()

	if(!istype(parent, /obj/item))
		return COMPONENT_INCOMPATIBLE

	interaction_callback = CALLBACK(parent, on_interaction_callback)

/datum/component/liquids_interaction/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ITEM_AFTERATTACK, PROC_REF(on_afterattack)) //The only signal allowing item -> turf interaction

/datum/component/liquids_interaction/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_ITEM_AFTERATTACK)

/datum/component/liquids_interaction/proc/on_afterattack(obj/item/source, turf/target, mob/user)
	SIGNAL_HANDLER

	if(!istype(target) || !target.liquids)
		return NONE

	if(interaction_callback.Invoke(target, user, target.liquids))
		return COMPONENT_CANCEL_ATTACK_CHAIN
