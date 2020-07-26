# This state file deploys an HTTP honeypot

# https://docs.saltstack.com/en/latest/ref/states/all/salt.states.docker_container.html#salt.states.docker_container.run


http_container:
  docker_container.running:
    - name: honeyswarm_wordpress_honeypot
    - image: honeyswarm/honeyswarm_wordpress_honeypot
    - environment:
      - HPFSERVER: {{salt['pillar.get']('HPFSERVER')}}
      - HPFPORT: {{salt['pillar.get']('HPFPORT')}}
      - HPFIDENT: {{salt['pillar.get']('HPFIDENT')}}
      - HPFSECRET: {{salt['pillar.get']('HPFSECRET')}}
      - HIVEID: {{salt['pillar.get']('HIVEID')}}
      - SERVER_STRING: {{salt['pillar.get']('SERVER_STRING')}}
    - replace: true
    - force: true
    - port_bindings:
      - 80:80
