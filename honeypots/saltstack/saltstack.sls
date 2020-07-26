# This state file deploys an HTTP honeypot

# https://docs.saltstack.com/en/latest/ref/states/all/salt.states.docker_container.html#salt.states.docker_container.run


http_container:
  docker_container.running:
    - name: honeyswarm_saltstack_honeypot
    - image: honeyswarm/honeyswarm_saltstack_honeypot
    - environment:
      - HPFSERVER: {{salt['pillar.get']('HPFSERVER')}}
      - HPFPORT: {{salt['pillar.get']('HPFPORT')}}
      - HPFIDENT: {{salt['pillar.get']('HPFIDENT')}}
      - HPFSECRET: {{salt['pillar.get']('HPFSECRET')}}
      - HIVEID: {{salt['pillar.get']('HIVEID')}}
    - replace: true
    - force: true
    - port_bindings:
      - 4506:4506
