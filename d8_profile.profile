<?php

use Drupal\Core\Form\FormStateInterface;
use Drupal\contact\Entity\ContactForm;

/**
 * Allows the profile to alter the site configuration form.
 */
function drupal_profile_form_install_configure_form_alter(&$form, $form_state) {

  // Regional settings defaults
  $form['regional_settings']['site_default_country']['#default_value'] = "CH";
  $form['regional_settings']['date_default_timezone']['#default_value'] = "Europe/Zurich";

  // Site information defaults
  $form['site_information']['site_name']['#default_value'] = 'Drupal website';
  $form['site_information']['site_mail']['#default_value'] = 'email@contact.local';

  // Account information defaults
  $form['admin_account']['account']['name']['#default_value'] = 'admin';
  $form['admin_account']['account']['mail']['#default_value'] = 'email@contact.local';

  // Date/time settings
  $form['server_settings']['site_default_country']['#default_value'] = 'Suisse';
  $form['server_settings']['date_default_timezone']['#default_value'] = 'Europe/Zurich';

  $form['#submit'][] = 'drupal_profile_form_install_configure_submit';
}

/**
 * Submission handler to sync the contact.form.feedback recipient.
 */
function drupal_profile_form_install_configure_submit($form, FormStateInterface $form_state) {
  $site_mail = $form_state->getValue('site_mail');
  ContactForm::load('feedback')->setRecipients([$site_mail])->trustData()->save();
}
