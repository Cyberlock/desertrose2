// If I could have gotten away with using a tilde in the type path, I would have.
/datum/interaction/lewd
	command = "assslap"
	description = "Slap their ass."
	simple_message = "USER slaps TARGET right on the ass!"
	simple_style = "danger"
	interaction_sound = 'honk/sound/interactions/slap.ogg'
	needs_physical_contact = TRUE
	require_ooc_consent = TRUE
	max_distance = 1

	write_log_user = "ass-slapped"
	write_log_target = "was ass-slapped by"

	var/user_not_tired
	var/target_not_tired

	var/require_user_topless
	var/require_target_topless
	var/require_user_bottomless
	var/require_target_bottomless

	var/require_user_penis
	var/require_user_anus
	var/require_user_vagina
	var/require_user_breasts

	var/require_target_penis
	var/require_target_anus
	var/require_target_vagina
	var/require_target_breasts

	var/user_refactory_cost
	var/target_refactory_cost

/datum/interaction/lewd/evaluate_user(mob/living/carbon/human/user, silent = TRUE)
	if(..(user, silent))
		if(user_not_tired && user.refactory_period)
			if(!silent) //bye spam
				to_chat(user, "<span class='warning'>You need to wait [DisplayTimeText(user.refactory_period * 10, TRUE)] to interact again.</span>")
			return FALSE

		if(require_user_bottomless && !user.is_bottomless())
			if(!silent)
				to_chat(user, "<span class = 'warning'>Your pants are in the way.</span>")
			return FALSE

		if(require_user_topless && !user.is_topless())
			if(!silent)
				to_chat(user, "<span class = 'warning'>Your top is in the way.</span>")
			return FALSE

		if(require_user_penis && !user.has_penis())
			if(!silent)
				to_chat(user, "<span class = 'warning'>You don't have a penis.</span>")
			return FALSE

		if(require_user_anus && !user.has_anus())
			if(!silent)
				to_chat(user, "<span class = 'warning'>You don't have an anus.</span>")
			return FALSE

		if(require_user_vagina && !user.has_vagina())
			if(!silent)
				to_chat(user, "<span class = 'warning'>You don't have a vagina.</span>")
			return FALSE

		if(require_user_breasts && !user.has_breasts())
			if(!silent)
				to_chat(user, "<span class = 'warning'>You don't have breasts.</span>")
			return FALSE

		if(require_ooc_consent)
			if(user.client && user.client.prefs)
				if(user.client.prefs.wasteland_toggles & VERB_CONSENT)
					return TRUE
				else
					return FALSE
		return TRUE
	return FALSE

/datum/interaction/lewd/evaluate_target(mob/living/carbon/human/user, mob/living/carbon/human/target, silent = TRUE)
	if(..(user, target, silent))
		if(target_not_tired && target.refactory_period)
			if(!silent) //same with this
				to_chat(user, "<span class='warning'>They need to wait [DisplayTimeText(user.refactory_period * 10, TRUE)] to interact again.</span>")
			return FALSE

		if(require_target_bottomless && !target.is_bottomless())
			if(!silent)
				to_chat(user, "<span class = 'warning'>Their pants are in the way.</span>")
			return FALSE

		if(require_target_bottomless && !target.is_bottomless())
			if(!silent)
				to_chat(user, "<span class = 'warning'>Their pants are in the way.</span>")
			return FALSE

		if(require_target_topless && !target.is_topless())
			if(!silent)
				to_chat(user, "<span class = 'warning'>Their top is in the way.</span>")
			return FALSE

		if(require_target_penis && !target.has_penis())
			if(!silent)
				to_chat(user, "<span class = 'warning'>They don't have a penis.</span>")
			return FALSE

		if(require_target_anus && !target.has_anus())
			if(!silent)
				to_chat(user, "<span class = 'warning'>They don't have an anus.</span>")
			return FALSE

		if(require_target_vagina && !target.has_vagina())
			if(!silent)
				to_chat(user, "<span class = 'warning'>They don't have a vagina.</span>")
			return FALSE

		if(require_target_breasts && !target.has_breasts())
			if(!silent)
				to_chat(user, "<span class = 'warning'>They don't have breasts.</span>")
			return FALSE

		if(require_ooc_consent)
			if(target.client && target.client.prefs)
				if(target.client.prefs.wasteland_toggles & VERB_CONSENT)
					return TRUE
				else
					return FALSE
		return TRUE
	return FALSE

/datum/interaction/lewd/post_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user_refactory_cost)
		user.refactory_period += user_refactory_cost
	if(target_refactory_cost)
		target.refactory_period += target_refactory_cost
	return ..()

/datum/interaction/lewd/get_action_link_for(mob/living/carbon/human/user, mob/living/carbon/human/target)
	return "<font color='#FF0000'><b>LEWD:</b></font> [..()]"
	if(user.stat == DEAD)
		to_chat(user, "<span class='warning'>You cannot have sex as ghost!</span>")
		return

/mob/living/carbon/human/list_interaction_attributes()
	var/dat = ..()
	if(refactory_period)
		dat += "<br>...are sexually exhausted for the time being."
	if(a_intent == INTENT_HELP)
		dat += "<br>...are acting gentle."
	else if (a_intent == INTENT_DISARM)
		dat += "<br>...are acting playful."
	else if (a_intent == INTENT_GRAB)
		dat += "<br>...are acting rough."
	else if(a_intent == INTENT_HARM)
		dat += "<br>...are fighting anyone who comes near."
	if(is_topless())
		if(has_breasts())
			dat += "<br>...have breasts."
	if(is_bottomless())
		dat += "<br>...are naked."
		if(has_penis())
			dat += "<br>...have a penis."
		if(has_vagina())
			dat += "<br>...have a vagina."
		if(has_anus())
			dat += "<br>...have an anus."
	else
		dat += "<br>...are clothed."
	return dat
