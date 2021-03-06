require "log4r"

module VagrantPlugins
  module ProviderBhyve
    module Action
      class Setup

	def initialize(app, env)
	  @logger = Log4r::Logger.new("vagrant_bhyve::action::setup")
	  @app = app
	end

	def call(env)
	  @driver	= env[:machine].provider.driver
	  env[:ui].info I18n.t('vagrant_bhyve.action.vm.setup_environment')
	  @driver.check_bhyve_support
	  module_list 	= %w(vmm nmdm if_bridge if_tap pf)
	  for kernel_module in module_list
	    @driver.load_module(kernel_module)
	  end
	  @app.call(env)
	end

      end
    end
  end
end
