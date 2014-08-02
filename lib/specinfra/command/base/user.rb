class Specinfra::Command::Base::User < Specinfra::Command::Base
  class << self
    def check_exists(user)
      "id #{escape(user)}"
    end

    def check_belongs_to_group(user, group)
      "id #{escape(user)} | awk '{print $3}' | grep -- #{escape(group)}"
    end

    def check_belongs_to_primary_group(user, group)
      "id -gn #{escape(user)}| grep ^#{escape(group)}$"
    end

    def check_has_uid(user, uid)
      regexp = "^uid=#{uid}("
      "id #{escape(user)} | grep -- #{escape(regexp)}"
    end

    def check_has_home_directory(user, path_to_home)
      "getent passwd #{escape(user)} | cut -f 6 -d ':' | grep -w -- #{escape(path_to_home)}"
    end

    def check_has_login_shell(user, path_to_shell)
      "getent passwd #{escape(user)} | cut -f 7 -d ':' | grep -w -- #{escape(path_to_shell)}"
    end

    def check_has_authorized_key(user, key)
      key.sub!(/\s+\S*$/, '') if key.match(/^\S+\s+\S+\s+\S*$/)
      "grep -w -- #{escape(key)} ~#{escape(user)}/.ssh/authorized_keys"
    end
  end
end
