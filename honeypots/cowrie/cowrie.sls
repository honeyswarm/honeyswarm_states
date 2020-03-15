# This state file deploys a cowrie honeypot

# https://docs.saltstack.com/en/latest/ref/states/all/salt.states.docker_container.html#salt.states.docker_container.run


# Move the SSH Port so we dont interfere with ssh honeypots
ssh_config:
  cmd.run:
    - names:
      - sed -i "s/#Port 22/Port 22222/" /etc/ssh/sshd_config
      - systemctl restart sshd.service

# Add the config file
/etc/cowrie/cowrie.cfg:
  file.managed:
    - source: salt://honeypots/{{salt['pillar.get']('HONEYPOTID')}}/cowrie.cfg
    - makedirs: true

# Modify the config file based on pillar
# pillar='{HPFSERVER: "192.168.1.183", HPFPORT: 20000, HPFIDENT: cowrie, HPFSECRET: cowrie}'
edit_config:
  cmd.run:
    - names:
      - sed -i 's/HPFSERVER/{{salt['pillar.get']('HPFSERVER')}}/g' /etc/cowrie/cowrie.cfg
      - sed -i 's/HPFPORT/{{salt['pillar.get']('HPFPORT')}}/g' /etc/cowrie/cowrie.cfg
      - sed -i 's/HPFIDENT/{{salt['pillar.get']('HPFIDENT')}}/g' /etc/cowrie/cowrie.cfg
      - sed -i 's/HPFSECRET/{{salt['pillar.get']('HPFSECRET')}}/g' /etc/cowrie/cowrie.cfg
      - sed -i 's/COWRIEHOSTNAME/{{salt['pillar.get']('COWRIEHOSTNAME')}}/g' /etc/cowrie/cowrie.cfg
      - sed -i 's/INSTANCEID/{{salt['pillar.get']('INSTANCEID')}}/g' /etc/cowrie/cowrie.cfg

# Wait for config file then start. 
# Might be able to use onlyif / unless in place of wait
wait for edit_config:
  docker_container.running:
    - name: honeypot_cowrie
    - image: honeyswarm/honeyswarm_cowrie
    - replace: true
    - force: true
    - port_bindings:
      - 22:2222
      - 23:2223
    - binds: /etc/cowrie/cowrie.cfg:/cowrie/cowrie-git/etc/cowrie.cfg
