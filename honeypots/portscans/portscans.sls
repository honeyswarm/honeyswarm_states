# This state file deploys a cowrie honeypot

# https://docs.saltstack.com/en/latest/ref/states/all/salt.states.docker_container.html#salt.states.docker_container.run


# Add the config file
/etc/portscan/config.py:
  file.managed:
    - source: salt://honeypots/{{salt['pillar.get']('HONEYPOTID')}}/config.py
    - makedirs: true


portscan_container:
  docker_container.running:
    - name: honeypot_portscans
    - image: honeyswarm/honeyswarm_portscans
    - replace: true
    - force: true
    - network_mode: host # This is needed for the large number of ports and the dynamic method of configuration
    - binds: /etc/portscan/config.py:/opt/honeypot/config.py
