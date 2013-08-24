require 'support'
require 'sword/debugger'
require 'sword/execute/parser'

describe Sword::Execute::Parser do
  subject { described_class.new([], 20) }

  it { should have_option :add        }
  it { should have_option :aloud      }
  it { should have_option :help       }
  it { should have_option :cache      }
  it { should have_option :compress   }
  it { should have_option :debug      }
  it { should have_option :directory  }
  it { should have_option :error      }
  it { should have_option :exceptions }
  it { should have_option :favicon    }
  it { should have_option :help       }
  it { should have_option :here       }
  it { should have_option :host       }
  it { should have_option :install    }
  it { should have_option :mutex      }
  it { should have_option :no_layouts }
  it { should have_option :pid        }
  it { should have_option :plain      }
  it { should have_option :port       }
  it { should have_option :require    }
  it { should have_option :scripts    }
  it { should have_option :server     }
  it { should have_option :settings   }
  it { should have_option :silent     }
  it { should have_option :styles     }
  it { should have_option :templates  }
  it { should have_option :version    }

  it 'should have --daemonize if running new Ruby' do
    stub_const('::RUBY_VERSION', '1.9.1')
    reload_system
    should have_option :daemonize
  end

  it 'should not have --daemonize if running old Ruby' do
    stub_const('::RUBY_VERSION', '1.8.7')
    reload_system
    should_not have_option :daemonize
  end

  it 'should not have --daemonize if running on OS X' do
    stub_const('::RUBY_PLATFORM', 'x86_64-darwin12.4.1')
    reload_system
    should have_option :open
  end
end
