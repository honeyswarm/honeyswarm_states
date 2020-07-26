# This state file deploys an HTTP honeypot

# https://docs.saltstack.com/en/latest/ref/states/all/salt.states.docker_container.html#salt.states.docker_container.run


http_container:
  docker_container.running:
    - name: honeyswarm_http_honeypot
    - image: honeyswarm/honeyswarm_http_honeypot
    - environment:
      - HPFSERVER: {{salt['pillar.get']('HPFSERVER')}}
      - HPFPORT: {{salt['pillar.get']('HPFPORT')}}
      - HPFIDENT: {{salt['pillar.get']('HPFIDENT')}}
      - HPFSECRET: {{salt['pillar.get']('HPFSECRET')}}
      - HIVEID: {{salt['pillar.get']('HIVEID')}}
      - SERVER_STRING: {{salt['pillar.get']('SERVER_STRING')}}
      - USE_HTTPS: {{salt['pillar.get']('USE_HTTPS')}}
      - HTTPS_CERT: {{salt['pillar.get']('HTTPS_CERT')}}
    - replace: true
    - force: true
    - port_bindings:
      - 80:80
      - 443:443
    - binds: /etc/honeyswarm/apache/index.html:/var/www/html/index.html
