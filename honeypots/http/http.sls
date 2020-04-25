# This state file deploys an HTTP honeypot

# https://docs.saltstack.com/en/latest/ref/states/all/salt.states.docker_container.html#salt.states.docker_container.run


http_container:
  docker_container.running:
    - name: honeypot_http
    - image: honeyswarm/honeyswarm_http
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
    - binds: /etc/honeyswarm/apache/index.html:/var/www/html/index.html
