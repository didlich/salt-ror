rbenv-deps:
  pkg.installed:
   - pkgs:
      - git-core
      - curl
      - zlib1g-dev
      - build-essential
      - libssl-dev
      - libreadline-dev
      - libyaml-dev
      - libsqlite3-dev
      - sqlite3
      - libxml2-dev
      - libxslt1-dev
      - libcurl4-openssl-dev
      - python-software-properties

ruby-{{ pillar['ruby']['version'] }}:
  rbenv.installed:
    - user: rbenv
    - default: True
    - require:
      - pkg: rbenv-deps

# rbenv env variables
/home/rbenv/.profile.d:
  file.directory:
    - makedirs: True
    - user: rbenv
    - group: rbenv
    
profile.d-rbenv-bin:
  file.managed:
    - user: rbenv
    - group: rbenv
    - name: /home/rbenv/.profile.d/rbenv-bin
      
/home/rbenv/.profile.d/rbenv-bin:  
  file.append:
    - text:
      - export PATH="$HOME/.rbenv/bin:$PATH"
      - eval "$(rbenv init -)"
    - require:      
      - file: profile.d-rbenv-bin
      
profile.d-rbenv-ruby-build-bin:
  file.managed:
    - user: rbenv
    - group: rbenv
    - name: /home/rbenv/.profile.d/rbenv-ruby-build-bin
      
/home/rbenv/.profile.d/rbenv-ruby-build-bin:
  file.append:
    - text:
      - export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
    - require:      
      - file: profile.d-rbenv-ruby-build-bin

# make rbenv paths available in the shell
/home/rbenv/.bashrc:
  file.append:
    - text: |
        #
        . "$HOME/.profile.d/rbenv-bin"
        . "$HOME/.profile.d/rbenv-ruby-build-bin"
        #
    - require:
      - file: /home/rbenv/.profile.d/rbenv-bin
      - file: /home/rbenv/.profile.d/rbenv-ruby-build-bin
      
source /home/rbenv/.profile:
  cmd.run:
    - user: rbenv
      
# tell Rubygems not to install the documentation for each package locally
file-dot-gemrc:
  file.managed:
    - user: rbenv
    - group: rbenv
    - name: /home/rbenv/.gemrc

/home/rbenv/.gemrc:
  file.append:
    - user: rbenv
    - group: rbenv
    - text:
      - "gem: --no-ri --no-rdoc"
    - require:
      - file: file-dot-gemrc

rails-{{ pillar['rails']['version'] }}:
  gem.installed:
    - name: rails
    - ruby: {{ pillar['ruby']['version'] }}
    - user: rbenv
    - version: {{ pillar['rails']['version'] }}
    - rdoc: false
    - ri: false    
    - require:
      - rbenv: ruby-{{ pillar['ruby']['version'] }}
      - file: /home/rbenv/.gemrc
