module DPL
  class Provider
    class NPM < Provider
      NPMRC_FILE = '~/.npmrc'

      def needs_key?
        false
      end

      def check_app
      end

      def setup_auth
        f = File.open(File.expand_path(NPMRC_FILE), 'w')
        f.puts("//registry.npmjs.org/:_authToken=${NPM_API_KEY}")
      end

      def check_auth
        setup_auth
        log "Authenticated with email #{option(:email)}"
      end

      def push_app
        log "NPM API key format changed recently. If your deployment fails, check your API key in ~/.npmrc."
        log "http://docs.travis-ci.com/user/deployment/npm/"
        context.shell "env NPM_API_KEY=#{option(:api_key)} npm publish"
        FileUtils.rm(File.expand_path(NPMRC_FILE))
      end
    end
  end
end
