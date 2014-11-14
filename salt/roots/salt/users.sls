# ubuntu: sudo apt-get install whois
# used for password: mkpasswd -m sha-512
#rbenvuser
rbenv:
  user.present:
    - fullname: rbenv environment
    - shell: /bin/bash
    - home: /home/rbenv
    - password: $6$LNvZDmmuNaEq$F3a/wELeVB3AnvHvQYFGk6lchO.JkscEHHE8yEDkeUUTM78rvJCB0V5O5c5EOUoUriRsDpSNjkTcFAkuVkA.X.
