require 'support'
require 'sword/server/templates'

describe Sword::Server::Templates do
  it { should have_method :inject_styles  }
  it { should have_method :inject_scripts }
  it { should have_method :inject_html    }
  
  it { should have_method :inject_template_variables_first }
  it { should have_method :inject_templates_last }
end
