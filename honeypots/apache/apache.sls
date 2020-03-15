# This state file deploys a cowrie honeypot

# https://docs.saltstack.com/en/latest/ref/states/all/salt.states.docker_container.html#salt.states.docker_container.run


# Add the default index.html file
/etc/honeyswarm/apache/index.html:
  file.managed:
    - source: salt://honeypots/{{salt['pillar.get']('HONEYPOTID')}}/index.html
    - makedirs: true



# Wait for config file then start. 
# Might be able to use onlyif / unless in place of wait
wait for edit_config:
  docker_container.running:
    - name: honeypot_apache2
    - image: honeyswarm/honeyswarm_apache2
    - environment:
      - HPFSERVER: {{salt['pillar.get']('HPFSERVER')}}
      - HPFPORT: {{salt['pillar.get']('HPFPORT')}}
      - HPFIDENT: {{salt['pillar.get']('HPFIDENT')}}
      - HPFSECRET: {{salt['pillar.get']('HPFSECRET')}}
      - HIVEID: {{salt['pillar.get']('HIVEID')}}
    - replace: true
    - force: true
    - port_bindings:
      - 80:80
    - binds: /etc/honeyswarm/apache/index.html:/var/www/html/index.html
