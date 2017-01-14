# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
# Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
# about supported directives.

# Limitless template files
# ------------------------
#= require 'limitless/plugins/loaders/pace.min.js'
#= require jquery
#= require jquery_ujs
#= require jquery.remotipart
#= require jquery.turbolinks
#= require turbolinks
#= require turbolinks-compatibility

#= require 'limitless/core/libraries/jquery_ui/interactions.min.js'
#= require 'limitless/core/libraries/jquery_ui/widgets.min.js'
#= require 'limitless/core/libraries/jquery_ui/effects.min.js'
#= require 'limitless/core/libraries/bootstrap.min'
#= require 'limitless/plugins/loaders/blockui.min.js'
#= require 'limitless/plugins/ui/nicescroll.min.js'
#= require 'limitless/plugins/datatables/datatables.min.js'
#= require 'limitless/plugins/forms/selects/select2.min.js'
#= require 'limitless/plugins/forms/styling/uniform.min.js'
#= require 'limitless/plugins/ui/moment/moment-with-locales.js'
#= require 'limitless/plugins/pickers/daterangepicker.js'
#= require 'limitless/plugins/notifications/pnotify.min.js'
#= require 'limitless/plugins/visualization/echarts/echarts-all.js'
#= require 'limitless/core/app.min.js'

#= require layouts/main_layout
#= require layouts/sidebar
#= require layouts/form_elements
#= require layouts/datapicker
#= require layouts/datatable_defaults
#= require home
#= require leads
#= require contacts
#= require admin/users
#= require users
#= require notifications
#= require limitless/plugins/visualization/echarts/theme/limitless
#= require charts
#= require send_email_with_lead
#= require ckeditor/init

# pace.js - disable ajax tracking except on page navigation
Pace.options.restartOnRequestAfter = false
