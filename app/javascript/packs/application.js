import Rails from '@rails/ujs'
Rails.start()
global.Rails = Rails
require('turbolinks').start()
require('@rails/activestorage').start()
require('channels')
require('bootstrap')
require('@fortawesome/fontawesome-free')
import 'bootstrap-datepicker'
global.I18n = require('i18n-js')
global.toastr = require('toastr')
global.$ = global.jQuery = require('jquery')
require('./shared/nice-select')
