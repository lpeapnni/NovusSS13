/// Body size preference
/datum/preference/numeric/body_size
	priority = PREFERENCE_PRIORITY_BODYPARTS
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_key = "body_size"
	savefile_identifier = PREFERENCE_CHARACTER
	minimum = BODY_SIZE_PREF_MINIMUM
	maximum = BODY_SIZE_PREF_MAXIMUM

/datum/preference/numeric/body_size/create_default_value()
	return BODY_SIZE_STANDARD

/datum/preference/numeric/body_size/apply_to_human(mob/living/carbon/human/target, value)
	target.set_body_size(value)
