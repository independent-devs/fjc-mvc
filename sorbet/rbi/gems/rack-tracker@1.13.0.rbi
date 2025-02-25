# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `rack-tracker` gem.
# Please instead update this file by running `bin/tapioca gem rack-tracker`.


# source://rack-tracker//lib/rack/tracker/extensions.rb#10
class Hash
  include ::Enumerable

  # source://rack-tracker//lib/rack/tracker/extensions.rb#42
  def _deep_transform_keys_in_object!(object, &block); end

  # source://rack-tracker//lib/rack/tracker/extensions.rb#18
  def compact; end

  # source://rack-tracker//lib/rack/tracker/extensions.rb#22
  def deep_merge!(other_hash, &block); end

  # source://rack-tracker//lib/rack/tracker/extensions.rb#11
  def stringify_values; end
end

# source://rack-tracker//lib/rack/tracker/version.rb#1
module Rack
  class << self
    # source://rack/3.1.8/lib/rack/version.rb#18
    def release; end
  end
end

# source://rack-tracker//lib/rack/tracker/version.rb#2
class Rack::Tracker
  # @return [Tracker] a new instance of Tracker
  #
  # source://rack-tracker//lib/rack/tracker.rb#35
  def initialize(app, &block); end

  # source://rack-tracker//lib/rack/tracker.rb#44
  def _call(env); end

  # source://rack-tracker//lib/rack/tracker.rb#40
  def call(env); end

  private

  # source://rack-tracker//lib/rack/tracker.rb#67
  def inject(env, response); end
end

# source://rack-tracker//lib/rack/tracker/bing/bing.rb#1
class Rack::Tracker::Bing < ::Rack::Tracker::Handler
  # source://rack-tracker//lib/rack/tracker/bing/bing.rb#8
  def tracker; end

  class << self
    # source://rack-tracker//lib/rack/tracker/handler.rb#13
    def position; end
  end
end

# source://rack-tracker//lib/rack/tracker/bing/bing.rb#3
class Rack::Tracker::Bing::Conversion < ::OpenStruct; end

# source://rack-tracker//lib/rack/tracker/controller.rb#3
module Rack::Tracker::Controller
  # source://rack-tracker//lib/rack/tracker/controller.rb#4
  def tracker(&block); end
end

# source://rack-tracker//lib/rack/tracker/criteo/criteo.rb#1
class Rack::Tracker::Criteo < ::Rack::Tracker::Handler
  # global events (setSiteType, setAccount, ...) for each tracker instance
  #
  # source://rack-tracker//lib/rack/tracker/criteo/criteo.rb#20
  def tracker_events; end

  class << self
    # source://rack-tracker//lib/rack/tracker/handler.rb#13
    def position; end

    # source://rack-tracker//lib/rack/tracker/criteo/criteo.rb#30
    def track(name, event_name, event_args = T.unsafe(nil)); end
  end
end

# source://rack-tracker//lib/rack/tracker/criteo/criteo.rb#11
class Rack::Tracker::Criteo::Event < ::OpenStruct
  # source://rack-tracker//lib/rack/tracker/criteo/criteo.rb#12
  def write; end
end

# source://rack-tracker//lib/rack/tracker/criteo/criteo.rb#3
Rack::Tracker::Criteo::TRACKER_EVENTS = T.let(T.unsafe(nil), Hash)

# source://rack-tracker//lib/rack/tracker/drift/drift.rb#1
class Rack::Tracker::Drift < ::Rack::Tracker::Handler; end

# source://rack-tracker//lib/rack/tracker.rb#33
Rack::Tracker::EVENT_TRACKING_KEY = T.let(T.unsafe(nil), String)

# source://rack-tracker//lib/rack/tracker/facebook/facebook.rb#1
class Rack::Tracker::Facebook < ::Rack::Tracker::Handler
  class << self
    # source://rack-tracker//lib/rack/tracker/handler.rb#13
    def position; end

    # source://rack-tracker//lib/rack/tracker/facebook/facebook.rb#10
    def track(name, *event); end
  end
end

# source://rack-tracker//lib/rack/tracker/facebook/facebook.rb#2
class Rack::Tracker::Facebook::Event < ::OpenStruct
  # source://rack-tracker//lib/rack/tracker/facebook/facebook.rb#3
  def write; end
end

# source://rack-tracker//lib/rack/tracker/facebook_pixel/facebook_pixel.rb#1
class Rack::Tracker::FacebookPixel < ::Rack::Tracker::Handler
  class << self
    # source://rack-tracker//lib/rack/tracker/handler.rb#16
    def allowed_tracker_options; end

    # source://rack-tracker//lib/rack/tracker/handler.rb#13
    def position; end
  end
end

# source://rack-tracker//lib/rack/tracker/facebook_pixel/facebook_pixel.rb#5
class Rack::Tracker::FacebookPixel::Event < ::OpenStruct
  # source://rack-tracker//lib/rack/tracker/facebook_pixel/facebook_pixel.rb#6
  def write; end

  private

  # source://rack-tracker//lib/rack/tracker/facebook_pixel/facebook_pixel.rb#16
  def options_to_json; end

  # source://rack-tracker//lib/rack/tracker/facebook_pixel/facebook_pixel.rb#12
  def type_to_json; end
end

# source://rack-tracker//lib/rack/tracker/facebook_pixel/facebook_pixel.rb#21
class Rack::Tracker::FacebookPixel::Track < ::Rack::Tracker::FacebookPixel::Event
  # source://rack-tracker//lib/rack/tracker/facebook_pixel/facebook_pixel.rb#22
  def name; end
end

# source://rack-tracker//lib/rack/tracker/facebook_pixel/facebook_pixel.rb#27
class Rack::Tracker::FacebookPixel::TrackCustom < ::Rack::Tracker::FacebookPixel::Event
  # source://rack-tracker//lib/rack/tracker/facebook_pixel/facebook_pixel.rb#28
  def name; end
end

# source://rack-tracker//lib/rack/tracker/go_squared/go_squared.rb#1
class Rack::Tracker::GoSquared < ::Rack::Tracker::Handler
  # source://rack-tracker//lib/rack/tracker/go_squared/go_squared.rb#14
  def tracker; end

  # source://rack-tracker//lib/rack/tracker/go_squared/go_squared.rb#18
  def trackers; end

  # source://rack-tracker//lib/rack/tracker/go_squared/go_squared.rb#26
  def visitor_info; end

  # source://rack-tracker//lib/rack/tracker/go_squared/go_squared.rb#22
  def visitor_name; end
end

# source://rack-tracker//lib/rack/tracker/go_squared/go_squared.rb#8
class Rack::Tracker::GoSquared::VisitorInfo < ::OpenStruct
  # source://rack-tracker//lib/rack/tracker/go_squared/go_squared.rb#9
  def write; end
end

# source://rack-tracker//lib/rack/tracker/go_squared/go_squared.rb#2
class Rack::Tracker::GoSquared::VisitorName < ::OpenStruct
  # source://rack-tracker//lib/rack/tracker/go_squared/go_squared.rb#3
  def write; end
end

# source://rack-tracker//lib/rack/tracker/google_adwords_conversion/google_adwords_conversion.rb#1
class Rack::Tracker::GoogleAdwordsConversion < ::Rack::Tracker::Handler
  class << self
    # source://rack-tracker//lib/rack/tracker/handler.rb#13
    def position; end
  end
end

# source://rack-tracker//lib/rack/tracker/google_adwords_conversion/google_adwords_conversion.rb#2
class Rack::Tracker::GoogleAdwordsConversion::Conversion < ::OpenStruct; end

# source://rack-tracker//lib/rack/tracker/google_analytics/google_analytics.rb#1
class Rack::Tracker::GoogleAnalytics < ::Rack::Tracker::Handler
  # @return [GoogleAnalytics] a new instance of GoogleAnalytics
  #
  # source://rack-tracker//lib/rack/tracker/google_analytics/google_analytics.rb#5
  def initialize(env, options = T.unsafe(nil)); end

  # source://rack-tracker//lib/rack/tracker/google_analytics/google_analytics.rb#65
  def ecommerce_events; end

  # source://rack-tracker//lib/rack/tracker/google_analytics/google_analytics.rb#69
  def enhanced_ecommerce_events; end

  # source://rack-tracker//lib/rack/tracker/google_analytics/google_analytics.rb#73
  def pageview_url_script; end

  # source://rack-tracker//lib/rack/tracker/google_analytics/google_analytics.rb#61
  def tracker; end

  private

  # source://rack-tracker//lib/rack/tracker/google_analytics/google_analytics.rb#79
  def tracker_option_key(key); end

  # source://rack-tracker//lib/rack/tracker/google_analytics/google_analytics.rb#83
  def tracker_option_value(value); end

  class << self
    # source://rack-tracker//lib/rack/tracker/handler.rb#16
    def allowed_tracker_options; end
  end
end

# source://rack-tracker//lib/rack/tracker/google_analytics/google_analytics.rb#43
class Rack::Tracker::GoogleAnalytics::Ecommerce < ::OpenStruct
  # source://rack-tracker//lib/rack/tracker/google_analytics/google_analytics.rb#44
  def write; end
end

# source://rack-tracker//lib/rack/tracker/google_analytics/google_analytics.rb#29
class Rack::Tracker::GoogleAnalytics::EnhancedEcommerce < ::OpenStruct
  # source://rack-tracker//lib/rack/tracker/google_analytics/google_analytics.rb#30
  def write; end
end

# source://rack-tracker//lib/rack/tracker/google_analytics/google_analytics.rb#54
class Rack::Tracker::GoogleAnalytics::Parameter < ::OpenStruct
  include ::Rack::Tracker::JavaScriptHelper

  # source://rack-tracker//lib/rack/tracker/google_analytics/google_analytics.rb#56
  def write; end
end

# source://rack-tracker//lib/rack/tracker/google_analytics/google_analytics.rb#10
class Rack::Tracker::GoogleAnalytics::Send < ::OpenStruct
  # @return [Send] a new instance of Send
  #
  # source://rack-tracker//lib/rack/tracker/google_analytics/google_analytics.rb#11
  def initialize(attrs = T.unsafe(nil)); end

  # source://rack-tracker//lib/rack/tracker/google_analytics/google_analytics.rb#24
  def attributes; end

  # source://rack-tracker//lib/rack/tracker/google_analytics/google_analytics.rb#20
  def event; end

  # source://rack-tracker//lib/rack/tracker/google_analytics/google_analytics.rb#16
  def write; end
end

# source://rack-tracker//lib/rack/tracker/google_global/google_global.rb#1
class Rack::Tracker::GoogleGlobal < ::Rack::Tracker::Handler
  # source://rack-tracker//lib/rack/tracker/google_global/google_global.rb#33
  def events; end

  # source://rack-tracker//lib/rack/tracker/handler.rb#31
  def handler_events; end

  # source://rack-tracker//lib/rack/tracker/google_global/google_global.rb#27
  def pages; end

  # source://rack-tracker//lib/rack/tracker/google_global/google_global.rb#41
  def set_options; end

  # source://rack-tracker//lib/rack/tracker/google_global/google_global.rb#37
  def trackers; end

  private

  # source://rack-tracker//lib/rack/tracker/google_global/google_global.rb#72
  def build_set_options; end

  # source://rack-tracker//lib/rack/tracker/google_global/google_global.rb#47
  def build_trackers; end

  # source://rack-tracker//lib/rack/tracker/google_global/google_global.rb#51
  def call_tracker(tracker); end

  # @return [Boolean]
  #
  # source://rack-tracker//lib/rack/tracker/google_global/google_global.rb#59
  def invalid_tracker?(tracker); end

  # source://rack-tracker//lib/rack/tracker/google_global/google_global.rb#77
  def select_handler_events(klass); end

  class << self
    # source://rack-tracker//lib/rack/tracker/handler.rb#16
    def allowed_tracker_options; end
  end
end

# source://rack-tracker//lib/rack/tracker/google_global/google_global.rb#12
class Rack::Tracker::GoogleGlobal::Event < ::OpenStruct
  # source://rack-tracker//lib/rack/tracker/google_global/google_global.rb#16
  def params; end

  private

  # source://rack-tracker//lib/rack/tracker/google_global/google_global.rb#22
  def param_key(key); end
end

# source://rack-tracker//lib/rack/tracker/google_global/google_global.rb#13
Rack::Tracker::GoogleGlobal::Event::PREFIXED_PARAMS = T.let(T.unsafe(nil), Array)

# source://rack-tracker//lib/rack/tracker/google_global/google_global.rb#14
Rack::Tracker::GoogleGlobal::Event::SKIP_PARAMS = T.let(T.unsafe(nil), Array)

# source://rack-tracker//lib/rack/tracker/google_global/google_global.rb#6
class Rack::Tracker::GoogleGlobal::Page < ::OpenStruct
  # source://rack-tracker//lib/rack/tracker/google_global/google_global.rb#7
  def params; end
end

# source://rack-tracker//lib/rack/tracker/google_tag_manager/google_tag_manager.rb#1
class Rack::Tracker::GoogleTagManager < ::Rack::Tracker::Handler
  # source://rack-tracker//lib/rack/tracker/google_tag_manager/google_tag_manager.rb#22
  def container; end

  # source://rack-tracker//lib/rack/tracker/google_tag_manager/google_tag_manager.rb#9
  def inject(response); end

  # source://rack-tracker//lib/rack/tracker/google_tag_manager/google_tag_manager.rb#30
  def render_body; end

  # source://rack-tracker//lib/rack/tracker/google_tag_manager/google_tag_manager.rb#26
  def render_head; end
end

# source://rack-tracker//lib/rack/tracker/google_tag_manager/google_tag_manager.rb#3
class Rack::Tracker::GoogleTagManager::Push < ::OpenStruct
  # source://rack-tracker//lib/rack/tracker/google_tag_manager/google_tag_manager.rb#4
  def write; end
end

# source://rack-tracker//lib/rack/tracker/handler.rb#1
class Rack::Tracker::Handler
  include ::Rack::Tracker::JavaScriptHelper

  # @return [Handler] a new instance of Handler
  #
  # source://rack-tracker//lib/rack/tracker/handler.rb#25
  def initialize(env, options = T.unsafe(nil)); end

  # source://rack-tracker//lib/rack/tracker/handler.rb#16
  def allowed_tracker_options; end

  # source://rack-tracker//lib/rack/tracker/handler.rb#16
  def allowed_tracker_options=(_arg0); end

  # source://rack-tracker//lib/rack/tracker/handler.rb#16
  def allowed_tracker_options?; end

  # the request has set the DO NOT TRACK (DNT) and has opted to get not tracked (DNT=1)
  #
  # @return [Boolean]
  #
  # source://rack-tracker//lib/rack/tracker/handler.rb#80
  def dnt_header_opt_out?; end

  # Returns the value of attribute env.
  #
  # source://rack-tracker//lib/rack/tracker/handler.rb#20
  def env; end

  # Sets the attribute env
  #
  # @param value the value to set the attribute env to.
  #
  # source://rack-tracker//lib/rack/tracker/handler.rb#20
  def env=(_arg0); end

  # source://rack-tracker//lib/rack/tracker/handler.rb#31
  def events; end

  # source://rack-tracker//lib/rack/tracker/handler.rb#64
  def handler_name; end

  # source://rack-tracker//lib/rack/tracker/handler.rb#40
  def inject(response); end

  # Returns the value of attribute options.
  #
  # source://rack-tracker//lib/rack/tracker/handler.rb#19
  def options; end

  # Sets the attribute options
  #
  # @param value the value to set the attribute options to.
  #
  # source://rack-tracker//lib/rack/tracker/handler.rb#19
  def options=(_arg0); end

  # source://rack-tracker//lib/rack/tracker/handler.rb#13
  def position; end

  # source://rack-tracker//lib/rack/tracker/handler.rb#13
  def position=(_arg0); end

  # source://rack-tracker//lib/rack/tracker/handler.rb#13
  def position?; end

  # source://rack-tracker//lib/rack/tracker/handler.rb#36
  def render; end

  # source://rack-tracker//lib/rack/tracker/handler.rb#68
  def tracker_options; end

  # source://rack-tracker//lib/rack/tracker/handler.rb#55
  def write_event(event); end

  private

  # Transformations to be applied to tracker option keys.
  # Override in descendants, if necessary.
  #
  # source://rack-tracker//lib/rack/tracker/handler.rb#88
  def tracker_option_key(key); end

  # Transformations to be applied to tracker option values.
  # Override in descendants, if necessary.
  #
  # source://rack-tracker//lib/rack/tracker/handler.rb#94
  def tracker_option_value(value); end

  class << self
    # source://rack-tracker//lib/rack/tracker/handler.rb#16
    def allowed_tracker_options; end

    # source://rack-tracker//lib/rack/tracker/handler.rb#16
    def allowed_tracker_options=(value); end

    # source://rack-tracker//lib/rack/tracker/handler.rb#16
    def allowed_tracker_options?; end

    # source://rack-tracker//lib/rack/tracker/handler.rb#13
    def position; end

    # source://rack-tracker//lib/rack/tracker/handler.rb#13
    def position=(value); end

    # source://rack-tracker//lib/rack/tracker/handler.rb#13
    def position?; end

    # source://rack-tracker//lib/rack/tracker/handler.rb#3
    def process_track(env, method_name, *args, &block); end

    # overwrite me in the handler subclass if you need more control over the event
    #
    # source://rack-tracker//lib/rack/tracker/handler.rb#8
    def track(name, *event); end
  end
end

# source://rack-tracker//lib/rack/tracker/handler_delegator.rb#1
class Rack::Tracker::HandlerDelegator
  # @return [HandlerDelegator] a new instance of HandlerDelegator
  #
  # source://rack-tracker//lib/rack/tracker/handler_delegator.rb#10
  def initialize(env = T.unsafe(nil)); end

  # Returns the value of attribute env.
  #
  # source://rack-tracker//lib/rack/tracker/handler_delegator.rb#8
  def env; end

  # Sets the attribute env
  #
  # @param value the value to set the attribute env to.
  #
  # source://rack-tracker//lib/rack/tracker/handler_delegator.rb#8
  def env=(_arg0); end

  # @raise [ArgumentError]
  #
  # source://rack-tracker//lib/rack/tracker/handler_delegator.rb#26
  def handler(method_name); end

  # source://rack-tracker//lib/rack/tracker/handler_delegator.rb#14
  def method_missing(method_name, *args, &block); end

  # @return [Boolean]
  #
  # source://rack-tracker//lib/rack/tracker/handler_delegator.rb#22
  def respond_to?(method_name, include_private = T.unsafe(nil)); end

  class << self
    # source://rack-tracker//lib/rack/tracker/handler_delegator.rb#3
    def handler(method_name); end
  end
end

# source://rack-tracker//lib/rack/tracker.rb#75
class Rack::Tracker::HandlerSet
  # @return [HandlerSet] a new instance of HandlerSet
  #
  # source://rack-tracker//lib/rack/tracker.rb#82
  def initialize(&block); end

  # source://rack-tracker//lib/rack/tracker.rb#102
  def each(env = T.unsafe(nil), &block); end

  # setup the handler class with configuration options and make it ready for receiving the env during injection
  #
  # usage:
  #
  #   use Rack::Tracker do
  #     handler :google_analytics, { tracker: 'U-XXXXX-Y' }
  #   end
  #
  # source://rack-tracker//lib/rack/tracker.rb#95
  def handler(name, configuration = T.unsafe(nil), &block); end
end

# source://rack-tracker//lib/rack/tracker.rb#76
class Rack::Tracker::HandlerSet::Handler < ::Struct
  # Returns the value of attribute configuration
  #
  # @return [Object] the current value of configuration
  def configuration; end

  # Sets the attribute configuration
  #
  # @param value [Object] the value to set the attribute configuration to.
  # @return [Object] the newly set value
  def configuration=(_); end

  # source://rack-tracker//lib/rack/tracker.rb#77
  def init(env); end

  # Returns the value of attribute klass
  #
  # @return [Object] the current value of klass
  def klass; end

  # Sets the attribute klass
  #
  # @param value [Object] the value to set the attribute klass to.
  # @return [Object] the newly set value
  def klass=(_); end

  class << self
    def [](*_arg0); end
    def inspect; end
    def keyword_init?; end
    def members; end
    def new(*_arg0); end
  end
end

# source://rack-tracker//lib/rack/tracker/heap/heap.rb#1
class Rack::Tracker::Heap < ::Rack::Tracker::Handler; end

# source://rack-tracker//lib/rack/tracker/hotjar/hotjar.rb#1
class Rack::Tracker::Hotjar < ::Rack::Tracker::Handler; end

# source://rack-tracker//lib/rack/tracker/hubspot/hubspot.rb#1
class Rack::Tracker::Hubspot < ::Rack::Tracker::Handler; end

# This module is extracted from Rails to provide reliable javascript escaping.
#
# @see https://github.com/rails/rails/blob/master/actionview/lib/action_view/helpers/javascript_helper.rb
#
# source://rack-tracker//lib/rack/tracker/javascript_helper.rb#4
module Rack::Tracker::JavaScriptHelper
  # Escapes carriage returns and single and double quotes for JavaScript segments.
  #
  # Also available through the alias j(). This is particularly helpful in JavaScript
  # responses, like:
  #
  #   $('some_element').replaceWith('<%=j render 'some/element_template' %>');
  #
  # source://rack-tracker//lib/rack/tracker/javascript_helper.rb#25
  def escape_javascript(javascript); end

  # Escapes carriage returns and single and double quotes for JavaScript segments.
  #
  # Also available through the alias j(). This is particularly helpful in JavaScript
  # responses, like:
  #
  #   $('some_element').replaceWith('<%=j render 'some/element_template' %>');
  #
  # source://rack-tracker//lib/rack/tracker/javascript_helper.rb#25
  def j(javascript); end
end

# source://rack-tracker//lib/rack/tracker/javascript_helper.rb#6
Rack::Tracker::JavaScriptHelper::JS_ESCAPE_MAP = T.let(T.unsafe(nil), Hash)

# source://rack-tracker//lib/rack/tracker/railtie.rb#3
class Rack::Tracker::Railtie < ::Rails::Railtie; end

# source://rack-tracker//lib/rack/tracker/version.rb#3
Rack::Tracker::VERSION = T.let(T.unsafe(nil), String)

# source://rack-tracker//lib/rack/tracker/vwo/vwo.rb#1
class Rack::Tracker::Vwo < ::Rack::Tracker::Handler; end

# source://rack-tracker//lib/rack/tracker/zanox/zanox.rb#1
class Rack::Tracker::Zanox < ::Rack::Tracker::Handler
  # source://rack-tracker//lib/rack/tracker/zanox/zanox.rb#32
  def lead_events; end

  # source://rack-tracker//lib/rack/tracker/zanox/zanox.rb#26
  def mastertag; end

  # source://rack-tracker//lib/rack/tracker/zanox/zanox.rb#36
  def sale_events; end

  class << self
    # source://rack-tracker//lib/rack/tracker/handler.rb#13
    def position; end
  end
end

# source://rack-tracker//lib/rack/tracker/zanox/zanox.rb#13
class Rack::Tracker::Zanox::Lead < ::OpenStruct
  # Example: OrderID=[[DEFC-4321]]&CurrencySymbol=[[EUR]]&TotalPrice=[[23.40]]
  #
  # source://rack-tracker//lib/rack/tracker/zanox/zanox.rb#15
  def write; end
end

# name of the handler
# everything after is passed as options
#
# source://rack-tracker//lib/rack/tracker/zanox/zanox.rb#5
class Rack::Tracker::Zanox::Mastertag < ::OpenStruct
  # source://rack-tracker//lib/rack/tracker/zanox/zanox.rb#6
  def write; end
end

# source://rack-tracker//lib/rack/tracker/zanox/zanox.rb#22
class Rack::Tracker::Zanox::Sale < ::Rack::Tracker::Zanox::Lead; end
