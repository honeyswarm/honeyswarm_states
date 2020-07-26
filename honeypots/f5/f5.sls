# This state file deploys an F5 honeypot

# https://docs.saltstack.com/en/latest/ref/states/all/salt.states.docker_container.html#salt.states.docker_container.run


http_container:
  docker_container.running:
    - name: honeyswarm_f5_honeypot
    - image: honeyswarm/honeyswarm_f5_honeypot
    - environment:
      - HPFSERVER: {{salt['pillar.get']('HPFSERVER')}}
      - HPFPORT: {{salt['pillar.get']('HPFPORT')}}
      - HPFIDENT: {{salt['pillar.get']('HPFIDENT')}}
      - HPFSECRET: {{salt['pillar.get']('HPFSECRET')}}
      - HIVEID: {{salt['pillar.get']('HIVEID')}}
    - replace: true
    - force: true
    - port_bindings:
      - 8443:8443
      - 443:443
